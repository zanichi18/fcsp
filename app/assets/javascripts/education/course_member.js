$(document).ready(function(){
  var idItems = [];

  $('.search_users').on('keyup', '#user_search', 
    function() {
      var user_search = $('#user_search').val();
      var user_ids = idItems
      data = {user_search, user_ids}

      $.get($('#user_search').attr('action'), data, null, 'script');
      return false;
    }
  );

  $('.search_added_users').on('keyup', '#search_added_users', 
    function() {
      $.get($('#search_added_users').attr('action'),
      $('#search_added_users').serialize(), null, 'script');
      return false;
    }
  );
 
  check_user = function(obj) { 
    if($(obj).is(':checked')){
      idItems.push(parseInt($(obj).val()));
    }
    else{
      var index = idItems.indexOf($(obj).val());
      idItems.splice(index, 1);
    }
  };

  $('.check_all').click( function() {
    $('input[name="users[]"]').prop('checked', this.checked)
  })
});
