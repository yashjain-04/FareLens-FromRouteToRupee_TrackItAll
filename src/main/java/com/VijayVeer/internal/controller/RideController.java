package com.VijayVeer.internal.controller;

import com.VijayVeer.internal.model.Ride;
import com.VijayVeer.internal.model.RouteInfo;
import com.VijayVeer.internal.service.FareCalculatorService;
import com.VijayVeer.internal.service.RideService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/rides")
public class RideController {
    
    @Autowired
    private RideService rideService;
    @Autowired
    private FareCalculatorService fareCalculatorService;
    
    // Home page with ride booking form
    @GetMapping("/")
    public String homePage() {
        return "home";
    }
    
    // Get route estimation before booking
    @GetMapping("/route-estimation")
    public String getRouteEstimation(@RequestParam String origin, @RequestParam String destination, @RequestParam String name,  Model model) {
        try {
            RouteInfo routeInfo = rideService.getRouteEstimation(origin, destination);
            
            // Add data to model for JSP
            model.addAttribute("origin", origin);
            model.addAttribute("destination", destination);
            model.addAttribute("distance", routeInfo.getDistance());
            model.addAttribute("duration", routeInfo.getDuration());
            model.addAttribute("encodedPolyline", routeInfo.getEncodedPolyline());
            model.addAttribute("estimatedFare", routeInfo.getEstimatedFare());
            model.addAttribute("baseFare", routeInfo.getBaseFare());
            model.addAttribute("distanceFare", routeInfo.getDistanceFare());
            model.addAttribute("perKmCharge", routeInfo.getPerKmCharge());
            model.addAttribute("surgePricing", routeInfo.getSurgePricing());
            model.addAttribute("originLat", routeInfo.getOriginLat());
            model.addAttribute("originLng", routeInfo.getOriginLng());
            model.addAttribute("destinationLat", routeInfo.getDestinationLat());
            model.addAttribute("destinationLng", routeInfo.getDestinationLng());
            model.addAttribute("name", name);
            
            return "routeEstimation";
        } catch (Exception e) {
            model.addAttribute("error", "Error getting route: " + e.getMessage());
            return "error";
        }
    }
    
    // Book a ride
    @PostMapping("/book")
    public String bookRide(@RequestParam String origin, 
                          @RequestParam String destination,
                          @RequestParam double originLat,
                          @RequestParam double originLng,
                          @RequestParam double destinationLat,
                          @RequestParam double destinationLng,
                           @RequestParam double estimatedFare,
                           @RequestParam String encodedPolyline,
                           @RequestParam double baseFare,
                           @RequestParam double perKmCharge,
                           @RequestParam double surgePricing,
                           @RequestParam String name,
                          Model model) {
        try {
            // Call the service to get route estimation
            RouteInfo routeInfo = rideService.getRouteEstimation(origin, destination);

            // Create ride directly
            Ride ride = new Ride(origin, destination, routeInfo.getDistanceValue(),
                    routeInfo.getDurationValue(), estimatedFare,
                                encodedPolyline);
            
            ride.setOriginLat(originLat);
            ride.setOriginLng(originLng);
            ride.setDestinationLat(destinationLat);
            ride.setDestinationLng(destinationLng);
            ride.setBaseFare(baseFare);
            ride.setPerKmCharge(perKmCharge);
            ride.setSurgePricing(surgePricing);
            ride.setUserName(name);
            
            // Save the ride
            ride = rideService.createRideDirectly(ride);
            
            model.addAttribute("rideId", ride.getId());
            model.addAttribute("origin", ride.getOrigin());
            model.addAttribute("destination", ride.getDestination());
            model.addAttribute("estimatedFare", ride.getEstimatedFare());
            model.addAttribute("distance", routeInfo.getDistance());
            model.addAttribute("duration", routeInfo.getDuration());
            model.addAttribute("encodedPolyline", ride.getEncodedPolyline());
            model.addAttribute("originLat", ride.getOriginLat());
            model.addAttribute("originLng", ride.getOriginLng());
            model.addAttribute("destinationLat", ride.getDestinationLat());
            model.addAttribute("destinationLng", ride.getDestinationLng());
            
            // Fare breakdown
            model.addAttribute("baseFare", ride.getBaseFare());
            model.addAttribute("distanceFare", routeInfo.getDistanceFare());
            model.addAttribute("surgePricing", ride.getSurgePricing());
            model.addAttribute("name", ride.getUserName());
            
            return "rideConfirmation";
        } catch (Exception e) {
            model.addAttribute("error", "Error booking ride: " + e.getMessage());
            return "error";
        }
    }
    
