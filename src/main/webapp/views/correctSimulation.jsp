function initMap() {
    const originLat = parseFloat("${originLat}");
    const originLng = parseFloat("${originLng}");
    const destinationLat = parseFloat("${destinationLat}");
    const destinationLng = parseFloat("${destinationLng}");

    const origin = { lat: originLat, lng: originLng };
    const destination = { lat: destinationLat, lng: destinationLng };

    const center = {
        lat: (origin.lat + destination.lat) / 2,
        lng: (origin.lng + destination.lng) / 2
    };

    map = new google.maps.Map(document.getElementById("map"), {
        zoom: 10,
        center: center,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });

    const trafficLayer = new google.maps.TrafficLayer();
    trafficLayer.setMap(map);

    const directionsService = new google.maps.DirectionsService();
    const directionsRenderer = new google.maps.DirectionsRenderer({
        map: map,
        suppressMarkers: true,
        polylineOptions: {
            strokeColor: "#22C55E",
            strokeWeight: 5
        }
    });

    directionsService.route({
        origin: origin,
        destination: destination,
        travelMode: google.maps.TravelMode.DRIVING
    }, (response, status) => {
        if (status === "OK") {
            directionsRenderer.setDirections(response);

            const route = response.routes[0].overview_path;

            // Place origin marker
            new google.maps.Marker({
                position: origin,
                map: map,
                icon: {
                    url: "https://maps.google.com/mapfiles/ms/icons/green-dot.png",
                    scaledSize: new google.maps.Size(36, 36)
                },
                title: "Origin"
            });

            // Place destination marker
            new google.maps.Marker({
                position: destination,
                map: map,
                icon: {
                    url: "https://maps.google.com/mapfiles/ms/icons/red-dot.png",
                    scaledSize: new google.maps.Size(36, 36)
                },
                title: "Destination"
            });

            // Place car marker at starting point
            carMarker = new google.maps.Marker({
                position: route[0],
                map: map,
                icon: {
                    url: "https://maps.google.com/mapfiles/ms/icons/cabs.png",
                    scaledSize: new google.maps.Size(40, 40)
                },
                title: "Your Ride"
            });

            // Draw path as the car moves
            path = new google.maps.Polyline({
                path: [route[0]],
                geodesic: true,
                strokeColor: "#22C55E",
                strokeOpacity: 1.0,
                strokeWeight: 4,
                map: map
            });

            // ✅ Start simulation using the actual route from Directions API
            setTimeout(() => startSimulationFromRoute(route), 1000);

        } else {
            console.error("Directions request failed due to:", status);
        }
    });
}




function startSimulationFromRoute(route) {
    let index = 0;

    const interval = setInterval(() => {
        if (index >= route.length) {
            clearInterval(interval);
            console.log("Ride completed!");
            return;
        }

        const currentPosition = route[index];
        carMarker.setPosition(currentPosition);

        // Extend polyline
        const pathArray = path.getPath();
        pathArray.push(currentPosition);

        index++;
    }, 1000); // move every 1 second (you can adjust speed)
}



function startSimulationFromRoute(route) {
            console.log("Starting simulation");

            if (simulationRunning) {
                console.log("Simulation already running");
                return;
            }

            simulationRunning = true;
            startTime = new Date();
            document.getElementById('time-elapsed').innerHTML = '00:00';

            setInterval(updateTimeDisplay, 1000);

            fetch('/rides/${rideId}/simulate')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok: ' + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("Simulation data received:", data);

                    actualDistance = data.actualDistance;
                    actualDuration = data.actualDuration;

                    document.getElementById('actual-distance-input').value = actualDistance;
                    document.getElementById('actual-duration-input').value = actualDuration;

                    const etaMinutes = Math.round(actualDuration / 60);
                    document.getElementById('eta').textContent = etaMinutes + ' min';

                    // Move car
                    let index = 0;
                    simulationInterval = setInterval(() => {
                        if (index >= route.length) {
                            clearInterval(simulationInterval);
                            console.log("Ride simulation completed");
                            return;
                        }

                        const currentPosition = route[index];
                        carMarker.setPosition(currentPosition);

                        // Extend path
                        const pathArray = path.getPath();
                        pathArray.push(currentPosition);

                        index++;
                    }, 500);
                })
                .catch(error => {
                    console.error('Error fetching simulation data:', error);
                    simulationRunning = false;
                    alert('Error starting simulation: ' + error.message);
                });
        }