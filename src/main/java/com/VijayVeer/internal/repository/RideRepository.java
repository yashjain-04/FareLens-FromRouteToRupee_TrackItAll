package com.VijayVeer.internal.repository;

import com.VijayVeer.internal.model.Ride;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RideRepository extends JpaRepository<Ride, Long> {
    List<Ride> findByStatusOrderByStartTimeDesc(String status);
    List<Ride> findByFareDisputedTrueOrderByEndTimeDesc();
    List<Ride> findById(int rideId);
} 