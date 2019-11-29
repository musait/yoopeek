$(function() {
  // $('[data-channel-subscribe="user"]').each(function(index, element) {
    // var $element = $(element),
    current_user_id = $('#user-channel-subscribe').data('user-id')
    //     console.log(current_user_id);
    App.cable.subscriptions.create(
      {
        channel: "UserChannel",
        user_id: current_user_id
      },
      {
        received: function(data) {
          console.log(data);
          if(data.created_for == "room_message") {
            $notifications_count = $("#notifications-messages-count")
            $notifications_count.html(parseInt($notifications_count.html()) + 1)

            notification = '<li class="notifications-not-read">' +
            '<a href="' + data.url + '" data-method="get">' +
            '<span class="notification-avatar status-online"><img src= "'+ data.author_avatar + '" alt=""></span>' +
            '<div class="notification-text">' +
            '<strong>' + data.author_full_name + '</strong>' +
            '<p class="notification-msg-text">' + data.message + '</p>' +
            '<span class="color">' + data.time_ago_in_words + '</span>' +
            '</div>' +
            '</li>'
            $("#notifications-messages-ul-container").html(notification)

          } else {
            notification = "<li class='notifications-not-read'>" +
            "<a href='" + data.url + "' data-method='get'>" +
              "<span class='notification-icon'><i class='icon-material-outline-group'></i></span>" +
              "<span class='notification-text'>" +
              data.raw_message +
              "</span>" +
              "</a>" +
            "</li>"
            $("#header-ul-notification-container").prepend(notification)
            emptyContainer = $("#notification-empty-container")
            if (emptyContainer.length > 0) {
              emptyContainer.remove()
            }
            $notificationCount = $("#header-notifications-count")
            $notificationCount.html(parseInt($notificationCount.html()) + 1)
          }
      }
    });
  // });
});
