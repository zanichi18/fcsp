$(document).ready(function () {
  effect();
  load_more();
});

function effect() {
  $('ul[data-liffect] li').each(function (i) {
    $(this).attr('style', 'animation-delay:' + i * 250 + 'ms;');
    if (i === $('ul[data-liffect] li').size() -1) {
      $('ul[data-liffect]').addClass('play')
  }});
}

function load_more() {
  size = $('.load-more-project').length;
  x = 8;
  if(x >= size) {
    $('#more-project').hide();
    $('#next-project').show();
  } 
  else {
    $('#next-project').hide();
    $('#more-project').show();
  };
  $('.load-more-project:lt(' + size + ')').hide();
  $('.load-more-project:lt(' + x + ')').show();
  $('.read-more').click(function () {
    x = (x <= size) ? x + 4 : size;
    $('.load-more-project:lt(' + x + ')').show();
    if(x >= size){
      $('#more-project').hide();
      $('#next-project').show();
      $("#back-project").show();
    }
  });
}



