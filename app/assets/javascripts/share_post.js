$(document).ready(function() {
  $('body').on('click', '.share-post', function(e) {
    e.preventDefault();
    var self = $(this);
    var isShare = confirm(I18n.t('share_posts.share'));
    if (isShare) {
      var post_id = self.data('id');
      $.ajax({
        url: '/share_posts',
        type: 'POST',
        dataType: 'json',
        data: {id: post_id},
        success: function(data) {
          if(data.status === 200) {
            $.growl.notice({message: data.flash});
            self.removeClass('icon-share').addClass('icon-remove');
            self.removeClass('share-post').addClass('unshare-post');
            self.text(I18n.t('share_posts.post.unshare'));
          } else {
            $.growl.error({message: data.flash});
          }
        },
        error: function(error) {
          $.growl.error({message: error});
        }
      });
    }
  });

  $('body').on('click', '.unshare-post', function(e) {
    e.preventDefault();
    var self = $(this);
    var isUnShare = confirm(I18n.t('share_posts.unshare'));
    if (isUnShare) {
      var post_id = self.data('id');
      $.ajax({
        url: '/share_posts/' + post_id,
        type: 'DELETE',
        dataType: 'json',
        success: function(data) {
          if(data.status === 200) {
            $.growl.notice({message: data.flash});
            self.removeClass('icon-remove').addClass('icon-share');
            self.removeClass('unshare-post').addClass('share-post');
            self.text(I18n.t('share_posts.post.share'));
          } else {
            $.growl.error({message: data.flash});
          }
        },
        error: function(error) {
          $.growl.error({message: error});
        }
      });
    }
  });
});
