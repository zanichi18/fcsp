function delete_award(id) {
  $.ajax({
    type: 'DELETE',
    url: '/awards/' + id,
    dataType: 'json',
    success: function(data) {
      if(data['status'] === 200) {
        $('#award-' + id).remove();
        $.growl.notice({title: '', message: data['flash']});
      }
    },
    error: function(error_message) {
      $.growl.error({message: error_message});
      location.reload();
    }
  });
}

$(document).ready(function() {
  $('.datepicker').datepicker({
    format: 'dd-mm-yyyy'
  });

  $('.hover-button-award').hide();
  $('.award-hover').mouseenter(function(){
    $(this).find('.hover-button-award').show();
  }).mouseleave(function() {
    $(this).find('.hover-button-award').hide();
  });

  $('.delete-award').on('click', function() {
    var id = this.dataset.id;
    var status_alert = I18n.t('javascripts.user_award_alert');
    if(confirm(status_alert)) {
      delete_award(id);
    }
  });
});
