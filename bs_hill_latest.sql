-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2021 at 09:26 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bs_hill`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_appointments`
--

CREATE TABLE `admin_appointments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `appointment_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `appointment_end_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `appointment_type` tinyint(4) DEFAULT 0,
  `appointment_duration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `appointment_status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `appointment_end_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `appointment_type` tinyint(4) DEFAULT 0,
  `appointment_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1->appointment fix,2->cancel appoin.,3->resedule',
  `payment_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0: Payment Not done; 1: Payment Done',
  `consultation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `appointment_date`, `appointment_time`, `appointment_end_time`, `appointment_type`, `appointment_status`, `payment_status`, `consultation_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, '2020-10-27', '16:25:00', '16:30:00', 1, 2, 1, 29, 1, NULL, '2021-01-29 18:15:35'),
(2, '2020-10-27', '16:25:00', '16:30:00', 2, 1, 0, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `appointment_prices`
--

CREATE TABLE `appointment_prices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `appointment_type_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `appointment_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `appointment_duration` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '1-> consultation , 2->Appointment',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `appointment_prices`
--

INSERT INTO `appointment_prices` (`id`, `appointment_type_name`, `appointment_price`, `appointment_duration`, `type`, `created_at`, `updated_at`) VALUES
(1, 'Initial Meeting', '', '45', 2, NULL, NULL),
(2, 'Followup Meeting', '', '15', 2, NULL, NULL),
(3, 'Existing follow up', '65', '15', 2, NULL, NULL),
(4, 'Personalized Trichological Consultation', '300', '300', 2, NULL, NULL),
(5, 'New Consultation ', '150', '', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `consultations`
--

CREATE TABLE `consultations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `consultations_comments` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consultant_created_at` datetime DEFAULT NULL,
  `consultant_ended_at` datetime DEFAULT NULL,
  `car_report_response` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `car_report_created_at` datetime DEFAULT NULL,
  `feedback_rating` tinyint(4) DEFAULT 0,
  `feedback_text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `car_admin_remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `concern_type` int(11) DEFAULT NULL,
  `condition_type` int(11) DEFAULT NULL,
  `consultant_status` tinyint(4) DEFAULT 0 COMMENT '0->in progress,1->final submitted and payment done,2->under review,3-> CAR Generated,4->ques and images submit payment not done,5->question done and images pending; 6 - Disabled',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `consultations`
--

INSERT INTO `consultations` (`id`, `user_id`, `consultations_comments`, `consultant_created_at`, `consultant_ended_at`, `car_report_response`, `car_report_created_at`, `feedback_rating`, `feedback_text`, `car_admin_remarks`, `concern_type`, `condition_type`, `consultant_status`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, '2020-12-02 13:14:58', '2020-12-02 13:14:58', NULL, NULL, 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam quam eros, elementum vel laoreet eu, egestas at tellus.', NULL, 1, 6, 2, '2020-12-02 13:14:58', '2021-01-08 14:24:21'),
(2, 2, NULL, '2020-12-02 13:14:58', '2020-12-02 13:14:58', NULL, NULL, 0, NULL, NULL, 1, 5, 2, '2020-12-02 13:14:58', '2021-01-08 14:20:58'),
(3, 6, NULL, '2021-01-05 18:30:54', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-05 18:30:54', '2021-01-05 18:30:54'),
(4, 6, NULL, '2021-01-05 18:36:02', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-05 18:36:02', '2021-01-05 18:36:02'),
(5, 6, NULL, '2021-01-05 18:37:01', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-05 18:37:01', '2021-01-05 18:37:01'),
(6, 6, NULL, '2021-01-05 18:43:57', NULL, NULL, NULL, 0, NULL, NULL, 1, 7, 2, '2021-01-05 18:43:57', '2021-01-08 23:24:42'),
(7, 1, NULL, '2021-01-17 20:43:32', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-17 15:13:32', '2021-01-17 15:13:32'),
(8, 1, NULL, '2021-01-18 22:28:12', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 16:58:12', '2021-01-18 16:58:12'),
(9, 1, NULL, '2021-01-18 22:29:23', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 16:59:23', '2021-01-18 16:59:23'),
(10, 1, NULL, '2021-01-18 22:29:27', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 16:59:27', '2021-01-18 16:59:27'),
(11, 1, NULL, '2021-01-18 22:33:46', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 17:03:46', '2021-01-18 17:03:46'),
(12, 1, NULL, '2021-01-18 22:34:24', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 17:04:24', '2021-01-18 17:04:24'),
(13, 1, NULL, '2021-01-18 22:35:01', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 17:05:01', '2021-01-18 17:05:01'),
(14, 1, NULL, '2021-01-18 22:37:28', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 17:07:28', '2021-01-18 17:07:28'),
(15, 1, NULL, '2021-01-18 22:39:49', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 17:09:49', '2021-01-18 17:09:49'),
(16, 1, NULL, '2021-01-18 23:29:50', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 17:59:50', '2021-01-18 17:59:50'),
(17, 1, NULL, '2021-01-18 23:42:56', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 18:12:56', '2021-01-18 18:12:56'),
(18, 1, NULL, '2021-01-18 23:45:51', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 18:15:51', '2021-01-18 18:15:51'),
(19, 1, NULL, '2021-01-18 23:46:10', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 18:16:10', '2021-01-18 18:16:10'),
(20, 1, NULL, '2021-01-18 23:46:26', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 18:16:26', '2021-01-18 18:16:26'),
(21, 1, NULL, '2021-01-18 23:46:41', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 18:16:41', '2021-01-18 18:16:41'),
(22, 1, NULL, '2021-01-18 23:46:51', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 18:16:51', '2021-01-18 18:16:51'),
(23, 1, NULL, '2021-01-18 23:50:00', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 18:20:00', '2021-01-18 18:20:00'),
(24, 1, NULL, '2021-01-18 23:50:21', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 18:20:21', '2021-01-18 18:20:21'),
(25, 1, NULL, '2021-01-18 23:50:39', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 18:20:39', '2021-01-18 18:20:39'),
(26, 1, NULL, '2021-01-18 23:51:53', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 18:21:53', '2021-01-18 18:21:53'),
(27, 1, NULL, '2021-01-19 00:01:55', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2021-01-18 18:31:55', '2021-01-18 18:31:55'),
(28, 1, NULL, '2021-01-19 13:34:40', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 4, '2021-01-19 08:04:40', '2021-01-19 13:31:40'),
(29, 1, NULL, '2021-01-19 20:31:36', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 1, '2021-01-19 15:01:36', '2021-01-20 10:23:53');

-- --------------------------------------------------------

--
-- Table structure for table `consultation_notes`
--

CREATE TABLE `consultation_notes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `consultation_id` int(11) NOT NULL,
  `note_type` tinyint(4) NOT NULL,
  `condition_id` int(11) NOT NULL,
  `consultation_note` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `consultation_products`
--

CREATE TABLE `consultation_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `consulation_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `country_short_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phonecode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `country_short_name`, `country_name`, `phonecode`, `created_at`, `updated_at`) VALUES
(231, 'US', 'United States', '1', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `country_states`
--

CREATE TABLE `country_states` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `state_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `country_states`
--

INSERT INTO `country_states` (`id`, `state_name`, `country_id`, `created_at`, `updated_at`) VALUES
(1, 'Alabama', 231, NULL, NULL),
(2, 'Alaska', 231, NULL, NULL),
(3, 'Arizona', 231, NULL, NULL),
(4, 'Arkansas', 231, NULL, NULL),
(5, 'Byram', 231, NULL, NULL),
(6, 'California', 231, NULL, NULL),
(7, 'Cokato', 231, NULL, NULL),
(8, 'Connecticut', 231, NULL, NULL),
(9, 'Delaware', 231, NULL, NULL),
(10, 'District of Columbia', 231, NULL, NULL),
(11, 'Florida', 231, NULL, NULL),
(12, 'Georgia', 231, NULL, NULL),
(13, 'Hawaii', 231, NULL, NULL),
(14, 'Idaho', 231, NULL, NULL),
(15, 'Illinois', 231, NULL, NULL),
(16, 'Indiana', 231, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `consultation_id` int(11) DEFAULT NULL,
  `file_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_type` tinyint(4) DEFAULT 1 COMMENT '1->image,2->videos',
  `file_view_from` tinyint(4) DEFAULT 0 COMMENT '0->none,1->left,2->right,3->front,4->back',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`id`, `user_id`, `consultation_id`, `file_url`, `file_type`, `file_view_from`, `created_at`, `updated_at`) VALUES
(3, 1, 6, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/HOAkxUONA66SGPvycXUfio41ClV7CuVIkknWpOa5.jpeg', 1, 3, NULL, NULL),
(4, 1, 6, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/HOAkxUONA66SGPvycXUfio41ClV7CuVIkknWpOa5.jpeg', 1, 4, NULL, NULL),
(5, NULL, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/iwlEeAyB4V1tOxCqmMKNW38UZvRF1kF4v4aRSjUG.png', 1, 1, '2021-01-19 11:44:11', '2021-01-19 11:44:11'),
(6, NULL, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/AVx3qG3AuZesPGuoiVDLBiwZ3DfgTepVZiNxDsGr.png', 1, 1, '2021-01-19 11:44:12', '2021-01-19 11:44:12'),
(7, NULL, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/mrZpqPAsy05H5tiFCPy1p332HHkxu16J7AQS0q2y.png', 1, 1, '2021-01-19 11:45:17', '2021-01-19 11:45:17'),
(8, NULL, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/AH63qGfK0426Q42zxLPQYB8PQT5V5ycTetznIiOx.png', 1, 1, '2021-01-19 11:45:17', '2021-01-19 11:45:17'),
(9, NULL, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/jkee85c7il4HD9zn3i7OtZFzSjYQc00m0kvsXTy6.png', 1, 1, '2021-01-19 11:47:30', '2021-01-19 11:47:30'),
(10, NULL, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/60U9bVYG0Ti2o9ABVir1qZo7dNYiPaWd8IiQOtbR.png', 1, 1, '2021-01-19 11:47:31', '2021-01-19 11:47:31'),
(11, 1, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/or2xh5UzyPRn45kbDm6dWlLPwAwNoQRXkNVPf4nV.png', 1, 1, '2021-01-19 11:48:04', '2021-01-19 11:48:04'),
(12, 1, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/TQFEOmQZUbpZFx3pGbSDArTvTEZLkPQVSikErxPh.png', 1, 1, '2021-01-19 11:48:04', '2021-01-19 11:48:04'),
(13, 1, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/ygKDANB4nOEnNaxOCmdKPVXrNSCvXUuQkiV4edV3.png', 1, 2, '2021-01-19 12:57:48', '2021-01-19 12:57:48'),
(14, 1, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/FIXbkbVvk9FoWSGreusltCzN0ib25KvRCBPlthTR.png', 1, 2, '2021-01-19 12:57:48', '2021-01-19 12:57:48'),
(15, 1, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/VqaiQSB1s0SYos4T0lDMgMOjYgyOwihed1Funsll.png', 1, 3, '2021-01-19 12:57:54', '2021-01-19 12:57:54'),
(16, 1, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/OhWDTochjRiWxd2do17dwbnmeIQNBWxUPFXb1J1r.png', 1, 3, '2021-01-19 12:57:54', '2021-01-19 12:57:54'),
(17, 1, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/JChfyeFNtCq1HFw64ShvsES7k11g0OBSITKwNGMw.png', 1, 4, '2021-01-19 12:58:00', '2021-01-19 12:58:00'),
(18, 1, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/Te9a4ih81NAUuWWHQB6kO8b5jVTIEFpuJycIfIi0.png', 1, 4, '2021-01-19 12:58:00', '2021-01-19 12:58:00'),
(19, 1, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/qM0vDj31KLslIR064PEDrHabhU6yQmTitPGijFRK.png', 1, 4, '2021-01-19 12:59:32', '2021-01-19 12:59:32'),
(20, 1, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/YKDLc6g0iD5Vy53DhlAiE6KSKWQ0njssTo15v5ZN.png', 1, 4, '2021-01-19 12:59:32', '2021-01-19 12:59:32'),
(21, 1, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/consultation/aCMa18MvWqsJiTdtpjCKBtN7dnWtOEZMGRaBXCs2.png', 1, 4, '2021-01-19 13:31:39', '2021-01-19 13:31:39'),
(22, 1, 28, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/consultation/IzGwcH6CVWT1ctqjbQmuXkVPGPBGcdVAWmSh0q0Y.png', 1, 4, '2021-01-19 13:31:40', '2021-01-19 13:31:40');

-- --------------------------------------------------------

--
-- Table structure for table `gender`
--

CREATE TABLE `gender` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `gender_key` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `gender_val` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `gender`
--

INSERT INTO `gender` (`id`, `gender_key`, `gender_val`, `created_at`, `updated_at`) VALUES
(1, 'F', 'Female', '0000-00-00 00:00:00', '2021-01-15 16:23:46'),
(2, 'M', 'Male', '0000-00-00 00:00:00', '2021-01-15 16:23:46'),
(3, 'T', 'Transgender', '0000-00-00 00:00:00', '2021-01-15 16:23:46'),
(4, 'O', 'Others', '0000-00-00 00:00:00', '2021-01-15 16:23:46');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2019_08_19_000000_create_failed_jobs_table', 1),
(3, '2020_09_25_081415_create_roles_table', 1),
(4, '2020_09_25_081603_create_user_sessions_table', 1),
(5, '2020_09_25_083131_create_user_roles_table', 1),
(6, '2020_09_29_075424_create_otps_table', 1),
(7, '2020_10_08_102025_create_countries_table', 2),
(8, '2020_10_08_102654_create_country_states_table', 2),
(9, '2020_10_15_105317_create_ques_table', 3),
(10, '2020_10_15_105414_create_ques_options_table', 3),
(11, '2020_10_15_105507_create_ques_answers_consultant_table', 3),
(12, '2020_10_15_105559_create_consultants_table', 3),
(13, '2020_10_20_132443_create_ques_conditions_table', 3),
(14, '2020_10_26_162329_create_files_table', 3),
(15, '2020_10_27_122233_create_appointments_table', 3),
(16, '2020_10_27_140106_create_appointment_prices_table', 3),
(17, '2020_10_29_184957_create_products_table', 3),
(18, '2020_10_29_185906_create_product_images_table', 3),
(19, '2020_10_29_190052_create_product_associated_concern_mapping_table', 3),
(20, '2020_10_29_190111_create_product_associated_condition_mapping_table', 3),
(21, '2020_10_29_194020_create_product_associated_types_table', 3),
(22, '2020_10_30_133541_create_consultation_products_table', 3),
(23, '2020_10_30_154251_create_consultation_notes_table', 3),
(24, '2020_11_04_124608_create_admin_appointments_table', 4),
(25, '2020_11_12_164331_create_promotion_videos_table', 5),
(26, '2020_11_17_104647_create_static_pages_table', 5),
(27, '2020_11_17_111840_create_static_page_linking_table', 5);

-- --------------------------------------------------------

--
-- Table structure for table `otps`
--

CREATE TABLE `otps` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_otp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_otp` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `temp_token` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `otps`
--

INSERT INTO `otps` (`id`, `email`, `email_otp`, `mobile`, `mobile_otp`, `temp_token`, `status`, `created_at`, `updated_at`) VALUES
(1, 'shubham.agnihotri35@gmail.com', '267360', NULL, NULL, 'c02039001bc9bdddfee011b1824eb6f84bcd546233934c1486379800e4b45737a497c74bc0c97c25b0c9434a5ed6c45c220f', 1, '2020-10-06 16:19:40', NULL),
(2, 'shubham.agnihotri35@gmail.com', '449330', NULL, NULL, 'b7709a48e0d6fc3145a8ed52d12c45def1e9f353d6404060965bbafdee8e5b1869b208913595b6f34838c9c31fcf50c40437', 1, '2020-10-06 16:21:24', NULL),
(3, 'shubham.agnihotri356@gmail.com', '805977', NULL, NULL, 'c20efe5f65f3de17bfaa7934829a8fc487a7d8cfed24e3871a14f1062e45c34359182fb2ad289cf87c570a78bb7909ea4832', 1, '2020-10-06 19:00:30', NULL),
(4, 'shubham.agnihotri356@gmail.com', '811468', NULL, NULL, '071ac3abc8fe27f6f03ffbed08c1f2d71e566f2d837f76a263d0a92067f52c4e2fd3b89dd1ac3c9d30b534aa5ffaad285b8c', 1, '2020-10-06 19:02:09', NULL),
(6, 'shubham.agnihotri356@gmail.com', '224752', NULL, NULL, 'ac98164b54de49bab24f6eeae0298913e3ffb1bb03077e7c58c194bcd9f529a33268d3f917a0406f958e75d6377cf8de933f', 1, '2020-10-06 19:07:52', NULL),
(7, 'shubham.agnihotri356@gmail.com', '790336', NULL, NULL, '2ae6069cadcc61bd5cd63fb2d81e800d2e4617a723c88aa33aef9301b45cae8c3296855ca918d5b291d93e60988144eb00ab', 1, '2020-10-06 19:32:30', NULL),
(8, 'shubham.@gmail.com', '164117', NULL, NULL, 'f2686402fc7ed7c5e7d282ce474d4d5bd32ddb4f1bf6a0e119b947fa9ded15ef0967a73f50addc1e05f6e104be6b30e57edb', 1, '2020-10-13 01:19:52', NULL),
(9, 'shubham@gmail.com', '909575', NULL, NULL, '7f5433c6edb489954a815bb188623a951140b8822174970714f3ef4df9b6220b20e9ba3aecd0e7dc2d1024bcbc85db8050f2', 1, '2020-10-13 01:19:57', NULL),
(10, 'shubham.@gmail.com', '468407', NULL, NULL, '71176d27182229be6ddcb318d3221aa19b3aeb074758343b30a15a8afdff86b7823c0aeb55c413edb97457b7c18addb31bab', 1, '2020-10-13 01:20:08', NULL),
(12, 'yaloyeg.@jarilusua.com', '482779', NULL, NULL, '9c1b5fd03c27d9827ed67258e128fe4e530cc548960693ab90cefcd0d58cfd358231b627002e1b645c94b23f67e1a5aea057', 1, '2020-10-13 12:58:43', NULL),
(13, 'johndoe@pastortips.com', '113744', NULL, NULL, '6ace6cec3b715c91f8bf331a97e0de781a4b3f91912b17b05c609bf1e21b8a74eebbfe4f81def5bb02261a08e72451dadfc8', 0, '2020-10-13 22:42:20', '2020-10-13 22:42:53'),
(14, 'johndoe@pastortips.com', '359304', NULL, NULL, 'ee48c248d2ce7ec0855acdf522f814dd58ada82a91b150cdbeb8f9a4b4b98882315efc6dfe61691e8eaeaa4141b058aafa78', 1, '2020-10-14 11:31:59', NULL),
(15, 'johndoe@pastortips.com', '470302', NULL, NULL, 'b0772ea84d42999fe27d5de3f46c7909ced484cb7ce7cb57da121d337b99785ed443fd0901bb87fe4e99864739d8d64671e6', 1, '2020-10-14 11:33:10', NULL),
(16, 'johndoe@pastortips.com', '618383', NULL, NULL, 'c4e588f5c3a06c9e480b4575d6e323cb71a7b2c0adea72dadd6c09dcddb41ea5ca04712876d34842fc5287271d299b50cb3e', 1, '2020-10-14 11:34:35', NULL),
(18, 'shubham.agnihotri356@gmail.com', '877730', NULL, NULL, '954a4c975301b3c5455a610bf3dbde4bcaa763006f252e8c11008ccce3a720eb03fc2e05325d03ab7a6064e22b148df413b1', 1, '2020-10-14 13:34:10', NULL),
(20, 'johndoe@pastortips.com', '244009', NULL, NULL, '15ab56f6f0ea464bebb1aff30e5c8ecf3d347fdae3b081e08a0ffc36f8d88fe7cb42fbae40c75d7344d2f4af64001e61772e', 0, '2020-10-14 14:47:06', '2020-10-14 14:47:32'),
(21, 'johndoe@pastortips.com', '254040', NULL, NULL, '0a3506af56b881ccfdc40888b8f87551b350bde03d26962702ceb49726f6c3b29906f6f435f2b129700f09e50ffad75f23e6', 0, '2020-10-14 14:50:31', '2020-10-14 14:51:19'),
(23, 'rachitmathur8@gmail.com', '960211', NULL, NULL, '5911da789e453d8d525f283a9b802038e4c2afff6fff1cd35095e53c0597ecde432f91a446c7ddff075c2b26b03ddc8dadee', 1, '2020-12-15 00:31:02', NULL),
(27, 'shashi.r@coppermobile.com', '497236', NULL, NULL, '2167ab273678856ffb5ac1705158736ec4eea268bed279703bcce1919743e74f769b3c05fb99e24c4c7f1450da981c0b5d9d', 1, '2021-01-28 13:09:51', NULL),
(28, 'shubham.agnihotri356@gmail.com', '373798', NULL, NULL, 'c852678f189d9a5463042b603e303479cd4fdce29f1f3c85d9dbc64a7223a3cdfc894db046a63147d14b31477ffef6bc6eac', 1, '2021-01-28 13:11:35', NULL),
(29, 'shubham.agnihotri356@gmail.com', '559784', NULL, NULL, 'b90aed68fb227799d0aa15d3737c7e376a3c3e57df841302dd99c4d6f46969685fe72909934a61d27b8fd408b686abb7a8b3', 1, '2021-01-28 13:13:14', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_details`
--

CREATE TABLE `payment_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `consultation_id` bigint(20) UNSIGNED NOT NULL,
  `appointment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `amount` double NOT NULL,
  `transaction_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `balance_transaction` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `payment_type` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_brand` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `card_num` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0: Fail, 1: success',
  `response` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payment_details`
--

INSERT INTO `payment_details` (`id`, `consultation_id`, `appointment_id`, `user_id`, `amount`, `transaction_id`, `balance_transaction`, `payment_type`, `card_brand`, `card_num`, `status`, `response`, `created_at`, `updated_at`) VALUES
(1, 29, 0, 1, 29, NULL, NULL, '', '', '', 0, NULL, '2021-01-20 14:13:59', '2021-01-20 14:13:59'),
(2, 29, 0, 1, 29, 'ch_1IBcIoKW5uvc4Ovee3i7KgpC', 'txn_1IBcIoKW5uvc4Ove5mGkiQkC', '', '', '', 1, '{\"id\":\"ch_1IBcIoKW5uvc4Ovee3i7KgpC\",\"object\":\"charge\",\"amount\":30000,\"amount_captured\":30000,\"amount_refunded\":0,\"application\":null,\"application_fee\":null,\"application_fee_amount\":null,\"balance_transaction\":\"txn_1IBcIoKW5uvc4Ove5mGkiQkC\",\"billing_details\":{\"address\":{\"city\":null,\"country\":null,\"line1\":null,\"line2\":null,\"postal_code\":null,\"state\":null},\"email\":null,\"name\":null,\"phone\":null},\"calculated_statement_descriptor\":\"Stripe\",\"captured\":true,\"created\":1611132274,\"currency\":\"usd\",\"customer\":null,\"description\":\"Test payment from itsolutionstuff.com.\",\"destination\":null,\"dispute\":null,\"disputed\":false,\"failure_code\":null,\"failure_message\":null,\"fraud_details\":[],\"invoice\":null,\"livemode\":false,\"metadata\":[],\"on_behalf_of\":null,\"order\":null,\"outcome\":{\"network_status\":\"approved_by_network\",\"reason\":null,\"risk_level\":\"normal\",\"risk_score\":44,\"seller_message\":\"Payment complete.\",\"type\":\"authorized\"},\"paid\":true,\"payment_intent\":null,\"payment_method\":\"card_1IBcIcKW5uvc4OvejhTYFdV1\",\"payment_method_details\":{\"card\":{\"brand\":\"visa\",\"checks\":{\"address_line1_check\":null,\"address_postal_code_check\":null,\"cvc_check\":\"pass\"},\"country\":\"US\",\"exp_month\":12,\"exp_year\":2024,\"fingerprint\":\"F31fzV5XBAlmkZp1\",\"funding\":\"credit\",\"installments\":null,\"last4\":\"4242\",\"network\":\"visa\",\"three_d_secure\":null,\"wallet\":null},\"type\":\"card\"},\"receipt_email\":null,\"receipt_number\":null,\"receipt_url\":\"https:\\/\\/pay.stripe.com\\/receipts\\/acct_1EhYGSKW5uvc4Ove\\/ch_1IBcIoKW5uvc4Ovee3i7KgpC\\/rcpt_InCiy3katGyNpr1qehH7Nk5DCKFDpSU\",\"refunded\":false,\"refunds\":{\"object\":\"list\",\"data\":[],\"has_more\":false,\"total_count\":0,\"url\":\"\\/v1\\/charges\\/ch_1IBcIoKW5uvc4Ovee3i7KgpC\\/refunds\"},\"review\":null,\"shipping\":null,\"source\":{\"id\":\"card_1IBcIcKW5uvc4OvejhTYFdV1\",\"object\":\"card\",\"address_city\":null,\"address_country\":null,\"address_line1\":null,\"address_line1_check\":null,\"address_line2\":null,\"address_state\":null,\"address_zip\":null,\"address_zip_check\":null,\"brand\":\"Visa\",\"country\":\"US\",\"customer\":null,\"cvc_check\":\"pass\",\"dynamic_last4\":null,\"exp_month\":12,\"exp_year\":2024,\"fingerprint\":\"F31fzV5XBAlmkZp1\",\"funding\":\"credit\",\"last4\":\"4242\",\"metadata\":[],\"name\":null,\"tokenization_method\":null},\"source_transfer\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2021-01-20 14:14:35', '2021-01-20 14:14:35'),
(3, 29, 29, 1, 29, NULL, NULL, '', '', '', 0, NULL, '2021-01-20 14:14:59', '2021-01-20 14:14:59'),
(4, 29, 29, 1, 29, NULL, NULL, '', '', '', 0, NULL, '2021-01-20 15:01:41', '2021-01-20 15:01:41'),
(5, 29, 0, 1, 29, 'ch_1IBd2tKW5uvc4OveSe1QPwKr', 'txn_1IBd2uKW5uvc4OveWbURgFVi', '', '', '', 1, '{\"id\":\"ch_1IBd2tKW5uvc4OveSe1QPwKr\",\"object\":\"charge\",\"amount\":30000,\"amount_captured\":30000,\"amount_refunded\":0,\"application\":null,\"application_fee\":null,\"application_fee_amount\":null,\"balance_transaction\":\"txn_1IBd2uKW5uvc4OveWbURgFVi\",\"billing_details\":{\"address\":{\"city\":null,\"country\":null,\"line1\":null,\"line2\":null,\"postal_code\":null,\"state\":null},\"email\":null,\"name\":null,\"phone\":null},\"calculated_statement_descriptor\":\"Stripe\",\"captured\":true,\"created\":1611135131,\"currency\":\"usd\",\"customer\":null,\"description\":\"Test payment from itsolutionstuff.com.\",\"destination\":null,\"dispute\":null,\"disputed\":false,\"failure_code\":null,\"failure_message\":null,\"fraud_details\":[],\"invoice\":null,\"livemode\":false,\"metadata\":[],\"on_behalf_of\":null,\"order\":null,\"outcome\":{\"network_status\":\"approved_by_network\",\"reason\":null,\"risk_level\":\"normal\",\"risk_score\":49,\"seller_message\":\"Payment complete.\",\"type\":\"authorized\"},\"paid\":true,\"payment_intent\":null,\"payment_method\":\"card_1IBd2gKW5uvc4OvenygIO3qM\",\"payment_method_details\":{\"card\":{\"brand\":\"visa\",\"checks\":{\"address_line1_check\":null,\"address_postal_code_check\":null,\"cvc_check\":\"pass\"},\"country\":\"US\",\"exp_month\":12,\"exp_year\":2024,\"fingerprint\":\"F31fzV5XBAlmkZp1\",\"funding\":\"credit\",\"installments\":null,\"last4\":\"4242\",\"network\":\"visa\",\"three_d_secure\":null,\"wallet\":null},\"type\":\"card\"},\"receipt_email\":null,\"receipt_number\":null,\"receipt_url\":\"https:\\/\\/pay.stripe.com\\/receipts\\/acct_1EhYGSKW5uvc4Ove\\/ch_1IBd2tKW5uvc4OveSe1QPwKr\\/rcpt_InDTZXZeLS1K5sDj3ivkAEgw5AofF1n\",\"refunded\":false,\"refunds\":{\"object\":\"list\",\"data\":[],\"has_more\":false,\"total_count\":0,\"url\":\"\\/v1\\/charges\\/ch_1IBd2tKW5uvc4OveSe1QPwKr\\/refunds\"},\"review\":null,\"shipping\":null,\"source\":{\"id\":\"card_1IBd2gKW5uvc4OvenygIO3qM\",\"object\":\"card\",\"address_city\":null,\"address_country\":null,\"address_line1\":null,\"address_line1_check\":null,\"address_line2\":null,\"address_state\":null,\"address_zip\":null,\"address_zip_check\":null,\"brand\":\"Visa\",\"country\":\"US\",\"customer\":null,\"cvc_check\":\"pass\",\"dynamic_last4\":null,\"exp_month\":12,\"exp_year\":2024,\"fingerprint\":\"F31fzV5XBAlmkZp1\",\"funding\":\"credit\",\"last4\":\"4242\",\"metadata\":[],\"name\":null,\"tokenization_method\":null},\"source_transfer\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2021-01-20 15:02:12', '2021-01-20 15:02:12'),
(6, 29, 0, 1, 29, 'ch_1IBd44KW5uvc4Ovepa7qAAIR', 'txn_1IBd44KW5uvc4OveOj9CiunV', '', '', '', 1, '{\"id\":\"ch_1IBd44KW5uvc4Ovepa7qAAIR\",\"object\":\"charge\",\"amount\":30000,\"amount_captured\":30000,\"amount_refunded\":0,\"application\":null,\"application_fee\":null,\"application_fee_amount\":null,\"balance_transaction\":\"txn_1IBd44KW5uvc4OveOj9CiunV\",\"billing_details\":{\"address\":{\"city\":null,\"country\":null,\"line1\":null,\"line2\":null,\"postal_code\":null,\"state\":null},\"email\":null,\"name\":null,\"phone\":null},\"calculated_statement_descriptor\":\"Stripe\",\"captured\":true,\"created\":1611135204,\"currency\":\"usd\",\"customer\":null,\"description\":\"Test payment from itsolutionstuff.com.\",\"destination\":null,\"dispute\":null,\"disputed\":false,\"failure_code\":null,\"failure_message\":null,\"fraud_details\":[],\"invoice\":null,\"livemode\":false,\"metadata\":[],\"on_behalf_of\":null,\"order\":null,\"outcome\":{\"network_status\":\"approved_by_network\",\"reason\":null,\"risk_level\":\"normal\",\"risk_score\":61,\"seller_message\":\"Payment complete.\",\"type\":\"authorized\"},\"paid\":true,\"payment_intent\":null,\"payment_method\":\"card_1IBd3sKW5uvc4OvetDZyJC0A\",\"payment_method_details\":{\"card\":{\"brand\":\"visa\",\"checks\":{\"address_line1_check\":null,\"address_postal_code_check\":null,\"cvc_check\":\"pass\"},\"country\":\"US\",\"exp_month\":12,\"exp_year\":2024,\"fingerprint\":\"F31fzV5XBAlmkZp1\",\"funding\":\"credit\",\"installments\":null,\"last4\":\"4242\",\"network\":\"visa\",\"three_d_secure\":null,\"wallet\":null},\"type\":\"card\"},\"receipt_email\":null,\"receipt_number\":null,\"receipt_url\":\"https:\\/\\/pay.stripe.com\\/receipts\\/acct_1EhYGSKW5uvc4Ove\\/ch_1IBd44KW5uvc4Ovepa7qAAIR\\/rcpt_InDVRXYJyIuQsaxId8xXqp418Sjprbs\",\"refunded\":false,\"refunds\":{\"object\":\"list\",\"data\":[],\"has_more\":false,\"total_count\":0,\"url\":\"\\/v1\\/charges\\/ch_1IBd44KW5uvc4Ovepa7qAAIR\\/refunds\"},\"review\":null,\"shipping\":null,\"source\":{\"id\":\"card_1IBd3sKW5uvc4OvetDZyJC0A\",\"object\":\"card\",\"address_city\":null,\"address_country\":null,\"address_line1\":null,\"address_line1_check\":null,\"address_line2\":null,\"address_state\":null,\"address_zip\":null,\"address_zip_check\":null,\"brand\":\"Visa\",\"country\":\"US\",\"customer\":null,\"cvc_check\":\"pass\",\"dynamic_last4\":null,\"exp_month\":12,\"exp_year\":2024,\"fingerprint\":\"F31fzV5XBAlmkZp1\",\"funding\":\"credit\",\"last4\":\"4242\",\"metadata\":[],\"name\":null,\"tokenization_method\":null},\"source_transfer\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2021-01-20 15:03:24', '2021-01-20 15:03:24'),
(7, 29, 0, 1, 29, NULL, NULL, NULL, NULL, NULL, 0, NULL, '2021-01-20 15:53:37', '2021-01-20 15:53:37'),
(8, 29, 0, 1, 29, 'ch_1IBdquKW5uvc4Ove4DylyRvp', 'txn_1IBdquKW5uvc4OveuFVJxt3a', 'card', 'visa', '4242', 1, '{\"id\":\"ch_1IBdquKW5uvc4Ove4DylyRvp\",\"object\":\"charge\",\"amount\":30000,\"amount_captured\":30000,\"amount_refunded\":0,\"application\":null,\"application_fee\":null,\"application_fee_amount\":null,\"balance_transaction\":\"txn_1IBdquKW5uvc4OveuFVJxt3a\",\"billing_details\":{\"address\":{\"city\":null,\"country\":null,\"line1\":null,\"line2\":null,\"postal_code\":null,\"state\":null},\"email\":null,\"name\":null,\"phone\":null},\"calculated_statement_descriptor\":\"Stripe\",\"captured\":true,\"created\":1611138232,\"currency\":\"usd\",\"customer\":null,\"description\":\"Test payment from itsolutionstuff.com.\",\"destination\":null,\"dispute\":null,\"disputed\":false,\"failure_code\":null,\"failure_message\":null,\"fraud_details\":[],\"invoice\":null,\"livemode\":false,\"metadata\":[],\"on_behalf_of\":null,\"order\":null,\"outcome\":{\"network_status\":\"approved_by_network\",\"reason\":null,\"risk_level\":\"normal\",\"risk_score\":46,\"seller_message\":\"Payment complete.\",\"type\":\"authorized\"},\"paid\":true,\"payment_intent\":null,\"payment_method\":\"card_1IBdqlKW5uvc4OvetEWEQBqE\",\"payment_method_details\":{\"card\":{\"brand\":\"visa\",\"checks\":{\"address_line1_check\":null,\"address_postal_code_check\":null,\"cvc_check\":\"pass\"},\"country\":\"US\",\"exp_month\":12,\"exp_year\":2024,\"fingerprint\":\"F31fzV5XBAlmkZp1\",\"funding\":\"credit\",\"installments\":null,\"last4\":\"4242\",\"network\":\"visa\",\"three_d_secure\":null,\"wallet\":null},\"type\":\"card\"},\"receipt_email\":null,\"receipt_number\":null,\"receipt_url\":\"https:\\/\\/pay.stripe.com\\/receipts\\/acct_1EhYGSKW5uvc4Ove\\/ch_1IBdquKW5uvc4Ove4DylyRvp\\/rcpt_InEJd36tr2TqhLUBcLAvFIHgjhycH17\",\"refunded\":false,\"refunds\":{\"object\":\"list\",\"data\":[],\"has_more\":false,\"total_count\":0,\"url\":\"\\/v1\\/charges\\/ch_1IBdquKW5uvc4Ove4DylyRvp\\/refunds\"},\"review\":null,\"shipping\":null,\"source\":{\"id\":\"card_1IBdqlKW5uvc4OvetEWEQBqE\",\"object\":\"card\",\"address_city\":null,\"address_country\":null,\"address_line1\":null,\"address_line1_check\":null,\"address_line2\":null,\"address_state\":null,\"address_zip\":null,\"address_zip_check\":null,\"brand\":\"Visa\",\"country\":\"US\",\"customer\":null,\"cvc_check\":\"pass\",\"dynamic_last4\":null,\"exp_month\":12,\"exp_year\":2024,\"fingerprint\":\"F31fzV5XBAlmkZp1\",\"funding\":\"credit\",\"last4\":\"4242\",\"metadata\":[],\"name\":null,\"tokenization_method\":null},\"source_transfer\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2021-01-20 15:53:53', '2021-01-20 15:53:53'),
(9, 29, 1, 1, 29, 'ch_1IBdsTKW5uvc4OverPG8QTdv', 'txn_1IBdsUKW5uvc4OvePAfeSixF', 'card', 'visa', '4242', 1, '{\"id\":\"ch_1IBdsTKW5uvc4OverPG8QTdv\",\"object\":\"charge\",\"amount\":30000,\"amount_captured\":30000,\"amount_refunded\":0,\"application\":null,\"application_fee\":null,\"application_fee_amount\":null,\"balance_transaction\":\"txn_1IBdsUKW5uvc4OvePAfeSixF\",\"billing_details\":{\"address\":{\"city\":null,\"country\":null,\"line1\":null,\"line2\":null,\"postal_code\":null,\"state\":null},\"email\":null,\"name\":null,\"phone\":null},\"calculated_statement_descriptor\":\"Stripe\",\"captured\":true,\"created\":1611138329,\"currency\":\"usd\",\"customer\":null,\"description\":\"Test payment from itsolutionstuff.com.\",\"destination\":null,\"dispute\":null,\"disputed\":false,\"failure_code\":null,\"failure_message\":null,\"fraud_details\":[],\"invoice\":null,\"livemode\":false,\"metadata\":[],\"on_behalf_of\":null,\"order\":null,\"outcome\":{\"network_status\":\"approved_by_network\",\"reason\":null,\"risk_level\":\"normal\",\"risk_score\":12,\"seller_message\":\"Payment complete.\",\"type\":\"authorized\"},\"paid\":true,\"payment_intent\":null,\"payment_method\":\"card_1IBdsEKW5uvc4OveR5IVr2m6\",\"payment_method_details\":{\"card\":{\"brand\":\"visa\",\"checks\":{\"address_line1_check\":null,\"address_postal_code_check\":null,\"cvc_check\":\"pass\"},\"country\":\"US\",\"exp_month\":12,\"exp_year\":2024,\"fingerprint\":\"F31fzV5XBAlmkZp1\",\"funding\":\"credit\",\"installments\":null,\"last4\":\"4242\",\"network\":\"visa\",\"three_d_secure\":null,\"wallet\":null},\"type\":\"card\"},\"receipt_email\":null,\"receipt_number\":null,\"receipt_url\":\"https:\\/\\/pay.stripe.com\\/receipts\\/acct_1EhYGSKW5uvc4Ove\\/ch_1IBdsTKW5uvc4OverPG8QTdv\\/rcpt_InELAa4kCak1HHf25TTpuYN0ZhfJdLA\",\"refunded\":false,\"refunds\":{\"object\":\"list\",\"data\":[],\"has_more\":false,\"total_count\":0,\"url\":\"\\/v1\\/charges\\/ch_1IBdsTKW5uvc4OverPG8QTdv\\/refunds\"},\"review\":null,\"shipping\":null,\"source\":{\"id\":\"card_1IBdsEKW5uvc4OveR5IVr2m6\",\"object\":\"card\",\"address_city\":null,\"address_country\":null,\"address_line1\":null,\"address_line1_check\":null,\"address_line2\":null,\"address_state\":null,\"address_zip\":null,\"address_zip_check\":null,\"brand\":\"Visa\",\"country\":\"US\",\"customer\":null,\"cvc_check\":\"pass\",\"dynamic_last4\":null,\"exp_month\":12,\"exp_year\":2024,\"fingerprint\":\"F31fzV5XBAlmkZp1\",\"funding\":\"credit\",\"last4\":\"4242\",\"metadata\":[],\"name\":null,\"tokenization_method\":null},\"source_transfer\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2021-01-20 15:55:30', '2021-01-20 15:55:30'),
(10, 29, 1, 1, 300, NULL, NULL, NULL, NULL, NULL, 0, NULL, '2021-01-20 15:58:54', '2021-01-20 15:58:54'),
(11, 29, 1, 1, 300, 'ch_1IBdy8KW5uvc4OveTCs0oScT', 'txn_1IBdy8KW5uvc4OveAbDsbOW1', 'card', 'visa', '4242', 1, '{\"id\":\"ch_1IBdy8KW5uvc4OveTCs0oScT\",\"object\":\"charge\",\"amount\":30000,\"amount_captured\":30000,\"amount_refunded\":0,\"application\":null,\"application_fee\":null,\"application_fee_amount\":null,\"balance_transaction\":\"txn_1IBdy8KW5uvc4OveAbDsbOW1\",\"billing_details\":{\"address\":{\"city\":null,\"country\":null,\"line1\":null,\"line2\":null,\"postal_code\":null,\"state\":null},\"email\":null,\"name\":null,\"phone\":null},\"calculated_statement_descriptor\":\"Stripe\",\"captured\":true,\"created\":1611138680,\"currency\":\"usd\",\"customer\":null,\"description\":\"Test payment from itsolutionstuff.com.\",\"destination\":null,\"dispute\":null,\"disputed\":false,\"failure_code\":null,\"failure_message\":null,\"fraud_details\":[],\"invoice\":null,\"livemode\":false,\"metadata\":[],\"on_behalf_of\":null,\"order\":null,\"outcome\":{\"network_status\":\"approved_by_network\",\"reason\":null,\"risk_level\":\"normal\",\"risk_score\":18,\"seller_message\":\"Payment complete.\",\"type\":\"authorized\"},\"paid\":true,\"payment_intent\":null,\"payment_method\":\"card_1IBdxzKW5uvc4OveLoXSm8BL\",\"payment_method_details\":{\"card\":{\"brand\":\"visa\",\"checks\":{\"address_line1_check\":null,\"address_postal_code_check\":null,\"cvc_check\":\"pass\"},\"country\":\"US\",\"exp_month\":12,\"exp_year\":2024,\"fingerprint\":\"F31fzV5XBAlmkZp1\",\"funding\":\"credit\",\"installments\":null,\"last4\":\"4242\",\"network\":\"visa\",\"three_d_secure\":null,\"wallet\":null},\"type\":\"card\"},\"receipt_email\":null,\"receipt_number\":null,\"receipt_url\":\"https:\\/\\/pay.stripe.com\\/receipts\\/acct_1EhYGSKW5uvc4Ove\\/ch_1IBdy8KW5uvc4OveTCs0oScT\\/rcpt_InER1CPUkm8UJLVC1CsBS7cYWF3QMPh\",\"refunded\":false,\"refunds\":{\"object\":\"list\",\"data\":[],\"has_more\":false,\"total_count\":0,\"url\":\"\\/v1\\/charges\\/ch_1IBdy8KW5uvc4OveTCs0oScT\\/refunds\"},\"review\":null,\"shipping\":null,\"source\":{\"id\":\"card_1IBdxzKW5uvc4OveLoXSm8BL\",\"object\":\"card\",\"address_city\":null,\"address_country\":null,\"address_line1\":null,\"address_line1_check\":null,\"address_line2\":null,\"address_state\":null,\"address_zip\":null,\"address_zip_check\":null,\"brand\":\"Visa\",\"country\":\"US\",\"customer\":null,\"cvc_check\":\"pass\",\"dynamic_last4\":null,\"exp_month\":12,\"exp_year\":2024,\"fingerprint\":\"F31fzV5XBAlmkZp1\",\"funding\":\"credit\",\"last4\":\"4242\",\"metadata\":[],\"name\":null,\"tokenization_method\":null},\"source_transfer\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2021-01-20 16:01:20', '2021-01-20 16:01:20');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_url` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_associated_concern_mapping`
--

CREATE TABLE `product_associated_concern_mapping` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_concern_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_associated_condition_mapping`
--

CREATE TABLE `product_associated_condition_mapping` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_condition_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_associated_types`
--

CREATE TABLE `product_associated_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `associated_type` tinyint(4) NOT NULL COMMENT '1->concern type (Scalp conscern),2->condition type',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_associated_types`
--

INSERT INTO `product_associated_types` (`id`, `type_title`, `associated_type`, `created_at`, `updated_at`) VALUES
(1, 'Scalp concern', 1, NULL, NULL),
(2, 'Hair thining concern', 1, NULL, NULL),
(3, 'Hair loss concern', 1, NULL, NULL),
(4, 'Hair fibre concern ', 1, NULL, NULL),
(5, 'Extreme', 2, NULL, NULL),
(6, 'Moderate Extreme', 2, NULL, NULL),
(7, 'Low Extreme', 2, NULL, NULL),
(8, 'Nominal', 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_image_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promotion_videos`
--

CREATE TABLE `promotion_videos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `video_title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_url` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_level` tinyint(4) NOT NULL,
  `play_after_ques_id` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `promotion_videos`
--

INSERT INTO `promotion_videos` (`id`, `video_title`, `video_url`, `video_level`, `play_after_ques_id`, `created_at`, `updated_at`) VALUES
(1, 'v1', 'v1.mp4', 1, 0, NULL, NULL),
(2, 'v2', 'v2.mp4', 2, 32, NULL, NULL),
(3, 'v3', 'v3.mp4', 3, 0, NULL, NULL),
(4, 'v4', 'v4.mp4', 0, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ques`
--

CREATE TABLE `ques` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ques_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ques_option_type` enum('1','2','3','4','5','6','7','8','9') COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '1 ->Multiple choice (radio)2 ->Checkbox 3 ->input 4 ->label (static page) 5-> car (dropdown)6-> date 7-> time 8->image radio;9->Product Page',
  `ques_ordering_id` int(11) DEFAULT NULL COMMENT 'question_ordering_id for sorting',
  `ques_parent_option_id` int(11) DEFAULT 0 COMMENT '0->nothing ,if option have sub question',
  `is_sub_question` tinyint(4) DEFAULT 0 COMMENT '0=>not sub question,1=>subquestion',
  `is_first_question` int(11) DEFAULT NULL,
  `is_last_question` tinyint(4) DEFAULT 0 COMMENT '0->not last, 1->last',
  `ques_level` int(11) DEFAULT NULL,
  `ques_status` tinyint(4) DEFAULT 1 COMMENT '0->incative ,1->active',
  `is_use_existing_car` tinyint(4) NOT NULL DEFAULT 0,
  `condition_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1: Gender; 2: Age Group',
  `gender_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1: Female, 2: Male; 3: Transgender; 4: Others',
  `from_age_condition` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `to_age_condition` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `request_json` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pre_question_id` bigint(20) DEFAULT NULL,
  `next_question_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ques`
--

INSERT INTO `ques` (`id`, `ques_title`, `ques_option_type`, `ques_ordering_id`, `ques_parent_option_id`, `is_sub_question`, `is_first_question`, `is_last_question`, `ques_level`, `ques_status`, `is_use_existing_car`, `condition_type`, `gender_id`, `from_age_condition`, `to_age_condition`, `request_json`, `pre_question_id`, `next_question_id`, `created_at`, `updated_at`) VALUES
(1, 'Do you spend more than 25 hours a week in working in any of these occupations?', '1', 1, 0, 0, 1, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 2, NULL, NULL),
(2, 'How long has your concern existed?', '1', 2, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, 1, 3, NULL, NULL),
(3, 'How would you describe the amount of hair shedding your experience?', '1', 3, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, 2, 4, NULL, NULL),
(4, 'How much time do you spend on scalp care?', '1', 4, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, 3, 5, NULL, NULL),
(5, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', '1', 5, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, 4, 6, NULL, NULL),
(6, 'What information are you hoping to leave with today?', '1', 6, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, 5, 44, NULL, NULL),
(8, 'Select to continue for personalization consultation', '1', 1, 25, 0, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, 6, 44, NULL, NULL),
(9, 'Please select CAR.', '5', 9, 27, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(10, 'Please select CAR.', '5', 10, 29, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(11, 'Please select CAR.', '5', 11, 30, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(12, 'Select your concern', '1', 12, 28, 0, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, 8, NULL, NULL, NULL),
(14, 'How would you describe the condition of your scalp? Please check all that apply.', '2', 1, 32, 0, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 15, NULL, NULL),
(15, 'What is the location on scalp?', '1', 2, 0, 0, NULL, 0, NULL, 1, 0, '1', '1', '0', '0', NULL, 14, 16, NULL, NULL),
(16, 'What is the location on scalp?', '1', 2, 0, 0, NULL, 0, NULL, 1, 0, '1', '2,3,4', '0', '0', NULL, 15, 17, NULL, NULL),
(17, 'Have you had a biopsy or culture performed by a dermatologist or medical professional with a positive diagnosis?', '1', 3, 0, 0, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, 16, 44, NULL, NULL),
(18, 'Please check all that apply.', '2', 1, 56, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(19, 'Select your condition', '1', 1, 33, 0, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 22, NULL, NULL),
(20, '', '1', 1, 68, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(21, '', '1', 1, 71, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(22, 'What is the location on scalp?', '1', 2, 0, 0, NULL, 0, NULL, 1, 0, '1', '1', '0', '0', NULL, NULL, 23, NULL, NULL),
(23, 'What is the location on scalp?', '1', 2, 0, 0, NULL, 0, NULL, 1, 0, '1', '2,3,4', '0', '0', NULL, NULL, 44, NULL, NULL),
(25, 'Select case type.', '1', 25, 34, 0, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 39, NULL, NULL),
(26, 'Select Extreme case type', '1', 26, 80, 0, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 39, NULL, NULL),
(29, 'Select Nominal case type', '1', 1, 83, 0, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 39, NULL, NULL),
(30, 'Select Mild case type', '1', 1, 88, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(31, '', '1', 1, 89, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(32, 'Pleases select which best describes your hair porosity', '1', 1, 94, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(33, '', '1', 1, 90, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(34, '', '1', 1, 91, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(35, 'Are you still breast feeding?', '1', 35, 119, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(36, 'Length of time you have been breast feeding?', '3', 36, 104, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(37, 'Products', '9', 1, 24, 0, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, 6, NULL, '2021-01-08 18:30:00', NULL),
(38, NULL, '1', 1, 92, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(39, 'What is the location on scalp?', '1', 2, 0, 0, NULL, 0, NULL, 1, 0, '1', '1', '0', '0', NULL, NULL, 40, NULL, NULL),
(40, 'What is the location on scalp?', '1', 2, 0, 0, NULL, 0, NULL, 1, 0, '1', '2,3,4', '0', '0', NULL, NULL, 44, NULL, NULL),
(41, 'please select a CAR', '5', 1, 29, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(42, 'please select a CAR', '5', 1, 30, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(43, 'please select a CAR', '5', NULL, 27, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(44, 'How much time do you spend on hair care treatments?', '1', 6, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 45, NULL, NULL),
(45, 'Have you made previous attempts to fix your hair or scalp problem by any of the following?', '1', 7, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 47, NULL, NULL),
(46, NULL, '1', 1, 136, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(47, 'Are you  or have you ever been anemic?', '1', 8, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 49, NULL, NULL),
(48, 'Please check all any of the below that have been used within the last year?', '1', 1, 143, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(49, 'Do you currently have or had Allergies?', '1', 8, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 51, NULL, NULL),
(50, 'Choose all that apply', '2', 9, 149, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(51, 'Do you currently have or had any auto-immune diseases?', '1', 9, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 52, NULL, NULL),
(52, 'Are you or have you ever been treated for any type of cancer?', '1', 10, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 53, NULL, NULL),
(53, 'Are you or have you ever been diabetic?', '1', 11, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 54, NULL, NULL),
(54, 'Are you currently being treated or have you ever been treated for gynecological conditions?', '1', 12, 0, 0, NULL, 0, NULL, 1, 0, '1,2', '1', '18', '0', NULL, NULL, 56, NULL, NULL),
(55, 'Choose all that apply', '2', 1, 162, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(56, 'Are you or have you ever been diabetic?', '1', 12, 0, 0, NULL, 0, NULL, 1, 0, '1,2', '1', '18', '0', NULL, NULL, 58, NULL, NULL),
(57, 'List any medications if any that you take?', '3', 1, 168, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(58, 'Do you take Medications for Post Partum?', '1', 13, 0, 0, NULL, 0, NULL, 1, 0, '1,2', '1', '18', '0', NULL, NULL, 59, NULL, NULL),
(59, 'Do you take Medications for Post Surgery?', '1', 14, 0, 0, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 60, NULL, NULL),
(60, 'Do you take Medications for Thyroid?', '1', 15, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 61, NULL, NULL),
(61, 'Drastic Weight loss', '1', 16, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 64, NULL, NULL),
(62, NULL, '1', 1, 176, 1, NULL, 0, 2, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(63, 'Select month, day and Year', '6', 1, 179, 1, NULL, 0, 2, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(64, 'Dietary Deficiencies', '1', 17, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 67, NULL, NULL),
(65, NULL, '1', 1, 180, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(66, 'list', '3', 1, 182, 1, NULL, 0, NULL, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(67, 'High Blood Pressure', '1', 18, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 68, NULL, NULL),
(68, 'Chronic Health Problems', '1', NULL, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 69, NULL, NULL),
(69, 'Have you been prescribed any  of the prescription topicals to address hair loss or scalp issues? Please check all that apply?', '2', 19, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 70, NULL, NULL),
(70, 'Have you been prescribed any of the listed prescription medication  to address hair loss, thinning, or balding orally?', '1', 20, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 71, NULL, NULL),
(71, 'Have you used any listed supplement to address hair loss, thinning or balding? Please check all that apply.', '2', 21, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 72, NULL, NULL),
(72, 'How frequently do you consume fatty foods?', '1', 22, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 73, NULL, NULL),
(73, 'How much sugar do you consume including  your beverages?', '1', 23, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 74, NULL, NULL),
(74, 'Do you consume meat?', '1', 24, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 76, NULL, NULL),
(75, 'If Not a meat eater, length of time on meatless diet', '1', 1, 215, 1, NULL, 0, 2, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL),
(76, 'If Vegetarian do you consume any of the following daily for as protein sources?', '1', 1, 0, 0, NULL, 0, 2, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 78, NULL, NULL),
(77, 'How much dark green do you consume in your diet?', '1', 1, 214, 0, NULL, 0, 2, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 79, NULL, NULL),
(78, 'How much dark green do you consume in your diet?', '1', 1, 0, 0, NULL, 0, 2, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 79, NULL, NULL),
(79, 'How much yeast do you consume in your diet?', '1', 25, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, 80, NULL, NULL),
(80, 'How Frequently do you exercise?', '1', 26, 0, 0, NULL, 1, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ques_answers_consultations`
--

CREATE TABLE `ques_answers_consultations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ques_id` bigint(20) NOT NULL,
  `option_id` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ques_answers_comments` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `question_for_admin` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answer_for_admin` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_associated_type_id` int(11) DEFAULT 0,
  `consultant_id` bigint(20) NOT NULL,
  `ques_anser_status` tinyint(4) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ques_answers_consultations`
--

INSERT INTO `ques_answers_consultations` (`id`, `ques_id`, `option_id`, `ques_answers_comments`, `question_for_admin`, `answer_for_admin`, `product_associated_type_id`, `consultant_id`, `ques_anser_status`, `created_at`, `updated_at`) VALUES
(1, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 4, 1, '2021-01-05 18:36:02', '2021-01-05 18:36:02'),
(2, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 5, 1, '2021-01-05 18:37:01', '2021-01-05 18:37:01'),
(3, 1, '8', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Public Figure', 5, 6, 1, '2021-01-05 18:43:57', '2021-01-05 18:43:57'),
(4, 2, '9', NULL, 'How long has your concern existed?', 'Recently', 0, 6, 1, '2021-01-05 18:45:32', '2021-01-05 18:45:32'),
(5, 3, '17', NULL, 'How would you describe the amount of hair shedding your experience?', 'Excessive', 0, 6, 1, '2021-01-05 18:46:08', '2021-01-05 18:46:08'),
(6, 4, '19', NULL, 'How much time do you spend on scalp care?', '1-3 Times a Month', 0, 6, 1, '2021-01-05 18:46:43', '2021-01-05 18:46:43'),
(7, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 6, 1, '2021-01-05 18:47:18', '2021-01-05 18:47:18'),
(18, 6, '25', NULL, 'What information are you hoping to leave with today?', 'Purchase Personalized Consultation', 0, 6, 1, '2021-01-06 18:02:47', '2021-01-06 18:02:47'),
(19, 8, '28', NULL, 'Select to continue for personalization consultation', 'Create a New Consultation Analysis Report (CAR)', 0, 6, 1, '2021-01-06 18:02:50', '2021-01-06 18:02:50'),
(20, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 7, 1, '2021-01-17 15:13:33', '2021-01-17 15:13:33'),
(21, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 100, 1, '2021-01-18 16:50:48', '2021-01-18 16:50:48'),
(22, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 100, 1, '2021-01-18 16:50:48', '2021-01-18 16:50:48'),
(23, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 1, 1, '2021-01-18 16:50:48', '2021-01-18 16:50:48'),
(24, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 11, 1, '2021-01-18 17:03:46', '2021-01-18 17:03:46'),
(25, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 12, 1, '2021-01-18 17:04:24', '2021-01-18 17:04:24'),
(26, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 13, 1, '2021-01-18 17:05:01', '2021-01-18 17:05:01'),
(27, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 14, 1, '2021-01-18 17:07:28', '2021-01-18 17:07:28'),
(28, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 15, 1, '2021-01-18 17:09:49', '2021-01-18 17:09:49'),
(29, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 16, 1, '2021-01-18 17:59:50', '2021-01-18 17:59:50'),
(30, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 17, 1, '2021-01-18 18:12:56', '2021-01-18 18:12:56'),
(31, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 18, 1, '2021-01-18 18:15:51', '2021-01-18 18:15:51'),
(32, 2, '9', NULL, 'How long has your concern existed?', 'Recently', 0, 19, 1, '2021-01-18 18:16:10', '2021-01-18 18:16:10'),
(33, 3, '14', NULL, 'How would you describe the amount of hair shedding your experience?', 'Nominal', 0, 20, 1, '2021-01-18 18:16:26', '2021-01-18 18:16:26'),
(34, 4, '18', NULL, 'How much time do you spend on scalp care?', 'None at All', 0, 21, 1, '2021-01-18 18:16:41', '2021-01-18 18:16:41'),
(35, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 22, 1, '2021-01-18 18:16:51', '2021-01-18 18:16:51'),
(36, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 23, 1, '2021-01-18 18:20:00', '2021-01-18 18:20:00'),
(37, 6, '24', NULL, 'What information are you hoping to leave with today?', 'Purchase Products', 0, 24, 1, '2021-01-18 18:20:22', '2021-01-18 18:20:22'),
(38, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 25, 1, '2021-01-18 18:20:39', '2021-01-18 18:20:39'),
(39, 6, '25', NULL, 'What information are you hoping to leave with today?', 'Purchase Personalized Consultation', 0, 26, 1, '2021-01-18 18:21:53', '2021-01-18 18:21:53'),
(40, 8, '25', NULL, 'Select to continue for personalization consultation', 'Purchase Personalized Consultation', 0, 27, 1, '2021-01-18 18:31:55', '2021-01-18 18:31:55'),
(41, 8, '25', NULL, 'Select to continue for personalization consultation', 'Purchase Personalized Consultation', 0, 26, 1, '2021-01-18 18:34:14', '2021-01-18 18:34:14'),
(42, 8, '28', NULL, 'Select to continue for personalization consultation', 'Create a New Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 18:34:43', '2021-01-18 18:34:43'),
(43, 8, '29', NULL, 'Select to continue for personalization consultation', 'Use an Existing Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 18:35:04', '2021-01-18 18:35:04'),
(44, 8, '28', NULL, 'Select to continue for personalization consultation', 'Create a New Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:06:16', '2021-01-18 19:06:16'),
(45, 8, '28', NULL, 'Select to continue for personalization consultation', 'Create a New Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:12:16', '2021-01-18 19:12:16'),
(46, 8, '28', NULL, 'Select to continue for personalization consultation', 'Create a New Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:15:02', '2021-01-18 19:15:02'),
(47, 8, '29', NULL, 'Select to continue for personalization consultation', 'Use an Existing Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:15:10', '2021-01-18 19:15:10'),
(48, 8, '29', NULL, 'Select to continue for personalization consultation', 'Use an Existing Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:15:31', '2021-01-18 19:15:31'),
(49, 8, '29', NULL, 'Select to continue for personalization consultation', 'Use an Existing Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:15:43', '2021-01-18 19:15:43'),
(50, 8, '29', NULL, 'Select to continue for personalization consultation', 'Use an Existing Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:21:18', '2021-01-18 19:21:18'),
(51, 8, '28', NULL, 'Select to continue for personalization consultation', 'Create a New Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:21:26', '2021-01-18 19:21:26'),
(52, 8, '28', NULL, 'Select to continue for personalization consultation', 'Create a New Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:24:37', '2021-01-18 19:24:37'),
(53, 8, '28', NULL, 'Select to continue for personalization consultation', 'Create a New Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:24:59', '2021-01-18 19:24:59'),
(54, 8, '29', NULL, 'Select to continue for personalization consultation', 'Use an Existing Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:25:07', '2021-01-18 19:25:07'),
(55, 8, '28', NULL, 'Select to continue for personalization consultation', 'Create a New Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:26:31', '2021-01-18 19:26:31'),
(56, 12, '31', NULL, 'Select your concern', 'Prevention', 0, 26, 1, '2021-01-18 19:26:58', '2021-01-18 19:26:58'),
(57, 12, '31', NULL, 'Select your concern', 'Prevention', 0, 26, 1, '2021-01-18 19:28:12', '2021-01-18 19:28:12'),
(58, 12, '31', NULL, 'Select your concern', 'Prevention', 0, 26, 1, '2021-01-18 19:29:01', '2021-01-18 19:29:01'),
(59, 12, '31', NULL, 'Select your concern', 'Prevention', 0, 26, 1, '2021-01-18 19:29:31', '2021-01-18 19:29:31'),
(60, 8, '28', NULL, 'Select to continue for personalization consultation', 'Create a New Consultation Analysis Report (CAR)', 0, 26, 1, '2021-01-18 19:30:13', '2021-01-18 19:30:13'),
(61, 12, '32', NULL, 'Select your concern', 'Scalp Concern', 0, 26, 1, '2021-01-18 19:30:38', '2021-01-18 19:30:38'),
(62, 14, '35,36', NULL, 'How would you describe the condition of your scalp? Please check all that apply.', 'Tight and Flaky (Capitis),Congested with Build up (Steoides)', 0, 26, 1, '2021-01-18 19:31:56', '2021-01-18 19:31:56'),
(63, 15, '44', NULL, 'What is the location on scalp?', 'Normal', 0, 26, 1, '2021-01-18 19:32:32', '2021-01-18 19:32:32'),
(64, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 28, 1, '2021-01-19 08:04:40', '2021-01-19 08:04:40'),
(65, 2, '9', NULL, 'How long has your concern existed?', 'Recently', 0, 28, 1, '2021-01-19 08:05:03', '2021-01-19 08:05:03'),
(66, 3, '14', NULL, 'How would you describe the amount of hair shedding your experience?', 'Nominal', 0, 28, 1, '2021-01-19 08:05:23', '2021-01-19 08:05:23'),
(67, 4, '18', NULL, 'How much time do you spend on scalp care?', 'None at All', 0, 28, 1, '2021-01-19 08:05:37', '2021-01-19 08:05:37'),
(68, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 28, 1, '2021-01-19 08:05:50', '2021-01-19 08:05:50'),
(69, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 28, 1, '2021-01-19 08:07:22', '2021-01-19 08:07:22'),
(70, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 28, 1, '2021-01-19 08:07:40', '2021-01-19 08:07:40'),
(71, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 28, 1, '2021-01-19 08:07:54', '2021-01-19 08:07:54'),
(72, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 28, 1, '2021-01-19 08:08:14', '2021-01-19 08:08:14'),
(73, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 28, 1, '2021-01-19 08:09:13', '2021-01-19 08:09:13'),
(74, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 28, 1, '2021-01-19 08:10:13', '2021-01-19 08:10:13'),
(75, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 28, 1, '2021-01-19 08:11:23', '2021-01-19 08:11:23'),
(76, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 28, 1, '2021-01-19 08:11:47', '2021-01-19 08:11:47'),
(77, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 28, 1, '2021-01-19 08:11:55', '2021-01-19 08:11:55'),
(78, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 28, 1, '2021-01-19 08:12:57', '2021-01-19 08:12:57'),
(79, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 28, 1, '2021-01-19 08:13:18', '2021-01-19 08:13:18'),
(80, 1, '1', NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 29, 1, '2021-01-19 15:01:36', '2021-01-19 15:01:36'),
(81, 2, '9', NULL, 'How long has your concern existed?', 'Recently', 0, 29, 1, '2021-01-19 15:02:00', '2021-01-19 15:02:00'),
(82, 3, '14', NULL, 'How would you describe the amount of hair shedding your experience?', 'Nominal', 0, 29, 1, '2021-01-19 15:02:08', '2021-01-19 15:02:08'),
(83, 4, '18', NULL, 'How much time do you spend on scalp care?', 'None at All', 0, 29, 1, '2021-01-19 15:02:18', '2021-01-19 15:02:18'),
(84, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 29, 1, '2021-01-19 15:02:26', '2021-01-19 15:02:26'),
(85, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 29, 1, '2021-01-19 15:03:08', '2021-01-19 15:03:08'),
(86, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 29, 1, '2021-01-19 15:04:28', '2021-01-19 15:04:28'),
(87, 6, '24', NULL, 'What information are you hoping to leave with today?', 'Purchase Products', 0, 29, 1, '2021-01-19 15:04:41', '2021-01-19 15:04:41'),
(88, 37, '', NULL, 'Products', '0', 0, 29, 1, '2021-01-19 15:07:22', '2021-01-19 15:07:22'),
(89, 37, '', NULL, 'Products', '0', 0, 29, 1, '2021-01-19 15:09:46', '2021-01-19 15:09:46'),
(90, 5, '21', NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 29, 1, '2021-01-19 15:10:13', '2021-01-19 15:10:13'),
(91, 6, '24', NULL, 'What information are you hoping to leave with today?', 'Purchase Products', 0, 29, 1, '2021-01-19 15:10:31', '2021-01-19 15:10:31'),
(92, 6, '24', NULL, 'What information are you hoping to leave with today?', 'Purchase Products', 0, 29, 1, '2021-01-19 15:10:53', '2021-01-19 15:10:53'),
(93, 6, '24', NULL, 'What information are you hoping to leave with today?', 'Purchase Products', 0, 29, 1, '2021-01-19 15:11:07', '2021-01-19 15:11:07'),
(94, 6, '24', NULL, 'What information are you hoping to leave with today?', 'Purchase Products', 0, 29, 1, '2021-01-19 15:11:18', '2021-01-19 15:11:18'),
(95, 6, '24', NULL, 'What information are you hoping to leave with today?', 'Purchase Products', 0, 29, 1, '2021-01-19 15:11:27', '2021-01-19 15:11:27'),
(96, 6, '24', NULL, 'What information are you hoping to leave with today?', 'Purchase Products', 0, 29, 1, '2021-01-19 15:12:50', '2021-01-19 15:12:50'),
(97, 6, '24', NULL, 'What information are you hoping to leave with today?', 'Purchase Products', 0, 29, 1, '2021-01-19 15:13:04', '2021-01-19 15:13:04'),
(98, 6, '24', NULL, 'What information are you hoping to leave with today?', 'Purchase Products', 0, 29, 1, '2021-01-19 15:14:49', '2021-01-19 15:14:49'),
(99, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 29, 1, '2021-01-19 15:28:06', '2021-01-19 15:28:06'),
(100, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 29, 1, '2021-01-19 15:32:14', '2021-01-19 15:32:14'),
(101, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 29, 1, '2021-01-19 15:32:25', '2021-01-19 15:32:25'),
(102, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 29, 1, '2021-01-19 15:33:04', '2021-01-19 15:33:04'),
(103, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 29, 1, '2021-01-19 15:33:40', '2021-01-19 15:33:40'),
(104, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 29, 1, '2021-01-19 15:33:53', '2021-01-19 15:33:53'),
(105, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 29, 1, '2021-01-19 15:34:04', '2021-01-19 15:34:04'),
(106, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 29, 1, '2021-01-19 15:34:36', '2021-01-19 15:34:36'),
(107, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 29, 1, '2021-01-19 15:34:39', '2021-01-19 15:34:39'),
(108, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 29, 1, '2021-01-19 15:34:49', '2021-01-19 15:34:49'),
(109, 6, '23', NULL, 'What information are you hoping to leave with today?', 'Information (Marketing)', 0, 29, 1, '2021-01-19 15:35:40', '2021-01-19 15:35:40'),
(110, 6, '24', NULL, 'What information are you hoping to leave with today?', 'Purchase Products', 0, 29, 1, '2021-01-19 15:35:56', '2021-01-19 15:35:56'),
(111, 6, '25', NULL, 'What information are you hoping to leave with today?', 'Purchase Personalized Consultation', 0, 29, 1, '2021-01-19 15:36:16', '2021-01-19 15:36:16'),
(112, 14, '35,36', NULL, 'How would you describe the condition of your scalp? Please check all that apply.', 'Tight and Flaky (Capitis),Congested with Build up (Steoides)', 0, 29, 1, '2021-01-19 18:54:24', '2021-01-19 18:54:24'),
(113, 14, '35,36', NULL, 'How would you describe the condition of your scalp? Please check all that apply.', 'Tight and Flaky (Capitis),Congested with Build up (Steoides)', 0, 29, 1, '2021-01-19 18:56:31', '2021-01-19 18:56:31');

-- --------------------------------------------------------

--
-- Table structure for table `ques_conditions`
--

CREATE TABLE `ques_conditions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `condition_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `condition_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ques_conditions`
--

INSERT INTO `ques_conditions` (`id`, `condition_title`, `condition_code`, `created_at`, `updated_at`) VALUES
(1, 'Female', 'm', NULL, NULL),
(2, 'Male', 'f', NULL, NULL),
(3, 'Transgender', 't', NULL, NULL),
(4, 'Others', 'o', NULL, NULL),
(5, 'Age', 'z', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ques_options`
--

CREATE TABLE `ques_options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `option_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `option_ques_id` int(11) DEFAULT NULL,
  `option_status` tinyint(4) DEFAULT 1 COMMENT '0->incative ,1->active',
  `static_page_id` bigint(20) UNSIGNED DEFAULT NULL,
  `option_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'link if any',
  `option_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'image url',
  `option_check_condition_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `option_condition_true_next_question_id` int(11) DEFAULT 0,
  `option_condition_false_next_question_id` int(11) DEFAULT 0,
  `product_associated_type_id` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ques_options`
--

INSERT INTO `ques_options` (`id`, `option_title`, `option_ques_id`, `option_status`, `static_page_id`, `option_link`, `option_image`, `option_check_condition_id`, `option_condition_true_next_question_id`, `option_condition_false_next_question_id`, `product_associated_type_id`, `created_at`, `updated_at`) VALUES
(1, 'Athlete', 1, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(2, 'Business Professional', 1, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(3, 'Construction', 1, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(4, 'Landscaping', 1, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(5, 'Medical', 1, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(6, 'Outdoor Environments', 1, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(7, 'Outdoor Environments', 1, 0, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(8, 'Public Figure', 1, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(9, 'Recently', 2, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(10, '0-6 Months', 2, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(11, '6-18 Months', 2, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(12, 'Over 2 Years', 2, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(13, 'Decades', 2, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(14, 'Nominal', 3, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(15, 'Nominal to Mild', 3, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(16, 'Occasionally More Than Nominal to Mild', 3, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(17, 'Excessive', 3, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(18, 'None at All', 4, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(19, '1-3 Times a Month', 4, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(20, 'Weekly', 4, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(21, 'Yes', 5, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(22, 'No', 5, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(23, 'Information (Marketing)', 6, 1, 1, '', '', '0', 0, 0, 0, NULL, NULL),
(24, 'Purchase Products', 6, 1, NULL, 'https://www.dtdc.in/tracking/tracking_results.asp', '', '0', 0, 0, 0, NULL, NULL),
(25, 'Purchase Personalized Consultation', 6, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(26, 'New Client Purchase', 6, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(27, 'Purchase Follow Up Appointment ', 6, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(28, 'Create a New Consultation Analysis Report (CAR)', 8, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(29, 'Use an Existing Consultation Analysis Report (CAR)', 8, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(30, 'Follow up Consultation Analysis Report (CAR)', 8, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(31, 'Prevention', 12, 1, 2, '', '', '0', 0, 0, 0, NULL, NULL),
(32, 'Scalp Concern', 12, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(33, 'Hair Thining Concern', 12, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(34, 'Hair Loss Concern', 12, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(35, 'Tight and Flaky (Capitis)', 14, 1, NULL, '', '', '1', 0, 0, 0, NULL, NULL),
(36, 'Congested with Build up (Steoides)', 14, 1, NULL, '', '', '1', 0, 0, 0, NULL, NULL),
(37, 'Itchy', 14, 1, NULL, '', '', '1', 0, 0, 0, NULL, NULL),
(38, 'Bleeding', 14, 1, NULL, '', '', '1', 0, 0, 0, NULL, NULL),
(39, 'Sores', 14, 1, NULL, '', '', '1', 0, 0, 0, NULL, NULL),
(40, 'Smell', 14, 1, NULL, '', '', '1', 0, 0, 0, NULL, NULL),
(41, 'Scabs', 14, 1, NULL, '', '', '1', 0, 0, 0, NULL, NULL),
(42, 'Redness/Irritation', 14, 1, NULL, '', '', '1', 0, 0, 0, NULL, NULL),
(43, 'Balanced and Healthy', 14, 1, NULL, '', '', '1', 0, 0, 0, NULL, NULL),
(44, 'Normal', 15, 1, NULL, '', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/fermalenormal.png', '0', 0, 0, 0, NULL, NULL),
(45, 'Type I', 15, 1, NULL, '', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/fermaletype-1.png', '0', 0, 0, 0, NULL, NULL),
(46, 'Type II', 15, 1, NULL, '', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/fermaletype-2.png', '0', 0, 0, 0, NULL, NULL),
(47, 'Type III', 15, 1, NULL, '', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/fermaletype-3.png', '0', 0, 0, 0, NULL, NULL),
(48, 'Type I', 16, 1, NULL, '', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-1.png', '0', 0, 0, 0, NULL, NULL),
(49, 'Type II', 16, 1, NULL, '', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-2.png', '0', 0, 0, 0, NULL, NULL),
(50, 'Type III', 16, 1, NULL, '', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-3.png', '0', 0, 0, 0, NULL, NULL),
(51, 'Type IV', 16, 1, NULL, '', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-4.png', '0', 0, 0, 0, NULL, NULL),
(52, 'Type V', 16, 1, NULL, '', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-5.png', '0', 0, 0, 0, NULL, NULL),
(53, 'Type VI', 16, 1, NULL, '', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-6.png', '0', 0, 0, 0, NULL, NULL),
(54, 'Type VII', 16, 1, NULL, '', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-7.png', '0', 0, 0, 0, NULL, NULL),
(55, 'Type VIII', 16, 1, NULL, '', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-8.png', '0', 0, 0, 0, NULL, NULL),
(56, 'Yes', 17, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(57, 'No', 17, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(58, 'Alopecia', 18, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(59, 'Any Scalp Bacterial or Fungus', 18, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(60, 'Dermatitis', 18, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(61, 'Eczema', 18, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(62, 'Psoriasis', 18, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(63, 'Trichotillomania', 18, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(64, 'Folliculitis', 18, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(65, 'Lichen Planus Undiagnosed Microbiome Imbalances', 18, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(66, 'Dandruff Steaoides', 18, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(67, 'Dandruff Steaoides', 18, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(68, 'Extreme', 19, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(69, 'Moderately Extreme', 19, 1, NULL, '', '', '1', 27, 28, 0, NULL, NULL),
(70, 'Low Extreme', 19, 1, NULL, '', '', '1', 27, 28, 0, NULL, NULL),
(71, 'Nominal', 19, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(72, 'Hormonal', 20, 1, NULL, '', '', '1', 22, 23, 0, NULL, NULL),
(73, 'Scalp condition', 20, 1, NULL, '', '', '1', 22, 23, 0, NULL, NULL),
(74, 'Disrupted Microbiome', 20, 1, NULL, '', '', '1', 22, 23, 0, NULL, NULL),
(75, 'Drastic diet /medication/internal change', 21, 1, NULL, '', '', '1', 22, 23, 0, NULL, NULL),
(76, 'Hair Styling Habits', 21, 1, NULL, '', '', '1', 22, 23, 0, NULL, NULL),
(77, 'Sudden Medical Emergency', 21, 1, NULL, '', '', '1', 22, 23, 0, NULL, NULL),
(78, 'Pregnancy', 21, 1, NULL, '', '', '1', 22, 23, 0, NULL, NULL),
(79, 'Stress', 21, 1, NULL, '', '', '1', 22, 23, 0, NULL, NULL),
(80, 'Extreme', 25, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(81, 'Moderately Extreme', 25, 1, NULL, '', '', '1', 0, 0, 0, NULL, NULL),
(82, 'Low Extreme', 25, 1, NULL, '', '', '1', 0, 0, 0, NULL, NULL),
(83, 'Nominal', 25, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(84, 'Androgenic', 26, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(85, 'Alopeicas', 26, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(86, 'Central Centrifugal Cicatricial Alopecia concern', 26, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(87, 'Stressful Moments in Life Concerns', 29, 1, NULL, '', '', '1', 28, 27, 0, NULL, NULL),
(88, 'Hair Fiber Concerns', 29, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(89, 'Hair Porosity Concerns', 29, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(90, 'Chemically Treated', 29, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(91, 'Protective Style Hair Damage', 29, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(92, 'Post Partum Concerns', 29, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(93, 'Yes', 30, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(94, 'Yes', 31, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(95, 'No', 31, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(96, 'Low', 32, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(97, 'High', 32, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(98, 'Hair Fibre Concern', 12, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(99, 'No', 30, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(100, 'Yes', 33, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(101, 'No', 33, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(102, 'Yes', 34, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(103, 'No', 34, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(104, 'Yes', 35, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(105, 'No', 35, 1, NULL, '', '', '1', 0, 0, 0, NULL, NULL),
(106, '', 36, 1, NULL, '', '', '0', 0, 0, 0, NULL, NULL),
(107, 'Normal', 22, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/fermalenormal.png', '0', 0, 0, 0, NULL, NULL),
(108, 'Type I', 22, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/fermaletype-1.png', '0', 0, 0, 0, NULL, NULL),
(109, 'Type II', 22, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/fermaletype-2.png', '0', 0, 0, 0, NULL, NULL),
(110, 'Type III', 22, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/fermaletype-3.png', '0', 0, 0, 0, NULL, NULL),
(111, 'Type I', 23, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-1.png', '0', 0, 0, 0, NULL, NULL),
(112, 'Type II', 23, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-2.png', '0', 0, 0, 0, NULL, NULL),
(113, 'Type III', 23, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-3.png', '0', 0, 0, 0, NULL, NULL),
(114, 'Type IV', 23, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-4.png', '0', 0, 0, 0, NULL, NULL),
(115, 'Type V', 23, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-5.png', '0', 0, 0, 0, NULL, NULL),
(116, 'Type VI', 23, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-6.png', '0', 0, 0, 0, NULL, NULL),
(117, 'Type VII', 23, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-7.png', '0', 0, 0, 0, NULL, NULL),
(118, 'Type VIII', 23, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-8.png', '0', 0, 0, 0, NULL, NULL),
(119, 'Yes', 38, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(120, 'No', 38, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(121, 'Normal', 39, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/fermalenormal.png', '0', 0, 0, 0, NULL, NULL),
(122, 'Type I', 39, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/fermaletype-1.png', '0', 0, 0, 0, NULL, NULL),
(123, 'Type II', 39, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/fermaletype-2.png', '0', 0, 0, 0, NULL, NULL),
(124, 'Type III', 39, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/fermaletype-3.png', '0', 0, 0, 0, NULL, NULL),
(125, 'Type I', 40, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-1.png', '0', 0, 0, 0, NULL, NULL),
(126, 'Type II', 40, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-2.png', '0', 0, 0, 0, NULL, NULL),
(127, 'Type III', 40, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-3.png', '0', 0, 0, 0, NULL, NULL),
(128, 'Type IV', 40, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-4.png', '0', 0, 0, 0, NULL, NULL),
(129, 'Type V', 40, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-5.png', '0', 0, 0, 0, NULL, NULL),
(130, 'Type VI', 40, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-6.png', '0', 0, 0, 0, NULL, NULL),
(131, 'Type VII', 40, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-7.png', '0', 0, 0, 0, NULL, NULL),
(132, 'Type VIII', 40, 1, NULL, NULL, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Questions/maletype-8.png', '0', 0, 0, 0, NULL, NULL),
(133, 'None at all', 44, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(134, '1-3 times a month', 44, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(135, 'Weekly', 44, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(136, 'Yes', 45, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(137, 'No', 45, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(138, 'Transplants', 46, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(139, 'Scalp treatments', 46, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(140, 'Hair replacement', 46, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(141, 'Extensions/Wigs', 46, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(142, 'Over-the-counter product', 46, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(143, 'Yes', 47, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(144, 'No', 47, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(145, 'Medications for anemia', 48, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(146, 'Vitamin supplements', 48, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(147, 'Iron supplements', 48, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(148, 'Ferritin supplements', 48, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(149, 'Yes', 49, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(150, 'No', 49, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(151, 'Cosmetic', 50, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(152, 'Food', 50, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(153, 'Environmental', 50, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(154, 'Seasonal', 50, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(155, 'Medications', 50, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(156, 'Yes', 51, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(157, 'No', 51, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(158, 'Yes', 52, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(159, 'No', 52, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(160, 'Yes', 53, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(161, 'No', 53, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(162, 'Yes', 54, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(163, 'No', 54, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(164, 'Irregular Menstrual Cycles', 55, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(165, 'Pregnancies', 55, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(166, 'Polycystic ovaries', 55, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(167, 'Uterine fibroids', 55, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(168, 'Yes', 56, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(169, 'No', 56, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(170, 'Yes', 58, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(171, 'No', 58, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(172, 'Yes', 59, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(173, 'No', 59, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(174, 'Yes', 60, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(175, 'No', 60, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(176, 'Yes', 61, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(177, 'No', 61, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(178, 'Medications', 62, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(179, 'Surgical procedure? List month and year', 62, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(180, 'Yes', 64, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(181, 'No', 64, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(182, 'Please List', 65, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(183, 'Medications', 65, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(184, 'Blood thinners', 67, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(185, 'Beta blockers', 67, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(186, 'Anti depressants', 68, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(187, 'Arthritis', 68, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(188, 'Parkinson’s', 68, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(189, 'Epilepsy-  anti convulsants', 68, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(190, 'None of the above', 68, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(191, 'Ciclopirox', 69, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(192, 'Clobetasol ', 69, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(193, 'Ketoconazole', 69, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(194, 'Minoxidil', 69, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(195, 'Otzela (seborreheic, psoriasis)', 69, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(196, 'Prednisone (scalp/hair)', 69, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(197, 'Avacor', 70, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(198, 'Finasteride', 70, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(199, 'Minoxidil', 70, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(200, 'Propecia', 70, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(201, 'Spironolactone', 70, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(202, 'Saw palmetto', 71, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(203, 'Nutrafol ', 71, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(204, 'Viviscal', 71, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(205, 'Nourkrin', 71, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(206, 'Daily', 72, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(207, '1-3 times a week ', 72, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(208, 'Less than 2 times a week', 72, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(209, 'Never', 72, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(210, 'Daily', 73, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(211, '1-3 times a week ', 73, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(212, 'Less than 2 times a week', 73, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(213, 'Never', 73, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(214, 'Yes', 74, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(215, 'No', 74, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(216, 'Recently ', 75, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(217, 'Less than 6 months', 75, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(218, 'Less than a year', 75, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(219, 'More than a year', 75, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(220, 'Black beans', 76, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(221, 'Lentils', 76, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(222, 'Powder substitution', 76, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(223, 'Quinoa', 76, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(224, 'Daily', 77, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(225, '1-3 times a week', 77, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(226, 'Monthly', 77, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(227, 'Rarely', 77, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(228, 'Daily', 78, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(229, '1-3 times a week', 78, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(230, 'Monthly', 78, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(231, 'Rarely', 78, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(232, 'Daily', 79, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(233, '1-3 times a week', 79, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(234, 'Monthly', 79, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(235, 'Rarely', 79, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(236, 'Daily', 80, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(237, '1-3 times a week', 80, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(238, 'Monthly', 80, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL),
(239, 'Rarely', 80, 1, NULL, NULL, NULL, '0', 0, 0, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', NULL, NULL),
(2, 'user', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `static_pages`
--

CREATE TABLE `static_pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `page_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `static_pages`
--

INSERT INTO `static_pages` (`id`, `page_title`, `page_content`, `created_at`, `updated_at`) VALUES
(1, 'Test Content', '<h2>Testing Content Header</h2>', '2021-01-08 18:30:00', NULL),
(2, 'Prevention', '</h2>Prevention</h2>', '2021-01-08 18:30:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `static_page_linking`
--

CREATE TABLE `static_page_linking` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `static_page_id` int(11) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `static_page_linking`
--

INSERT INTO `static_page_linking` (`id`, `static_page_id`, `option_id`, `question_id`, `created_at`, `updated_at`) VALUES
(1, 1, 23, 6, '2021-01-08 18:30:00', NULL),
(2, 2, 31, 12, '2021-01-08 18:30:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ethinicity` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` enum('m','f','t','o') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'm=male,f=female,t=transgender,o=others',
  `mobile_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_reset_token` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `profile_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signup_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0=email,1=google,2=facebook',
  `social_media_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_status` tinyint(4) NOT NULL DEFAULT 0,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fname`, `lname`, `email`, `ethinicity`, `gender`, `mobile_number`, `address`, `state`, `country`, `zip_code`, `password_reset_token`, `email_verified_at`, `password`, `date_of_birth`, `profile_image`, `signup_type`, `social_media_id`, `profile_status`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'shubham', 'agnihohtrisss', 'shubham.agnihotri356@gmail.com', 'ssss', 'm', '9821033378', 'sasdasdsd', '6', '231', '332332', NULL, NULL, '$2y$10$absUyPRAMp2hskYG0gF8F.U49fKH2BhI9XxzGeT3Df58BHo.Xoe0y', '1995-11-10', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/HOAkxUONA66SGPvycXUfio41ClV7CuVIkknWpOa5.jpeg', 0, NULL, 1, NULL, '2020-10-06 19:06:58', '2021-01-22 13:03:12'),
(2, 'Rachit', 'Mathur', 'rachitmath06u00s440@gmail.com', '2', 'm', NULL, 'asdasdasdasdasd', '2', '231', '332332', NULL, NULL, '$2y$10$1RGu/5xGz.T3pSUEC9Me2ez3672WWW4X92QcDhaYSJE5W1WG8XEWe', '1993-10-01', '', 2, '20085804092041734s', 1, NULL, '2020-10-13 00:56:52', '2020-10-13 00:56:52'),
(3, NULL, NULL, 'yaloyeg797@jarilusua.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$10$QALhfHjCQXiPOT.J/KfgfuvTzuL.UZFqlHXphuwuorMAdKMnkYdA6', NULL, '', 0, NULL, 0, NULL, '2020-10-13 12:13:37', '2020-10-13 12:13:37'),
(4, 'Jacob', 'Kean', 'y8g4ebjl11@temporary-mail.net', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$10$8O9CGHEUnIpS46gb1CaPHu9bHVGxly/rn9UbCP2PP7dvhTF02k6g2', NULL, '', 2, '20085804092041734f', 0, NULL, '2020-10-14 00:23:53', '2020-10-14 00:23:53'),
(5, NULL, NULL, 'johndoe@pastortips.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$10$Go5j3ZR1W203mAPeVII3C.r9RHKn/6rOLBgJYSQWZigHGL98otvSy', NULL, '', 0, NULL, 0, NULL, '2020-10-14 11:39:56', '2020-10-14 14:54:09'),
(6, 'Rachit', 'Mathur', 'rachitmathur8@gmail.com', '2', 'm', NULL, 'Mathur', '14', '231', '83201', NULL, NULL, '$2y$10$fpfmOQ6wDvqoH3R/WSFdguzVYLzHNW36qIRvo63krF/TLmovOo5sO', '1994-03-06', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/4UyzhsRdoymo532TehivJnE5vb0yMz5lmW8oCms2.png', 0, NULL, 1, NULL, '2020-12-15 00:57:38', '2020-12-15 01:01:07');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 2, NULL, NULL),
(2, 2, 2, NULL, NULL),
(3, 3, 2, NULL, NULL),
(4, 4, 2, NULL, NULL),
(5, 5, 2, NULL, NULL),
(6, 6, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `token` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_sessions`
--

INSERT INTO `user_sessions` (`id`, `user_id`, `token`, `created_at`, `updated_at`) VALUES
(1, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2dlbmVyYXRlX3Bhc3N3b3JkIiwiaWF0IjoxNjAxOTkxNDE4LCJleHAiOjE2MDE5OTUwMTgsIm5iZiI6MTYwMTk5MTQxOCwianRpIjoid2xGNlJRZGJmN2gyZTR4bSIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.y_ooEMjGI5Iujh-YRWV6gS9AMnP-spYkiD9E53te4jU', NULL, NULL),
(2, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNTEyOTE2LCJleHAiOjE2MDI1MTY1MTYsIm5iZiI6MTYwMjUxMjkxNiwianRpIjoiZ0JFWEc5QkF1dTlFNXhSaCIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.GfTzGO1pZnir22qhfNUyiJ62h-VScFCXmQG7-Tky4HM', NULL, NULL),
(3, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNTI5NTYxLCJleHAiOjE2MDI1MzMxNjEsIm5iZiI6MTYwMjUyOTU2MSwianRpIjoiSTN6d2cwSWlsM2xkSnB1ViIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.KBRCx1EG5hvBv01QcW0F8ezZWg-HFU3PWoIlcBL4wag', NULL, NULL),
(4, 2, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL3NvY2lhbF9tZWRpYV9zaWduVXAiLCJpYXQiOjE2MDI1MzA4MTIsImV4cCI6MTYwMjUzNDQxMiwibmJmIjoxNjAyNTMwODEyLCJqdGkiOiJTc1haSUxsZlV2alpGMDRWIiwic3ViIjoyLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.odXc99Jk_3-UbvAIKwcMboVXWviHtqpMKz0G2Yk36KQ', NULL, NULL),
(6, 3, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2dlbmVyYXRlX3Bhc3N3b3JkIiwiaWF0IjoxNjAyNTcxNDE3LCJleHAiOjE2MDI1NzUwMTcsIm5iZiI6MTYwMjU3MTQxNywianRpIjoiSks5NkpES3JBRmhmQklGUyIsInN1YiI6MywicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.rJ5B63SdLZIo37ByI-zr5ZeuQMj3WQ1_gsPaD6kHByY', NULL, NULL),
(7, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNTc2MjQzLCJleHAiOjE2MDI1Nzk4NDMsIm5iZiI6MTYwMjU3NjI0MywianRpIjoiUjF4MFhQYnRnc2VTQTJJUSIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.LZbWvx64HfiXCzKMK8nQu2StEYZpkZwT3x1_nF2l_oI', NULL, NULL),
(8, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNjA0MjgwLCJleHAiOjE2MDI2MDc4ODAsIm5iZiI6MTYwMjYwNDI4MCwianRpIjoiNnVDbHlma3lLUW9aOUZSRCIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.tD2dqHXYoqSdAGwAyjE3i96iUikZkyw029RqshBw4Ew', NULL, NULL),
(9, 4, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL3NvY2lhbF9tZWRpYV9zaWduVXAiLCJpYXQiOjE2MDI2MTUyMzMsImV4cCI6MTYwMjYxODgzMywibmJmIjoxNjAyNjE1MjMzLCJqdGkiOiJvYzZQdVljbzhrV3ZYVEdUIiwic3ViIjo0LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.99BZ284gX3RjvedYFMZYCxRhftCAfLIYW7htowI24CY', NULL, NULL),
(10, 5, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2dlbmVyYXRlX3Bhc3N3b3JkIiwiaWF0IjoxNjAyNjU1Nzk2LCJleHAiOjE2MDI2NTkzOTYsIm5iZiI6MTYwMjY1NTc5NiwianRpIjoiQm43ZmpMZUFOYmhqZk16eSIsInN1YiI6NSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.9s4RS2I81c_Z7L3xFBAsJom91uF1O-r6qh-12Jw7_b4', NULL, NULL),
(11, 5, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL3VwZGF0ZV9mb3JnZXRfcGFzc3dvcmQiLCJpYXQiOjE2MDI2NjQ5NzAsImV4cCI6MTYwMjY2ODU3MCwibmJmIjoxNjAyNjY0OTcwLCJqdGkiOiJWSmF1dXpZZUhWRmpGZUZXIiwic3ViIjo1LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.t9CETdd0VoiuCGUapF80mB-YFGHvd9T6_U928Ir0r2I', NULL, NULL),
(12, 5, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL3VwZGF0ZV9mb3JnZXRfcGFzc3dvcmQiLCJpYXQiOjE2MDI2Njc0NDksImV4cCI6MTYwMjY3MTA0OSwibmJmIjoxNjAyNjY3NDQ5LCJqdGkiOiJXZGVZWlVQQ3BkdGUwUjlXIiwic3ViIjo1LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.nm0GMUDCnQRi7P0m6ExWvQqei9WbB3JVV-SxO6eCxpM', NULL, NULL),
(13, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNjcyMDg4LCJleHAiOjE2MDI2NzU2ODgsIm5iZiI6MTYwMjY3MjA4OCwianRpIjoiMVQwcW91U1BFUzBxb3FyTCIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.y3ANzciAwAMmhBuW1SZmOeBptgsQWDqG8YlkPDWOl8o', NULL, NULL),
(14, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNjg1Mzk3LCJleHAiOjE2MDI2ODg5OTcsIm5iZiI6MTYwMjY4NTM5NywianRpIjoiRFJwN3d3MjhjdWdUUmw3dSIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.erL_O-VVyQuJLEXGk3P-teR5o3jJrK959aXwZKLvO28', NULL, NULL),
(15, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNjkwODMxLCJleHAiOjE2MDI2OTQ0MzEsIm5iZiI6MTYwMjY5MDgzMSwianRpIjoiZDFOU215dlo2WGdJdkVuVSIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.YbrqQE5BvSDDQGW_YW6UK8lTohnDDrYjPxTtbk4bVw0', NULL, NULL),
(16, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNjkxOTUyLCJleHAiOjE2MDI2OTU1NTIsIm5iZiI6MTYwMjY5MTk1MiwianRpIjoiUWVyQ1FiSmlHWWxGTkN4diIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.1NWUAxiyZYknogdngXSa_UQkc34CLlCpH5i9T28xrr8', NULL, NULL),
(17, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNzA2MTMwLCJleHAiOjE2MDI3MDk3MzAsIm5iZiI6MTYwMjcwNjEzMCwianRpIjoiWlZMT2FiN2FmdGdwRThiVCIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.dS5-jijp-1bsoeG12NAc_pg--Pt9CuHWIK0jCxaTvH8', NULL, NULL),
(18, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNzM4NTkxLCJleHAiOjE2MDI3NDIxOTEsIm5iZiI6MTYwMjczODU5MSwianRpIjoiWkFmcWJTUjNMc2tKTW1XQiIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.gCYp0PKenKV-0jt5OOhPnOOJH1hQjejIZuVM0VfzpRM', NULL, NULL),
(19, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNzUyNDgxLCJleHAiOjE2MDI3NTYwODEsIm5iZiI6MTYwMjc1MjQ4MSwianRpIjoiTmFQTkt1MUp3cTc5OHZyUiIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.5oLsjtiaLoCG3mN3LK83Je9G3ylFdQCXzN2KiloacPw', NULL, NULL),
(20, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNzU3NTM3LCJleHAiOjE2MDI3NjExMzcsIm5iZiI6MTYwMjc1NzUzNywianRpIjoiSWhPSXp3SUxyajBtT29ORSIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.hhlxh3WzBqsgBr5nkZcnBZUc_LOEdyA47FOEMIpB1wU', NULL, NULL),
(21, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNzU4MTcyLCJleHAiOjE2MDI3NjE3NzIsIm5iZiI6MTYwMjc1ODE3MiwianRpIjoia1dwdWxvb3RVWEhxd0tOTCIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.fXB9TjOjfDXBzDWX4O2G1Qc7mFI35u3yIkkgp9z1hFo', NULL, NULL),
(22, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNzU5NTQ2LCJleHAiOjE2MDI3NjMxNDYsIm5iZiI6MTYwMjc1OTU0NiwianRpIjoiVFoydjExSXlqOU9lQWh0UCIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.Z_LHje3hCrsilmwCUH0IP2Kr9-8ZORIQyHntrcjSOzk', NULL, NULL),
(23, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNzYyMzczLCJleHAiOjE2MDI3NjU5NzMsIm5iZiI6MTYwMjc2MjM3MywianRpIjoiZk5lNzVjQTVzNkRac3JndyIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.sBHoTpPAvoqK6PI5-LPQUI217AMmNL9co8QJ5Rr8SOw', NULL, NULL),
(24, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNzc3NTQxLCJleHAiOjE2MDI3ODExNDEsIm5iZiI6MTYwMjc3NzU0MSwianRpIjoiem5UN0Z4cjFnTk56eDh0eiIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.CgoJSwwq7wYMxYi0m-9jyGzlLIldRPQr-x8K-Pu6hWA', NULL, NULL),
(25, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNzgzMjQzLCJleHAiOjE2MDI3ODY4NDMsIm5iZiI6MTYwMjc4MzI0MywianRpIjoidENrSnpLcUpBYVRud3RTayIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.X6m_OeVo90vn1EESUg85jYqZh8shNe53XWRaWK5lWGs', NULL, NULL),
(26, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyNzg0MzU2LCJleHAiOjE2MDI3ODc5NTYsIm5iZiI6MTYwMjc4NDM1NiwianRpIjoiVEtMRXdXa0l3djN3dkYzayIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.yATFvykiMFki8r959ZlObZU4XG0Q31sbr_Z3C8SbO8I', NULL, NULL),
(27, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyODI5NjE0LCJleHAiOjE2MDI4MzMyMTQsIm5iZiI6MTYwMjgyOTYxNCwianRpIjoiYkRmZDRrODZXNE1UY09SZSIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.EcF1mrNNUTMA6Mu7UECUx0RHxtxF_GFzOyGUKwu9GRk', NULL, NULL),
(28, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjAyODMyMzYwLCJleHAiOjE2MDI4MzU5NjAsIm5iZiI6MTYwMjgzMjM2MCwianRpIjoib0NjbkFjMzRFOU9qSnRUMSIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.UQpYr-UXAjrX8aovXrm44R2H5eSbCHbJQHEOrDH4YR4', NULL, NULL),
(29, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA0OTUwMDEwLCJuYmYiOjE2MDQ5NTAwMTAsImp0aSI6ImVhR3p4Z0RvakZOWkhpQm0iLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.jjfXX77GwxRUyb2AK6yeBtE9zdONHRkbzyjRShT2IFk', NULL, NULL),
(30, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA1MTY1NDA4LCJuYmYiOjE2MDUxNjU0MDgsImp0aSI6ImFPcHhJTE5DbTJPUzFHaU8iLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.DHzFB6eApGqk-0m8HEBYHbdbB_uFZlF_PAM66a0UMZ0', NULL, NULL),
(31, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA1MTcxNTQyLCJuYmYiOjE2MDUxNzE1NDIsImp0aSI6ImpRZkF0V2JCakVvaVc4SEEiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.xjyXiQ-CnL-tQ_DNW6WvMomZTGn8wWdiKHVShDmF9iE', NULL, NULL),
(32, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA1NTk0NDIxLCJuYmYiOjE2MDU1OTQ0MjEsImp0aSI6ImZmUlZ3R21TWlRmSTZnUnciLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.-2L-5SsbV-Bym96bHJbAq8IoON_Y3x7lE4my3u8d8mI', NULL, NULL),
(33, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA2MjI0NjY0LCJuYmYiOjE2MDYyMjQ2NjQsImp0aSI6IkZpYXFualVTdW91czFENDAiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.GW_REIct1c57yu0QJbczab9O8UfW5ewP5xfpPlyQYBw', NULL, NULL),
(34, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA2MjI0NjY1LCJuYmYiOjE2MDYyMjQ2NjUsImp0aSI6InNnY3Q2dUFCaXhSR05ac08iLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.cYP1FUO0SFEycgaFlFYd6sHjMG4P-_pMd_yJztcJA8A', NULL, NULL),
(35, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA2MjM5NDkyLCJuYmYiOjE2MDYyMzk0OTIsImp0aSI6InNPZ25mc3NrNWNhVVQ0dFciLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.istYKArGHXEoFWeYtzguesot8vXD270NaYDTC5aqr9Y', NULL, NULL),
(36, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA2MjM5NzgxLCJuYmYiOjE2MDYyMzk3ODEsImp0aSI6ImdGT0hETE1zanp2V1RUQzQiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.RDYEKU7CDj889St6mJmrO01t1PoAnS9Kkke5UdBXrAo', NULL, NULL),
(37, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA2MjM5Nzg1LCJuYmYiOjE2MDYyMzk3ODUsImp0aSI6IkdmclVvNjdjaUx6YlBCQUciLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.Qxs71CrP1MwZDp2L0xBugdIiUYvn_Nvx5AKU306Q0IY', NULL, NULL),
(38, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA2MzA2NzY3LCJuYmYiOjE2MDYzMDY3NjcsImp0aSI6IlBaZlh0cHFRcjZPdHlCVmsiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.obMqwMByw3gCtyAgkUkyGQxNMW9J-JhNmeLWj3fNRZs', NULL, NULL),
(39, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA2NDU5Nzc1LCJuYmYiOjE2MDY0NTk3NzUsImp0aSI6ImhWb2FzdEF4bFhWS2doM0MiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.Otb8hEXgeicN_pChRN4rkzWuGfo9GtRQusghlLqi_Fw', NULL, NULL),
(40, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA2NDc1NDA4LCJuYmYiOjE2MDY0NzU0MDgsImp0aSI6InR5UUNMYWpqVmlsT01nUjUiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.dAWdxyQddgRxPRKCNRemfAJ9k81JN2kvh-uOY7PkM0Y', NULL, NULL),
(41, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA2NDc2NzE5LCJuYmYiOjE2MDY0NzY3MTksImp0aSI6InFMZjk3WjJuVmhFV2hsOEkiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.uJCfoT6HWPzIzzSyJe2cm6FYTmjw7MG7uSlN1iL40gc', NULL, NULL),
(43, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA2ODk0NzkzLCJuYmYiOjE2MDY4OTQ3OTMsImp0aSI6Imx6VnBtdGFFbjBLTWpITkciLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.q2y8ilK_gYegj9Rf64rxll0B5o1xqqaWtYmjoFLvgTU', NULL, NULL),
(44, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA2ODk3MzgxLCJuYmYiOjE2MDY4OTczODEsImp0aSI6InlDZU5OdDFwRXA5d280NmgiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.fjg7Eg72DoorHxDWfglBs7Tiy85-mPxl8LYpJqtsncA', NULL, NULL),
(46, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA3NDIwODg5LCJuYmYiOjE2MDc0MjA4ODksImp0aSI6InlkdWVWOWJPanVLd1ZVZnYiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.6Rh0TwhxWhonFsXB_lxlSy1OZf1L1WfK0RY39F8dyLw', NULL, NULL),
(47, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA3NTE0ODkxLCJuYmYiOjE2MDc1MTQ4OTEsImp0aSI6IjRiQnV2WTh2VVZhd2kxQXUiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.S17vMeDUwpd9a8wqH1zMW8zVuThJzimuR20MpKJXD5E', NULL, NULL),
(49, 6, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2dlbmVyYXRlX3Bhc3N3b3JkIiwiaWF0IjoxNjA3OTc0MDU4LCJuYmYiOjE2MDc5NzQwNTgsImp0aSI6ImdobVRpOHBocWxMTEpneVMiLCJzdWIiOjYsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.vur8wZCeyIN9vfuQFCAZSzobAwsDxleOaWXdQvG9r8g', NULL, NULL),
(53, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA4MTAzMTIzLCJuYmYiOjE2MDgxMDMxMjMsImp0aSI6IkQ5UG5MSFZTSW1WZlBsa0UiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.-MkyjgQl-inRxcRXy4wpsYWt8powD6i7unOIXz6hOGk', NULL, NULL),
(56, 6, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA4MTQzMDU4LCJuYmYiOjE2MDgxNDMwNTgsImp0aSI6InZLNjlwMm9meFFCQWVyNkUiLCJzdWIiOjYsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.TlidRzzxMPOFWVy29WinbKyxie-5LL9rAeU9Sq7pJfE', NULL, NULL),
(61, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA4NTQzNTAwLCJuYmYiOjE2MDg1NDM1MDAsImp0aSI6Im1VNkgzRkU0TDBlZkFHS0kiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.a-niKzkhHz0jwUgb478R6t0eQ3BhsXWLO9IoMSKMHug', NULL, NULL),
(62, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA4NTQ2MTA2LCJuYmYiOjE2MDg1NDYxMDYsImp0aSI6ImhoVzBOTzRlRGExM2VwOFUiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.nnB6UMAFlVSFrgIyPjhqpFynvTIOYKj80S4Ftl5xYbA', NULL, NULL),
(63, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA4NjQ0NzgwLCJuYmYiOjE2MDg2NDQ3ODAsImp0aSI6IkUxWDlYUUJjY2hqRmpXWVMiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.hb2Ydm08tno5N8_7BkIjqvkiydgI8SyhqcvmdEU6KpI', NULL, NULL),
(64, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA4NjYwODYyLCJuYmYiOjE2MDg2NjA4NjIsImp0aSI6IldNaEFoV1dVa3hMQVozbUwiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.UdGX7l98q7S8mjMwJ4JGX7Iay4mYswClfD-pBZ9gfFM', NULL, NULL),
(65, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA5MTQxMjQ2LCJuYmYiOjE2MDkxNDEyNDYsImp0aSI6IjlpNW9IV0hKeTRqMHFDaVQiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.v7d9VLPj9QqFy7YW1Lm2b-wONKickoDLoVTG-QumQxw', NULL, NULL),
(66, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA5MTYzNDM1LCJuYmYiOjE2MDkxNjM0MzUsImp0aSI6Im1BUktVVG8ydlFoeGl0R0EiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.uEH2LqvhGRfeGvI35cNK9_Ypehzo5sAIKymy7J15DLQ', NULL, NULL),
(68, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA5MzE4NDAyLCJuYmYiOjE2MDkzMTg0MDIsImp0aSI6ImM1VWdmd3d6aFBkVFNHR2QiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.TQ9Nit4uq0ByBtYk57woEJVZvJWaqjokKvhLXDT8M8U', NULL, NULL),
(69, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA5NzQzMDQzLCJuYmYiOjE2MDk3NDMwNDMsImp0aSI6ImZZaDR5UHZhaFBXc01rQXEiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.K3BeNd_b3MbzUIFPqoBYbJ9ZnB8oDBoK_x2s7g9vkP4', NULL, NULL),
(70, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA5NzQ2OTExLCJuYmYiOjE2MDk3NDY5MTEsImp0aSI6Im80MXd1aWE2MW85bVZ3NmsiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.17TyhpPwKfXQAjGA6OpV5edc5WwMYUvJEs-zBVihmaU', NULL, NULL),
(71, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA5NzUyNzc3LCJuYmYiOjE2MDk3NTI3NzcsImp0aSI6ImR4cXZJOE9lWm9oR1JBMkEiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.I2nST6eLeIMwLuE0LjuDYjt8VJprzQV9axgZfksSnuw', NULL, NULL),
(72, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA5ODU2NzIzLCJuYmYiOjE2MDk4NTY3MjMsImp0aSI6ImdSZ2xYQ1BiS1JVUFl5RTAiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.-hEAmghqzr5NmyQUhB-CxAJx8ni-PvSkPpC0QeoTv3I', NULL, NULL),
(73, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjA5OTE2MTEyLCJuYmYiOjE2MDk5MTYxMTIsImp0aSI6InFLUTdZcHlvT2RMaTA1c2IiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.9vYzxG2QYkNTaQZMzbtTuuf9zLhmiJN3WNZAjgzSxBc', NULL, NULL),
(74, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL3VwZGF0ZV9mb3JnZXRfcGFzc3dvcmQiLCJpYXQiOjE2MDk5OTc3OTcsIm5iZiI6MTYwOTk5Nzc5NywianRpIjoiVzg0SjdBWTBOS1hPTnRwYSIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.1Iw1Ud1jVmlMqoGk7oCYbNaFq8M_ORQ6S0sMVHEDca0', NULL, NULL),
(75, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2FkbWluXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMDAwMDQyMCwibmJmIjoxNjEwMDAwNDIwLCJqdGkiOiJsdjNXT0pVbnIwZGtmZTVYIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.pxjNwq8h2iK6zHGV-E0TI0J0LAp-a96WkFjm4LEPJ58', NULL, NULL),
(76, 6, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjEwMDAyMDEwLCJuYmYiOjE2MTAwMDIwMTAsImp0aSI6Im9ONGZ1bkNxOTZ5c0xCd2oiLCJzdWIiOjYsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.z7TG0mrmUX6QcLJUcm9_5eCIZ-pKx4hZQeNfA6yd7H4', NULL, NULL),
(77, 6, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOC4yMTguNDguMzBcL2RldlwvYnNoaWxsX2JhY2tlbmRcL2FwaVwvdjFcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjEwMDA2MTE5LCJuYmYiOjE2MTAwMDYxMTksImp0aSI6IjRVelF0MURMSkhGelNWNjMiLCJzdWIiOjYsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.xxfd642sJymqw0bNSQAD5Y9-hsFRJhMGx5iBto3IywY', NULL, NULL),
(78, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMDg3ODg5OCwibmJmIjoxNjEwODc4ODk4LCJqdGkiOiJWSG5LVTFHclhlNk1pTmY4Iiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.8KosVGhBYKCFtPNqR9pEE3HIpLR6uVck31_EMFVmSp0', NULL, NULL),
(79, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMTA2NDg0NSwibmJmIjoxNjExMDY0ODQ1LCJqdGkiOiJVd3k1cmpKeEpUQm5PNVhVIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.0c1QQe6YhCM3FbkRkEMPD4ikUEP7vHZ2FobPlyNW3MU', NULL, NULL),
(80, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMTIzNTA3MiwibmJmIjoxNjExMjM1MDcyLCJqdGkiOiJraGhEbmJIS1A4VVhXeFJlIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Jz7UhjBKvBcpiTnd35ckWEbpqyojS4PeFiemWLdgq04', NULL, NULL),
(81, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMTIzNjcwMywibmJmIjoxNjExMjM2NzAzLCJqdGkiOiI1RlZCZ05IVVhuUnI5Vzk1Iiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.sCm9sguUu-hIckcLzEiMhI7uWJc8kosqZTbO-bT_2cc', NULL, NULL),
(82, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMTMxOTgwMywibmJmIjoxNjExMzE5ODAzLCJqdGkiOiJtV1g3OTVTR2tVRW94V3dIIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Zq6uFsL7PbEX4iSc0onnb0lyt_-EJJhXGSdud7wtv5c', NULL, NULL),
(83, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMTMyMDM3NCwibmJmIjoxNjExMzIwMzc0LCJqdGkiOiJFQUpHNjd2eFlON3pCWUlkIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.hYW5noliUHr4wxDbk-Cpolnk2q82uNOoYEtucf3gbeY', NULL, NULL),
(84, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMTMyMDU1MywibmJmIjoxNjExMzIwNTUzLCJqdGkiOiJqendWTHozajNoSE1nYU1nIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.bBms4k1s5cfhEy8VJTKF2vpWzOl125xRvecBuBvR_Yk', NULL, NULL),
(85, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMTMyMDU3OCwibmJmIjoxNjExMzIwNTc4LCJqdGkiOiJ4SUsyY3pRRkJQcThtUjJrIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.tZyFyJdATJCzNzMfZ-JvneKo2vBV1uZ5RSZIXNvbib8', NULL, NULL),
(86, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMTQxMzAyMiwibmJmIjoxNjExNDEzMDIyLCJqdGkiOiJwbHNyanZDQnBFT2ZwRFVqIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.bPpOZ6ctNdAIcZjNV2qDrGdE9Gh8_ObCYTkH0GTCE_I', NULL, NULL),
(87, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxMjAwNjU2MiwibmJmIjoxNjEyMDA2NTYyLCJqdGkiOiJtYXZRRURjemVWSTF6UFJYIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.rEf4DEsxpcUvMhImj33U8H9DBbn7aqaXnbpg8ujxIIA', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_appointments`
--
ALTER TABLE `admin_appointments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `appointment_prices`
--
ALTER TABLE `appointment_prices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `consultations`
--
ALTER TABLE `consultations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `consultation_notes`
--
ALTER TABLE `consultation_notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `consultation_products`
--
ALTER TABLE `consultation_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `country_states`
--
ALTER TABLE `country_states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gender`
--
ALTER TABLE `gender`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `otps`
--
ALTER TABLE `otps`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_details`
--
ALTER TABLE `payment_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_associated_concern_mapping`
--
ALTER TABLE `product_associated_concern_mapping`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_associated_condition_mapping`
--
ALTER TABLE `product_associated_condition_mapping`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_associated_types`
--
ALTER TABLE `product_associated_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promotion_videos`
--
ALTER TABLE `promotion_videos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ques`
--
ALTER TABLE `ques`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ques_answers_consultations`
--
ALTER TABLE `ques_answers_consultations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ques_conditions`
--
ALTER TABLE `ques_conditions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ques_options`
--
ALTER TABLE `ques_options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `static_pages`
--
ALTER TABLE `static_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `static_page_linking`
--
ALTER TABLE `static_page_linking`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_mobile_number_unique` (`mobile_number`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_appointments`
--
ALTER TABLE `admin_appointments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `appointment_prices`
--
ALTER TABLE `appointment_prices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `consultations`
--
ALTER TABLE `consultations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `consultation_notes`
--
ALTER TABLE `consultation_notes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `consultation_products`
--
ALTER TABLE `consultation_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=232;

--
-- AUTO_INCREMENT for table `country_states`
--
ALTER TABLE `country_states`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `gender`
--
ALTER TABLE `gender`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `otps`
--
ALTER TABLE `otps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `payment_details`
--
ALTER TABLE `payment_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_associated_concern_mapping`
--
ALTER TABLE `product_associated_concern_mapping`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_associated_condition_mapping`
--
ALTER TABLE `product_associated_condition_mapping`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_associated_types`
--
ALTER TABLE `product_associated_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promotion_videos`
--
ALTER TABLE `promotion_videos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ques`
--
ALTER TABLE `ques`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `ques_answers_consultations`
--
ALTER TABLE `ques_answers_consultations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `ques_conditions`
--
ALTER TABLE `ques_conditions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ques_options`
--
ALTER TABLE `ques_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=240;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `static_pages`
--
ALTER TABLE `static_pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `static_page_linking`
--
ALTER TABLE `static_page_linking`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
