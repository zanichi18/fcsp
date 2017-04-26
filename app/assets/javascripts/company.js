$(document).ready(function() {
  $('#tab-jobs .pagination').hide();
  $(document).delegate('#load-more', 'click', function() {
    loadMore();
  });
});

function loadMore() {
  var url = $('#tab-jobs .pagination a[rel=next]').attr('href');
  if (url) {
    $.get(url, function(data) {
      $('#load-more').replaceWith(data.content);
      $('#tab-jobs .pagination').hide();
      next_url = $('#tab-jobs .pagination a[rel=next]').attr('href');
      if (!next_url) {
        $('.btn-info').remove();
      }
    });
  }
}
