import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {

    const current_user=$("#current_user_id").val();

    if ( data.content.user_id == current_user ){
    const html =
    `<div class="outgoing_msg" >
      <div class="sent_msg">
        <p>${ data.content.message}</p>
        <span class="time_date">今</span>
      </div>
    </div>`;
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('message_message');
    messages.insertAdjacentHTML('beforeend', html);
    newMessage.value='';
    messages.scrollTop = messages.scrollHeight;
    }
    else{
      const html =
      `<div class="incoming_msg">
      <div class="incoming_msg_img"> 
        <img src= ${data.user_image}  size= "35x35"  class= "img-circle">
      </div>
      <div class="received_msg">
        <div class="received_withd_msg">
          <p>${data.content.message}</p>
          <span class="time_date">今</span>
        </div>
      </div>
    </div>`;
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('message_message');
    messages.insertAdjacentHTML('beforeend', html);
    newMessage.value='';
    const obj = document.getElementById("messages");
    obj.scrollTop = obj.scrollHeight;
    };
  }
});
