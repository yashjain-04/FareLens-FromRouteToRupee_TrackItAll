package com.VijayVeer.internal.service;

import com.VijayVeer.internal.model.RouteInfo;
import org.springframework.stereotype.Service;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.client.RestTemplate;
import org.json.JSONObject;

@Service
public class FirstService {
    public RouteInfo getRouteData(String origin, String destination, Model model) {
//        String apiKey = "AIzaSyBoQ6FN55NtAUucLWKMDW5s1CricaJ8UdE";
//        String url = "https://maps.googleapis.com/maps/api/directions/json?origin=" + origin +
//                "&destination=" + destination + "&key=" + apiKey;
//        return restTemplate.getForObject(url, String.class);

        final RestTemplate restTemplate = new RestTemplate();

        String apiKey = "AIzaSyBoQ6FN55NtAUucLWKMDW5s1CricaJ8UdE";
        String url = "https://maps.googleapis.com/maps/api/directions/json?origin=" + origin +
                "&destination=" + destination + "&key=" + apiKey;

        // Fetch JSON response
        String jsonResponse = restTemplate.getForObject(url, String.class);

        // Parse JSON response
        JSONObject jsonObject = new JSONObject(jsonResponse);
        JSONObject route = jsonObject.getJSONArray("routes").getJSONObject(0);  // Get first route
        JSONObject leg = route.getJSONArray("legs").getJSONObject(0);  // Get first leg

        String distance = leg.getJSONObject("distance").getString("text");
        String duration = leg.getJSONObject("duration").getString("text");
        String encodedPolyline = route.getJSONObject("overview_polyline").getString("points");

        return new RouteInfo(distance, duration, encodedPolyline);
    }
}

//https://maps.googleapis.com/maps/api/directions/json?origin='Bangali Square' &destination= 'Rau Square' &key= 'AIzaSyBoQ6FN55NtAUucLWKMDW5s1CricaJ8UdE'