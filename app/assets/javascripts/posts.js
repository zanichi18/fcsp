$(document).ready(function(){
  $('input#image-user-post').on('change', function(){
    $('.form-user-post').find('img').remove();
  });
});
