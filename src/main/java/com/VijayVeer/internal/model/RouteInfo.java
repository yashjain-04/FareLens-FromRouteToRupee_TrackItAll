package com.VijayVeer.internal.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Component
@NoArgsConstructor
@Getter
@Setter
public class RouteInfo {
    private String distance;
    private String duration;
    private String encodedPolyline;
    private double distanceValue; // distance in meters
    private double durationValue; // duration in seconds
    private double estimatedFare;
    private double actualFare;
    private double baseFare;
    private double distanceFare;
    private double perKmCharge;
    private double surgePricing;
    private double tollCharges;
    private boolean isFareDisputed;
    private String originAddress;
    private String destinationAddress;
    private double originLat;
    private double originLng;
    private double destinationLat;
    private double destinationLng;

    public RouteInfo(String distance, String duration, String encodedPolyline){
        this.distance = distance;
        this.duration = duration;
        this.encodedPolyline = encodedPolyline;
    }
}
