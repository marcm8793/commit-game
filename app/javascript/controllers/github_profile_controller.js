import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["link"];

  connect() {
    this.createTooltip();
  }

  createTooltip() {
    this.tooltip = document.createElement("div");
    this.tooltip.textContent = "View GitHub profile";
    this.tooltip.classList.add("custom-tooltip");
    this.element.appendChild(this.tooltip);
  }

  showTooltip() {
    if (this.tooltip) {
      this.tooltip.classList.add("show");
    }
  }

  hideTooltip() {
    if (this.tooltip) {
      this.tooltip.classList.remove("show");
    }
  }

  disconnect() {
    if (this.tooltip) {
      this.tooltip.remove();
    }
  }
}
