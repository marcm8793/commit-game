import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "card",
    "name",
    "description",
    "start_date",
    "end_date",
    "image",
    "prize",
    "slots",
    "category",
    "categorySelect",
    "languageSelect",
    "imageUrlInput",
  ];

  connect() {
    this.blurTimeout = null;
  }

  updateCard(event) {
    clearTimeout(this.blurTimeout);

    this.cardTarget.style.filter = "blur(5px)";
    this.cardTarget.style.transition = "filter 0.3s";

    this.blurTimeout = setTimeout(() => {
      this.cardTarget.style.filter = "none";
      this.updateCardContent(event);

      if (event.target.name === "arena[start_date]") {
        this.updateEndDate(event.target.value);
      }
    }, 300);

    const selectedLanguage = this.languageSelectTarget.selectedOptions[0];
    if (selectedLanguage) {
      const imageUrl = selectedLanguage.dataset.imageUrl;
      this.imageTarget.src = imageUrl;
      this.imageUrlInputTarget.value = imageUrl;
    }
  }

  updateCardContent(event) {
    const input = event.target;
    const name = input
      .getAttribute("name")
      .replace("arena[", "")
      .replace("]", "");
    let value = input.type === "checkbox" ? input.checked : input.value;

    if (input.type === "date") {
      value = input.value ? new Date(input.value).toLocaleDateString() : "";
    }

    switch (name) {
      case "name":
        this.nameTarget.textContent = value;
        break;
      case "description":
        this.descriptionTarget.textContent = value;
        break;
      case "start_date":
        this.start_dateTarget.textContent = value;
        break;
      case "end_date":
        this.end_dateTarget.textContent = value;
        break;
      case "image_url":
        this.imageTarget.src = value;
        this.imageTarget.alt = `Image for ${this.nameTarget.textContent}`;
        break;
      case "prize":
        this.prizeTarget.textContent = value;
        break;
      case "slots":
        this.slotsTarget.textContent = value;
        break;
      case "category_id":
        const selectedCategory = input.options[input.selectedIndex].text;
        console.log(selectedCategory);
        this.categoryTarget.textContent = selectedCategory;
        break;
      case "language_id":
        this.updateLanguageImage(value);
        break;
    }
  }

  updateLanguageImage(languageId) {
    fetch(`/languages/${languageId}`)
      .then((response) => response.json())
      .then((data) => {
        this.imageTarget.src = data.image_url;
        this.imageUrlInputTarget.value = data.image_url;
        this.imageTarget.alt = `Image for ${
          this.languageSelectTarget.options[
            this.languageSelectTarget.selectedIndex
          ].text
        }`;
      })
      .catch((error) => console.error("Error:", error));
  }

  updateEndDate(startDate) {
    if (startDate) {
      const start = new Date(startDate);
      if (!isNaN(start.getTime())) {
        const end = new Date(start);
        end.setDate(start.getDate() + 35); // 5 weeks later
        this.end_dateTarget.textContent = end.toLocaleDateString();
      } else {
        this.end_dateTarget.textContent = "Invalid Date";
      }
    } else {
      this.end_dateTarget.textContent = "";
    }
  }
}
