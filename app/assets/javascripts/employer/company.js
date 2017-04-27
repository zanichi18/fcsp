$(document).ready(function() {
  fade_flash();

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
      data: formdata ? formdata : form.serialize(),
      success: function(data){
        var msg = data.flash.msg;
        var type = data.flash.type;
        if (type === 'danger') {
          $('#wizard').smartWizard('goBackward');
        }
        show_ajax_message(msg, type);
      },
      error: function() {
        $('#wizard').smartWizard('goBackward');
      }
    });
  }

  function fade_flash() {
    $('#flash-message').show();
    setTimeout(function() {
      $('#flash-message').hide();
    }, 4000);
  };

  function show_ajax_message(msg, type) {
    $('#flash-message').html('<div class="alert alert-' + type + ' text-center">'
      + msg + '</div>');
    fade_flash();
  };
});
