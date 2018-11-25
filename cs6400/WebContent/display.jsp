
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
      var atlanta = {lat: 33.753746, lng: -84.386330};
      // The map, centered at atlanta
      var map = new google.maps.Map(
          document.getElementById('map'), {zoom: 12, center: atlanta});
      // The marker, positioned at atlanta
      var house = '${houseInfo}';
      var marker = new google.maps.Marker({position: atlanta, map: map});
    }
    </script>
    

  </body>
</html>