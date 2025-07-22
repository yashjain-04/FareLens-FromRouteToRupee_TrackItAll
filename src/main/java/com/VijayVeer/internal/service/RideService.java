package com.VijayVeer.internal.service;

import com.VijayVeer.internal.model.Ride;
import com.VijayVeer.internal.model.RouteInfo;
import com.VijayVeer.internal.repository.RideRepository;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
public class RideService {

    @Autowired
    private RideRepository rideRepository;
    
    @Autowired
    private FareCalculatorService fareCalculatorService;
    
    @Autowired
    private RestTemplate restTemplate;
    
    private static final String API_KEY = "AIzaSyBoQ6FN55NtAUucLWKMDW5s1CricaJ8UdE";
    private static final String DIRECTIONS_API_URL = "https://maps.googleapis.com/maps/api/directions/json";
    private static final Random random = new Random();
    
    public RouteInfo getRouteEstimation(String origin, String destination) {
        // URL encode the origin and destination parameters
        String encodedOrigin = java.net.URLEncoder.encode(origin, java.nio.charset.StandardCharsets.UTF_8);
        String encodedDestination = java.net.URLEncoder.encode(destination, java.nio.charset.StandardCharsets.UTF_8);

        String url = DIRECTIONS_API_URL + "?origin=" + encodedOrigin + "&destination=" + encodedDestination + "&departure_time=now&traffic_model=best_guess" + "&key=" + API_KEY;
        
        // Fetch JSON response from Google Directions API
        String jsonResponse = restTemplate.getForObject(url, String.class);
        
        // Parse JSON response
        JSONObject jsonObject = new JSONObject(jsonResponse);
        
        if (!jsonObject.getString("status").equals("OK")) {
            throw new RuntimeException("Failed to get directions: " + jsonObject.optString("error_message", "Unknown error"));
        }

        System.out.println(jsonObject);
        
        JSONObject route = jsonObject.getJSONArray("routes").getJSONObject(0);
        JSONObject leg = route.getJSONArray("legs").getJSONObject(0);
        
        // Extract location information
        JSONObject startLocation = leg.getJSONObject("start_location");
        JSONObject endLocation = leg.getJSONObject("end_location");
        
        // Extract text representations
        String distance = leg.getJSONObject("distance").getString("text");
        String duration = leg.getJSONObject("duration").getString("text");
        String encodedPolyline = route.getJSONObject("overview_polyline").getString("points");
        System.out.println(url);
        System.out.println(encodedPolyline);
        
        // Extract numeric values
        double distanceValue = leg.getJSONObject("distance").getDouble("value"); // in meters
        double durationValue = leg.getJSONObject("duration").getDouble("value"); // in seconds
        
        // Calculate fare
        double estimatedFare = fareCalculatorService.calculateEstimatedFare(distanceValue, durationValue);
        
        // Create and populate RouteInfo object
        RouteInfo routeInfo = new RouteInfo(distance, duration, encodedPolyline);
        routeInfo.setDistanceValue(distanceValue);
        routeInfo.setDurationValue(durationValue);
        routeInfo.setEstimatedFare(estimatedFare);
        routeInfo.setBaseFare(fareCalculatorService.getFareBreakdown(distanceValue, durationValue, 0).getBaseFare());
        routeInfo.setDistanceFare(fareCalculatorService.getFareBreakdown(distanceValue, durationValue, 0).getDistanceFare());
        routeInfo.setSurgePricing(fareCalculatorService.getFareBreakdown(distanceValue, durationValue, 0).getSurgeMultiplier());
        routeInfo.setPerKmCharge(fareCalculatorService.getFareBreakdown(distanceValue, durationValue, 0).getPerKmCharge());
        routeInfo.setOriginAddress(leg.getString("start_address"));
        routeInfo.setDestinationAddress(leg.getString("end_address"));
        routeInfo.setOriginLat(startLocation.getDouble("lat"));
        routeInfo.setOriginLng(startLocation.getDouble("lng"));
        routeInfo.setDestinationLat(endLocation.getDouble("lat"));
        routeInfo.setDestinationLng(endLocation.getDouble("lng"));
        
        return routeInfo;
    }
    
    public Ride createRide(RouteInfo routeInfo) {
        Ride ride = new Ride(
            routeInfo.getOriginAddress(),
            routeInfo.getDestinationAddress(),
            routeInfo.getDistanceValue(),
            routeInfo.getDurationValue(),
            routeInfo.getEstimatedFare(),
            routeInfo.getEncodedPolyline()
        );
        
        ride.setOriginLat(routeInfo.getOriginLat());
        ride.setOriginLng(routeInfo.getOriginLng());
        ride.setDestinationLat(routeInfo.getDestinationLat());
        ride.setDestinationLng(routeInfo.getDestinationLng());
        ride.setBaseFare(routeInfo.getBaseFare());
        ride.setPerKmCharge(routeInfo.getPerKmCharge());
        ride.setSurgePricing(routeInfo.getSurgePricing());
        
        return rideRepository.save(ride);
    }
    
    public Ride createRideDirectly(Ride ride) {
        // Save directly to repository
        return rideRepository.save(ride);
    }
    
    public Ride startRide(Long rideId) {
        Optional<Ride> optionalRide = rideRepository.findById(rideId);
        if (optionalRide.isPresent()) {
            Ride ride = optionalRide.get();
            ride.setStartTime(LocalDateTime.now());
            ride.setStatus("IN_PROGRESS");
            return rideRepository.save(ride);
        } else {
            throw new RuntimeException("Ride not found with id: " + rideId);
        }
    }
    
