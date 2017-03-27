$(document).ready(function() {
  draftjob.initialize();
});

var draftjob = {
  initialize: function() {
    $('.draft').click(function() {
      var id = $(this).attr('id');
      draftjob.close_job(id);
    });

    $('.reopen').click(function() {
      var id = $(this).attr('id');
      draftjob.reopen_job(id);
    });
  },

  close_job: function(id) {
    $.ajax({
      url: '/employer/companies/' + id +'/jobs/'+ id,
      method: 'DELETE',
      data: {type: 'delete'},
      success: function(){
        $('#job_'+ id).fadeOut(300);
      }
    });
  },

  reopen_job: function(id) {
    $.get('/employer/companies/' + id +'/jobs/', {type: 'reopen', id: id}, function() {
      $('#job_'+ id).fadeOut(300);
    });
  }
}
