$(document).ready(function() {
  $('.friend-ship').on('click', function() {
    var id = this.dataset.id;
    update_friend('accept', id);
  });

  $('.request-waiting').on('click', function() {
    $.growl.notice({message: I18n.t('users.friend_ship_form.request_waiting')});
  });

  $('.friend-ship-decline').on('click', function() {
    var id = this.dataset.id;
    update_friend('decline', id);
  });
});

function update_friend(status, id) {
  $.ajax({
    type: 'patch',
    dataType: 'json',
    url: '/friend_ships/' + id,
    data: {status: status},
    success: function(data) {
      $('.friendships-' + id).remove();
      $.growl.notice({title: '', message: data['message']});
    },
    error: function(error_message) {
      $.growl.error({message: error_message});
      location.reload();
    }
  });
}
