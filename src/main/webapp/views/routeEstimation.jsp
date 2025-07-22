<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ride Estimation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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

                            .route-info {
                                display: flex;
                                flex-wrap: wrap;
                                gap: 1rem;
                                margin-bottom: 1.5rem;
                            }

                            .route-info-item {
                                flex: 1;
                                min-width: 200px;
                            }

                            .route-info-item h3 {
                                font-size: 1rem;
                                color: rgba(248, 250, 252, 0.6);
                                margin-bottom: 0.5rem;
                            }

                            .route-info-item p {
                                font-size: 1.2rem;
                                font-weight: 500;
                            }

                            .fare-breakdown {
                                margin-top: 1.5rem;
                            }

                            .fare-breakdown h3 {
                                font-size: 1.2rem;
                                margin-bottom: 1rem;
                                color: var(--secondary-color);
                            }

                            .fare-item {
                                display: flex;
                                justify-content: space-between;
                                padding: 0.5rem 0;
                                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                            }

                            .fare-item:last-child {
                                border-bottom: none;
                                font-weight: bold;
                                font-size: 1.1rem;
                                padding-top: 1rem;
                                color: var(--secondary-color);
                            }

                            .map-container {
                                height: 400px;
                                border-radius: 15px;
                                overflow: hidden;
                            }

                            #map {
                                height: 100%;
                                width: 100%;
                            }

                            .btn-row {
                                display: flex;
                                justify-content: flex-end;
                                gap: 1rem;
                                margin-top: 1.5rem;
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
        <h2><i class="fas fa-route"></i> ${name} Your Route</h2>
        <div class="route-info">
            <div class="route-info-item">
                <h3>FROM</h3>
                <p>${origin}</p>
            </div>
            <div class="route-info-item">
                <h3>TO</h3>
                <p>${destination}</p>
            </div>
            <div class="route-info-item">
                <h3>DISTANCE</h3>
                <p>${distance}</p>
            </div>
            <div class="route-info-item">
                <h3>ESTIMATED TIME</h3>
                <p>${duration}</p>
            </div>
        </div>

        <div class="map-container">
            <div id="map"></div>
        </div>
    </div>

    <div class="card">
        <h2><i class="fas fa-receipt"></i> Fare Estimation</h2>
        <div class="fare-breakdown">
            <h3>Fare Breakdown</h3>

            <div class="fare-item">
                <span>Base Fare</span>
                <span>₹${baseFare}</span>
            </div>

            <div class="fare-item">
                <span>Distance Charge (${distance})</span>
                <span>₹${distanceFare}</span>
            </div>

            <div class="fare-item">
                <span>Surge Pricing (${surgePricing}x)</span>
                <span>
                    ₹<%
                        double surge = Double.parseDouble(request.getAttribute("surgePricing").toString());
                        double base = Double.parseDouble(request.getAttribute("baseFare").toString());
                        double dist = Double.parseDouble(request.getAttribute("distanceFare").toString());
                        double total = Double.parseDouble(request.getAttribute("estimatedFare").toString());
                        double surgeComponent = total - (base + dist);
                        out.print(String.format("%.2f", (surge > 1 ? surgeComponent : 0.0)));
                    %>
                </span>
            </div>

            <div class="fare-item">
                <span>Total Estimated Fare</span>
                <span>₹${estimatedFare}</span>
            </div>
        </div>

        <form action="/rides/book" method="post" id="bookingForm">
            <input type="hidden" name="origin" value="${origin}">
            <input type="hidden" name="destination" value="${destination}">
            <input type="hidden" name="originLat" value="${originLat}">
            <input type="hidden" name="originLng" value="${originLng}">
            <input type="hidden" name="destinationLat" value="${destinationLat}">
            <input type="hidden" name="destinationLng" value="${destinationLng}">
            <input type="hidden" name="estimatedFare" value="${estimatedFare}">
            <input type="hidden" name="encodedPolyline" value="${encodedPolyline}">
            <input type="hidden" name="distance" value="${distance}">
            <input type="hidden" name="duration" value="${duration}">
            <input type="hidden" name="baseFare" value="${baseFare}">
            <input type="hidden" name="perKmCharge" value="${perKmCharge}">
            <input type="hidden" name="surgePricing" value="${surgePricing}">
            <input type="hidden" name="name" value="${name}">

            <div class="btn-row">
                <a href="/rides/" class="btn btn-secondary">Back</a>
                <button type="submit" class="btn btn-primary">Book Ride</button>
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
    let directionsService;
    let alternativeRoutes = [];

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

        directionsService = new google.maps.DirectionsService();

        new google.maps.Marker({
            position: {lat: parseFloat("${originLat}"), lng: parseFloat("${originLng}")},
            map,
            icon: {
                url: "https://maps.google.com/mapfiles/ms/icons/green-dot.png",
                scaledSize: new google.maps.Size(40, 40)
            },
            title: "Origin"
        });

        new google.maps.Marker({
            position: {lat: parseFloat("${destinationLat}"), lng: parseFloat("${destinationLng}")},
            map,
            icon: {
                url: "https://maps.google.com/mapfiles/ms/icons/red-dot.png",
                scaledSize: new google.maps.Size(40, 40)
            },
            title: "Destination"
        });

        directionsService.route({
            origin: {lat: parseFloat("${originLat}"), lng: parseFloat("${originLng}")},
            destination: {lat: parseFloat("${destinationLat}"), lng: parseFloat("${destinationLng}")},
            travelMode: google.maps.TravelMode.DRIVING,
            provideRouteAlternatives: true
        }, (response, status) => {
            if (status === "OK") {
                const colors = ["#22C55E", "#3B82F6", "#F97316", "#E11D48"];
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

                //addRouteSelection(response.routes);
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
        routeSelector.style.padding = "18px";
        routeSelector.style.borderRadius = "8px";

        routes.forEach((route, index) => {
            console.log(route);
            console.log(index);
            const option = document.createElement("option");
            option.value = index;
            option.textContent = `Route ${index + 1} - ${route.legs[0].distance.text} (${route.legs[0].duration.text})`;
            routeSelector.appendChild(option);
        });

        routeSelector.addEventListener("change", (event) => {
            const selectedIndex = event.target.value;
            alternativeRoutes.forEach((polyline, index) => {
                polyline.setOptions({strokeOpacity: index == selectedIndex ? 1.0 : 0.2});
            });
        });

        //map.controls[google.maps.ControlPosition.TOP_LEFT].push(routeSelector);
    }
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBoQ6FN55NtAUucLWKMDW5s1CricaJ8UdE&libraries=geometry&callback=initMap" async defer></script>
</body>
</html>
