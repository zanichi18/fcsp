$(function() {
  friend_ship.initialize();
});

var friend_ship = {
  initialize: function() {
    friend_ship.add_friend_ship();
    friend_ship.remove_friend_ship();
    friend_ship.unfriend();
  },

  add_friend_ship: function() {
    $('body').on('click', '.request-friend', function() {
      var self = $(this);
      var user_id = $('#user_id').val();
      $.ajax({
        url: '/friend_ships/', 
        data: {id: user_id}, 
        type: 'POST',
        success: function(data) {
          if(data.status === 200) {
            $.growl.notice({message: data.flash});
            self.removeClass('request-friend btn-success')
              .addClass('remove-request btn-warning');
            self.text(I18n.t('users.friend_ship_form.remove_request'));
          }
          else {
            $.growl.error({message: data.flash});
          } 
        },
        error: function(error) {
          $.growl.error({message: error});
        }
      });
      return false;
    });
  },

  remove_friend_ship: function() {
    $('body').on('click', '.remove-request', function() {
      var self = $(this);
      var user_id = $('#user_id').val();
      var is_unfriend = $('#is_unfriend').val();
      $.ajax({
        url: '/friend_ships/' + user_id,
        type: 'DELETE',
        success: function(data) {
          if(data.status === 200) {
            $.growl.warning({message: data.flash});
            self.removeClass('remove-request btn-warning')
              .addClass('request-friend btn-success');
            self.text(I18n.t('users.friend_ship_form.request_friend'));
          }
          else {
            $.growl.error({message: data.flash});
          } 
        },
        error: function(error) {
          $.growl.error({message: error});
        }
      });
      return false;
    });
  },

  unfriend: function() {
    $('body').on('click', '.unfriend', function() {
      var self = $(this);
      var user_id = $('#user_id').val();
      $.ajax({
        url: '/friend_ships/' + user_id,
        data: {is_unfriend: true},
        type: 'DELETE',
        success: function(data) {
          if(data.status === 200) {
            $.growl.error({message: data.flash});
            self.removeClass('unfriend btn-danger')
              .addClass('request-friend btn-success');
            self.text(I18n.t('users.friend_ship_form.request_friend'));
          }
          else {
            $.growl.error({message: data.flash});
          } 
        },
        error: function(error) {
          $.growl.error({message: error});
        }
      });
      return false;
    });
  }
}
