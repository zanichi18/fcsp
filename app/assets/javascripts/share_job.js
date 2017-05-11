$(document).ready(function() {
  $('body').on('click', '.share-job', function(e) {
    e.preventDefault();
    var self = $(this);
    var isShare = confirm(I18n.t('share_jobs.share'));
    if (isShare) {
      var job_id = self.data('id');
      $.ajax({
        url: '/share_jobs',
        type: 'POST',
        dataType: 'json',
        data: {id: job_id},
        success: function(data) {
          if(data.status === 200) {
            $.growl.notice({message: data.flash});
            self.removeClass('icon-share').addClass('icon-remove');
            self.removeClass('share-job').addClass('unshare-job');
            self.text(I18n.t('share_jobs.job.unshare'));
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

  $('body').on('click', '.unshare-job', function(e) {
    e.preventDefault();
    var self = $(this);
    var isUnShare = confirm(I18n.t('share_jobs.unshare'));
    if (isUnShare) {
      var job_id = self.data('id');
      $.ajax({
        url: '/share_jobs/' + job_id,
        type: 'DELETE',
        dataType: 'json',
        success: function(data) {
          if(data.status === 200) {
            $.growl.notice({message: data.flash});
            self.removeClass('icon-remove').addClass('icon-share');
            self.removeClass('unshare-job').addClass('share-job');
            self.text(I18n.t('share_jobs.job.share'));
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
