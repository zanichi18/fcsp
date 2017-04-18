$(function() {
  bookmark.initialize()
})

var bookmark = {
  initialize: function() {
    bookmark.add_bookmark()
    bookmark.unbookmark()
  },

  add_bookmark: function() {

    $('body').on('click', '.add_bookmark', function() {
      var self = $(this)
      var job = $(this).attr('id')
      $.post('/bookmarks/', {id: job}, function() {
        self.removeClass('button-green add_bookmark')
          .addClass('rm_bookmark')
        self.prop('title', I18n.t("jobs.bookmark.unbookmark"))
        self.find('span').text(I18n.t("jobs.bookmark.bookmarked"))
      })
      return false;
    })
  },

  unbookmark: function() {

    $('body').on('click', '.rm_bookmark', function() {
      var self = $(this)
      var job = $(this).attr('id')
      $.ajax({
        url: '/bookmarks/' + job,
        type: 'DELETE',
        success: function() {
          self.removeClass('buttonrm_bookmark')
            .addClass('add_bookmark button-green')
          self.prop('title', I18n.t("jobs.bookmark.bookmark_job"))
          self.find('span').text(I18n.t("jobs.bookmark.bookmark"))
        }
      })
      return false;
    })
  }
}
