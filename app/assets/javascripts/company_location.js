$(document).ready(function(){
  getLocation.initialize();
});

var getLocation = {
  initialize: function() {
    getLocation.fetch_data();
  },

  fetch_data: function() {
    var url_path = window.location.pathname;
    $.get(url_path, function(data) {
      var latitude = data[0].latitude;
      var longitude = data[0].longitude;

      getLocation.draw_map(latitude, longitude);
    }, 'json');
  },

  draw_map: function(lat, lng) {
    var companyLatlng = new google.maps.LatLng(lat, lng);
    var mapOptions = {
      zoom: 15,
      center: companyLatlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    var map = new google.maps.Map(document.getElementById('map'), mapOptions);
    var marker = new google.maps.Marker({
      position: companyLatlng,
      map: map
    });
  }
}
