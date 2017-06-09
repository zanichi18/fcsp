$(document).ready(function(){
  $('#friend_search').on('keyup', function() {
    var friend_search = $(this).val();
    var id = $('.get-id').attr('data-id');
    var data = {friend_search: friend_search};
    $.get('/users/'+ id, data, null, 'script');
  });
});
