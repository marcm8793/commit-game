import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.dismiss();
    }, 10000);
  }

  dismiss() {
    this.element.classList.remove("show");
    this.element.classList.add("fade");
    setTimeout(() => {
      this.element.remove();
    }, 500);
  }
}
