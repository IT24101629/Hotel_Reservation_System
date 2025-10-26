promotion_usage-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.43 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for hotel_reservation_db
CREATE DATABASE IF NOT EXISTS `hotel_reservation_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hotel_reservation_db`;

-- Dumping structure for view hotel_reservation_db.available_rooms_view
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `available_rooms_view` (
	`room_id` BIGINT NOT NULL,
	`room_number` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`floor_number` INT NOT NULL,
	`price_per_night` DECIMAL(10,2) NOT NULL,
	`room_description` TEXT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`image_url` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`type_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`type_description` TEXT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`max_occupancy` INT NOT NULL,
	`amenities` JSON NULL
);

-- Dumping structure for table hotel_reservation_db.bookings
CREATE TABLE IF NOT EXISTS `bookings` (
  `booking_id` bigint NOT NULL AUTO_INCREMENT,
  `booking_reference` varchar(20) NOT NULL,
  `customer_id` bigint NOT NULL,
  `room_id` bigint NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `number_of_guests` int NOT NULL,
  `number_of_nights` int NOT NULL,
  `room_price_per_night` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `booking_status` enum('PENDING','PENDING_PAYMENT','CONFIRMED','CHECKED_IN','CHECKED_OUT','CANCELLED','COMPLETED','NO_SHOW','APPROVED') DEFAULT 'PENDING',
  `payment_status` enum('PENDING','COMPLETED','FAILED','REFUNDED','PARTIAL_REFUND') DEFAULT 'PENDING',
  `special_requests` varchar(500) DEFAULT NULL,
  `customer_notes` varchar(1000) DEFAULT NULL,
  `admin_notes` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `cancellation_reason` varchar(500) DEFAULT NULL,
  `qr_code_path` varchar(500) DEFAULT NULL,
  `checked_in_at` datetime(6) DEFAULT NULL,
  `checked_out_at` datetime(6) DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT NULL,
  `original_amount` decimal(10,2) DEFAULT NULL,
  `promo_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  UNIQUE KEY `booking_reference` (`booking_reference`),
  KEY `idx_booking_dates` (`check_in_date`,`check_out_date`),
  KEY `idx_booking_status` (`booking_status`),
  KEY `idx_customer_bookings` (`customer_id`),
  KEY `idx_room_bookings` (`room_id`),
  KEY `idx_bookings_status_date` (`booking_status`,`created_at`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE RESTRICT,
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE RESTRICT,
  CONSTRAINT `bookings_chk_1` CHECK (((`number_of_guests` >= 1) and (`number_of_guests` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hotel_reservation_db.bookings: ~27 rows (approximately)
INSERT INTO `bookings` (`booking_id`, `booking_reference`, `customer_id`, `room_id`, `check_in_date`, `check_out_date`, `number_of_guests`, `number_of_nights`, `room_price_per_night`, `total_amount`, `booking_status`, `payment_status`, `special_requests`, `customer_notes`, `admin_notes`, `created_at`, `updated_at`, `cancelled_at`, `cancellation_reason`, `qr_code_path`, `checked_in_at`, `checked_out_at`, `discount_amount`, `original_amount`, `promo_code`) VALUES
	(1, 'BK3476912776', 3, 11, '2025-08-21', '2025-08-23', 2, 2, 18000.00, 40320.00, 'PENDING_PAYMENT', 'PENDING', '', '', NULL, '2025-08-18 16:45:48', '2025-08-18 16:45:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 'BK5089797461', 3, 2, '2025-08-21', '2025-08-22', 2, 1, 12000.00, 13440.00, 'PENDING_PAYMENT', 'PENDING', '', '', NULL, '2025-08-18 16:48:29', '2025-08-18 16:48:29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 'BK9200319284', 3, 1, '2025-08-21', '2025-08-23', 1, 2, 8500.00, 19040.00, 'PENDING_PAYMENT', 'PENDING', '', '', NULL, '2025-08-19 14:02:00', '2025-08-19 14:02:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 'BK9321488937', 3, 1, '2025-08-21', '2025-08-23', 1, 2, 8500.00, 19040.00, 'PENDING_PAYMENT', 'PENDING', '', '', NULL, '2025-08-19 14:02:12', '2025-08-19 14:02:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 'BK5544328696', 3, 1, '2025-08-21', '2025-08-22', 1, 1, 8500.00, 9520.00, 'PENDING_PAYMENT', 'PENDING', '', '', NULL, '2025-08-19 14:29:14', '2025-08-19 14:29:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(6, 'BK0849928999', 3, 1, '2025-08-22', '2025-08-23', 1, 1, 8500.00, 9520.00, 'PENDING_PAYMENT', 'PENDING', '', '', NULL, '2025-08-20 13:41:25', '2025-08-20 13:41:25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(7, 'BK2241726943', 3, 2, '2025-08-22', '2025-08-23', 1, 1, 12000.00, 13440.00, 'PENDING_PAYMENT', 'PENDING', '', '', NULL, '2025-08-20 14:00:24', '2025-08-20 14:00:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(8, 'BK9878633477', 3, 2, '2025-08-22', '2025-08-23', 1, 1, 12000.00, 13440.00, 'PENDING_PAYMENT', 'PENDING', '', '', NULL, '2025-08-20 14:13:08', '2025-08-20 14:13:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(9, 'BK8092243099', 3, 2, '2025-08-23', '2025-08-24', 1, 1, 12000.00, 13440.00, 'PENDING_PAYMENT', 'PENDING', '', '', NULL, '2025-08-20 14:26:49', '2025-08-20 14:26:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(10, 'BK5202573311', 3, 2, '2025-08-22', '2025-08-23', 1, 1, 12000.00, 13440.00, 'CONFIRMED', 'COMPLETED', '', '', NULL, '2025-08-21 10:38:40', '2025-08-21 10:39:56', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(13, 'BK2127030154', 3, 2, '2025-08-23', '2025-08-24', 2, 1, 12000.00, 13440.00, 'CANCELLED', 'REFUNDED', 'aaasdss', 'fflf', NULL, '2025-08-21 15:00:13', '2025-08-22 00:24:43', '2025-08-22 00:24:43', 'Cancelled by customer', NULL, NULL, NULL, NULL, NULL, NULL),
	(14, 'BK5222605763', 3, 2, '2025-09-02', '2025-09-03', 1, 1, 12000.00, 13440.00, 'CONFIRMED', 'COMPLETED', 'fff', 'wdwdd', NULL, '2025-08-31 11:45:22', '2025-08-31 11:46:28', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(15, 'BK9230178646', 3, 1, '2025-09-03', '2025-09-04', 1, 1, 8500.00, 9520.00, 'PENDING_PAYMENT', 'PENDING', '', '', NULL, '2025-08-31 22:58:43', '2025-08-31 22:58:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(16, 'BK9230172405', 3, 1, '2025-09-03', '2025-09-04', 1, 1, 8500.00, 9520.00, 'PENDING_PAYMENT', 'PENDING', '', '', NULL, '2025-08-31 22:58:43', '2025-08-31 22:58:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(17, 'BK4229809699', 3, 2, '2025-09-04', '2025-09-05', 1, 1, 12000.00, 13440.00, 'CONFIRMED', 'COMPLETED', '', '', NULL, '2025-09-01 11:53:43', '2025-09-01 11:54:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(18, 'BK1523616489', 2, 1, '2025-10-03', '2025-10-04', 1, 1, 8500.00, 9520.00, 'CONFIRMED', 'COMPLETED', 'ddaass', 'dddaa', NULL, '2025-09-30 14:25:52', '2025-09-30 14:26:54', NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL),
	(19, 'BK3267825907', 2, 2, '2025-10-10', '2025-10-11', 2, 1, 12000.00, 13440.00, 'PENDING_PAYMENT', 'PENDING', 'dfdf', 'fgfg', NULL, '2025-10-03 15:15:27', '2025-10-03 15:15:27', NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL),
	(20, 'BK3330180091', 2, 1, '2025-10-09', '2025-10-10', 1, 1, 8500.00, 9520.00, 'CONFIRMED', 'COMPLETED', 'dfdf', 'fgfgaa', NULL, '2025-10-03 15:32:13', '2025-10-03 16:13:00', NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL),
	(21, 'BK4147530867', 7, 5, '2025-10-08', '2025-10-10', 1, 2, 18000.00, 40320.00, 'CONFIRMED', 'COMPLETED', 'no special decorations . only formal roomaapppp', 'gggg', NULL, '2025-10-04 09:36:55', '2025-10-04 11:18:23', NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL),
	(22, 'BK4401411472', 7, 2, '2025-10-15', '2025-10-16', 2, 1, 12000.00, 13440.00, 'CONFIRMED', 'COMPLETED', 'no special decorations . only formal roomaaaq', '', NULL, '2025-10-04 11:17:20', '2025-10-04 11:17:52', NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL),
	(23, 'BK8105070621', 7, 2, '2025-10-07', '2025-10-08', 2, 1, 12000.00, 13440.00, 'CONFIRMED', 'COMPLETED', 'no special decorations . only formal roomaaaaaaa', '', NULL, '2025-10-05 04:03:31', '2025-10-05 04:03:50', NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL),
	(24, 'BK7972266103', 7, 4, '2025-10-27', '2025-10-28', 1, 1, 8500.00, 9520.00, 'PENDING_PAYMENT', 'PENDING', 'no special decorations . only formal roomaaaaaaa', '', NULL, '2025-10-05 05:26:37', '2025-10-05 05:26:37', NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL),
	(25, 'REF01', 1, 2, '2025-11-01', '2025-11-03', 2, 2, 12000.00, 24000.00, 'PENDING_PAYMENT', 'PENDING', NULL, NULL, NULL, '2025-10-09 12:43:20', '2025-10-09 12:43:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(26, 'REF02', 2, 3, '2025-11-05', '2025-11-08', 2, 3, 18000.00, 54000.00, 'PENDING_PAYMENT', 'PENDING', NULL, NULL, NULL, '2025-10-09 12:43:20', '2025-10-09 12:43:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(27, 'REF03', 3, 5, '2025-12-10', '2025-12-15', 4, 5, 25000.00, 125000.00, 'PENDING_PAYMENT', 'PENDING', NULL, NULL, NULL, '2025-10-09 12:43:20', '2025-10-09 12:43:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(28, 'REF04', 4, 6, '2025-12-20', '2025-12-22', 2, 2, 45000.00, 90000.00, 'PENDING_PAYMENT', 'PENDING', NULL, NULL, NULL, '2025-10-09 12:43:20', '2025-10-09 12:43:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(29, 'REF05', 5, 1, '2026-01-05', '2026-01-10', 1, 5, 8500.00, 42500.00, 'PENDING_PAYMENT', 'PENDING', NULL, NULL, NULL, '2025-10-09 12:43:20', '2025-10-09 12:43:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(30, 'REF-TRIG-TEST', 1, 1, '2026-02-01', '2026-02-03', 2, 2, 8500.00, 17000.00, 'PENDING', 'PENDING', NULL, NULL, NULL, '2025-10-09 13:35:04', '2025-10-09 13:35:04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Dumping structure for view hotel_reservation_db.booking_details_view
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `booking_details_view` (
	`booking_id` BIGINT NOT NULL,
	`booking_reference` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`check_in_date` DATE NOT NULL,
	`check_out_date` DATE NOT NULL,
	`number_of_guests` INT NOT NULL,
	`total_amount` DECIMAL(10,2) NOT NULL,
	`booking_status` ENUM('PENDING','PENDING_PAYMENT','CONFIRMED','CHECKED_IN','CHECKED_OUT','CANCELLED','COMPLETED','NO_SHOW','APPROVED') NULL COLLATE 'utf8mb4_0900_ai_ci',
	`payment_status` ENUM('PENDING','COMPLETED','FAILED','REFUNDED','PARTIAL_REFUND') NULL COLLATE 'utf8mb4_0900_ai_ci',
	`customer_name` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`customer_email` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`phone_number` VARCHAR(1) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`room_number` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`room_type` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`created_at` TIMESTAMP NULL
);

-- Dumping structure for procedure hotel_reservation_db.CheckRoomAvailability
DELIMITER //
CREATE PROCEDURE `CheckRoomAvailability`(
    IN p_room_id BIGINT,
    IN p_check_in DATE,
    IN p_check_out DATE
)
BEGIN
    SELECT COUNT(*) as conflicting_bookings
    FROM bookings 
    WHERE room_id = p_room_id 
    AND ((check_in_date < p_check_out AND check_out_date > p_check_in))
    AND booking_status IN ('CONFIRMED', 'CHECKED_IN');
END//
DELIMITER ;

-- Dumping structure for table hotel_reservation_db.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `customer_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` text,
  `city` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `id_number` varchar(50) DEFAULT NULL,
  `emergency_contact_name` varchar(100) DEFAULT NULL,
  `emergency_contact_phone` varchar(20) DEFAULT NULL,
  `preferences` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  KEY `idx_customers_user` (`user_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hotel_reservation_db.customers: ~12 rows (approximately)
INSERT INTO `customers` (`customer_id`, `user_id`, `phone_number`, `address`, `city`, `country`, `postal_code`, `date_of_birth`, `id_number`, `emergency_contact_name`, `emergency_contact_phone`, `preferences`, `created_at`, `updated_at`) VALUES
	(1, 2, '+94771234567', '123 Main Street, Colombo', 'Colombo', 'Sri Lanka', '00100', NULL, NULL, NULL, NULL, NULL, '2025-08-17 19:23:41', '2025-08-17 19:23:41'),
	(2, 3, '+94771234567', '123 Main Street, Colombo', 'Colombo', 'Sri Lanka', '10100', NULL, NULL, NULL, NULL, NULL, '2025-08-18 02:35:26', '2025-08-18 02:35:26'),
	(3, 4, '+94779393662', 'No 24/2, Monnankulama, Galgamuwa', NULL, 'Sri Lankan', NULL, '2002-02-24', '200205500754', NULL, NULL, NULL, '2025-08-18 04:01:15', '2025-08-18 04:01:15'),
	(4, 5, '+94729393662', 'colombo', NULL, 'Sri Lankan', NULL, '2002-05-20', '200205500752', NULL, NULL, NULL, '2025-08-18 04:23:04', '2025-08-18 04:23:04'),
	(5, 7, '+94723232432', 'test', NULL, 'Sri Lankan', NULL, '2001-03-21', '200123455321', NULL, NULL, NULL, '2025-08-22 01:45:36', '2025-08-22 01:45:36'),
	(6, 8, '+94779393662', 'no,24/2, monnankulama,galgamuwa', NULL, 'Sri Lankan', NULL, '2007-09-15', '200205500754', NULL, NULL, NULL, '2025-09-22 06:48:11', '2025-09-22 06:48:11'),
	(7, 11, '0779393662', 'Malabe,colombo', '', 'Sri Lankan', '', '2002-02-24', '200205500754', NULL, NULL, NULL, '2025-10-04 09:34:20', '2025-10-20 05:01:24'),
	(8, 1, '0771112222', '12 Galle Rd', 'Colombo', 'Sri Lanka', NULL, NULL, '200205500754', NULL, NULL, NULL, '2025-10-09 10:37:24', '2025-10-09 10:37:24'),
	(9, 2, '0712223333', '34 Kandy Rd', 'Kandy', 'Sri Lanka', NULL, NULL, '200112345678', NULL, NULL, NULL, '2025-10-09 10:37:24', '2025-10-09 10:37:24'),
	(10, 3, '0763334444', '56 Main St', 'Jaffna', 'Sri Lanka', NULL, NULL, '200023456789', NULL, NULL, NULL, '2025-10-09 10:37:24', '2025-10-09 10:37:24'),
	(11, 4, '0754445555', '78 Beach Rd', 'Negombo', 'Sri Lanka', NULL, NULL, '200234567890', NULL, NULL, NULL, '2025-10-09 10:37:24', '2025-10-09 10:37:24'),
	(12, 5, '0705556666', '90 Hill Rise', 'Nuwara Eliya', 'Sri Lanka', NULL, NULL, '200145678901', NULL, NULL, NULL, '2025-10-09 10:37:24', '2025-10-09 10:37:24');

-- Dumping structure for procedure hotel_reservation_db.GetAvailableRooms
DELIMITER //
CREATE PROCEDURE `GetAvailableRooms`(
    IN p_check_in DATE,
    IN p_check_out DATE,
    IN p_guests INT
)
BEGIN
    SELECT DISTINCT
        r.room_id,
        r.room_number,
        r.floor_number,
        r.price_per_night,
        r.description,
        r.image_url,
        rt.type_name,
        rt.max_occupancy,
        rt.amenities
    FROM rooms r
    JOIN room_types rt ON r.type_id = rt.type_id
    WHERE r.status = 'AVAILABLE'
    AND rt.max_occupancy >= p_guests
    AND r.room_id NOT IN (
        SELECT DISTINCT room_id 
        FROM bookings 
        WHERE ((check_in_date < p_check_out AND check_out_date > p_check_in))
        AND booking_status IN ('CONFIRMED', 'CHECKED_IN')
    )
    ORDER BY r.floor_number, r.room_number;
END//
DELIMITER ;

-- Dumping structure for table hotel_reservation_db.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `is_read` bit(1) DEFAULT NULL,
  `message` text NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9y21adhxn0ayjhfocscqox7bh` (`user_id`),
  CONSTRAINT `FK9y21adhxn0ayjhfocscqox7bh` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hotel_reservation_db.notifications: ~5 rows (approximately)
INSERT INTO `notifications` (`id`, `created_at`, `is_read`, `message`, `user_id`) VALUES
	(1, NULL, b'0', 'Your booking REF01 has been confirmed. We look forward to welcoming you on 2025-11-01!', 1),
	(2, NULL, b'0', 'Payment of 54000.00 LKR for booking REF02 was successful.', 2),
	(3, NULL, b'1', 'Your booking REF03 has been created and is now pending payment.', 3),
	(4, NULL, b'0', 'A friendly reminder for your upcoming stay with us, booking REF04 on 2025-12-20.', 4),
	(5, NULL, b'1', 'Thank you for your feedback on your recent stay related to booking REF05!', 5);

-- Dumping structure for table hotel_reservation_db.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `payment_id` bigint NOT NULL AUTO_INCREMENT,
  `booking_id` bigint NOT NULL,
  `payment_method` enum('PAYHERE','CREDIT_CARD','DEBIT_CARD','CASH','BANK_TRANSFER') NOT NULL,
  `payment_provider` varchar(50) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `payhere_payment_id` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) DEFAULT 'LKR',
  `payment_status` enum('PENDING','PROCESSING','COMPLETED','FAILED','CANCELLED','REFUNDED') DEFAULT 'PENDING',
  `payment_date` timestamp NULL DEFAULT NULL,
  `gateway_response` json DEFAULT NULL,
  `failure_reason` text,
  `refund_amount` decimal(10,2) DEFAULT '0.00',
  `refund_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `completed_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  KEY `booking_id` (`booking_id`),
  KEY `idx_payment_status` (`payment_status`),
  KEY `idx_transaction_id` (`transaction_id`),
  KEY `idx_payment_date` (`payment_date`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hotel_reservation_db.payments: ~14 rows (approximately)
INSERT INTO `payments` (`payment_id`, `booking_id`, `payment_method`, `payment_provider`, `transaction_id`, `payhere_payment_id`, `amount`, `currency`, `payment_status`, `payment_date`, `gateway_response`, `failure_reason`, `refund_amount`, `refund_date`, `created_at`, `updated_at`, `completed_at`) VALUES
	(1, 10, 'CREDIT_CARD', NULL, '58feba97-77d9-4ff3-9968-6311b2ac4ce7', NULL, 13440.00, 'LKR', 'COMPLETED', '2025-08-21 10:39:50', NULL, NULL, 0.00, NULL, '2025-08-21 10:39:50', '2025-08-21 10:39:50', '2025-08-21 16:09:50.032512'),
	(4, 13, 'CREDIT_CARD', NULL, '1310ada6-7a27-4ab8-8ee2-b424ea804d66', NULL, 13440.00, 'LKR', 'COMPLETED', '2025-08-21 15:00:48', NULL, NULL, 0.00, NULL, '2025-08-21 15:00:48', '2025-08-21 15:00:48', '2025-08-21 20:30:47.983349'),
	(5, 14, 'CREDIT_CARD', NULL, 'f9082d16-aeab-4343-b57f-83cbb9226ddd', NULL, 13440.00, 'LKR', 'COMPLETED', '2025-08-31 11:46:28', NULL, NULL, 0.00, NULL, '2025-08-31 11:46:28', '2025-08-31 11:46:28', '2025-08-31 17:16:27.912156'),
	(6, 17, 'CREDIT_CARD', NULL, 'bcaac504-7485-4ee3-a659-46eb06c3db9a', NULL, 13440.00, 'LKR', 'COMPLETED', '2025-09-01 11:54:05', NULL, NULL, 0.00, NULL, '2025-09-01 11:54:05', '2025-09-01 11:54:05', '2025-09-01 17:24:04.740966'),
	(7, 18, 'CREDIT_CARD', NULL, '93deff2d-d97e-421a-9edf-7dfc6215fed7', NULL, 9520.00, 'LKR', 'COMPLETED', '2025-09-30 14:26:17', NULL, NULL, 0.00, NULL, '2025-09-30 14:26:17', '2025-09-30 14:26:17', '2025-09-30 19:56:16.805593'),
	(8, 20, 'CREDIT_CARD', NULL, '9c3e5740-41e9-4b3f-b8cc-beaec40e6fa3', NULL, 9520.00, 'LKR', 'COMPLETED', '2025-10-03 15:48:12', NULL, NULL, 0.00, NULL, '2025-10-03 15:48:12', '2025-10-03 15:48:12', '2025-10-03 21:18:12.268704'),
	(9, 21, 'CREDIT_CARD', NULL, '23cbf0d0-8b0b-4b33-81b8-602b64a8ec3a', NULL, 40320.00, 'LKR', 'COMPLETED', '2025-10-04 10:47:59', NULL, NULL, 0.00, NULL, '2025-10-04 10:47:59', '2025-10-04 10:47:59', '2025-10-04 16:17:59.180690'),
	(10, 22, 'CREDIT_CARD', NULL, 'b416492d-e39b-41ba-ac97-97c578c4af42', NULL, 13440.00, 'LKR', 'COMPLETED', '2025-10-04 11:17:51', NULL, NULL, 0.00, NULL, '2025-10-04 11:17:51', '2025-10-04 11:17:51', '2025-10-04 16:47:51.226036'),
	(11, 23, 'CREDIT_CARD', NULL, '0fe1a760-e35b-4c81-969c-3c8b30af6ab6', NULL, 13440.00, 'LKR', 'COMPLETED', '2025-10-05 04:03:49', NULL, NULL, 0.00, NULL, '2025-10-05 04:03:50', '2025-10-05 04:03:50', '2025-10-05 09:33:49.497186'),
	(12, 1, 'CREDIT_CARD', NULL, 'TXN001', NULL, 24000.00, 'LKR', 'COMPLETED', '2025-10-09 12:45:19', NULL, NULL, 0.00, NULL, '2025-10-09 12:45:19', '2025-10-09 12:45:19', NULL),
	(13, 2, 'BANK_TRANSFER', NULL, 'TXN002', NULL, 54000.00, 'LKR', 'COMPLETED', '2025-10-09 12:45:19', NULL, NULL, 0.00, NULL, '2025-10-09 12:45:19', '2025-10-09 12:45:19', NULL),
	(14, 3, 'PAYHERE', NULL, 'TXN003', NULL, 125000.00, 'LKR', 'COMPLETED', '2025-10-09 12:45:19', NULL, NULL, 0.00, NULL, '2025-10-09 12:45:19', '2025-10-09 12:45:19', NULL),
	(15, 4, 'CASH', NULL, 'TXN004', NULL, 90000.00, 'LKR', 'COMPLETED', '2025-10-09 12:45:19', NULL, NULL, 0.00, NULL, '2025-10-09 12:45:19', '2025-10-09 12:45:19', NULL),
	(16, 5, 'DEBIT_CARD', NULL, 'TXN005', NULL, 42500.00, 'LKR', 'COMPLETED', '2025-10-09 12:45:19', NULL, NULL, 0.00, NULL, '2025-10-09 12:45:19', '2025-10-09 12:45:19', NULL);

-- Dumping structure for table hotel_reservation_db.promotions
CREATE TABLE IF NOT EXISTS `promotions` (
  `promotion_id` bigint NOT NULL AUTO_INCREMENT,
  `applicable_room_types` json DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `description` text,
  `discount_type` enum('FIXED_AMOUNT','PERCENTAGE') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `end_date` datetime(6) NOT NULL,
  `image_path` varchar(500) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `maximum_discount` decimal(10,2) DEFAULT NULL,
  `minimum_booking_amount` decimal(10,2) DEFAULT NULL,
  `promo_code` varchar(20) NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `terms_conditions` text,
  `title` varchar(100) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `usage_count` int DEFAULT NULL,
  `usage_limit` int DEFAULT NULL,
  `created_by` bigint NOT NULL,
  PRIMARY KEY (`promotion_id`),
  UNIQUE KEY `UKlb6axxr9obo82kwyavxvj917y` (`promo_code`),
  KEY `FKdmyppdycrsqwl5mikrw105clk` (`created_by`),
  CONSTRAINT `FKdmyppdycrsqwl5mikrw105clk` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `promotions_chk_1` CHECK ((`usage_limit` >= 1))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hotel_reservation_db.promotions: ~7 rows (approximately)
INSERT INTO `promotions` (`promotion_id`, `applicable_room_types`, `created_at`, `description`, `discount_type`, `discount_value`, `end_date`, `image_path`, `is_active`, `maximum_discount`, `minimum_booking_amount`, `promo_code`, `start_date`, `terms_conditions`, `title`, `updated_at`, `usage_count`, `usage_limit`, `created_by`) VALUES
	(2, NULL, '2025-09-30 14:48:41.349232', 'daaas', 'PERCENTAGE', 20.00, '2025-10-08 14:47:00.000000', '/images/promotions/21465a5a-eb7a-4535-a38f-ea8e58811143.jpeg', b'1', 10000.00, 10.00, 'SUMMER21', '2025-10-01 14:47:00.000000', 'test', 'Summer special ', '2025-09-30 14:48:41.349232', 0, 20, 1),
	(3, NULL, '2025-10-05 09:29:21.653136', 'test', 'PERCENTAGE', 20.00, '2025-10-30 09:29:00.000000', '/images/promotions/ee3af4b4-7ef7-4a93-ad1c-435a715d6ed1.jpg', b'1', 300000.00, 10000.00, 'TEST122', '2025-10-06 09:28:00.000000', 'test', 'hotel promotionskkkkkkkkk', '2025-10-05 10:53:49.491620', 0, 60, 1),
	(14, NULL, NULL, 'Get 10% off your booking for a limited time.', 'PERCENTAGE', 10.00, '2025-12-31 23:59:59.000000', NULL, NULL, NULL, NULL, 'promotionsSAVE10', '2025-10-01 00:00:00.000000', NULL, '10% Off Autumn Sale', NULL, NULL, NULL, 1),
	(15, NULL, NULL, 'Enjoy a 20% discount for all stays during the winter season.', 'PERCENTAGE', 20.00, '2026-01-31 23:59:59.000000', NULL, NULL, NULL, NULL, 'WINTER20', '2025-11-01 00:00:00.000000', NULL, 'Winter Special 20%', NULL, NULL, NULL, 1),
	(16, NULL, NULL, 'Get a fixed 5000 LKR discount on bookings over 50000 LKR.', 'FIXED_AMOUNT', 5000.00, '2025-10-31 23:59:59.000000', NULL, NULL, NULL, NULL, 'FIXED5K', '2025-09-01 00:00:00.000000', NULL, 'Flat 5000 Off', NULL, NULL, NULL, 1),
	(17, NULL, NULL, 'Book 5 nights or more and get a 25% discount.', 'PERCENTAGE', 25.00, '2026-03-31 23:59:59.000000', NULL, NULL, NULL, NULL, 'LONGSTAY', '2025-10-01 00:00:00.000000', NULL, 'Long Stay Offer', NULL, NULL, NULL, 1),
	(18, NULL, NULL, 'A 24-hour flash sale with 50% off on deluxe rooms.', 'PERCENTAGE', 50.00, '2025-10-10 23:59:59.000000', NULL, NULL, NULL, NULL, 'FLASH50', '2025-10-10 00:00:00.000000', NULL, 'Flash Sale 50% Off!', NULL, NULL, NULL, 1);

-- Dumping structure for table hotel_reservation_db.promotion_usage
CREATE TABLE IF NOT EXISTS `promotion_usage` (
  `usage_id` bigint NOT NULL AUTO_INCREMENT,
  `discount_applied` decimal(10,2) NOT NULL,
  `used_at` datetime(6) NOT NULL,
  `booking_id` bigint NOT NULL,
  `customer_id` bigint NOT NULL,
  `promotion_id` bigint NOT NULL,
  PRIMARY KEY (`usage_id`),
  KEY `FK9xl425xpylqw9ayx67j0d6bjc` (`booking_id`),
  KEY `FK4x8sa31599c6wj1kqqclu2fnu` (`customer_id`),
  KEY `FKejsynwyybbw6r6eo7w0p6sfa5` (`promotion_id`),
  CONSTRAINT `FK4x8sa31599c6wj1kqqclu2fnu` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `FK9xl425xpylqw9ayx67j0d6bjc` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`),
  CONSTRAINT `FKejsynwyybbw6r6eo7w0p6sfa5` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`promotion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hotel_reservation_db.promotion_usage: ~3 rows (approximately)
INSERT INTO `promotion_usage` (`usage_id`, `discount_applied`, `used_at`, `booking_id`, `customer_id`, `promotion_id`) VALUES
	(4, 10800.00, '2025-10-09 18:21:37.000000', 2, 2, 2),
	(5, 25000.00, '2025-10-09 18:21:37.000000', 3, 3, 3),
	(6, 18000.00, '2025-10-09 18:21:37.000000', 4, 4, 2);

-- Dumping structure for table hotel_reservation_db.reviews
CREATE TABLE IF NOT EXISTS `reviews` (
  `review_id` bigint NOT NULL AUTO_INCREMENT,
  `admin_response` text,
  `comment` text,
  `created_at` datetime(6) DEFAULT NULL,
  `is_approved` bit(1) DEFAULT NULL,
  `is_verified_stay` bit(1) DEFAULT NULL,
  `rating` int NOT NULL,
  `responded_at` datetime(6) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `booking_id` bigint DEFAULT NULL,
  `customer_id` bigint NOT NULL,
  `room_id` bigint NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `FK28an517hrxtt2bsg93uefugrm` (`booking_id`),
  KEY `FK4sm0k8kw740iyuex3vwwv1etu` (`customer_id`),
  KEY `FKoppowk1pob9qiujo31erx63x1` (`room_id`),
  CONSTRAINT `FK28an517hrxtt2bsg93uefugrm` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`),
  CONSTRAINT `FK4sm0k8kw740iyuex3vwwv1etu` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `FKoppowk1pob9qiujo31erx63x1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hotel_reservation_db.reviews: ~7 rows (approximately)
INSERT INTO `reviews` (`review_id`, `admin_response`, `comment`, `created_at`, `is_approved`, `is_verified_stay`, `rating`, `responded_at`, `title`, `updated_at`, `booking_id`, `customer_id`, `room_id`) VALUES
	(1, NULL, 'dfdfdf', '2025-09-30 22:38:30.743989', b'1', b'1', 5, NULL, 'tttt', '2025-09-30 22:48:16.525475', 18, 2, 1),
	(2, NULL, 'well room', '2025-10-04 16:49:23.412970', b'1', b'1', 4, NULL, 'supereb', '2025-10-04 16:49:47.829088', 22, 7, 2),
	(3, NULL, 'The room was clean and the staff were very friendly.', NULL, NULL, NULL, 5, NULL, 'Excellent Stay!', NULL, 1, 1, 2),
	(4, NULL, 'Enjoyed the city view from the deluxe room.', NULL, NULL, NULL, 4, NULL, 'Great View', NULL, 2, 2, 3),
	(5, NULL, 'The suite was spacious and comfortable for our family of four.', NULL, NULL, NULL, 5, NULL, 'Perfect for Families', NULL, 3, 3, 5),
	(6, NULL, 'The presidential suite exceeded all expectations.', NULL, NULL, NULL, 5, NULL, 'Pure Luxury', NULL, 4, 4, 6),
	(7, NULL, 'The single room was adequate for a short stay.', NULL, NULL, NULL, 3, NULL, 'Good for a Solo Trip', NULL, 5, 5, 1);

-- Dumping structure for table hotel_reservation_db.rooms
CREATE TABLE IF NOT EXISTS `rooms` (
  `room_id` bigint NOT NULL AUTO_INCREMENT,
  `room_number` varchar(10) NOT NULL,
  `type_id` bigint NOT NULL,
  `floor_number` int NOT NULL,
  `status` enum('AVAILABLE','OCCUPIED','MAINTENANCE','OUT_OF_ORDER') DEFAULT 'AVAILABLE',
  `price_per_night` decimal(10,2) NOT NULL,
  `description` text,
  `amenities` json DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `room_number` (`room_number`),
  KEY `idx_rooms_status` (`status`),
  KEY `idx_rooms_type` (`type_id`),
  KEY `idx_rooms_status_type` (`status`,`type_id`),
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `room_types` (`type_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hotel_reservation_db.rooms: ~16 rows (approximately)
INSERT INTO `rooms` (`room_id`, `room_number`, `type_id`, `floor_number`, `status`, `price_per_night`, `description`, `amenities`, `image_url`, `created_at`, `updated_at`) VALUES
	(1, '101', 1, 1, 'AVAILABLE', 8500.00, 'Cozy single room on the ground floor', NULL, NULL, '2025-08-17 19:23:41', '2025-10-03 21:32:42'),
	(2, '102', 2, 1, 'AVAILABLE', 12000.00, 'Comfortable double room with garden view', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(3, '103', 2, 1, 'AVAILABLE', 12000.00, 'Double room near reception', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(4, '104', 1, 1, 'AVAILABLE', 8500.00, 'Single room with courtyard view', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(5, '201', 3, 2, 'AVAILABLE', 18000.00, 'Deluxe room with city view', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(6, '202', 3, 2, 'AVAILABLE', 18000.00, 'Deluxe room with balcony', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(7, '203', 4, 2, 'AVAILABLE', 25000.00, 'Family suite with separate living area', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(8, '204', 3, 2, 'MAINTENANCE', 18000.00, 'Deluxe room under maintenance', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(9, '301', 4, 3, 'AVAILABLE', 25000.00, 'Spacious family suite with ocean view', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(10, '302', 5, 3, 'AVAILABLE', 45000.00, 'Presidential suite with panoramic views', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(11, '303', 3, 3, 'AVAILABLE', 18000.00, 'Deluxe room on top floor', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(12, '304', 4, 3, 'AVAILABLE', 25000.00, 'Family suite with mountain view', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(13, '401', 2, 4, 'AVAILABLE', 12000.00, 'Double room with excellent view', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(14, '402', 2, 4, 'AVAILABLE', 12000.00, 'Corner double room', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(15, '403', 1, 4, 'AVAILABLE', 8500.00, 'Single room on top floor', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38'),
	(16, '404', 3, 4, 'AVAILABLE', 18000.00, 'Deluxe room with premium location', NULL, '/images/room-default.jpg', '2025-08-17 19:23:41', '2025-09-30 18:55:38');

-- Dumping structure for table hotel_reservation_db.room_types
CREATE TABLE IF NOT EXISTS `room_types` (
  `type_id` bigint NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  `description` text,
  `base_price` decimal(10,2) NOT NULL,
  `max_occupancy` int NOT NULL,
  `amenities` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `type_name` (`type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hotel_reservation_db.room_types: ~5 rows (approximately)
INSERT INTO `room_types` (`type_id`, `type_name`, `description`, `base_price`, `max_occupancy`, `amenities`, `created_at`, `updated_at`) VALUES
	(1, 'Standard Single', 'Comfortable single room with essential amenities', 8500.00, 1, '["WiFi", "AC", "TV", "Private Bathroom"]', '2025-08-17 19:23:41', '2025-08-17 19:23:41'),
	(2, 'Standard Double', 'Spacious double room perfect for couples', 12000.00, 2, '["WiFi", "AC", "TV", "Private Bathroom", "Mini Fridge"]', '2025-08-17 19:23:41', '2025-08-17 19:23:41'),
	(3, 'Deluxe Room', 'Luxurious room with premium amenities', 18000.00, 3, '["WiFi", "AC", "TV", "Private Bathroom", "Mini Fridge", "Balcony", "Room Service"]', '2025-08-17 19:23:41', '2025-08-17 19:23:41'),
	(4, 'Family Suite', 'Large suite perfect for families', 25000.00, 4, '["WiFi", "AC", "TV", "Private Bathroom", "Mini Fridge", "Balcony", "Room Service", "Sofa Bed"]', '2025-08-17 19:23:41', '2025-08-17 19:23:41'),
	(5, 'Presidential Suite', 'Ultimate luxury accommodation', 45000.00, 6, '["WiFi", "AC", "TV", "Private Bathroom", "Mini Fridge", "Balcony", "Room Service", "Jacuzzi", "Butler Service"]', '2025-08-17 19:23:41', '2025-08-17 19:23:41');

-- Dumping structure for table hotel_reservation_db.users
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `role` enum('CUSTOMER','ADMIN','STAFF') DEFAULT 'CUSTOMER',
  `is_active` tinyint(1) DEFAULT '1',
  `email_verified` tinyint(1) DEFAULT '0',
  `verification_token` varchar(255) DEFAULT NULL,
  `reset_password_token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_users_email` (`email`),
  KEY `idx_users_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table hotel_reservation_db.users: ~15 rows (approximately)
INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `first_name`, `last_name`, `role`, `is_active`, `email_verified`, `verification_token`, `reset_password_token`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'admin@hotel.com', '$2a$10$5nfm2mElVp.cVGixqoVdiuJXXzhcP6b1Eplp4IOKnYpLPkLL0dU7C', 'Hotel', 'Administrator', 'ADMIN', 1, 1, NULL, NULL, '2025-08-17 19:23:41', '2025-09-30 01:12:12'),
	(2, 'john_doe', 'john.doe@gmail.com', '$2a$10$rOmSYGJUdVZKhWgfVwPLR.XhJLJhd3MKbYYoRi4CQUZ8XKUfgLJvy', 'John', 'Doe', 'CUSTOMER', 1, 1, NULL, NULL, '2025-08-17 19:23:41', '2025-08-17 19:23:41'),
	(3, 'customer1', 'customer@hotel.com', '$2a$10$a.lyutfEg55Ls5HrHYcQduOXVTLtC6dklXXpdbfQZRf/3BVlLucRS', 'John', 'Doe', 'CUSTOMER', 1, 1, NULL, NULL, '2025-08-18 02:35:26', '2025-08-18 02:35:26'),
	(4, 'hasindu_theekshana', 'hasindutwm@gmail.com', '$2a$10$.Xi92CyOawlRZKlRUbY80.sN5Ujut2wMVPmO8WtWxgyrE8oYTgxla', 'Hasindu', 'Wanninayake', 'CUSTOMER', 1, 1, NULL, NULL, '2025-08-18 04:01:15', '2025-08-18 04:01:15'),
	(5, 'koda_hari', 'haritha1@gmail.com', '$2a$10$r3rlPdGWe.5OzQzVVYZ6TuhCtOjzUB.zoLzPcZLyv2bgI6ugYmcUC', 'haritha', 'kodagoda', 'CUSTOMER', 1, 1, NULL, NULL, '2025-08-18 04:23:04', '2025-08-18 04:23:04'),
	(6, 'res_hotel', 'receptionist@goldpalmhotel.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.', 'reseptionist', 'palm', 'STAFF', 1, 1, NULL, NULL, '2025-08-22 06:56:04', '2025-08-22 06:56:04'),
	(7, 'reseptionist', 'hotelreseptionist@gmail.com', '$2a$10$X36UPgcr4vmRM8kYcq5ipu2/vsgXgiry/QDtZ3vPKb0PAOdsAuewK', 'hotel', 'reseptionist', 'STAFF', 1, 1, NULL, NULL, '2025-08-22 01:45:36', '2025-08-22 07:18:36'),
	(8, 'admin1', 'admin1@gmail.com', '$2a$10$e1wc5u30mFEQeABOM.Ne7u6I8U1VFdasfqtqYsGgiNVLIvHelpPLi', 'admin', 'super', 'ADMIN', 1, 1, NULL, NULL, '2025-09-22 06:48:11', '2025-09-22 12:18:23'),
	(9, 'receptionist', 'receptionist@hotel.com', '$2a$10$wHYFpZUBeX/6D0KJul5Q/.j9j29ltoostbv9y6XtDPHJvGc06Gr/u', 'Sarah', 'Johnson', 'STAFF', 1, 1, NULL, NULL, '2025-10-03 20:59:23', '2025-10-03 20:59:23'),
	(11, 'hasinduw11', 'hasindut1@gmail.com', '$2a$10$oKrMOGzKHlTNRTUftuHfCemlKS0IX0RaGqyRX8m7TsD6KEmnyLOf6', 'hasindu', 'wanninayake', 'CUSTOMER', 1, 1, NULL, NULL, '2025-10-04 09:34:20', '2025-10-20 05:01:24'),
	(17, 'hasinduw', 'hasindut11@gmail.com', '$2a$10$placeholderHashForSecurity1', 'Hasindu', 'Wanninayake', 'CUSTOMER', 1, 0, NULL, NULL, '2025-10-09 10:31:27', '2025-10-09 10:31:27'),
	(18, 'paveshc', 'chotabeemps@gmail.com', '$2a$10$placeholderHashForSecurity2', 'pavesh', 'chotabeem', 'CUSTOMER', 1, 0, NULL, NULL, '2025-10-09 10:31:27', '2025-10-09 10:31:27'),
	(19, 'hamesham', 'belekhamesha@gmail.com', '$2a$10$placeholderHashForSecurity3', 'hamesha', 'mudaligama', 'CUSTOMER', 1, 0, NULL, NULL, '2025-10-09 10:31:27', '2025-10-09 10:31:27'),
	(20, 'sheharap', 'sheharaabsent@gmail.com', '$2a$10$placeholderHashForSecurity4', 'shehara', 'perera', 'CUSTOMER', 1, 0, NULL, NULL, '2025-10-09 10:31:27', '2025-10-09 10:31:27'),
	(21, 'janithm', 'modajanith1@gmail.com', '$2a$10$placeholderHashForSecurity5', 'janith', 'mudunpila', 'CUSTOMER', 1, 0, NULL, NULL, '2025-10-09 10:31:27', '2025-10-09 10:31:27');

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `available_rooms_view`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `available_rooms_view` AS select `r`.`room_id` AS `room_id`,`r`.`room_number` AS `room_number`,`r`.`floor_number` AS `floor_number`,`r`.`price_per_night` AS `price_per_night`,`r`.`description` AS `room_description`,`r`.`image_url` AS `image_url`,`rt`.`type_name` AS `type_name`,`rt`.`description` AS `type_description`,`rt`.`max_occupancy` AS `max_occupancy`,`rt`.`amenities` AS `amenities` from (`rooms` `r` join `room_types` `rt` on((`r`.`type_id` = `rt`.`type_id`))) where (`r`.`status` = 'AVAILABLE')
;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `booking_details_view`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `booking_details_view` AS select `b`.`booking_id` AS `booking_id`,`b`.`booking_reference` AS `booking_reference`,`b`.`check_in_date` AS `check_in_date`,`b`.`check_out_date` AS `check_out_date`,`b`.`number_of_guests` AS `number_of_guests`,`b`.`total_amount` AS `total_amount`,`b`.`booking_status` AS `booking_status`,`b`.`payment_status` AS `payment_status`,concat(`u`.`first_name`,' ',`u`.`last_name`) AS `customer_name`,`u`.`email` AS `customer_email`,`c`.`phone_number` AS `phone_number`,`r`.`room_number` AS `room_number`,`rt`.`type_name` AS `room_type`,`b`.`created_at` AS `created_at` from ((((`bookings` `b` join `customers` `c` on((`b`.`customer_id` = `c`.`customer_id`))) join `users` `u` on((`c`.`user_id` = `u`.`user_id`))) join `rooms` `r` on((`b`.`room_id` = `r`.`room_id`))) join `room_types` `rt` on((`r`.`type_id` = `rt`.`type_id`)))
;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
