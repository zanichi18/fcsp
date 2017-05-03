$(document).ready(function () {
  $('.form_ajax form').on('submit',function(e){
    e.preventDefault();
    var form = $('form')[0];
    var formData = new FormData(form);
    $.ajax({        
        url: $('form').attr('action'),
        cache: false,
        type: 'POST',
        dataType: 'json',
        contentType: false, 
        processData: false,
        data: formData,
        success: function(result){
          $('.step-2-content').append(result.html_job);
          $('#step-1').hide();
          $('#step-2').slideDown();
          $('#a_step1').removeClass('selected');
          $('#a_step1').addClass('done');
          $('#a_step2').removeClass('disabled');
          $('#a_step2').addClass('selected');
          alert(I18n.t("employer.jobs.new.success"));
        },
        error: function(result){
          alert(result.errors);
         }
    });
  });
  
  $('.buttonPrevious').click(function(){
    $('#step-1').show();
    $('#step-2').hide();
    $('#a_step1').removeClass('done');
    $('#a_step1').addClass('selected');
    $('#a_step2').removeClass('selected');
    $('#a_step2').addClass('done');
  });

});
