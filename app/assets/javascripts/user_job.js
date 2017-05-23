$(document).ready(function() {
  $('#tab-suggest-job .pagination').hide();
  $(document).delegate('#tab-suggest-job .load-more', 'click', function() {
    loadMore();
  });

  function loadMore() {
    var url = $('#tab-suggest-job .pagination a[rel=next]').attr('href');
    if (url) {
      $.get(url, function(data) {
        $('#tab-suggest-job .load-more').replaceWith(data.content);
        $('#tab-suggest-job .pagination').hide();
        var next_url = $('#tab-suggest-job .pagination a[rel=next]').attr('href');
        if (!next_url) {
          $('.btn-info').remove();
        }
      });
    }
  }
});
