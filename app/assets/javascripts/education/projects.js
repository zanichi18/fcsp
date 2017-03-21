$(document).ready(function () {
  effect();
  load_more();
  $(function() {
    new app.Projects;
  });
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


var app = window.app = {};

app.Projects = function() {
  this._input = $('#projects-search-txt');
  this._initAutocomplete();
};

app.Projects.prototype = {
  _initAutocomplete: function() {
    this._input
      .autocomplete({
        source: Routes.education_projects_path(),
        appendTo: '#projects-search-results',
        select: $.proxy(this._select, this)
      })
    this._input.autocomplete().data("uiAutocomplete")._renderItem = $.proxy(this._render, this);
  },

  _render: function(ul, item) {
    var markup = [
      '<span class="img">',
        '<img src="' + item.image_url + '" />',
      '</span>',
      '<span class="name">' + item.name + '</span>',
      '<span class="description">' + item.description + '</span>',
      '<span class="plat-form">' + item.plat_form + '</span>'
    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  },

  _select: function(e, ui) {
    this._input.val(ui.item.name);
    return false;
  },
};


$(document).ready(function() {
  $('#projects-search-txt').on('keypress',function(e) {
    var enter = 13
    if(e.type === 'keypress' && e.keyCode === enter)
    {
      window.location.href = '/education/projects?term=' + $(this).val();
    }
  });
});
