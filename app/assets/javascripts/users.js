$(document).ready(function(){
  $('.change-image').on('change', function(){
    read_url(this);
    $('.user-old-image').val('');
    $('.btn-submit-avatar').addClass('btn-create-avatar');
    $('.btn-submit-avatar').removeClass('btn-update-avatar');
    $('.btn-submit-cover').addClass('btn-create-cover');
    $('.btn-submit-cover').removeClass('btn-update-cover');
  });

  $('.album-image').hide();

  $('.album-for-user').on('click', function(){
    $('.album-image').show();
  });

  $('.user-image-img').on('click', function(){
    image_id = this.dataset.id;
    image_src = $('#user-image-' + image_id).attr('src');
    $('.img-upload').attr('src', image_src);
    $('.user-old-image').val(image_id);
    $('.change-image').val('');
    $('.btn-submit-avatar').addClass('btn-update-avatar');
    $('.btn-submit-avatar').removeClass('btn-create-avatar');
    $('.btn-submit-cover').addClass('btn-update-cover');
    $('.btn-submit-cover').removeClass('btn-create-cover');
  });

  $('#changeAvatarModal').on('click', '.btn-create-avatar', function(){
    $('#form-create-avatar').submit();
  });

  $('#changeAvatarModal').on('click', '.btn-update-avatar', function(){
    $('#form-update-avatar').submit();
  });

  $('#changeCoverModal').on('click', '.btn-create-cover', function(){
    $('#form-create-cover').submit();
  });

  $('#changeCoverModal').on('click', '.btn-update-cover', function(){
    $('#form-update-cover').submit();
  });

  $('.hide-tab').hide();
  $('.hide-tab.active').show();
  $('.user-show a').click(function(){
    $('.user-show li.active').removeClass('active');
    $(this).parent().addClass('active');
    var target = '#' + $(this).data('target');
    $('.hide-tab').not(target).hide();
    $(target).show();
  });

  $('.edit-education').hide();
  $('.education-info').mouseenter(function(){
    $(this).find('.edit-education').show();
  }).mouseleave(function() {
    $(this).find('.edit-education').hide();
  });


  $('form#edit-about-me-form,' + 'form#edit-ambition-form,' + 
    'form#edit-introduction-form,' + 'form#edit-quote-form'
  ).bind('ajax:success', function(event, xhr, settings) {
    if(xhr['errors']) {
      $('.form-group').removeClass('has-error');
      $('span').remove('.help-block');
      var $form = $(this);
      if(xhr['errors']) {
        $.map(xhr['errors'], function(v, k) {
          var element_id = '#info_user_' + k;
          var $divFormGroup = $form.find(element_id).parent();
          $divFormGroup.addClass('has-error');
          $divFormGroup.append('<span class="help-block">' + v + '</span>');
        });
      }
    }else {
      $(this).closest('.modal').modal('hide');
      $('.form-group').removeClass('has-error');
      $('span').remove('.help-block');
    }
  })
});

function read_url(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('.img-upload').attr('src', e.target.result);
    }
    reader.readAsDataURL(input.files[0]);
  }
}
