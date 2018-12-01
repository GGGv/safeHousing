
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@ page import="org.json.simple.parser.JSONParser"%>

<!DOCTYPE html>

<html>
  <head>
  <link rel = "stylesheet" type = "text/css" href = "mystyle.css">
  </head>
  <body>
    <h3>Google Maps</h3>
    <!--The div element for the map -->
    <div id="map"></div>
    <div id="RecommandList">
        <table>
          <tr>
          <th>Housing Name</th>
          <th>Address</th>
          <th>Price</th>
          <th>Security Rate</th>
          </tr>
          
        <% 
         Object obj = request.getAttribute("houseInfo");
         JSONArray array = (JSONArray)obj;
		 int houseNum = 20;
		 if(array.size() < houseNum)	houseNum = array.size();
         for(int i = 0; i < houseNum; i++){ 
            JSONObject json = (JSONObject)array.get(i);
			%>
          <tr>
          <th><% out.println(json.get("id")); %></th>   
          <th><% out.println(json.get("address")); %></th>
          <th><% out.println(json.get("price")); %></th>
          </tr> 
       <%}%>

        </table>
    </div>

    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCbtPOHg_6oCT51HCFeTF1zb4vGv3pcG_E&callback=initMap">
    </script>
     
    <script>
    
 	// Initialize and add the map
    function initMap() {
      // The location of atlanta
      var houses = '${houseInfo}';
      //var NY = {lat: 40.730610, lng: -73.935242};
      var NY = {lat: houses[1].latitude, lng: houses[1].longitude};
      
      // The map, centered at atlanta
      var map = new google.maps.Map(
          document.getElementById('map'), {zoom: 10, center: NY});
      
      var marker = new google.maps.Marker({position: NY, map: map});
      /*
      var locations;
      for(var i = 0; i < houses.length; i++){
        var newLocation = {lat: houses[i].latitude, lng: houses[i].longitude};
        locations.push(newLocation);
      }

      // Create an array of alphabetical characters used to label the markers.
      var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      var markers = locations.map(function(location, i){
        return new google.maps.Marker({
          position: location,
          label: labels[i]
        });
      });
      var markerCluster = new MarkerCluster(map, markers,  {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'}); 
      */
    }
    </script>

    <script>
      <script src="markerclusterer.js">
    </script>

  </body>
</html>