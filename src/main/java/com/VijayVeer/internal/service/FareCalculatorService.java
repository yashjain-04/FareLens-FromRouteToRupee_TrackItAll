package com.VijayVeer.internal.service;

import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Service;

@Service
public class FareCalculatorService {
    
    // Constants (can be moved to configuration)
    private static final double BASE_FARE = 20.0; // base fare in rupees
    private static final double PER_KM_CHARGE = 8.0; // per km charge in rupees
    private static final double PER_MINUTE_CHARGE = 2.0; // per minute waiting charge
    private static final double SURGE_FACTOR_NORMAL = 1.0; // no surge
    private static final double SURGE_FACTOR_MODERATE = 1.2; // 20% surge
    private static final double SURGE_FACTOR_HIGH = 1.5; // 50% surge
    
    public double calculateEstimatedFare(double distanceInMeters, double durationInSeconds) {
        // Convert to km
        double distanceInKm = distanceInMeters / 1000.0;
        
        // Calculate base fare + distance fare
        double fare = BASE_FARE + (distanceInKm * PER_KM_CHARGE);
        
        // Apply current surge pricing (could be dynamic based on time of day, demand, etc.)
        double surgeFactor = getSurgeFactor();
        fare = fare * surgeFactor;
        
        // Round to 2 decimal places
        return Math.round(fare * 100.0) / 100.0;
    }
    
    public double calculateActualFare(double actualDistanceInMeters, double actualDurationInSeconds, 
                                     double estimatedDistanceInMeters, double waitingTimeInSeconds) {
        // Convert to km
        double actualDistanceInKm = actualDistanceInMeters / 1000.0;
        
        // Base fare + distance fare
        double fare = BASE_FARE + (actualDistanceInKm * PER_KM_CHARGE);
        
        // Add waiting charges if any (per minute)
        double waitingTimeInMinutes = waitingTimeInSeconds / 60.0;
        double waitingCharge = waitingTimeInMinutes * PER_MINUTE_CHARGE;
        fare += waitingCharge;
        
        // Apply surge pricing
        double surgeFactor = getSurgeFactor();
        fare = fare * surgeFactor;
        
        // Round to 2 decimal places
        return Math.round(fare * 100.0) / 100.0;
    }
    
    // Return breakdown of fare components
    public FareBreakdown getFareBreakdown(double distanceInMeters, double durationInSeconds, double waitingTimeInSeconds) {
        FareBreakdown breakdown = new FareBreakdown();
        
        double distanceInKm = distanceInMeters / 1000.0;
        double waitingTimeInMinutes = waitingTimeInSeconds / 60.0;
        
        breakdown.setBaseFare(BASE_FARE);
        breakdown.setDistanceFare(distanceInKm * PER_KM_CHARGE);
        breakdown.setWaitingCharge(waitingTimeInMinutes * PER_MINUTE_CHARGE);
        breakdown.setPerKmCharge(PER_KM_CHARGE);
        
        double surgeFactor = getSurgeFactor();
        breakdown.setSurgeMultiplier(surgeFactor);
        
        // Calculate total
        double totalBeforeSurge = breakdown.getBaseFare() + breakdown.getDistanceFare() + breakdown.getWaitingCharge();
        double totalAfterSurge = totalBeforeSurge * surgeFactor;
        
        breakdown.setTotalFare(Math.round(totalAfterSurge * 100.0) / 100.0);
        
        return breakdown;
    }
    
    // Get current surge factor based on time, demand, etc.
    private double getSurgeFactor() {
        // This could be dynamic based on time of day, current demand, etc.
        // For now using a simple implementation
        int hour = java.time.LocalTime.now().getHour();
        
        // Higher surge during morning and evening rush hours
        if ((hour >= 8 && hour <= 10) || (hour >= 17 && hour <= 19)) {
            return SURGE_FACTOR_MODERATE;
        } else if (hour >= 22 || hour <= 5) {
            // Late night surge
            return SURGE_FACTOR_HIGH;
        } else {
            return SURGE_FACTOR_NORMAL;
        }
    }
    
    // Inner class for fare breakdown
    public static class FareBreakdown {
        private double baseFare;
        private double distanceFare;
        private double perKmCharge;
        private double waitingCharge;
        private double tollCharge;
        private double surgeMultiplier;
        private double totalFare;
        
        // Getters and setters
        public double getBaseFare() {
            return baseFare;
        }
        
        public void setBaseFare(double baseFare) {
            this.baseFare = baseFare;
        }
        
        public double getDistanceFare() {
            return distanceFare;
        }
        
        public void setDistanceFare(double distanceFare) {
            this.distanceFare = distanceFare;
        }

        public double getPerKmCharge() {
            return perKmCharge;
        }

        public void setPerKmCharge(double perKmCharge) {
            this.perKmCharge = perKmCharge;
        }
        
        public double getWaitingCharge() {
            return waitingCharge;
        }
        
        public void setWaitingCharge(double waitingCharge) {
            this.waitingCharge = waitingCharge;
        }
        
        public double getTollCharge() {
            return tollCharge;
        }
        
        public void setTollCharge(double tollCharge) {
            this.tollCharge = tollCharge;
        }
        
        public double getSurgeMultiplier() {
            return surgeMultiplier;
        }
        
        public void setSurgeMultiplier(double surgeMultiplier) {
            this.surgeMultiplier = surgeMultiplier;
        }
        
        public double getTotalFare() {
            return totalFare;
        }
        
        public void setTotalFare(double totalFare) {
            this.totalFare = totalFare;
        }
    }
} 