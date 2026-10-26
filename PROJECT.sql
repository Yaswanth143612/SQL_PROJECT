create database event_ticket_db;
use event_ticket_db;

CREATE TABLE events_ (.
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    venue VARCHAR(100),
    ticket_price DECIMAL(10,2) NOT NULL,
    total_tickets INT NOT NULL,
    available_tickets INT NOT NULL
);

INSERT INTO events
(event_name, event_date, venue, ticket_price,
 total_tickets, available_tickets)
VALUES
('Python Workshop', '2026-11-15', 'Vizag Tech Hall', 500.00, 100, 100),
('Music Concert', '2026-11-20', 'Beach Arena', 1200.00, 200, 200),
('College Fest', '2026-11-25', 'College Ground', 300.00, 150, 150),
('AI Conference', '2026-12-05', 'City Convention Center', 800.00, 120, 120),
('Dance Show', '2026-12-10', 'Open Air Theatre', 400.00, 80, 80);

SELECT * FROM events;

SELECT event_name, ticket_price
FROM events
WHERE ticket_price > 500;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15)
);

INSERT INTO customers (customer_name, email, phone)
VALUES
('yashu', 'yashu@gmail.com', '9658125634'),
('Bhanu', 'bhanu@gmail.com', '9182645536'),
('Siva', 'siva@gmail.com', '9876543210'),
('Sarup', 'saru@gmail.com', '6548923017'),
('Praveen', 'praveen@gmail.com', '6301542895');

SELECT * FROM customers;

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    event_id INT NOT NULL,
    tickets_booked INT NOT NULL,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    booking_status VARCHAR(20) DEFAULT 'CONFIRMED',
    total_amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (event_id)
        REFERENCES events(event_id),

    CHECK (tickets_booked > 0),
    CHECK (total_amount >= 0)
);

INSERT INTO bookings
(customer_id, event_id, tickets_booked, total_amount)
VALUES
(1, 1, 2, 1000.00),
(2, 2, 1, 1200.00),
(3, 3, 3, 900.00),
(4, 4, 2, 1600.00),
(5, 1, 1, 500.00);

SELECT * FROM bookings;

SELECT
    b.booking_id,
    c.customer_name,
    e.event_name,
    b.tickets_booked,
    b.total_amount,
    b.booking_status
FROM bookings b
JOIN customers c
    ON b.customer_id = c.customer_id
JOIN events e
    ON b.event_id = e.event_id;

UPDATE events e
SET available_tickets = total_tickets - (
    SELECT COALESCE(SUM(b.tickets_booked), 0)
    FROM bookings b
    WHERE b.event_id = e.event_id
      AND b.booking_status = 'CONFIRMED'
);
SET SQL_SAFE_UPDATES = 0;

UPDATE events e
SET available_tickets = total_tickets - (
    SELECT COALESCE(SUM(b.tickets_booked), 0)
    FROM bookings b
    WHERE b.event_id = e.event_id
      AND b.booking_status = 'CONFIRMED'
);

SELECT event_name, total_tickets, available_tickets
FROM events;

DELIMITER ;
USE event_ticket_db;
DROP TRIGGER IF EXISTS before_booking_insert;

DELIMITER //

CREATE TRIGGER before_booking_insert
BEFORE INSERT ON bookings
FOR EACH ROW
BEGIN
    DECLARE v_available INT DEFAULT NULL;

    SELECT available_tickets
    INTO v_available
    FROM events
    WHERE event_id = NEW.event_id
    FOR UPDATE;

    IF v_available IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Event does not exist';
    ELSEIF NEW.tickets_booked <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tickets must be greater than zero';
    ELSEIF NEW.tickets_booked > v_available THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough tickets available';
    END IF;
END //

DELIMITER ;

CREATE OR REPLACE VIEW booking_details AS
SELECT
    b.booking_id,
    c.customer_name,
    e.event_name,
    b.tickets_booked,
    b.total_amount,
    b.booking_status,
    b.booking_date
FROM bookings b
JOIN customers c
    ON b.customer_id = c.customer_id
JOIN events e
    ON b.event_id = e.event_id;
    
SELECT * FROM booking_details;

CREATE TABLE IF NOT EXISTS payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(30) NOT NULL,
    payment_amount DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'PENDING',
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    CHECK (payment_amount >= 0)
);


SELECT * FROM payments;

USE event_ticket_db;

SELECT booking_id, customer_id, event_id, total_amount
FROM bookings
ORDER BY booking_id;

INSERT INTO payments
(booking_id, payment_method, payment_amount, payment_status)
VALUES
(1, 'UPI', 1000.00, 'PAID'),
(2, 'CARD', 1200.00, 'PAID'),
(3, 'CASH', 900.00, 'PENDING'),
(4, 'UPI', 1600.00, 'PAID'),
(5, 'CARD', 500.00, 'PAID');

SELECT * FROM payments;

SHOW TABLES;
SHOW TRIGGERS;
SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SELECT * FROM events;
SELECT * FROM customers;
SELECT * FROM bookings;
SELECT * FROM payments;
SELECT * FROM booking_details;

SHOW TABLES;
SHOW TRIGGERS;

SHOW PROCEDURE STATUS
WHERE Db = 'event_ticket_db';

SHOW INDEX FROM bookings;

SELECT * FROM booking_details;
SELECT * FROM payments;
