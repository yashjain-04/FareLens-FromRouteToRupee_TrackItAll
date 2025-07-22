<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ride History</title>
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            flex: 1;
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        h1 {
            font-size: 2rem;
            color: var(--secondary-color);
        }
        
        .card {
            background-color: var(--card-bg);
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .table-responsive {
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background-color: rgba(255, 255, 255, 0.05);
        }
        
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        th {
            font-weight: 600;
            color: rgba(248, 250, 252, 0.8);
        }
        
        tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.05);
        }
        
        .badge {
            display: inline-block;
            padding: 0.25em 0.75em;
            font-size: 0.75em;
            font-weight: 700;
            border-radius: 0.375rem;
            text-transform: uppercase;
        }
        
        .badge-success {
            background-color: rgba(34, 197, 94, 0.2);
            color: var(--secondary-color);
        }
        
        .badge-warning {
            background-color: rgba(245, 158, 11, 0.2);
            color: var(--warning-color);
        }
        
        .badge-danger {
            background-color: rgba(239, 68, 68, 0.2);
            color: var(--danger-color);
        }
        
        .badge-info {
            background-color: rgba(56, 189, 248, 0.2);
            color: #38BDF8;
        }
        
        .price {
            font-weight: 600;
        }
        
        .price-up {
            color: var(--danger-color);
        }
        
        .price-down {
            color: var(--secondary-color);
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
        
        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
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
        
        .empty-state {
            padding: 3rem;
            text-align: center;
        }
        
        .empty-state i {
            font-size: 3rem;
            color: rgba(255, 255, 255, 0.2);
            margin-bottom: 1rem;
        }
        
        .empty-state h2 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: rgba(255, 255, 255, 0.5);
        }
        
        .empty-state p {
            color: rgba(255, 255, 255, 0.3);
            margin-bottom: 1.5rem;
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
        <div class="page-header">
            <h1><i class="fas fa-history"></i> Ride History</h1>
            <a href="/rides/" class="btn btn-primary">Book New Ride</a>
        </div>
        
        <div class="card">
            <c:choose>
                <c:when test="${empty rides}">
                    <div class="empty-state">
                        <i class="fas fa-route"></i>
                        <h2>No Rides Yet</h2>
                        <p>You haven't taken any rides yet. Book your first ride to get started!</p>
                        <a href="/rides/" class="btn btn-primary">Book a Ride</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table>
                            <thead>
                                <tr>
                                    <th>Ride ID</th>
                                    <th>Date</th>
                                    <th>From - To</th>
                                    <th>Est. Fare</th>
                                    <th>Actual Fare</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${rides}" var="ride">
                                    <tr>
                                        <td>#${ride.id}</td>
                                        <td>
                                            <fmt:parseDate value="${ride.startTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                            <fmt:formatDate pattern="dd MMM, yyyy" value="${parsedDateTime}" />
                                        </td>
                                        <td>
                                            <div style="max-width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                ${ride.origin} → ${ride.destination}
                                            </div>
                                        </td>
                                        <td>₹${ride.estimatedFare}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${ride.completed}">
                                                    <c:set var="diff" value="${ride.actualFare - ride.estimatedFare}" />
                                                    <c:set var="percentDiff" value="${(diff / ride.estimatedFare) * 100}" />
                                                    
                                                    <span class="price ${diff > 0 ? 'price-up' : 'price-down'}">
                                                        ₹${ride.actualFare > ride.estimatedFare ? ride.actualFare : ride.estimatedFare}
                                                        <small>(${diff > 0 ? '+' : ''}${percentDiff > 0 ? String.format("%.2f", percentDiff) : String.format("%.2f", percentDiff)}%)</small>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    -
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${ride.status == 'COMPLETED'}">
                                                    <span class="badge badge-success">Completed</span>
                                                </c:when>
                                                <c:when test="${ride.status == 'IN_PROGRESS'}">
                                                    <span class="badge badge-info">In Progress</span>
                                                </c:when>
                                                <c:when test="${ride.status == 'CANCELLED'}">
                                                    <span class="badge badge-danger">Cancelled</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-warning">Scheduled</span>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <c:if test="${ride.fareDisputed}">
                                                <span class="badge badge-warning">Disputed</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${ride.status == 'SCHEDULED'}">
                                                    <a href="/rides/${ride.id}/start" class="btn btn-sm btn-primary">Start</a>
                                                </c:when>
                                                <c:when test="${ride.status == 'COMPLETED' && !ride.fareDisputed}">
                                                    <c:set var="diff" value="${ride.actualFare - ride.estimatedFare}" />
                                                    <c:set var="percentDiff" value="${(diff / ride.estimatedFare) * 100}" />
                                                    <c:if test="${percentDiff > 20}">
                                                        <a href="/rides/${ride.id}/start" class="btn btn-sm btn-warning">Dispute</a>
                                                    </c:if>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
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