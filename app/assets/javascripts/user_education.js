$(document).ready(function() {
  $('.edit-education').hide();
  $('.education-info').mouseenter(function(){
    $(this).find('.edit-education').show();
  }).mouseleave(function() {
    $(this).find('.edit-education').hide();
  });
});
