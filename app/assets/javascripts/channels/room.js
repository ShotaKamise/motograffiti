App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(message) {
    const messages = document.getElementById('messages');
    messages.innerHTML + `<p>${message}</p>`
    // Called when there's incoming data on the websocket for this channel
  },

  speak: function(content, user_id) {
    return this.perform('speak', {message: content, }); 
  }
});

document.addEventListener('DOMContentLoaded', function(){
  const input = document.getElementById('chat-speaker');
  const button = document.getElementById('button');
  button.addEventListener('click', function(){
   const content = input.value;
    App.room.speak(content);
    input.value = '';
  });
})