    // Start ride simulation
    @GetMapping("/{id}/start")
    public String startRideSimulation(@PathVariable("id") Long rideId, Model model) {
        try {
            Ride ride = rideService.startRide(rideId);
            
            model.addAttribute("rideId", ride.getId());
            model.addAttribute("origin", ride.getOrigin());
            model.addAttribute("destination", ride.getDestination());
            model.addAttribute("estimatedFare", ride.getEstimatedFare());
            model.addAttribute("encodedPolyline", ride.getEncodedPolyline());
            model.addAttribute("originLat", ride.getOriginLat());
            model.addAttribute("originLng", ride.getOriginLng());
            model.addAttribute("destinationLat", ride.getDestinationLat());
            model.addAttribute("destinationLng", ride.getDestinationLng());
            
            // Add fare breakdown components
            model.addAttribute("baseFare", ride.getBaseFare());
            model.addAttribute("perKmCharge", ride.getPerKmCharge());
            model.addAttribute("surgePricing", ride.getSurgePricing());
            model.addAttribute("name", ride.getUserName());
            
            return "rideSimulation";
        } catch (Exception e) {
            model.addAttribute("error", "Error starting ride: " + e.getMessage());
            return "error";
        }
    }
    
    // Simulate ride progress - API endpoint for AJAX calls
    @GetMapping("/{id}/simulate")
    @ResponseBody
    public ResponseEntity<RideService.SimulationResult> simulateRide(@PathVariable("id") Long rideId) {
        try {
            RideService.SimulationResult result = rideService.simulateRide(rideId);
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
    
    // Complete ride
    @PostMapping("/{id}/complete")
    public String completeRide(@PathVariable("id") Long rideId, 
                               @RequestParam double actualDistance,
                               @RequestParam double actualDuration,
                               @RequestParam String actualPolyline,
                               Model model) {
        try {
            System.out.println("======= COMPLETING RIDE =======");
            System.out.println("Ride ID: " + rideId);
            System.out.println("Actual Distance: " + actualDistance);
            System.out.println("Actual Duration: " + actualDuration);
            System.out.println("Polyline length: " + (actualPolyline != null ? actualPolyline.length() : "null"));
            
            // If polyline is empty, null or too long, use a simplified approach
            if (actualPolyline == null || actualPolyline.trim().isEmpty() || actualPolyline.length() > 100000) {
                System.out.println("WARNING: Problematic polyline received (" + 
                                  (actualPolyline == null ? "null" : 
                                   actualPolyline.trim().isEmpty() ? "empty" : 
                                   "too long: " + actualPolyline.length() + " chars") + 
                                  "), using encoded route as fallback");
                
                // Get the ride to get the encoded polyline
                Ride ride = rideService.getRide(rideId);
                if (ride != null && ride.getEncodedPolyline() != null) {
                    actualPolyline = ride.getEncodedPolyline();
                    System.out.println("Using encoded polyline as fallback, length: " + actualPolyline.length());
                } else {
                    // If all else fails, use an empty string
                    actualPolyline = "";
                    System.out.println("No fallback available, using empty string");
                }
            }
            
            Ride ride = rideService.completeRide(rideId, actualDistance, actualDuration, actualPolyline);
            
            // Log the calculated values for debugging
            double fareDifference = ride.getActualFare() - ride.getEstimatedFare();
            double percentDifference = (fareDifference / ride.getEstimatedFare()) * 100;
            
            System.out.println("Ride completed successfully:");
            System.out.println("- Estimated Fare: " + ride.getEstimatedFare());
            System.out.println("- Actual Fare: " + ride.getActualFare());
            System.out.println("- Fare Difference: " + fareDifference);
            System.out.println("- Percent Difference: " + percentDifference + "%");
            System.out.println("- Origin coordinates: " + ride.getOriginLat() + ", " + ride.getOriginLng());
            System.out.println("- Destination coordinates: " + ride.getDestinationLat() + ", " + ride.getDestinationLng());
            System.out.println("- Encoded polyline length: " + (ride.getEncodedPolyline() != null ? ride.getEncodedPolyline().length() : "null"));
            System.out.println("- Actual polyline length: " + (ride.getActualPolyline() != null ? ride.getActualPolyline().length() : "null"));
            System.out.println("==============================");
            
            model.addAttribute("ride", ride);
            model.addAttribute("rideId", ride.getId());
            model.addAttribute("origin", ride.getOrigin());
            model.addAttribute("destination", ride.getDestination());
            model.addAttribute("encodedPolyline", ride.getEncodedPolyline());
            model.addAttribute("actualPolyline", ride.getActualPolyline());
            model.addAttribute("originLat", ride.getOriginLat());
            model.addAttribute("originLng", ride.getOriginLng());
            model.addAttribute("destinationLat", ride.getDestinationLat());
            model.addAttribute("destinationLng", ride.getDestinationLng());
            
            // Add missing distance/duration attributes
            model.addAttribute("estimatedDistance", ride.getEstimatedDistance());
            model.addAttribute("actualDistance", ride.getActualDistance());
            model.addAttribute("estimatedDuration", ride.getEstimatedDuration());
            model.addAttribute("actualDuration", ride.getActualDuration());
            
            model.addAttribute("estimatedFare", ride.getEstimatedFare());
            model.addAttribute("actualFare", ride.getActualFare());
            model.addAttribute("fareDifference", fareDifference);
            model.addAttribute("percentDifference", percentDifference);
            
            // Fare breakdown
            model.addAttribute("baseFare", ride.getBaseFare());
            double dist = ride.getPerKmCharge() * (ride.getActualDistance() / 1000.0);
            System.out.println("per km charge : " + ride.getPerKmCharge());
            System.out.println("actual dist : " + ride.getActualDistance());
            System.out.println("distance fare : "+dist);
            model.addAttribute("distanceFare", dist);
            model.addAttribute("waitingCharges", ride.getWaitingCharges());
            model.addAttribute("surgePricing", ride.getSurgePricing());
            
            return "rideComplete";
        } catch (Exception e) {
            System.err.println("Error completing ride: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error completing ride: " + e.getMessage());
            return "error";
        }
    }
    
    // Dispute fare
    @PostMapping("/{id}/dispute")
    public String disputeFare(@PathVariable("id") Long rideId, 
                              @RequestParam String reason,
                              Model model) {
        try {
            boolean isAutoApproved = rideService.disputeFare(rideId, reason);
            
            model.addAttribute("rideId", rideId);
            model.addAttribute("isDisputeSubmitted", true);
            model.addAttribute("isAutoApproved", isAutoApproved);
            
            return "disputeSubmitted";
        } catch (Exception e) {
            model.addAttribute("error", "Error submitting dispute: " + e.getMessage());
            return "error";
        }
    }
    
    // Get ride history
    @GetMapping("/history")
    public String getRideHistory(Model model) {
        List<Ride> completedRides = rideService.getCompletedRides();
        model.addAttribute("rides", completedRides);
        return "rideHistory";
    }
    
    // Get disputed rides (for admin)
    @GetMapping("/disputed")
    public String getDisputedRides(Model model) {
        List<Ride> disputedRides = rideService.getDisputedRides();
        model.addAttribute("rides", disputedRides);
        return "disputedRides";
    }
} 