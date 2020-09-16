import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    let node = document.createElement("P");
    let textnode = document.createTextNode(data.sender + ": " + data.body);

    node.appendChild(textnode);

    document.getElementById("new_message").appendChild(node);
    document.getElementById("personal_message_body").value= "";
  }
});
