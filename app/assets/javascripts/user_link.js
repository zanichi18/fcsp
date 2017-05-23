$(document).ready(function() {
  $('.edit-link').hide();
  $('.link-info').mouseenter(function(){
    $(this).find('.edit-link').show();
  }).mouseleave(function() {
    $(this).find('.edit-link').hide();
  });
});
