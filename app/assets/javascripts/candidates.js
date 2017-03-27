$(document).ready(function(){
  $('.new_candidate').submit(function(e){
    e.preventDefault();
    var $form = $(this);
    $.ajax({
      dataType: 'html',
      url: '/candidates',
      type: 'POST',
      data: {candidate:
        {user_id: $('#user_id').val(),
        job_id: $('#job_id').val()}},
      success: function(data) {
        $('.new_candidate').remove();
        $('.apply_job').append(data);
      }
    })
  })
});
