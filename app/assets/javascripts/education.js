// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require jquery-ui/autocomplete
//= require education/feedback_map.js
//= require education/growl.custom
//= require js-routes
//= require social-share-button
//= require education/projects
//= require cocoon
//= require education/course.js
//= require education/course_member.js
//= require education/users

$(document).ready(function(){
  var $searchlink = $('#searchtoggl i');
  var $searchbar  = $('.searchbar');

  $('#topnav ul li #searchtoggl').on('click', function(e){
    e.preventDefault();

    if($(this).attr('id') == 'searchtoggl') {
      if(!$searchbar.is(":visible")) {
        // if invisible we switch the icon to appear collapsable
        $searchlink.removeClass('fa-search').addClass('fa-search-minus');
      } else {
        // if visible we switch the icon to appear as a toggle
        $searchlink.removeClass('fa-search-minus').addClass('fa-search');
      }

      $searchbar.slideToggle(300, function(){
        // callback after search bar animation
      });
    }
  });

  $('#searchform').submit(function(e){
    e.preventDefault(); // stop form submission
  });
})
