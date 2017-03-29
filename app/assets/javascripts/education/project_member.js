$(document).ready(function(){
  var idItems = [];
  var position = [];
  
  $('select[name="position"]').hide();

  $('#project_member_search').on('keyup',function() {
      
      $('input:checkbox[name="users[]"]:checked').each(function(){
        i = $(this).val();
        p = $('#project-member-position-'+i).val();
        position[i] = $('#project-member-position-'+i).val();
      });

      var user_search = $(this).val();
      var user_ids = idItems
      var member_position = position
      data = {user_search, user_ids, member_position}
      $.get($(this).attr('action'), data, null, 'script');
      return false;
    }
  );

  $('#search_added_members').on('keyup', function() {
      $.get($(this).attr('action'),
      $(this).serialize(), null, 'script');
      return false;
    }
  );
 
  check_user = function(obj) { 
    if($(obj).is(':checked')){
      i = parseInt($(obj).val())
      idItems.push(i);
      $('#project-member-position-'+i).show();
    }
    else{
      var index = idItems.indexOf($(obj).val());
      $('#project-member-position-'+$(obj).val()).hide();
      idItems.splice(index, 1);
    }
  };

  $('.check_all').click( function() {
    $('input[name="users[]"]').prop('checked', this.checked)
    if($(this).is(":checked")) {
      $('select[name="position"]').show();
    }
    else {
      $('select[name="position"]').hide();
    }
  })

  $('.create-member a').on('click', function(){
    var users = {}
    $('input:checkbox[name="users[]"]:checked').each(function(){
      i = $(this).val();
      users[i] = $('#project-member-position-'+i).val();
    });
    
    var project_id = $('#project_id').val();
    $.ajax({
      type: 'post',
      url: '/education/project_members',
      data: {users, project_id}
    });
  })
});
