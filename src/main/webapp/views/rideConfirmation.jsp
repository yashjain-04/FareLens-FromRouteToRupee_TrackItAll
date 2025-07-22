<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ride Confirmation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        :root {
            --primary-color: #1E3A8A;
            --secondary-color: #22C55E;
            --background-color: #0F172A;
            --text-color: #F8FAFC;
            --card-bg: #1E293B;
            --input-bg: #334155;
            --danger-color: #EF4444;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: var(--background-color);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        header {
            background-color: var(--primary-color);
            padding: 1rem 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: var(--text-color);
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }
        
        .card {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }
        
        .card h2 {
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
            color: var(--secondary-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .success-icon {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
        }
        
        .success-icon i {
            font-size: 4rem;
            color: var(--secondary-color);
            background-color: rgba(34, 197, 94, 0.1);
            border-radius: 50%;
            padding: 1.5rem;
        }
        
        .ride-details {
            margin-bottom: 2rem;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .detail-row:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            color: rgba(248, 250, 252, 0.6);
        }
        
        .detail-value {
            font-weight: 500;
        }
        
        .fare-card {
            background-color: rgba(34, 197, 94, 0.1);
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .fare-title {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
        }
        
        .fare-title h3 {
            color: var(--secondary-color);
            font-size: 1.2rem;
        }
        
        .fare-amount {
            font-size: 1.8rem;
            font-weight: bold;
            color: var(--secondary-color);
        }
        
        .map-container {
            height: 300px;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 2rem;
        }
        
        #map {
            height: 100%;
            width: 100%;
        }
        
        .btn-row {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }
        
        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .btn-primary {
            background-color: var(--secondary-color);
            color: #0F172A;
        }
        
        .btn-secondary {
            background-color: transparent;
            color: var(--text-color);
            border: 1px solid var(--text-color);
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .btn-primary:hover {
            background-color: #16A34A;
        }
        
        .btn-secondary:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        footer {
            text-align: center;
            padding: 1.5rem;
            background-color: var(--primary-color);
            margin-top: auto;
        }

        footer a {
                    color: var(--text-color);
                    text-decoration: none;
                    margin: 0 0.5rem;
                    transition: color 0.3s ease;
                }
                footer a:hover {
                    color: var(--secondary-color);
                }
    </style>
</head>
<body>
    <header>
        <div class="logo">FareLens</div>
    </header>
    
    <div class="container">
        <div class="card">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            
            <h2 class="text-center">${name} Your Ride is Confirmed!</h2>
            
            <div class="ride-details">
                <div class="detail-row">
                    <span class="detail-label">Ride ID</span>
                    <span class="detail-value">#${rideId}</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">From</span>
                    <span class="detail-value">${origin}</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">To</span>
                    <span class="detail-value">${destination}</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Distance</span>
                    <span class="detail-value">${distance}</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Duration</span>
                    <span class="detail-value">${duration}</span>
                </div>
            </div>
            
            <div class="fare-card">
                <div class="fare-title">
                    <h3>Estimated Fare</h3>
                    <div class="fare-amount">₹${estimatedFare}</div>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Base Fare</span>
                    <span class="detail-value">₹${baseFare}</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Distance Charge</span>
                    <span class="detail-value">₹${distanceFare}</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Surge Pricing (${surgePricing}x)</span>
                    <span class="detail-value">₹${surgePricing > 1 ? String.format("%.2f", estimatedFare - (baseFare + distanceFare)) : "0.00"}</span>
                </div>
            </div>
            
            <div class="map-container">
                <div id="map"></div>
            </div>
            
            <div class="btn-row">
                <a href="/rides/" class="btn btn-secondary">Cancel</a>
                <a href="/rides/${rideId}/start" class="btn btn-primary">Start Ride Simulation</a>
            </div>
        </div>
    </div>
    
    <footer>
           <p>&copy; 2025 FareLens : From Route To Rupee - Track It All!</p>
           <div style="margin-top: 1rem; display: flex; flex-wrap: wrap; justify-content: center; gap: 1rem;">
               <!-- LinkedIn profiles -->
               <a href="https://www.linkedin.com/in/-yashjain-/" target="_blank">
                   <i class="fab fa-linkedin"></i> Yash Jain
               </a>
               <a href="https://www.linkedin.com/in/ritik-kumar-developer/" target="_blank">
                   <i class="fab fa-linkedin"></i> Ritik Kumar
               </a>
               <a href="https://www.linkedin.com/in/vikaschourasiya79/" target="_blank">
                   <i class="fab fa-linkedin"></i> Vikas Chourasiya
               </a>
               <a href="https://www.linkedin.com/in/vinaypatidar708/" target="_blank">
                   <i class="fab fa-linkedin"></i> Vinay Patidar
               </a>
               <a href="https://www.linkedin.com/in/kanishka-dikhit-466837272/" target="_blank">
                   <i class="fab fa-linkedin"></i> Kanishka Dikhit
               </a>
           </div>
           <p style="margin-top: 1rem;"><strong>Developed by Team VijayVeer | Indore Institute of Science and Technology.</strong></p>
       </footer>
    
    <script>
            let map;
            let directionsService;
            let alternativeRoutes = [];

            let zoomNum;
                let distanceStr = "${distance}"; // Example: "25.4 km"
                let totDistance = parseFloat(distanceStr.replace(" km", ""));

            if (totDistance <= 5) zoomNum = 17;
                else if (totDistance <= 10) zoomNum = 16;
                else if (totDistance <= 50) zoomNum = 12;
                else if (totDistance <= 80) zoomNum = 9;
                else if (totDistance <= 200) zoomNum = 9;
                else if (totDistance <= 400) zoomNum = 8;
                else if (totDistance <= 800) zoomNum = 7;
                else if (totDistance <= 1000) zoomNum = 6;
                else zoomNum = 5;

                console.log(zoomNum);

            function initMap() {
                const originLatVal = "${originLat}";
                            const originLngVal = "${originLng}";
                            const destLatVal = "${destinationLat}";
                            const destLngVal = "${destinationLng}";

                            // Parse as numbers
                            const originLatNum = parseFloat(originLatVal);
                            const originLngNum = parseFloat(originLngVal);
                            const destLatNum = parseFloat(destLatVal);
                            const destLngNum = parseFloat(destLngVal);

                            console.log("Initializing map with coordinates:", {
                            originLat: originLatNum,
                            originLng: originLngNum,
                            destLat: destLatNum,
                            destLng: destLngNum
                            });

                            // Create map
                            const origin = { lat: originLatNum, lng: originLngNum };
                            const destination = { lat: destLatNum, lng: destLngNum };

                            // Center map between origin and destination
                            const center = {
                                lat: (origin.lat + destination.lat) / 2,
                                lng: (origin.lng + destination.lng) / 2
                            };

                // Initialize the map
                map = new google.maps.Map(document.getElementById("map"), {
                    zoom: zoomNum,
                    center: center,
                    mapId: "4504f8b37365c3d0",
                    disableDefaultUI: true,
                zoomControl: true,
                fullscreenControl: true,
                streetViewControl: true,
                mapTypeControl: true
                });

                // Initialize the Directions API service
                directionsService = new google.maps.DirectionsService();

                // Create origin and destination markers
                const originMarker = new google.maps.Marker({
                    position: { lat: parseFloat("${originLat}"), lng: parseFloat("${originLng}") },
                    map: map,
                    icon: {
                        url: "https://maps.google.com/mapfiles/ms/icons/green-dot.png",
                        scaledSize: new google.maps.Size(40, 40)
                    },
                    title: "Origin"
                });

                const destinationMarker = new google.maps.Marker({
                    position: { lat: parseFloat("${destinationLat}"), lng: parseFloat("${destinationLng}") },
                    map: map,
                    icon: {
                        url: "https://maps.google.com/mapfiles/ms/icons/red-dot.png",
                        scaledSize: new google.maps.Size(40, 40)
                    },
                    title: "Destination"
                });

                // Request multiple routes
                directionsService.route({
                    origin: { lat: parseFloat("${originLat}"), lng: parseFloat("${originLng}") },
                    destination: { lat: parseFloat("${destinationLat}"), lng: parseFloat("${destinationLng}") },
                    travelMode: google.maps.TravelMode.DRIVING,
                    provideRouteAlternatives: true // Request alternative routes
                }, (response, status) => {
                    if (status === "OK") {
                        const colors = ["#22C55E", "#3B82F6", "#F97316", "#E11D48"]; // Different colors for routes
                        response.routes.forEach((route, index) => {
                            const polyline = new google.maps.Polyline({
                                path: route.overview_path,
                                strokeColor: colors[index % colors.length],
                                strokeOpacity: 0.8,
                                strokeWeight: 5,
                                map: map
                            });
                            alternativeRoutes.push(polyline);
                        });

                        // Add route selection options
                        addRouteSelection(response.routes);
                    } else {
                        console.error("Directions request failed due to", status);
                    }
                });
            }

            function addRouteSelection(routes) {
                const routeSelector = document.createElement("select");
                routeSelector.style.position = "absolute";
                routeSelector.style.top = "10px";
                routeSelector.style.left = "10px";
                routeSelector.style.zIndex = "1000";

                routes.forEach((route, index) => {
                    const option = document.createElement("option");
                    option.value = index;
                    option.textContent = `Route ${index + 1} - ${route.legs[0].distance.text} (${route.legs[0].duration.text})`;
                    routeSelector.appendChild(option);
                });

                routeSelector.addEventListener("change", (event) => {
                    const selectedIndex = event.target.value;
                    alternativeRoutes.forEach((polyline, index) => {
                        polyline.setOptions({ strokeOpacity: index == selectedIndex ? 1.0 : 0.4 });
                    });
                });
            }
        </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBoQ6FN55NtAUucLWKMDW5s1CricaJ8UdE&libraries=geometry&callback=initMap" async defer></script>
</body>
</html> 