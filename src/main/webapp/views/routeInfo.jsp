<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Route Information</title>
</head>
<body>
    <h2>Confirm Your Ride</h2>
    <p><b>From:</b> ${origin}</p>
    <p><b>To:</b> ${destination}</p>
    <p><b>Expected Distance:</b> ${distance}</p>
    <p><b>Expected Duration:</b> ${duration}</p>

    <div id="map" style="width: 80%; height: 300;"></div>

    <script>
        function initMap() {
            var map = new google.maps.Map(document.getElementById("map"), {
                zoom: 5,
                center: { lat: 22.7196, lng: 75.8577 } // Default center
            });

            var encodedPolyline = "${encodedPolyline}"; // Pass from backend
            var decodedPath = google.maps.geometry.encoding.decodePath(encodedPolyline);

            var routePath = new google.maps.Polyline({
                path: decodedPath,
                geodesic: true,
                strokeColor: "#FF0000",
                strokeOpacity: 1.0,
                strokeWeight: 2
            });

            routePath.setMap(map);
        }
    </script>
</body>
</html>


