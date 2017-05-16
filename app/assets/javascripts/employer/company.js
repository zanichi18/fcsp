$(document).ready(function() {
  $('#wizard').smartWizard({
    includeFinishButton: false,
    labelNext: I18n.t('employer.companies.edit.next'),
    labelPrevious: I18n.t('employer.companies.edit.previous'),
    onLeaveStep: leaveStepCallback,
    reverseButtonsOrder: true
  });

  function leaveStepCallback(obj, context){
    if (context.fromStep === 1) {
      sendForm();
    }
    return true;
  }

  function sendForm(){
    var form = $('#edit_company_info');
    var formdata = new FormData(form[0]);
    var url = form.attr('action');
    $.ajax({
      type: 'patch',
      url: url,
      cache: false,
      contentType: false,
      processData: false,
      data: formdata,
      success: function(data){
        if (data.status === 'created') {
          swal({
            type: 'success',
            title: I18n.t('employer.companies.update.updated'),
            text: I18n.t('employer.companies.update.company_updated')
          });
        } else {
          $('#wizard').smartWizard('goBackward');
          swal({
            type: 'error',
            title: I18n.t('employer.companies.update.failed'),
            text: I18n.t('employer.companies.update.company_update_fail')
          });
        }
      },
      error: function() {
        $('#wizard').smartWizard('goBackward');
      }
    });
  }
});
