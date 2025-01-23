CarZ: Comprehensive Vehicle Management System
CarZ is a feature-rich, web-based application designed to streamline vehicle purchasing and customer engagement. Built using Python, Streamlit, and MySQL, this system provides an end-to-end solution for customers to explore, configure, and purchase vehicles while enabling seamless backend management for administrators.

Features
Interactive User Interface: Built with Streamlit for a clean and user-friendly experience.
Customer Management: Secure registration and login with SHA-256 password hashing.
Vehicle Browsing: Explore a catalog of vehicles with detailed descriptions and images.
Configuration & Pricing: Customize vehicles with additional features and see real-time pricing updates.
Online Ordering: Place orders with delivery address and payment method management.
Test Ride Booking: Schedule test rides with date, time, and duration validation.
Loan Management:
Apply for vehicle loans directly in the system.
Check loan offers and statuses.
Showroom Locator: Find nearby showrooms with detailed address and contact information.
Past Orders: View and manage previous orders.
Sales Analytics: Analyze showroom sales and performance metrics.
Technology Stack
Frontend: Streamlit for the interactive web-based UI.
Backend:
Python for business logic and database operations.
MySQL as the relational database.
Database Features:
Stored procedures (e.g., ApplyForLoan) for managing complex logic.
Triggers for enforcing business rules like test ride scheduling constraints.
Security:
SSL/TLS for secure communication between application components.
Password hashing using SHA-256.
Data Validation:
Regex for input validation (e.g., email format).
SQL triggers to prevent duplicate entries and enforce business rules.
Key Database Integrations
Stored Procedures:
ApplyForLoan: Automates loan application with real-time updates.
ApproveLoanApplication: Approves loan applications with status updates.
Triggers:
before_insert_testride: Restricts test ride bookings outside allowed hours.
Duplicate booking prevention for test rides.
How to Use
Clone the repository.
Set up the MySQL database using the provided carz.sql file.
Configure the database connection in the CarZ.py file.
Run the application using Streamlit:
bash
Copy
Edit
streamlit run CarZ.py
Access the web interface and explore the features.
