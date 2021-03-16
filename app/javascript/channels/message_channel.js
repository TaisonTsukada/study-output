import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    
    const html =
    `<div class="outgoing_msg" >
      <div class="sent_msg">
        <p>${ data.content.message}</p>
      </div>
    </div>`;
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('message_message');
    messages.insertAdjacentHTML('beforeend', html);
    newMessage.value='';
  }
});
