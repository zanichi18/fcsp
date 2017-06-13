$(document).ready(function () {
  $('#showLess').addClass('hidden');
  var size_li = $('.user-skill').size();
  var x=3;
  if (size_li <= 3) {
    $('#loadMore').addClass('hidden');
  }
  $('.user-skill:lt('+x+')').show();
  $('#loadMore').click(function () {
    $('#showLess').removeClass('hidden');
    x = (x+3 <= size_li) ? x+3 : size_li;
    $('.user-skill:lt('+x+')').show();
    if (size_li <= x) {
       $('#loadMore').addClass('hidden');
    }
  });
  $('#showLess').click(function () {
    $('#loadMore').removeClass('hidden');
    x=(x-3<0) ? 1 : x-3;
    $('.user-skill').not(':lt('+x+')').hide();
    if (3 >= x) {
      $('#showLess').addClass('hidden');
    }
  });
});
