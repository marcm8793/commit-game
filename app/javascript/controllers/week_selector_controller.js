// app/javascript/controllers/week_selector_controller.js
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

    // Fetch tasks for the selected week
    const tasksByWeek = JSON.parse(this.data.get("tasksByWeek"));
    const tasks = tasksByWeek[selectedWeek] || [];

    // Clear current tasks
    this.taskListTarget.innerHTML = "";

    // Render tasks for the selected week
    tasks.forEach((task) => {
      const taskItem = document.createElement("div");
      taskItem.classList.add("task-item");
      taskItem.innerHTML = `<h6>${task.name} - ${task.score} pts</h6><p>${task.description}</p>`;
      this.taskListTarget.appendChild(taskItem);
    });
  }
}
