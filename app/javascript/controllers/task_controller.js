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
  }

  disconnect() {
    Object.values(this.subscriptions).forEach((subscription) => {
      console.log("Unsubscribing from TaskChannel");
      subscription.unsubscribe();
    });
  }
}
