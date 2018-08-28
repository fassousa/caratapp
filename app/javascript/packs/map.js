import GMaps from 'gmaps/gmaps.js';
import { autocomplete } from '../components/autocomplete';

function initMap() {
  var mapElement = document.getElementById('map');
  if (mapElement) { // don't try to build a map if there's no div#map to inject in
    var map = new GMaps({ el: '#map', lat: 0, lng: 0 });
    var markers = JSON.parse(mapElement.dataset.markers);
    map.addMarkers(markers);
    if (markers.length === 0) {
      map.setZoom(2);
    } else if (markers.length === 1) {
      map.setCenter(markers[0].lat, markers[0].lng);
      map.setZoom(14);
    } else {
      map.fitLatLngBounds(markers);
    }
  }
  window.map = map
}

initMap();

autocomplete();

var btnMap = document.getElementById("init-map")

btnMap.addEventListener('click', function() {
  console.log("hey");
  initMap();
})
