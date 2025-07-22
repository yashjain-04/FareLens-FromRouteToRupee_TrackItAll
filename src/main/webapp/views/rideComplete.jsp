<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ride Completed</title>
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
            --warning-color: #F59E0B;
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
        
        .comparison-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .comparison-card {
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            padding: 1.5rem;
        }
        
        .comparison-card h3 {
            font-size: 1.2rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .estimated {
            color: var(--text-color);
        }
        
        .actual {
            color: var(--secondary-color);
        }
        
        .fare-difference {
            margin-top: 2rem;
            padding: 1.5rem;
            border-radius: 10px;
            background-color: rgba(34, 197, 94, 0.1);
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .fare-difference.warning {
            background-color: rgba(245, 158, 11, 0.1);
        }
        
        .fare-difference-icon {
            font-size: 2.5rem;
            color: var(--secondary-color);
        }
        
        .fare-difference-icon.warning {
            color: var(--warning-color);
        }
        
        .fare-difference-text {
            flex: 1;
        }
        
        .fare-difference h4 {
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
            color: var(--secondary-color);
        }
        
        .fare-difference.warning h4 {
            color: var(--warning-color);
        }
        
        .fare-breakdown {
            margin-top: 2rem;
        }
        
        .fare-breakdown h3 {
            font-size: 1.2rem;
            margin-bottom: 1rem;
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
        
        .btn-warning {
            background-color: var(--warning-color);
            color: #0F172A;
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
        
        .btn-warning:hover {
            background-color: #D97706;
        }
        
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 1000;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }
        
        .modal.show {
            display: flex !important;
        }
        
        .modal-content {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 2rem;
            max-width: 500px;
            width: 100%;
            position: relative;
        }
        
        .modal-close {
            position: absolute;
            top: 1rem;
            right: 1rem;
            font-size: 1.5rem;
            color: var(--text-color);
            cursor: pointer;
            opacity: 0.7;
            transition: opacity 0.3s;
        }
        
        .modal-close:hover {
            opacity: 1;
        }
        
        .modal h3 {
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            color: var(--warning-color);
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: rgba(248, 250, 252, 0.8);
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            background-color: var(--input-bg);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            color: var(--text-color);
            font-size: 1rem;
            resize: vertical;
            min-height: 100px;
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
                <i class="fas fa-flag-checkered"></i>
            </div>
            
            <h2 class="text-center">Ride Completed Successfully</h2>
            
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
            </div>
            
            <div class="comparison-grid">
                <div class="comparison-card">
                    <h3 class="estimated"><i class="fas fa-route"></i> Estimated Distance</h3>
                    <p>
                    <%
                        double estDistance = (Double)request.getAttribute("estimatedDistance"); 
                        out.print(String.format("%.2f km", estDistance / 1000.0));
                    %>
                    </p>
                </div>
                
                <div class="comparison-card">
                    <h3 class="actual" <% if ((Double)request.getAttribute("percentDifference") > 10) { %>style="color:var(--warning-color)"<% } %>><i class="fas fa-route"></i> Actual Distance</h3>
                    <p>
                    <%
                        double actDistance = (Double)request.getAttribute("actualDistance"); 
                        out.print(String.format("%.2f km", actDistance / 1000.0));
                    %>
                    </p>
                </div>
                
                <div class="comparison-card">
                    <h3 class="estimated"><i class="fas fa-clock"></i> Estimated Duration</h3>
                    <p>
                    <%
                        double estDuration = (Double)request.getAttribute("estimatedDuration"); 
                        out.print(Math.round(estDuration / 60) + " minutes");
                    %>
                    </p>
                </div>
                
                <div class="comparison-card">
                    <h3 class="actual"><i class="fas fa-clock"></i> Actual Duration</h3>
                    <p>
                    <%
                        double actDuration = (Double)request.getAttribute("actualDuration"); 
                        out.print(Math.round(actDuration / 60) + " minutes");
                    %>
                    </p>
                </div>
                
                <div class="comparison-card">
                    <h3 class="estimated"><i class="fas fa-rupee-sign"></i> Estimated Fare</h3>
                    <p>
                    <%
                        double estFare = (Double)request.getAttribute("estimatedFare"); 
                        out.print(String.format("₹%.2f", estFare));
                    %>
                    </p>
                </div>
                
                <div class="comparison-card">
                    <h3 class="actual"><i class="fas fa-rupee-sign"></i> Actual Fare</h3>
                    <p>
                    <%
                        double actFare = (Double)request.getAttribute("actualFare"); 
                        out.print(String.format("₹%.2f", actFare));
                    %>
                    </p>
                </div>
            </div>
            
            <div class="fare-difference ${percentDifference > 10 ? 'warning' : ''}">
                <div class="fare-difference-icon ${percentDifference > 10 ? 'warning' : ''}">
                    <i class="fas ${percentDifference > 10 ? 'fa-exclamation-triangle' : 'fa-check-circle'}"></i>
                </div>
                <div class="fare-difference-text">
                    <h4>${percentDifference > 10 ? 'Significant Fare Difference' : 'Fare Within Expected Range'}</h4>
                    <p>
                    <%-- Use JSP scriptlet for proper string formatting --%>
                    <% 
                        double percentDiff = (Double)request.getAttribute("percentDifference");
                        double fareDiff = (Double)request.getAttribute("fareDifference");
                        if (percentDiff > 20) {
                            out.print("Your final fare is " + String.format("%.1f", Math.abs(percentDiff)) + 
                                     "% higher than the estimate. You may dispute this charge if you feel it's incorrect.");
                        } else {
                            out.print("Your final fare is within " + String.format("%.1f", Math.abs(percentDiff)) + 
                                     "% of the estimated fare. Thanks for riding with us!");
                        }
                    %>
                    </p>
                </div>
            </div>
            
            <div class="fare-breakdown">
                <h3>Fare Breakdown</h3>
                form
                <div class="detail-row">
                    <span class="detail-label">Base Fare</span>
                    <span class="detail-value">₹20.00</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Distance Charge</span>
                    <script>console.log(${distanceFare})</script>
                    <span class="detail-value">₹${String.format("%.2f", distanceFare)}</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Waiting Charges</span>
                    <span class="detail-value">₹${String.format("%.2f", waitingCharges)}</span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Surge Pricing (${surgePricing}x)</span>
                    <span class="detail-value">
                    <%
                        double basePrice = 20.00;
                        double distancePrice = (Double)request.getAttribute("distanceFare");
                        double waitingPrice = (Double)request.getAttribute("waitingCharges");
                        double surgeMultiplier = (Double)request.getAttribute("surgePricing");
                        
                        double surgeAmount = 0.0;
                        if (surgeMultiplier > 1.0) {
                            // Calculate surge as additional charge above regular price
                            surgeAmount = (basePrice + distancePrice + waitingPrice) * (surgeMultiplier - 1.0);
                        }
                        out.print("₹" + String.format("%.2f", surgeAmount));
                    %>
                    </span>
                </div>
                
                <div class="detail-row">
                    <span class="detail-label">Total Fare</span>
                    <span class="detail-value">₹${String.format("%.2f", actualFare)}</span>
                </div>
            </div>
            
            <div class="map-container">
                <div id="map"></div>
            </div>
            
            <div class="btn-row">
                <a href="/rides/" class="btn btn-secondary">Back to Home</a>
                <a href="/rides/history" class="btn btn-secondary">View Ride History</a>
                <%
                    // Use scriptlet to ensure correct evaluation
                    double buttonPercentDiff = (Double)request.getAttribute("percentDifference");
                    boolean isDisabled = false;
                    if (isDisabled) {
                %>
                    <button id="dispute-btn" class="btn btn-warning disabled" disabled>Dispute Fare</button>
                <%
                    } else {
                %>
                    <button id="dispute-btn" class="btn btn-warning">Dispute Fare</button>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    
    <!-- Dispute Modal -->
    <div id="dispute-modal" class="modal">
        <div class="modal-content">
            <span class="modal-close" id="close-modal">&times;</span>
            <h3>Dispute Fare</h3>
            <p>Please explain why you believe this fare should be disputed:</p>
            
            <form action="/rides/${rideId}/dispute" method="post" id="dispute-form">
                <div class="form-group">
                    <label for="reason">Reason for Dispute</label>
                    <textarea id="reason" name="reason" class="form-control" 
                              placeholder="e.g., The driver took an unnecessarily long route..." required></textarea>
                </div>
                
                <div class="btn-row">
                    <button type="button" id="cancel-dispute" class="btn btn-secondary">Cancel</button>
                    <button type="submit" class="btn btn-warning">Submit Dispute</button>
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
        // Debug percentDifference value
        console.log("percentDifference value:", parseFloat("${percentDifference}"));

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
        
        // Initialize the map
        function initMap() {
            const originLat = parseFloat("${originLat}");
            const originLng = parseFloat("${originLng}");
            const destLat = parseFloat("${destinationLat}");
            const destLng = parseFloat("${destinationLng}");
            
            console.log("Initializing completion map with coordinates:", {
                originLat: originLat,
                originLng: originLng,
                destLat: destLat,
                destLng: destLng
            });
            
            // Create map centered between origin and destination
            const origin = { lat: originLat, lng: originLng };
            const destination = { lat: destLat, lng: destLng };
            
            // Create a map centered between origin and destination
            const center = {
                lat: (origin.lat + destination.lat) / 2,
                lng: (origin.lng + destination.lng) / 2
            };
            
            // Create the map with explicit MapTypeId
            const map = new google.maps.Map(document.getElementById("map"), {
                zoom: zoomNum,
                center: center,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                zoomControl: true,
                fullscreenControl: true,
                streetViewControl: true,
                mapTypeControl: true
            });
            
            console.log("Map created");
            
            // Create markers for origin and destination
            const originMarker = new google.maps.Marker({
                position: origin,
                map: map,
                title: "${origin}",
                icon: {
                    url: "https://maps.google.com/mapfiles/ms/icons/green-dot.png"
                }
            });
            
            const destinationMarker = new google.maps.Marker({
                position: destination,
                map: map,
                title: "${destination}",
                icon: {
                    url: "https://maps.google.com/mapfiles/ms/icons/red-dot.png"
                }
            });
            
            // Create bounds to fit all points
            const bounds = new google.maps.LatLngBounds();
            bounds.extend(origin);
            bounds.extend(destination);
            
            // Force map to redraw
            google.maps.event.trigger(map, 'resize');
            
            // Create polylines for expected and actual routes
            try {
                const encodedPolyline = "${encodedPolyline}";
                const actualPolyline = "${actualPolyline}";
                
                console.log("Expected polyline:", encodedPolyline);
                console.log("Actual polyline:", actualPolyline);
                
                // Check if the expected polyline exists and is valid
                if (encodedPolyline && encodedPolyline.length > 0) {
                    // Expected route (blue line)
                    try {
                        const expectedPath = google.maps.geometry.encoding.decodePath(encodedPolyline);
                        
                        if (expectedPath && expectedPath.length > 0) {
                            console.log("Expected path decoded with", expectedPath.length, "points");
                            
                            new google.maps.Polyline({
                                path: expectedPath,
                                geodesic: true,
                                strokeColor: "#2563EB",
                                strokeOpacity: 0.5,
                                strokeWeight: 5,
                                map: map
                            });
                            
                            // Add decoded points to bounds
                            expectedPath.forEach(function(point) {
                                bounds.extend(point);
                            });
                        } else {
                            console.error("Failed to decode expected path");
                        }
                    } catch (error) {
                        console.error("Error decoding expected polyline:", error);
                    }
                }
                
                // Check if the actual polyline exists and is valid
                if (actualPolyline && actualPolyline.length > 0) {
                    // Actual route (red line)
                    const actualPath = google.maps.geometry.encoding.decodePath(actualPolyline);

                    if (actualPath && actualPath.length > 0) {
                        console.log("Actual path decoded with", actualPath.length, "points");

                        new google.maps.Polyline({
                            path: actualPath,
                            geodesic: true,
                            strokeColor: "#EF4444",
                            strokeOpacity: 1.0,
                            strokeWeight: 5,
                            map: map
                        });

                        // Add decoded points to bounds
                        actualPath.forEach(point => bounds.extend(point));
                    } else {
                        console.error("Failed to decode actual path");
                    }
                }
                
                // If neither polyline worked, at least show a direct line
                if ((!encodedPolyline || encodedPolyline.length === 0) && 
                    (!actualPolyline || actualPolyline.length === 0)) {
                    console.log("Creating direct polyline between points");
                    
                    new google.maps.Polyline({
                        path: [origin, destination],
                        geodesic: true,
                        strokeColor: "#EF4444",
                        strokeOpacity: 1.0,
                        strokeWeight: 5,
                        map: map
                    });
                }
                
                // Fit map to bounds and add padding
                map.fitBounds(bounds);
                
            } catch (e) {
                console.error("Error displaying route polylines:", e);
                
                // If there's an error with polylines, draw a direct line and show the markers
                new google.maps.Polyline({
                    path: [origin, destination],
                    geodesic: true,
                    strokeColor: "#EF4444",
                    strokeOpacity: 1.0,
                    strokeWeight: 5,
                    map: map
                });
                
                map.fitBounds(bounds);
            }
        }
        
        // Dispute modal functionality
        document.addEventListener('DOMContentLoaded', function() {
            const disputeBtn = document.getElementById('dispute-btn');
            const disputeModal = document.getElementById('dispute-modal');
            const closeModalBtn = document.getElementById('close-modal');
            const cancelDisputeBtn = document.getElementById('cancel-dispute');
            const disputeForm = document.getElementById('dispute-form');
            
            console.log("Dispute elements:", {
                button: disputeBtn, 
                modal: disputeModal,
                closeBtn: closeModalBtn,
                cancelBtn: cancelDisputeBtn,
                form: disputeForm
            });
            
            if (disputeBtn) {
                disputeBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    console.log("Dispute button clicked");
                    if (disputeModal) {
                        disputeModal.classList.add('show');
                        // Force redisplay as flex
                        disputeModal.style.display = 'flex';
                    }
                });
            }
            
            if (closeModalBtn) {
                closeModalBtn.addEventListener('click', function() {
                    console.log("Close button clicked");
                    if (disputeModal) {
                        disputeModal.classList.remove('show');
                        // Force hide
                        disputeModal.style.display = 'none';
                    }
                });
            }
            
            if (cancelDisputeBtn) {
                cancelDisputeBtn.addEventListener('click', function() {
                    console.log("Cancel button clicked");
                    if (disputeModal) {
                        disputeModal.classList.remove('show');
                        // Force hide
                        disputeModal.style.display = 'none';
                    }
                });
            }
            
            if (disputeForm) {
                disputeForm.addEventListener('submit', function(e) {
                    console.log("Form submitted");
                });
            }
        });
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBoQ6FN55NtAUucLWKMDW5s1CricaJ8UdE&libraries=geometry&callback=initMap" async defer></script>
</body>
</html> 