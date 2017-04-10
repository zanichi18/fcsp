$(document).ready(function() {
  $('body').css('overflow', 'hidden');
  draftjob.initialize();
  showCandidateByjob();
  activeButton();
});

function showCandidateByjob() {
  $('.show-candidates').on('click', function() {
    var job_id = this.id;
    var company_id = $('#company-id').val();
    $.ajax({
      dataType: 'html',
      url: '/employer/companies/' + company_id + '/jobs/' + job_id,
      method: 'get',
      success: function(data) {
        $('.modal-show-candidates').html(data);
        $('#show-candidates-modal').modal('show');
      },
      error: function() {
        alert(I18n.t('employer.candidates.not_found'));
      }
    })
  });
}

function activeButton() {
  select = $('.select-job').data('select');
  $('.button-job').each(function(){
    link_arr = this.href.replace(/\/$/,'').split('?select=');
    if(link_arr[1] === select){
      $(this).addClass('active');
    }
  });
}

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