    public Ride completeRide(Long rideId, double actualDistance, double actualDuration, String actualPolyline) {
        Optional<Ride> optionalRide = rideRepository.findById(rideId);
        if (optionalRide.isPresent()) {
            Ride ride = optionalRide.get();
            
            // Update ride with actual values
            ride.setEndTime(LocalDateTime.now());
            ride.setActualDistance(actualDistance);
            ride.setActualDuration(actualDuration);
            
            // Handle very long polylines by truncating if necessary 
            // (max limit for MySQL LONGTEXT is around 4GB, but we'll be much more conservative)
            if (actualPolyline != null) {
                // Check if polyline is too long (over 50,000 chars)
                if (actualPolyline.length() > 50000) {
                    System.out.println("WARNING: Very long polyline detected (" + actualPolyline.length() + 
                                      " chars), truncating to 50,000 chars.");
                    // Truncate to a reasonable size
                    actualPolyline = actualPolyline.substring(0, 50000);
                }
            }
            
            ride.setActualPolyline(actualPolyline);
            ride.setStatus("COMPLETED");
            ride.setCompleted(true);
            
            // Calculate actual fare
            double waitingTime = calculateWaitingTime(ride.getActualDuration(), ride.getEstimatedDuration());
            double actualFare = fareCalculatorService.calculateActualFare(
                actualDistance, 
                actualDuration, 
                ride.getEstimatedDistance(),
                waitingTime
            );
            
            ride.setWaitingCharges(waitingTime * 2.0 / 60.0); // 2 rupees per minute
            ride.setActualFare(actualFare);
            
            return rideRepository.save(ride);
        } else {
            throw new RuntimeException("Ride not found with id: " + rideId);
        }
    }
    
    public boolean disputeFare(Long rideId, String reason) {
        Optional<Ride> optionalRide = rideRepository.findById(rideId);
        if (optionalRide.isPresent()) {
            Ride ride = optionalRide.get();
            
            // Check if dispute is valid (fare difference > 20%)
            double fareDifference = ride.getActualFare() - ride.getEstimatedFare();
            double percentageDifference = (fareDifference / ride.getEstimatedFare()) * 100;
            
            if (percentageDifference > 20) {
                // Auto-approve dispute
                ride.setFareDisputed(true);
                ride.setDisputeReason(reason);
                // Could reduce the fare here
                rideRepository.save(ride);
                return true;
            } else {
                // Still record the dispute but flag it differently
                ride.setFareDisputed(true);
                ride.setDisputeReason(reason);
                rideRepository.save(ride);
                return false;
            }
        } else {
            throw new RuntimeException("Ride not found with id: " + rideId);
        }
    }
    
    public List<Ride> getCompletedRides() {
        return rideRepository.findByStatusOrderByStartTimeDesc("COMPLETED");
    }
    
    public List<Ride> getDisputedRides() {
        return rideRepository.findByFareDisputedTrueOrderByEndTimeDesc();
    }
    
    // Get a ride by ID
    public Ride getRide(Long rideId) {
        Optional<Ride> optionalRide = rideRepository.findById(rideId);
        if (optionalRide.isPresent()) {
            return optionalRide.get();
        }
        return null;
    }
    
    // Simulate a ride with random deviations to make it more realistic
    public SimulationResult simulateRide(Long rideId) {
        Optional<Ride> optionalRide = rideRepository.findById(rideId);
        if (optionalRide.isPresent()) {
            Ride ride = optionalRide.get();
            
            // Introduce random variations in distance and duration
            double distanceDeviation = getRandomDeviation(1, 1.2);
            double durationDeviation = getRandomDeviation(1, 1.2);
            
            double actualDistance = ride.getEstimatedDistance() * distanceDeviation;
            double actualDuration = ride.getEstimatedDuration() * durationDeviation;
            
            // Generate a "modified" polyline with slight deviations (in real implementation, 
            // this would create actual variations in the path)
            // Here we're just using the original polyline for simplicity
            String simulatedPolyline = ride.getEncodedPolyline();
            
            // Return simulation data
            SimulationResult result = new SimulationResult();
            result.setActualDistance(actualDistance);
            result.setActualDuration(actualDuration);
            result.setSimulatedPolyline(simulatedPolyline);
            result.setWaitingTime(calculateWaitingTime(actualDuration, ride.getEstimatedDuration()));
            
            return result;
        } else {
            throw new RuntimeException("Ride not found with id: " + rideId);
        }
    }
    
    // Helper method to calculate waiting time (in seconds)
    private double calculateWaitingTime(double actualDuration, double estimatedDuration) {
        // Simplified calculation - in a real app this would be more complex
        double extraTime = actualDuration - estimatedDuration;
        // Only count significant delays as waiting time (> 5 minutes)
        if (extraTime > 300) {
            return extraTime * 0.5; // Assume 50% of extra time is waiting
        }
        return 0;
    }
    
    // Helper method to generate random deviations
    private double getRandomDeviation(double min, double max) {
        return min + (max - min) * random.nextDouble();
    }
    
    // Inner class for simulation results
    public static class SimulationResult {
        private double actualDistance;
        private double actualDuration;
        private String simulatedPolyline;
        private double waitingTime;
        
        public double getActualDistance() {
            return actualDistance;
        }
        
        public void setActualDistance(double actualDistance) {
            this.actualDistance = actualDistance;
        }
        
        public double getActualDuration() {
            return actualDuration;
        }
        
        public void setActualDuration(double actualDuration) {
            this.actualDuration = actualDuration;
        }
        
        public String getSimulatedPolyline() {
            return simulatedPolyline;
        }
        
        public void setSimulatedPolyline(String simulatedPolyline) {
            this.simulatedPolyline = simulatedPolyline;
        }
        
        public double getWaitingTime() {
            return waitingTime;
        }
        
        public void setWaitingTime(double waitingTime) {
            this.waitingTime = waitingTime;
        }
    }
} 