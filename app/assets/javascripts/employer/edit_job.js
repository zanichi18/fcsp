$(document).ready(function () {
  $('.edit .form_ajax form').on('submit', function(e){
    e.preventDefault();
    var form = $('form')[0];
    var formData = new FormData(form);
    $.ajax({
      url: $('form').attr('action'),
      cache: false,
      type: 'patch',
      dataType: 'json',
      contentType: false,
      processData: false,
      data: formData,
      success: function(data, textStatus, xhr){
        if (xhr.status === 200) {
          $('.edit .step-2-content').append(data.html_job);
          $('#step-1').hide();
          $('#step-2').slideDown();
          $('#a_step1').removeClass('selected').addClass('done');
          $('#a_step2').removeClass('disabled').addClass('selected');
          swal({
            type: 'success',
            title: I18n.t('employer.jobs.update.updated'),
            text: I18n.t('employer.jobs.update.job_post_updated')
          });
        } else {
          $(':submit').removeAttr('disabled');
          swal({
            type: 'error',
            title: I18n.t('employer.jobs.update.failed'),
            text: I18n.t('employer.jobs.update.job_post_update_fail')
          });
        }
      },
      error: function(){
        $(':submit').removeAttr('disabled');
        swal({
          type: 'error',
          title: I18n.t('employer.jobs.update.failed'),
          text: I18n.t('employer.jobs.update.job_post_update_fail')
        });
      }
    });
  });

  $('.edit .buttonPrevious').click(function(){
    $('#step-1').show();
    $('#step-2').hide();
    $('#a_step1').removeClass('done').addClass('selected');
    $('#a_step2').removeClass('selected').addClass('done');
    $(':submit').removeAttr('disabled');
  });
});
