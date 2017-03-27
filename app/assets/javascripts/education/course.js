$(document).ready(function() {

  $('.datetimepicker').datepicker({
    dateFormat: 'dd/mm/yy'
  });

  $('#course_search').on('keyup',function() {
    var course_search = $(this).val();
    var training_id = $('#training_id').val();
    data = {course_search, training_id}
    $.get($(this).attr('action'),
      data, null, 'script');
  });

  $('#training_id').on('change', function(){
    var course_search = $('#course_search').val();
    var training_id = $(this).val();
    data = {course_search, training_id}
    $.get($(this).attr('action'),
      data, null, 'script');
  });

  $('.course_image_slide').carousel();

  var onAddFile;
  onAddFile = function(event) {
    var file, thumbContainer, url;
    file = event.target.files[0];
    url = URL.createObjectURL(file);
    thumbContainer = $(this).parent().siblings('td.thumb');
    if (thumbContainer.find('img').length === 0) {
      return thumbContainer.append('<img src="' + url + '" />');
    } else {
      return thumbContainer.find('img').attr('src', url);
    }
  };
  $('input[type=file]').each(function() {
    return $(this).change(onAddFile);
  });
  $('body').on('cocoon:after-insert', function(e, addedPartial) {
    return $('input[type=file]', addedPartial).change(onAddFile);
  });
  $('a.add_fields').data('association-insertion-method', 'append');
  return $('a.add_fields').data('association-insertion-node', 'table.user-photo-form tbody');
});
