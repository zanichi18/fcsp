$(document).ready(function(){
  $('#school-search').hsearchbox({
    url: '/user_educations',
    param: 'search',
    dom_id: '#result-school-search'
  });

  $('.graduation-datepicker').datepicker({
    format: 'MM yyyy',
    viewMode: "months",
    minViewMode: "months"
  });
});
