# 🚖 FareLens – From Route to Rupee: Track It All

A smart fare transparency system that empowers users with clear, real-time, and detailed ride fare breakdowns, helping them track discrepancies and avoid unfair charges in ride-hailing platforms like Uber and Ola.

---

## 🧠 Problem Statement

Hidden fare manipulation in ride-booking apps is a growing concern. Users often:
- See an estimated fare but are charged much more post-ride.
- Face surge pricing without clear justification.
- Experience route manipulations or longer rides, leading to inflated costs.
- Lack real-time updates or explanations on fare changes.

---

## 💡 Our Solution – FareLens

### 🎯 Key Highlights:
- **Clear Fare Transparency**: Displays a comprehensive breakdown of estimated and actual fare.
- **Real-Time Tracking**: Live updates before, during, and after the ride.
- **Post-Ride Explanation**: Explains any surge, traffic delay, wait time, or tolls that caused the fare difference.
- **One-Tap Dispute Button**: Users can raise a fare dispute easily, and the system will review and resolve it automatically or manually.

---

## 🔁 How FareLens Works

### 🟢 Pre-Ride
- Shows base fare, per-km charge, surge price (if any), and tolls.
- Estimates distance and expected fare using Google Maps API.

### 🚗 During Ride
- Tracks route, deviations, and delays in real time.
- Notifies users of any unexpected route or time changes.

### 🔴 Post-Ride
- Compares actual vs expected fare.
- Shows a detailed breakdown for transparency.
- One-tap "Dispute Fare" option for quick action if charges seem unfair.

---

## 🖥️ Tech Stack

| Layer         | Technologies Used                                |
|---------------|--------------------------------------------------|
| **Frontend**  | HTML, CSS, JavaScript, JSP                       |
| **Backend**   | Java, Spring Boot, Spring MVC, Spring Data JPA   |
| **Database**  | MySQL                                            |
| **APIs**      | Google Maps Directions API (for route estimation) |
| **Build Tool**| Maven                                            |
| **IDE**       | IntelliJ IDEA                                    |

---

## 📈 Impact and Benefits

- 🔐 Transparent and trustworthy user experience
- ✅ Eliminates confusion over final fare
- 📡 Instant deviation alerts for any route or fare manipulation
- 🛡️ Secure, ethical, and no data misuse
- 🤝 Builds trust between platforms, drivers, and riders

---

## 🔍 References and Research

- [Mumbai Ola Fraud Case – ₹7000+ overcharges](https://www.timesnownews.com/mumbai/article/mumbai-ola-fraud-case-7000-victims-who-were-tricked-into-paying-higher-fares-for-rides-to-get-money-back/715860)
- [Reddit Uber Complaint – Fare almost doubled](https://www.reddit.com/r/uber/comments/19ac0wy/the_price_of_my_uber_almost_doubled_after/)
- [Uber Help – Upfront Fare Not Honored](https://help.uber.com/en/riders/article/my-upfront-fare-was-not-honored?nodeId=ff65490e-2ffb-41cf-a709-4611521c7b24)
- [India's New Rules on Surge Pricing](https://techcrunch.com/2020/11/27/india-sets-rules-for-commissions-surge-pricing-for-uber-and-ola/)
- [Delhi Driver Scam – Fake Screenshot](https://indianstartupnews.com/news/uber-driver-scams-delhi-passenger-by-showing-fake-screenshot-charges-double-fare-4422548)

---

## 👥 Team

**Team Name**: VijayVeer  
**Event**: Internal Hackathon 2025  
**Category**: Software  
**Theme**: Smart Automation 

---

## 📌 How to Run Locally

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/farelens.git
   cd farelens

2. Import the project as a Maven project in IntelliJ IDEA.

3. Configure your application.properties file with:
    ```bash
    spring.datasource.url=jdbc:mysql://localhost:3306/your_db
    spring.datasource.username=your_username
    spring.datasource.password=your_password
    google.maps.api.key=your_api_key
   
4. Run the project:
   ```bash
    mvn spring-boot:run
   
5. Open your browser and go to:
    ```bash
    http://localhost:8080

## 📜 License
This project is intended for educational and hackathon purposes only.
Feel free to fork, use, and build upon it!