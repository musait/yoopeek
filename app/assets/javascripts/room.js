$(function() {
  $('#new_room_message').on('ajax:success', function(a, b,c ) {
    $(this).find('#message_area').val('');
  });
});
