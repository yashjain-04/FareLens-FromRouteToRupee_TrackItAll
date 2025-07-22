<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ride Simulation</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: var(--text-color);
        }
        
        .nav-links {
            display: flex;
            gap: 1.5rem;
        }
        
        .nav-link {
            color: var(--text-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .nav-link:hover {
            color: var(--secondary-color);
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
        
        .ride-status {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
            background-color: rgba(34, 197, 94, 0.1);
            padding: 1rem;
            border-radius: 10px;
        }
        
        .status-icon {
            font-size: 2rem;
            color: var(--secondary-color);
            animation: pulse 1.5s infinite;
        }
        
        @keyframes pulse {
            0% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.1);
                opacity: 0.7;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
        
        .status-text {
            flex: 1;
        }
        
        .status-text h3 {
            font-size: 1.1rem;
            margin-bottom: 0.3rem;
            color: var(--secondary-color);
        }
        
        .status-text p {
            font-size: 0.9rem;
            opacity: 0.8;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .stat-label {
            font-size: 0.9rem;
            opacity: 0.7;
        }
        
        .stat-value {
            font-size: 1.5rem;
            font-weight: bold;
        }
        
        .map-container {
            height: 400px;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 2rem;
        }
        
        #map {
            height: 100%;
            width: 100%;
        }
        
        .progress-container {
            margin-bottom: 2rem;
        }
        
        .progress-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }
        
        .progress-bar {
            height: 8px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 4px;
            overflow: hidden;
        }
        
        .progress-fill {
            height: 100%;
            background-color: var(--secondary-color);
            width: 0%;
            transition: width 0.3s ease;
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
        
        .btn-danger {
            background-color: var(--danger-color);
            color: var(--text-color);
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
        
        .btn-danger:hover {
            background-color: #DC2626;
        }
        
        .btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
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
        <div class="nav-links">
            <a href="/rides/" class="nav-link">Home</a>
            <a href="/rides/history" class="nav-link">Ride History</a>
        </div>
    </header>
    
    <div class="container">
        <div class="card">
            <h2><i class="fas fa-car"></i> Live Ride Simulation</h2>
            
            <div class="ride-status">
                <div class="status-icon">
                    <i class="fas fa-car-side"></i>
                </div>
                <div class="status-text">
                    <h3>Ride in Progress</h3>
                    <p>${name} Your driver is taking you to your destination</p>
                </div>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-label">Distance Traveled</div>
                    <div class="stat-value" id="distance-traveled">0.0 km</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-label">Time Elapsed</div>
                    <div class="stat-value" id="time-elapsed">00:00</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-label">Current Fare</div>
                    <div class="stat-value" id="current-fare">₹0.0</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-label">ETA</div>
                    <div class="stat-value" id="eta">-- min</div>
                </div>
            </div>
            
            <div class="progress-container">
                <div class="progress-label">
                    <span>Trip Progress</span>
                    <span id="progress-percent">0%</span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" id="progress-fill"></div>
                </div>
            </div>
            
            <div class="map-container">
                <div id="map"></div>
            </div>
            
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
                    <span class="detail-label">Estimated Fare</span>
                    <span class="detail-value">₹${estimatedFare}</span>
                </div>
            </div>
            
            <form id="complete-ride-form" action="/rides/${rideId}/complete" method="post">
                <input type="hidden" name="actualDistance" id="actual-distance-input" value="0">
                <input type="hidden" name="actualDuration" id="actual-duration-input" value="0">
                <input type="hidden" name="actualPolyline" id="actual-polyline-input" value="${encodedPolyline}">
                
                <div class="btn-row">
                    <button type="button" id="cancel-btn" class="btn btn-secondary">Cancel Simulation</button>
                    <button type="submit" id="complete-btn" class="btn btn-primary" disabled>Complete Ride</button>
                </div>
            </form>
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
        let carMarker;
        let path;
        let decodedPath = [];
        let startTime;
        let animationStep = 0;
        let simulationInterval;
        let totalSteps = 100; // Number of steps to complete the animation
        let actualDistance = 0;
        let actualDuration = 0;
        let simulationRunning = false;
        let timerInterval; // New variable for tracking the timer

        // Helper function to directly update the time display - guarantees update
        function updateTimeDisplay() {
            try {
                const now = new Date();
                const elapsedTimeInSeconds = Math.floor((now - startTime) / 1000);
                console.log(elapsedTimeInSeconds);
                const minutes = Math.floor(elapsedTimeInSeconds / 60);
                console.log(minutes);
                const seconds = elapsedTimeInSeconds % 60;
                console.log(seconds);
                const timeString = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
                console.log(timeString);
                document.getElementById('time-elapsed').innerHTML = timeString;
            } catch (e) {
                console.error("Error directly updating time:", e);
            }
        }

        // Wait for page to fully load before initialization
        window.onload = function() {
            console.log("Page loaded, waiting for map to initialize");
        };

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

            // Create the map
            map = new google.maps.Map(document.getElementById("map"), {
                zoom: 10,
                center: center,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                zoomControl: true,
                fullscreenControl: true,
                streetViewControl: true,
                mapTypeControl: true
            });

            const trafficLayer = new google.maps.TrafficLayer();
            trafficLayer.setMap(map);

            console.log("Map created:", map);

            // Get and decode polyline
            var encodedPolyline = "${encodedPolyline}";
            console.log("Encoded polyline:", encodedPolyline);

            // Initialize the Directions API services
                        directionsService = new google.maps.DirectionsService();

                        directionsRenderer = new google.maps.DirectionsRenderer({
                                        map: map,
                                        suppressMarkers: true, // Prevents extra red markers from appearing
                                        polylineOptions: {
                                            strokeColor: "#0A05A6",
                                            strokeWeight: 5,
                                            strokeOpacity: 0.8
                                        }
                                    });

            // Request the correct route using Google Directions API
                        directionsService.route({
                            origin: { lat: parseFloat("${originLat}"), lng: parseFloat("${originLng}") },
                            destination: { lat: parseFloat("${destinationLat}"), lng: parseFloat("${destinationLng}") },
                            travelMode: google.maps.TravelMode.DRIVING
                        }, (response, status) => {
                            if (status === "OK") {
                                directionsRenderer.setDirections(response);

                                // Extract polyline from response to ensure correct path
                                const routePath = response.routes[0].overview_path;
                                const pathPolyline = new google.maps.Polyline({
                                    path: routePath,
                                    geodesic: true,
                                    strokeColor: "#22C55E",
                                    strokeOpacity: 1.0,
                                    strokeWeight: 4,
                                    map: map
                                });

                                console.log("Route Path",routePath);


                                try {
                                                // Check if we have geometry library loaded
                                                if (!google.maps.geometry) {
                                                    console.error("Google Maps geometry library not loaded!");
                                                    return;
                                                }

                                                decodedPath = routePath;
                                                console.log("Decoded path points:", decodedPath.length);

                                                if (decodedPath.length === 0) {
                                                    console.error("No path points decoded!");
                                                    return;
                                                }

                                                // Create bounds to fit the route
                                                const bounds = new google.maps.LatLngBounds();

                                                // Add origin and destination to bounds
                                                bounds.extend(origin);
                                                bounds.extend(destination);

                                                // Add all path points to bounds
                                                decodedPath.forEach(point => bounds.extend(point));

                                                // Create markers for origin and destination
                                                new google.maps.Marker({
                                                    position: origin,
                                                    map: map,
                                                    title: "${origin}",
                                                    icon: {
                                                        url: "https://maps.google.com/mapfiles/ms/icons/green-dot.png",
                                                        scaledSize: new google.maps.Size(36, 36)
                                                    }
                                                });

                                                new google.maps.Marker({
                                                    position: destination,
                                                    map: map,
                                                    title: "${destination}",
                                                    icon: {
                                                        url: "https://maps.google.com/mapfiles/ms/icons/red-dot.png",
                                                        scaledSize: new google.maps.Size(36, 36)
                                                    }
                                                });

                                                // Create car marker at the start
                                                carMarker = new google.maps.Marker({
                                                    position: decodedPath[0],
                                                    map: map,
                                                    icon: {
                                                        url: "https://maps.google.com/mapfiles/ms/icons/cabs.png",
                                                        scaledSize: new google.maps.Size(40, 40)
                                                    },
                                                    title: "Your Ride"
                                                });

                                                // Create path that will grow as car moves
                                                path = new google.maps.Polyline({
                                                    path: [decodedPath[0]],
                                                    geodesic: true,
                                                    strokeColor: "#22C55E",
                                                    strokeOpacity: 1.0,
                                                    strokeWeight: 4,
                                                    map: map
                                                });

                                                // Show the expected route with a light opacity
                                                new google.maps.Polyline({
                                                    path: decodedPath,
                                                    geodesic: true,
                                                    strokeColor: "#2563EB",
                                                    strokeOpacity: 0.3,
                                                    strokeWeight: 3,
                                                    map: map
                                                });

                                                // Fit map to bounds with padding
                                                map.fitBounds(bounds);

                                                // Force redraw of the map
                                                google.maps.event.trigger(map, 'resize');

                                                console.log("Map initialization complete, starting simulation");

                                                // Start the simulation with slight delay to ensure map is fully rendered
                                                setTimeout(startSimulation(encodedPolyline), 1000);

                                            } catch (e) {
                                                console.error("Error initializing map:", e);
                                                alert("Error initializing map: " + e.message);
                                            }

                                console.log(pathPolyline);
                            }
                            else {
                                console.error("Directions request failed due to", status);
                            }
                        });


            console.log("Encoded polyline:", encodedPolyline);


        }

        function startSimulation(encodedPolyline) {
            console.log("Starting simulation");
            if (simulationRunning) {
                console.log("Simulation already running");
                return;
            }

            simulationRunning = true;
            startTime = new Date();
            // Directly set the initial time
            document.getElementById('time-elapsed').innerHTML = '00:00';

            // Also add a manual interval for time updates as a backup
            timerInterval = setInterval(updateTimeDisplay, 1000);

            // Make AJAX call to get simulation data
            fetch('/rides/${rideId}/simulate')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("Simulation data received:", data);

                    data.simulatedPolyline = encodedPolyline;

                    // Store actual values for the ride
                    actualDistance = data.actualDistance;
                    actualDuration = data.actualDuration;

                    // Update form fields
                    document.getElementById('actual-distance-input').value = actualDistance;
                    document.getElementById('actual-duration-input').value = actualDuration;

                    // Set ETA
                    const etaMinutes = Math.round(actualDuration / 60);
                    document.getElementById('eta').textContent = etaMinutes + ' min';

                    // Start animation
                    console.log("Starting animation interval");
                    simulationInterval = setInterval(updateSimulation, 500);
                })
                .catch(error => {
                    console.error('Error fetching simulation data:', error);
                    simulationRunning = false;
                    alert('Error starting simulation: ' + error.message);
                });
        }

        function updateSimulation() {
            // Force a time update on each animation step for better sync
            updateTimeDisplay();

            if (animationStep >= totalSteps) {
                // Simulation complete
                clearInterval(simulationInterval);
                // Also clear the timer interval
                if (timerInterval) {
                    clearInterval(timerInterval);
                }

                // Explicitly set form field values
                document.getElementById('actual-distance-input').value = actualDistance;
                document.getElementById('actual-duration-input').value = actualDuration;

                // Enable the complete button and update UI
                document.getElementById('complete-btn').disabled = false;
                document.getElementById('progress-percent').textContent = '100%';
                document.getElementById('progress-fill').style.width = '100%';

                // Log the values to console for debugging
                console.log("Ready to complete ride with:", {
                    actualDistance: actualDistance,
                    actualDuration: actualDuration,
                    polyline: document.getElementById('actual-polyline-input').value
                });

                return;
            }

            animationStep++;

            // Calculate progress percentage
            const progress = (animationStep / totalSteps) * 100;
            document.getElementById('progress-percent').textContent = Math.round(progress) + '%';
            document.getElementById('progress-fill').style.width = progress + '%';

            try {
                // Calculate current position along the path - ensure we don't go out of bounds
                const pathIndex = Math.min(
                    Math.floor((decodedPath.length - 1) * (animationStep / totalSteps)),
                    decodedPath.length - 1
                );

                const currentPos = decodedPath[pathIndex];

                if (currentPos && currentPos.lat && currentPos.lng) {
                    // Move car marker
                    carMarker.setPosition(currentPos);

                    // Add point to path
                    const currentPath = path.getPath();
                    currentPath.push(currentPos);

                    // Update map view to follow car with smooth movement
                    if (animationStep % 5 === 0) {
                        map.panTo(currentPos);
                    }
                }
            } catch (e) {
                console.error("Error updating car position:", e);
            }

            // Update stats (but not time, which is now handled by timerInterval)
            updateStats(progress);
        }

        function updateStats(progress) {
            // Update distance traveled
            const distanceTraveled = (actualDistance / 1000) * (progress / 100);
            document.getElementById('distance-traveled').textContent = distanceTraveled.toFixed(2) + ' km';

            // Update current fare
            const baseFareValue = parseFloat("${baseFare}");
            const estimatedFareValue = parseFloat("${estimatedFare}");
            const currentFare = baseFareValue + ((estimatedFareValue - baseFareValue) * (progress / 100));
            document.getElementById('current-fare').textContent = '₹' + currentFare.toFixed(2);
        }

        // Cancel button functionality
        document.getElementById('cancel-btn').addEventListener('click', function() {
            if (confirm('Are you sure you want to cancel the simulation?')) {
                clearInterval(simulationInterval);
                if (timerInterval) clearInterval(timerInterval);
                window.location.href = '/rides/';
            }
        });

        // Handle form submission to prevent duplicate submissions and ensure data is set
        document.getElementById('complete-ride-form').addEventListener('submit', function(event) {
            event.preventDefault(); // Temporarily prevent default submission

            // Ensure form values are set correctly
            const distanceInput = document.getElementById('actual-distance-input');
            const durationInput = document.getElementById('actual-duration-input');

            // Set values one last time to be sure
            distanceInput.value = actualDistance;
            durationInput.value = actualDuration;

            // For longer routes, don't send the full polyline - the server will use the original one
            const polylineInput = document.getElementById('actual-polyline-input');
            if (polylineInput.value && polylineInput.value.length > 10000) {
                console.log("Polyline too long (" + polylineInput.value.length + " chars), using a placeholder");
                polylineInput.value = "PLACEHOLDER";
            }

            console.log("Submitting with values:", {
                actualDistance: distanceInput.value,
                actualDuration: durationInput.value,
                polylineLength: polylineInput.value.length
            });

            // Disable the complete button to prevent multiple clicks
            document.getElementById('complete-btn').disabled = true;
            document.getElementById('complete-btn').textContent = 'Processing...';

            // Submit the form immediately to prevent timing issues
            this.submit();
        });
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBoQ6FN55NtAUucLWKMDW5s1CricaJ8UdE&libraries=geometry&callback=initMap" async defer></script>
</body>
</html> 