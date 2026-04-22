# CarGo - Car Rental Management System

CarGo is a full-stack web application for managing car rental operations, built with ASP.NET Web Forms, C#, and SQL Server. The platform is deployed online and supports both customer booking workflows and administrator-side fleet and order management.

## Live Demo
- http://cargo.runasp.net/

## Key Features
- User authentication and role-based access (customer/admin)
- Car browsing and booking with rental period and fee calculation
- Booking history and profile management for users
- Admin car management (add, edit, remove, availability)
- Admin order list and status handling (booked/returned)
- Admin inbox/messages management from contact submissions

## Technology Stack
- ASP.NET Web Forms (.NET Framework)
- C#
- SQL Server (MDF/LDF in development)
- HTML5, CSS3, JavaScript
- Visual Studio

## Solution Structure
- carGo.sln: Visual Studio solution
- carGo/: Main ASP.NET Web Forms application
- carGo/App_Data/: Local development database files
- carGo/Images/: UI and car image assets

## Local Setup (Visual Studio)
1. Open carGo.sln in Visual Studio.
2. Restore NuGet packages for the solution.
3. Ensure SQL Server LocalDB or SQL Server instance is available.
4. Verify connection string in Web.config.
5. Build and run with IIS Express (F5).
6. Access login/register and test customer/admin flows.

## Screenshots
Store screenshots in docs/screenshots and reference them below.

- Booking page: docs/screenshots/booking-page.png
- Car gallery/home: docs/screenshots/home-cars.png
- Contact page: docs/screenshots/contact-page.png
- User profile: docs/screenshots/user-profile.png
- Admin order list: docs/screenshots/admin-order-list.png
- Admin manage cars: docs/screenshots/admin-manage-cars.png

## Architecture Overview
CarGo follows a layered full-stack workflow:
- Presentation layer: ASP.NET Web Forms pages
- Business layer: C# code-behind logic for bookings, validation, and admin actions
- Data layer: SQL Server tables for users, vehicles, bookings, and contact messages

## Portfolio Positioning
This project demonstrates production-oriented web development skills including CRUD operations, role-based workflows, relational data handling, and online deployment on ASP.NET hosting.
