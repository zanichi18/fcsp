//= require js/simplemde.min
//= require dropzone

$(document).ready(function(){
  var simplemde = new SimpleMDE({ element: document.getElementById('education_post_content'),
    spellChecker: false,
    toolbar: [
      'bold',
      'italic',
      'strikethrough',
      'heading',
      'heading-1',
      'heading-2',
      'heading-3',
      '|',
      'code',
      'quote',
      'unordered-list',
      'ordered-list',
      'clean-block',
      '|',
      'link',
      {
        name: 'image',
        action: function(){
          $('#image_insert_dialog').modal('show')
        },
        className: 'fa fa-image',
        title: 'Insert image'
      },
      'table',
      'horizontal-rule',
      '|',
      'preview',
      'side-by-side',
      'fullscreen',
      'guide',
    ]
  });
  if($('#dropzone').length){
    var mediaDropzone = new Dropzone('#dropzone');
    Dropzone.options.mediaDropzone = false;
    mediaDropzone.options.acceptedFiles = '.jpeg,.jpg,.png,.gif';
    mediaDropzone.options.maxFilesize = 1;
    mediaDropzone.options.createImageThumbnails = false;
    mediaDropzone.options.previewTemplate = '<div></div>';
    mediaDropzone.on('complete', function(files) {
      var response = JSON.parse(files.xhr.response);
      appendContent(response.url.url);
    });
  }

  $(document).on('click', '.mb-1', {}, function(e){
    $('#image_insert_dialog').modal('hide');
    var trigger = $('#image_insert_dialog').attr('trigger');
    var image = e.target
    var src = $(image).attr('src');
    if(trigger === '#choose-cover-btn'){
      $('#education_post_cover_photo').val(src);
      $('#image_insert_dialog').removeAttr('trigger');
    }else{
      var oldValue = simplemde.value();
      simplemde.value(oldValue + '![]('+src+')');
    }
  });

  $(document).on('click', '#choose-cover-btn', {}, function(e){
    e.preventDefault();
    $('#image_insert_dialog').attr('trigger', '#choose-cover-btn');
    $('#image_insert_dialog').modal('show');
  });

  $(document).ready(function(){
    $('.education_post_content').addClass('education-post-content');
    $('.CodeMirror-wrap').addClass('code-mirror-wrap');
    $('.CodeMirror-fullscreen').addClass('code-mirror-fullscreen');
    $('.CodeMirror-sided').addClass('code-mirror-sided');
  })
});


var appendContent = function(imageUrl){
  $('.mt-1').prepend('<div class=\"col-md-2 col-xs-3 mb-1\">'+
    '<a href=\"javascript:;\" class=\"thumbnail\" style=\"display: inline-block;\">'+
    '<img src=\"'+imageUrl+'" class=\"w-100\"></a></div>');
}
