$(document).ready(function() {
  $('#language-search-box').hsearchbox({
    url: '/user_languages',
    param: 'company',
    dom_id: '#livesearch_dom'
  });

  $('.org-search').on('click', function() {
    $('#language-search-box').val(this.dataset.name);
  })
});
