$(function() {
  $('[data-channel-subscribe="room"]').each(function(index, element) {
    var $element = $(element),
        room_id = $element.data('room-id')
        current_user_id =  $element.data('user-id')
        receiver_user_id =  $element.data('receiver-id')
        messageTemplate = $('[data-role="message-template"]');
        $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000);
        console.log(room_id);

    App.cable.subscriptions.create(
      {
        channel: "RoomChannel",
        room_id: room_id
      },
      {
        received: function(data) {
          if(data.is_valid) {
            console.log(current_user_id == data.author_id);
            var message_for = ($("#room_message_author_id").val() == data.author_id) ? "me" : ""
            console.log(message_for);
            var message = '<div class="message-time-sign">' +
              '<span>' + data.updated_at + '</span>' +
            '</div>' +
            '<div class="message-bubble ' + message_for + '">' +
              '<div class="message-bubble-inner" >' +
                '<div class="message-avatar"><img src="' + data.author_avatar + '" alt="" /></div>' +
                '<div class="message-text"><p>' + data.message + '</p></div>' +
              '</div>' +
              '<div class="clearfix"></div>' +
            '</div>';
            console.log(message, data);
            var $chatContainer = $(".chat[data-room-id='" + room_id + "']")
            $chatContainer.append(message)


            $chatContainer.stop().animate({
                scrollTop: $chatContainer[0].scrollHeight
              }, 800);

            $("#message_area").val(null);
          } else {
            // toastr['error']('data.unvalid_reason');
          }
        }
      }
    );
  });
});
