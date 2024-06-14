import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  static values = { chatroomId: Number };
  static targets = ["messages"];

  connect() {
    console.log("Connected to the chatroom subscription controller.");
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: (data) => this.#insertMessageAndScrollDown(data) }
    );
    console.log(
      `Subscribed to the chatroom with the id ${this.chatroomIdValue}.`
    );
  }

  #insertMessageAndScrollDown(message) {
    this.messagesTarget.insertAdjacentHTML("beforeend", message);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }

  resetForm(event) {
    event.target.reset();
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom");
    this.channel.unsubscribe();
  }
}
