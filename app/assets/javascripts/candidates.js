$(function() {
  candidate.initialize();
});

var candidate = {
  initialize: function() {
    candidate.apply_job();
    candidate.unapply_job();
  },

  apply_job: function() {

    $('body').on('click', '.apply_job', function() {
      var self = $(this);
      var job = $(this).attr('id');
      $.post('/candidates/', {id: job}, function() {
        self.removeClass('apply_job btn-primary')
          .addClass('cancel_apply_job btn-danger');
      });
      return false;
    });
  },

  unapply_job: function() {

    $('body').on('click', '.cancel_apply_job', function() {
      var self = $(this);
      var job = $(this).attr('id');
      $.ajax({
        url: '/candidates/' + job,
        type: 'DELETE',
        success: function() {
          self.removeClass('cancel_apply_job btn-danger')
            .addClass('apply_job btn-primary');
        }
      });
      return false;
    });
  }
}
