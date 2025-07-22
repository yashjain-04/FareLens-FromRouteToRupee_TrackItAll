<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dispute Submitted</title>
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
            --danger-color: #EF4444;
            --warning-color: #F59E0B;
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
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .card {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 2.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .icon-container {
            margin-bottom: 2rem;
        }
        
        .icon-circle {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: rgba(245, 158, 11, 0.1);
        }
        
        .icon-circle i {
            font-size: 3rem;
            color: var(--warning-color);
        }
        
        h1 {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: var(--warning-color);
        }
        
        .message {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 2rem;
            line-height: 1.6;
        }
        
        .status-info {
            background-color: rgba(245, 158, 11, 0.1);
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            text-align: left;
        }
        
        .status-info h2 {
            font-size: 1.3rem;
            margin-bottom: 1rem;
            color: var(--warning-color);
        }
        
        .status-info p {
            margin-bottom: 0.5rem;
        }
        
        .status-info.approved {
            background-color: rgba(34, 197, 94, 0.1);
        }
        
        .status-info.approved h2 {
            color: var(--secondary-color);
        }
        
        .btn-row {
            display: flex;
            justify-content: center;
            gap: 1rem;
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
            text-decoration: none;
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
            <div class="icon-container">
                <div class="icon-circle">
                    <i class="fas fa-file-invoice-dollar"></i>
                </div>
            </div>
            
            <h1>Dispute Submitted Successfully</h1>
            
            <p class="message">
                Thank you for bringing this to our attention. Your feedback helps us ensure fair pricing for all rides.
            </p>
            
            <div class="status-info ${isAutoApproved ? 'approved' : ''}">
                <h2>Dispute Status</h2>
                
                <p>
                    <strong>Ride ID:</strong> #${rideId}
                </p>
                
                <p>
                    <strong>Status:</strong> 
                    ${isAutoApproved ? 'Auto-Approved' : 'Under Review'}
                </p>
                
                <p>
                    ${isAutoApproved 
                      ? 'Your dispute has been automatically approved due to the significant difference between the estimated and actual fare.' 
                      : 'Our team will review your dispute and get back to you within 24 hours.'}
                </p>
            </div>
            
            <div class="btn-row">
                <a href="/rides/" class="btn btn-secondary">Back to Home</a>
                <a href="/rides/history" class="btn btn-primary">View Ride History</a>
                <a href="/rides/prompt?prompt=${rideId}" class="btn btn-secondary">View AI Dispute Analysis</a>
            </div>
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
</body>
</html> 