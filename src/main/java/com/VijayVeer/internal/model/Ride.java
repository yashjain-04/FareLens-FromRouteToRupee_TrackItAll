package com.VijayVeer.internal.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name = "rides")
@NoArgsConstructor
@Getter
@Setter
public class Ride {
    @Override
    public String toString() {
        return "Ride{" +
                "id=" + id +
                ", origin='" + origin + '\'' +
                ", destination='" + destination + '\'' +
                ", originLat=" + originLat +
                ", originLng=" + originLng +
                ", destinationLat=" + destinationLat +
                ", destinationLng=" + destinationLng +
                ", estimatedDistance=" + estimatedDistance +
                ", actualDistance=" + actualDistance +
                ", estimatedDuration=" + estimatedDuration +
                ", actualDuration=" + actualDuration +
                ", baseFare=" + baseFare +
                ", perKmCharge=" + perKmCharge +
                ", surgePricing=" + surgePricing +
                ", tollCharges=" + tollCharges +
                ", waitingCharges=" + waitingCharges +
                ", estimatedFare=" + estimatedFare +
                ", actualFare=" + actualFare +
                ", encodedPolyline='" + encodedPolyline + '\'' +
                ", actualPolyline='" + actualPolyline + '\'' +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", completed=" + completed +
                ", fareDisputed=" + fareDisputed +
                ", disputeReason='" + disputeReason + '\'' +
                ", status='" + status + '\'' +
                '}';
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String userName;
    
    private String origin;
    private String destination;
    private double originLat;
    private double originLng;
    private double destinationLat;
    private double destinationLng;
    
    private double estimatedDistance; // in meters
    private double actualDistance; // in meters
    
    private double estimatedDuration; // in seconds
    private double actualDuration; // in seconds
    
    private double baseFare;
    private double perKmCharge;
    private double surgePricing;
    private double tollCharges;
    private double waitingCharges;
    
    private double estimatedFare;
    private double actualFare;
    
    @Column(columnDefinition = "LONGTEXT")
    private String encodedPolyline;
    
    @Column(columnDefinition = "LONGTEXT")
    private String actualPolyline;
    
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    
    private boolean completed;
    private boolean fareDisputed;
    private String disputeReason;
    
    private String status; // SCHEDULED, IN_PROGRESS, COMPLETED, CANCELLED
    
    public Ride(String origin, String destination, double estimatedDistance, double estimatedDuration, 
                double estimatedFare, String encodedPolyline) {
        this.origin = origin;
        this.destination = destination;
        this.estimatedDistance = estimatedDistance;
        this.estimatedDuration = estimatedDuration;
        this.estimatedFare = estimatedFare;
        this.encodedPolyline = encodedPolyline;
        this.status = "SCHEDULED";
        this.completed = false;
        this.fareDisputed = false;
    }
} 