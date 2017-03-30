$(document).ready(function() {
  $('.delete-training').on('click', function() {
    var id = this.dataset.id;
    var status_alert = I18n.t('education.javascripts.training_alert');
    if(confirm(status_alert)) {
      delete_training(id);
    }    
  })
});

function delete_training(id) {
  $.ajax({
    type: "DELETE",
    url: "/education/trainings/" + id,
    dataType: "json",
    success: function(data) {
      if(data['status'] === 200) {
        $('#training-' + id).remove();
        $('#wrapper').trigger('resize');
        $.growl.notice({title: '', message: data['flash']});
      }
    },
    error: function(error_message) {
      $.growl.error({message: error_message});
      location.reload();
    }
  });
}
