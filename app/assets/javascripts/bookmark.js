$(function() {
  bookmark.initialize();
});

var bookmark = {
  initialize: function() {
    bookmark.add_bookmark();
    bookmark.unbookmark();
  },

  add_bookmark: function() {

    $('body').on('click', '.add_bookmark', function() {
      var self = $(this);
      var job = $(this).attr('id');
      $.post('/bookmarks/', {id: job}, function() {
        self.removeClass('add_bookmark btn-default')
          .addClass('rm_bookmark btn-danger');
      });
      return false;
    });
  },

  unbookmark: function() {

    $('body').on('click', '.rm_bookmark', function() {
      var self = $(this);
      var job = $(this).attr('id');
      $.ajax({
        url: '/bookmarks/' + job,
        type: 'DELETE',
        success: function() {
          self.removeClass('rm_bookmark btn-danger')
            .addClass('add_bookmark btn-default');
        }
      });
      return false;
    });
  }
}
