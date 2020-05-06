import consumer from "./consumer"

consumer.subscriptions.create("NotifierChannel", {
  received(data) {
    debugger
    if(data.notification) {
      document.getElementsByTagName("body")[0].insertAdjacentHTML('beforeend', data.notification);
    }
  }
});
