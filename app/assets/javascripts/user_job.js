$(function() {
  loadMore.initialize();
});

var loadMore = {
  initialize: function() {
    loadMore.lazyLoad('#tab-jobs');
    loadMore.lazyLoad('#tab-suggest-job');
  },

  lazyLoad: function(id) {
    $(id + ' .pagination').hide();
    $(document).delegate(id + ' .load-more', 'click', function() {
      var url = $(id + ' .pagination a[rel=next]').attr('href');
      if (url) {
        $.get(url, function(data) {
          $(id + ' .load-more').replaceWith(data.content);
          $(id + ' .pagination').hide();
          var next_url = $(id + ' .pagination a[rel=next]').attr('href');
          if (!next_url) {
            $('.btn-info').remove();
          }
        });
      }
    });
  }
};
