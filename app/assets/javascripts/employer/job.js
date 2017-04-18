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
    $('body').on('click', '.close-job', function() {
      var id = $(this).attr('id');
      draftjob.close_job(id);
    });

    $('body').on('click', '.public-job', function() {
      var id = $(this).attr('id');
      draftjob.reopen_job(id);
    });
  },

  close_job: function(id) {
    company_id = $('body').data('company');
    var public_button = '<button name="button" type="submit" id="';
      public_button += id;
      public_button += '" class="public-job btn btn-default">Public</button>';
    $.ajax({
      url: '/employer/companies/' + company_id +'/jobs/'+ id,
      method: 'PUT',
      data: {job: {status: 'close'}},
      success: function(data){
        status = data.status.substr(0, 1).toUpperCase()+data.status.substr(1);
        $('#job_'+ id).children('.status').text(status);
        $('#job_'+ id).children('.action').empty();
        $('#job_'+ id).children('.action').html(public_button);
      }
    });
  },

  reopen_job: function(id) {
    company_id = $('body').data('company');
    var close_button = '<button name="button" type="submit" id="';
      close_button += id
      close_button += '" class="close-job btn btn-warning">Close</button>'
    $.ajax({
      url: '/employer/companies/' + company_id +'/jobs/'+ id,
      method: 'PUT',
      data: {job: {status: 'active'}},
      success: function(data){
        status = data.status.substr(0, 1).toUpperCase()+data.status.substr(1);
        $('#job_'+ id).children('.status').text(status);
        $('#job_'+ id).children('.action').empty();
        $('#job_'+ id).children('.action').html(close_button);
      }
    });
  }
}
