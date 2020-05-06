import consumer from "./consumer"

consumer.subscriptions.create("AppearanceChannel", {
  received(data) {
    let user = document.getElementById("user-" + data['user_id']);
    data['online'] == true ? user.classList.add("online") : user.classList.remove("online");
   }
});
