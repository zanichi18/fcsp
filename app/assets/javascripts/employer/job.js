$(document).ready(function() {
  draftjob.initialize();
  showCandidateByjob();
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
    var public_button = '<button name="button" type="submit" id="' +
      id + '" class="public-job btn btn-success btn-xs test">Public</button>',
      company_id = $('#company-id').val();

    $.ajax({
      url: '/employer/companies/' + company_id +'/jobs/'+ id,
      method: 'PUT',
      data: {job: {status: 'close'}},
      success: function(data){
        $('#job_'+ id).children('.status').find('b').text(data.status);
        $('#job_'+ id).children('.action').html(public_button);
      }
    });
  },

  reopen_job: function(id) {
    var close_button = '<button name="button" type="submit" id="' +
      id + '" class="close-job btn btn-warning btn-xs">Close</button>',
      company_id = $('#company-id').val();

    $.ajax({
      url: '/employer/companies/' + company_id +'/jobs/'+ id,
      method: 'PUT',
      data: {job: {status: 'active'}},
      success: function(data){
        $('#job_'+ id).children('.status').find('b').text(data.status);
        $('#job_'+ id).children('.action').html(close_button);
      }
    });
  }
};

$('.pagination-job').on('click','.pagination .page-item a',function(e){
  e.preventDefault();
  var url_request = $(this).attr('href'),
    tbody = $('.jobs-list');
  $.ajax({
    url: url_request,
    method: 'GET',
    dataType: 'json'
  })
  .done(function(data) {
    tbody.html(data.html_job);
    $('.pagination-job').html(data.pagination_job);
    if ($('.btn-filter').hasClass('open')) {
      $('.btn-filter').removeClass('open');
    }
  });

  return false;
});
