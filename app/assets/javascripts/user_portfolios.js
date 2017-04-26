function delete_portfolio(id) {
  $.ajax({
    type: 'DELETE',
    url: '/user_portfolios/' + id,
    dataType: 'json',
    success: function(data) {
      if(data['status'] === 200) {
        $('#portfolio-' + id).remove();
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

  $('.delete-portfolio').on('click', function() {
    var id = this.dataset.id;
    var status_alert = I18n.t('javascripts.user_portfolio_alert');
    if(confirm(status_alert)) {
      delete_portfolio(id);
    }
  });
});
