// Initialize and add the map
function initMap() {
  // The location of atlanta
  var atlanta = {lat: 33.753746, lng: -84.386330};
  // The map, centered at atlanta
  var map = new google.maps.Map(
      document.getElementById('map'), {zoom: 12, center: atlanta});
  // The marker, positioned at atlanta
  var marker = new google.maps.Marker({position: atlanta, map: map});
}