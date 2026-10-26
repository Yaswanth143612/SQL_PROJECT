# 🎟️ Event Ticket Booking Management System

## 📌 Project Overview

The **Event Ticket Booking Management System** is a database management project developed to simplify and manage the process of booking tickets for different events. The system stores and manages customer details, event information, ticket bookings, booking status, and payment amounts in a structured database.

The main objective of this project is to maintain accurate booking records, reduce manual work, avoid invalid booking entries, and provide an organized way to retrieve event and booking information.

This project demonstrates practical knowledge of **MySQL, SQL queries, database design, primary keys, foreign keys, constraints, and relational database management**.

## 🎯 Objectives

- To store and manage customer information.
- To maintain event details in a structured database.
- To record ticket bookings for different events.
- To calculate and store the total booking amount.
- To track booking dates and booking status.
- To maintain data consistency using database constraints.
- To establish relationships between customers, events, and bookings.
- To retrieve booking information using SQL queries.

## 🛠️ Technologies Used

- **Database:** MySQL
- **Database Tool:** MySQL Workbench / MySQL Command Line Client
- **Query Language:** SQL
- **Concepts:** Relational Database Management System (RDBMS), Primary Keys, Foreign Keys, Constraints, Data Manipulation Language (DML), Data Definition Language (DDL)

## 🗂️ Database Structure

The database is designed around three main entities.

### 1. Customers

Stores information about customers who book event tickets.

Typical fields include:
- `customer_id` – Unique customer identifier
- `customer_name` – Customer name
- `email` – Customer email address
- `phone` – Customer contact number

### 2. Events

Stores details about the events available for booking.

Typical fields include:
- `event_id` – Unique event identifier
- `event_name` – Name of the event
- `event_date` – Date of the event
- `event_location` – Location where the event takes place
- `ticket_price` – Price of an individual ticket

### 3. Bookings

Stores ticket booking details and connects customers with events.

Fields include:
- `booking_id` – Unique booking identifier
- `customer_id` – Reference to the customer
- `event_id` – Reference to the event
- `tickets_booked` – Number of tickets booked
- `booking_date` – Date and time of booking
- `booking_status` – Current booking status
- `total_amount` – Total amount for the booking

**Note:** The exact customer and event column names should match the tables created in your database.

## 🔗 Database Relationships

- One customer can make multiple bookings.
- One event can have multiple bookings.
- Each booking belongs to one customer and one event.
- Foreign keys maintain valid relationships between the tables.

## ⚙️ Key Features

### Customer Management
Maintains customer information and provides a reference for ticket bookings.

### Event Management
Stores event details, dates, locations, and ticket prices.

### Ticket Booking
Records the customer, selected event, number of tickets, and total booking amount.

### Booking Status Tracking
Maintains the booking status, with `CONFIRMED` as the default status when configured in the database.

### Data Integrity
Uses primary keys, foreign keys, and constraints to help prevent invalid records.

### Booking Date Automation
Uses `CURRENT_TIMESTAMP` as the default booking date and time when configured in the bookings table.

### Data Validation
Constraints can ensure that the number of tickets booked is greater than zero and the total amount is not negative.

## 🧱 Database Constraints

The project uses the following database concepts:

- **PRIMARY KEY:** Uniquely identifies each record.
- **FOREIGN KEY:** Establishes relationships between tables.
- **AUTO_INCREMENT:** Automatically generates booking IDs.
- **NOT NULL:** Ensures required fields contain values.
- **DEFAULT:** Assigns default values to selected columns.
- **CHECK:** Validates ticket quantity and total amount where supported by the MySQL version and table definition.

## 🚀 How to Run the Project

1. Install MySQL Server and MySQL Workbench, or use the MySQL Command Line Client.
2. Open your MySQL environment.
3. Create the project database.
4. Create the required `customers`, `events`, and `bookings` tables.
5. Define primary keys, foreign keys, and other constraints.
6. Insert sample customer and event records.
7. Insert booking records using valid customer and event IDs.
8. Execute SQL queries to view, filter, update, and manage the booking data.

### Example SQL Queries

View all bookings:

```sql
SELECT * FROM bookings;
```

View confirmed bookings:

```sql
SELECT *
FROM bookings
WHERE booking_status = 'CONFIRMED';
```

Count bookings for each event:

```sql
SELECT event_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY event_id;
```

Calculate the total booking revenue recorded:

```sql
SELECT SUM(total_amount) AS total_revenue
FROM bookings
WHERE booking_status = 'CONFIRMED';
```

*These queries assume the listed columns exist in your database.*

## 📈 Future Enhancements

The project can be extended with the following features:

- A user-friendly frontend using HTML, CSS, and JavaScript.
- A backend using Python and Flask.
- Customer registration and login.
- Event search and filtering.
- Online payment integration.
- Booking cancellation and refund management.
- Ticket availability and seat management.
- Automated ticket confirmation and receipt generation.
- Reports and dashboards for event organizers.
- Stored procedures, transactions, and indexes for improved database operations.

## 🎓 Learning Outcomes

Through this project, practical experience can be gained in:

- Designing relational databases.
- Creating and managing tables using SQL.
- Establishing relationships between database entities.
- Applying constraints for data integrity.
- Inserting, updating, deleting, and retrieving records.
- Writing aggregate queries using functions such as `COUNT()` and `SUM()`.
- Understanding how a database supports a real-world ticket booking application.

## 🏁 Conclusion

The **Event Ticket Booking Management System** provides a structured approach to managing
