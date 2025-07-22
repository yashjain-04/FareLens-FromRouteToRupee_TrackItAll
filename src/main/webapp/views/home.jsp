<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ride Fare Transparency System</title>
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
        }
        
        .hero {
            text-align: center;
            margin-bottom: 3rem;
        }
        
        .hero h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--secondary-color);
        }
        
        .hero p {
            font-size: 1.2rem;
            max-width: 800px;
            margin: 0 auto;
            opacity: 0.9;
        }
        
        .card {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        
        .card h2 {
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
            color: var(--secondary-color);
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            background-color: var(--input-bg);
            border: 1px solid #4B5563;
            border-radius: 8px;
            color: var(--text-color);
            font-size: 1rem;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.3);
        }
        
        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            background-color: var(--secondary-color);
            color: #0F172A;
            font-weight: bold;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn:hover {
            background-color: #16A34A;
            transform: translateY(-2px);
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
        <div class="hero">
            <h1>FareLens : From Route To Rupee - Track It All!</h1>
            <p>Get accurate fare estimates and see real-time route simulation. Dispute unfair charges automatically!</p>
        </div>
        
        <div class="card">
            <h2>Book Your Ride</h2>
            <form action="/rides/route-estimation" method="get">
                <div class="form-group">
                    <label for="origin">Pick-up Location</label>
                    <input type="text" id="origin" name="origin" class="form-control" placeholder="Enter pick-up location" required>
                </div>
                
                <div class="form-group">
                    <label for="destination">Destination</label>
                    <input type="text" id="destination" name="destination" class="form-control" placeholder="Enter destination" required>
                </div>

                <div class="form-group">
                    <label for="name">Your Good Name</label>
                    <input type="text" id="name" name="name" class="form-control" placeholder="Enter your name" required>
                </div>
                
                <button type="submit" class="btn">Get Fare Estimate</button>
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
        // Initialize Google Places Autocomplete when available
        function initAutocomplete() {
            if (window.google && window.google.maps) {
                const originInput = document.getElementById('origin');
                const destinationInput = document.getElementById('destination');
                
                new google.maps.places.Autocomplete(originInput);
                new google.maps.places.Autocomplete(destinationInput);
            }
        }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBoQ6FN55NtAUucLWKMDW5s1CricaJ8UdE&libraries=places&callback=initAutocomplete" async defer></script>
</body>
</html> 