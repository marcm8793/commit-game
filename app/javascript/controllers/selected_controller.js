import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["languageSelect", "categorySelect"];

  connect() {
    console.log("SelectedController connected");
  }

  updateLanguage(event) {
    const selectedOption =
      event.target.options[event.target.selectedIndex].text;
    event.target.setAttribute("data-selected-text", selectedOption);
  }

  updateCategory(event) {
    const selectedOption =
      event.target.options[event.target.selectedIndex].text;
    event.target.setAttribute("data-selected-text", selectedOption);
  }
}
