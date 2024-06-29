import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static targets = ["task"];
  static values = { taskIds: Array };

  connect() {
    try {
      this.taskIds = JSON.parse(this.element.dataset.taskTaskIdsValue);
      console.log("TaskController connected with taskIds:", this.taskIds);
      this.subscriptions = {};

      this.taskIds.forEach((taskId) => {
        this.subscriptions[taskId] = createConsumer().subscriptions.create(
          { channel: "TaskChannel", task_id: taskId },
          {
            received: (data) => {
              console.log("Received data", data);
              if (data.task) {
                // Set a flag in localStorage to show a flash message after reload
                localStorage.setItem("showFlash", "true");
                localStorage.setItem(
                  "flashMessage",
                  "Task updated successfully!"
                );
                localStorage.setItem("flashType", "success");
                window.location.reload();
              } else {
                console.error(
                  "Received data does not contain task information"
                );
              }
            },
            connected: () => {
              console.log(
                `Subscribed to the task channel with the id ${taskId}.`
              );
            },
          }
        );
      });
    } catch (error) {
      console.error("Error connecting controller", error);
    }

    // Check if we need to show a flash message after reload
    if (localStorage.getItem("showFlash") === "true") {
      this.showFlashMessage();
    }
  }

  disconnect() {
    Object.values(this.subscriptions).forEach((subscription) => {
      console.log("Unsubscribing from TaskChannel");
      subscription.unsubscribe();
    });
  }

  showFlashMessage() {
    const message = localStorage.getItem("flashMessage");
    const type = localStorage.getItem("flashType");

    if (message && type) {
      const flashHtml = `
        <div class="flash flash-${type} alert alert-dismissible fade show" role="alert" data-controller="flash">
          <span>
            ${type === "success" ? "<strong>Yay!</strong> 🎉 " : ""}
            ${type === "warning" ? "<strong>Mmh</strong> 🤔 " : ""}
            ${type === "danger" ? "<strong>Oops!</strong> 😱 " : ""}
            ${message}
          </span>
          &nbsp;
          <a data-bs-dismiss="alert" aria-label="Close">
            <i class="fas fa-times"></i>
          </a>
        </div>
      `;

      document.body.insertAdjacentHTML("afterbegin", flashHtml);
    }

    // Clear the flash data from localStorage
    localStorage.removeItem("showFlash");
    localStorage.removeItem("flashMessage");
    localStorage.removeItem("flashType");
  }
}
