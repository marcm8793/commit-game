//TODO: Update this file to update the task status in real time
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["weekSelector", "currentWeekNumber", "taskList"];

  connect() {
    console.log("WeekSelectorController connected");
    this.weekSelectorTargets.forEach((selector) => {
      selector.addEventListener("change", this.updateTasks.bind(this));
    });
  }

  updateTasks(event) {
    const selectedWeek = event.target.value;
    this.currentWeekNumberTarget.textContent = selectedWeek;

    const tasksByWeek = JSON.parse(this.data.get("tasksByWeek"));
    const tasks = tasksByWeek[selectedWeek] || [];

    this.renderTasks(tasks);
  }

  renderTasks(tasks) {
    this.taskListTarget.innerHTML = "";
    tasks.forEach((task) => {
      const taskItem = document.createElement("div");
      taskItem.classList.add("task-item", "mt-2");

      const checkbox = document.createElement("input");
      checkbox.classList.add("form-check-input");
      checkbox.type = "checkbox";
      checkbox.disabled = true;
      if (task.done) checkbox.checked = true;

      const label = document.createElement("label");
      label.classList.add("form-check-label");
      if (task.done) label.classList.add("text-decoration-line-through");
      label.innerHTML = `${task.name} - ${task.score} pts`;

      taskItem.appendChild(checkbox);
      taskItem.appendChild(label);

      if (task.done) {
        const checkIcon = document.createElement("i");
        checkIcon.classList.add("fa", "fa-check", "text-success", "ml-2");
        taskItem.appendChild(checkIcon);
      }

      const description = document.createElement("p");
      description.textContent = task.description;
      taskItem.appendChild(description);

      this.taskListTarget.appendChild(taskItem);
    });
  }
}
