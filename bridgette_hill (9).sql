-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2021 at 09:22 PM
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
-- Database: `bridgette_hill`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_appointments`
--

CREATE TABLE `admin_appointments` (
  `id` int(11) NOT NULL,
  `appointment_title` varchar(255) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` varchar(255) NOT NULL,
  `appointment_end_time` varchar(255) DEFAULT NULL,
  `appointment_type` tinyint(2) NOT NULL COMMENT '1->intial,2->Follow Up,3->New on Existing,4-> Personalised',
  `appointment_duration` varchar(50) NOT NULL,
  `appointment_status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '1->appointment fix,2->cancel appoin.,3->resedule',
  `created_at` datetime NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin_appointments`
--

INSERT INTO `admin_appointments` (`id`, `appointment_title`, `appointment_date`, `appointment_time`, `appointment_end_time`, `appointment_type`, `appointment_duration`, `appointment_status`, `created_at`, `updated_at`) VALUES
(1, 'wwwwwwwwwwwwwww', '2020-10-27', '16:00:00', '16:45:00', 1, '60', 1, '2020-11-05 11:28:44', '2020-11-19 07:50:59'),
(2, 'shubham', '2020-08-25', '17:00:00', '16:15:00', 2, '60', 1, '2020-11-05 11:28:44', '2021-01-13 08:08:06'),
(3, 'QWQWQWQWQWQWQW', '2021-01-27', '16:25:00', NULL, 2, '10', 1, '2021-01-12 18:33:28', '2021-01-12 13:03:28'),
(4, 'QWQWQWQWQWQWQW', '2021-01-27', '16:25:00', '16:35', 2, '15', 1, '2021-01-12 18:45:54', '2021-01-12 13:15:54'),
(5, 'QWQWQWQWQWQWQW', '2021-01-27', '16:25:00', '05:30:00', 2, '15', 1, '2021-01-12 18:46:59', '2021-01-12 13:16:59'),
(6, 'QWQWQWQWQWQWQW', '2021-01-27', '16:25:00', '05:30:00', 2, '15', 1, '2021-01-12 18:47:38', '2021-01-12 13:17:38'),
(7, 'QWQWQWQWQWQWQW', '2021-01-27', '16:25:00', '16:40:00', 2, '15', 1, '2021-01-12 19:27:33', '2021-01-12 13:57:33'),
(8, 'QWQWQWQWQWQWQW', '2021-01-27', '16:25:00', '16:35:00', 2, '10', 1, '2021-01-12 19:28:03', '2021-01-12 13:58:03');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` varchar(255) NOT NULL,
  `appointment_end_time` varchar(255) DEFAULT NULL,
  `appointment_type` tinyint(4) NOT NULL COMMENT '1->initial,2->followup,3->existing follow up,4->personalized',
  `appointment_duration` varchar(50) DEFAULT NULL,
  `consultation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `appointment_status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1->appointment fix,2->cancel appoin.,3->resedule',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `appointment_date`, `appointment_time`, `appointment_end_time`, `appointment_type`, `appointment_duration`, `consultation_id`, `user_id`, `appointment_status`, `created_at`, `updated_at`) VALUES
(1, '2020-10-27', '16:25:00', NULL, 2, NULL, 1, 1, 1, '2020-12-09 12:46:19', '2020-12-09 12:46:19');

-- --------------------------------------------------------

--
-- Table structure for table `appointment_prices`
--

CREATE TABLE `appointment_prices` (
  `id` int(11) NOT NULL,
  `appointment_type_name` varchar(100) NOT NULL,
  `appointment_price` varchar(5) DEFAULT NULL,
  `appointment_duration` varchar(50) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '1-> consultation , 2->Appointment'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appointment_prices`
--

INSERT INTO `appointment_prices` (`id`, `appointment_type_name`, `appointment_price`, `appointment_duration`, `type`) VALUES
(1, 'Initial Meeting', '', '45', 2),
(2, 'Followup Meeting', '', '15', 2),
(3, 'Existing follow up', '65', '15', 2),
(4, 'Personalized Trichological Consultation', '300', '300', 2),
(5, 'New Consultation ', '150', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `consultations`
--

CREATE TABLE `consultations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `consultations_comments` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consultant_created_at` datetime DEFAULT NULL COMMENT 'consultant ques start',
  `consultant_ended_at` datetime DEFAULT NULL COMMENT 'consultant ques ended',
  `car_report_response` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `car_report_created_at` datetime DEFAULT NULL,
  `feedback_rating` tinyint(4) DEFAULT 0,
  `feedback_text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `car_admin_remarks` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `concern_type` int(11) DEFAULT NULL,
  `condition_type` int(11) DEFAULT NULL,
  `consultant_status` tinyint(4) DEFAULT 0 COMMENT '0->in progress,1->final submitted and payment done,2->under review,3-> CAR Generated,4->ques and images submit payment not done,5->question done and images pending',
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `consultations`
--

INSERT INTO `consultations` (`id`, `user_id`, `consultations_comments`, `consultant_created_at`, `consultant_ended_at`, `car_report_response`, `car_report_created_at`, `feedback_rating`, `feedback_text`, `car_admin_remarks`, `concern_type`, `condition_type`, `consultant_status`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, '2020-12-07 21:58:04', '2020-12-08 10:06:41', NULL, NULL, 0, NULL, NULL, NULL, NULL, 2, '2020-12-07 21:58:04', '2021-01-08 13:31:09'),
(3, 1, NULL, '2020-12-11 12:53:26', '2020-12-11 12:53:26', NULL, NULL, 0, NULL, NULL, NULL, NULL, 1, '2020-12-11 12:53:26', '2020-12-11 07:23:26'),
(4, 1, NULL, '2020-12-11 12:53:40', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2020-12-11 12:53:40', '2020-12-11 07:23:40'),
(5, 1, NULL, '2020-12-11 17:53:29', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2020-12-11 17:53:29', '2020-12-11 12:23:29'),
(6, 1, NULL, '2020-12-21 13:03:30', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, '2020-12-21 13:03:30', '2020-12-21 07:33:30');

-- --------------------------------------------------------

--
-- Table structure for table `consultation_notes`
--

CREATE TABLE `consultation_notes` (
  `id` int(11) NOT NULL,
  `consultation_id` int(11) NOT NULL,
  `note_type` tinyint(4) NOT NULL COMMENT '1->initial meeting,2->follow up meeting notes',
  `condition_id` int(3) NOT NULL,
  `consultation_note` text NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `consultation_notes`
--

INSERT INTO `consultation_notes` (`id`, `consultation_id`, `note_type`, `condition_id`, `consultation_note`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 5, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages', 1, NULL, '2021-01-09 11:19:03'),
(2, 5, 2, 5, 'asdasdasdasda', 1, NULL, '2021-01-09 13:23:55'),
(3, 5, 2, 5, 'asdasdasdasda', 1, NULL, '2021-01-10 06:41:59');

-- --------------------------------------------------------

--
-- Table structure for table `consultation_products`
--

CREATE TABLE `consultation_products` (
  `id` int(11) NOT NULL,
  `consulation_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `status` tinyint(3) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `consultation_products`
--

INSERT INTO `consultation_products` (`id`, `consulation_id`, `product_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, NULL, '2020-12-08 12:34:00');

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
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `consultation_id` int(11) DEFAULT NULL,
  `file_url` varchar(200) DEFAULT NULL,
  `file_type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1->image,2->videos',
  `file_view_from` tinyint(4) DEFAULT 0 COMMENT '1->left,2->right,3->front,4->back'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`id`, `user_id`, `consultation_id`, `file_url`, `file_type`, `file_view_from`) VALUES
(1, 1, 1, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/HOAkxUONA66SGPvycXUfio41ClV7CuVIkknWpOa5.jpeg', 1, 1),
(2, 1, 1, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/HOAkxUONA66SGPvycXUfio41ClV7CuVIkknWpOa5.jpeg', 1, 2),
(3, 1, 1, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/HOAkxUONA66SGPvycXUfio41ClV7CuVIkknWpOa5.jpeg', 1, 3),
(4, 1, 1, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/HOAkxUONA66SGPvycXUfio41ClV7CuVIkknWpOa5.jpeg', 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `form_details`
--

CREATE TABLE `form_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `form_type_id` int(11) NOT NULL,
  `ques_type` enum('1','2','3','4','5','6','7') COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '1->input,2 ->Checkbox,3,radio,4->select,5->date,6->time,7->file,8->multi checkbox,9->multi select',
  `ques_field` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ques_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ques_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_validation` int(11) DEFAULT NULL,
  `max_validation` int(11) DEFAULT NULL,
  `is_mandatory` tinyint(4) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(7, '2020_10_08_102025_create_countries_table', 1),
(8, '2020_10_08_102654_create_country_states_table', 1),
(9, '2020_10_15_105317_create_ques_table', 1),
(10, '2020_10_15_105414_create_ques_options_table', 1),
(11, '2020_10_15_105507_create_ques_answers_consultant_table', 1),
(12, '2020_10_15_105559_create_consultants_table', 1),
(13, '2020_10_15_174529_create_ques_options_next_questions_table', 1),
(14, '2020_10_15_174638_create_ques_options_prev_questions_table', 1),
(15, '2020_10_20_132443_create_ques_conditions_table', 1),
(16, '2020_11_24_163910_create_webview_urls_table', 2),
(17, '2020_11_24_171630_create_themes_table', 2),
(18, '2020_11_24_171738_create_form_types_table', 2),
(19, '2020_11_24_171833_create_form_details_table', 2),
(20, '2020_11_24_171854_create_form_options_table', 2),
(21, '2020_11_25_132859_create_themes_details_table', 2),
(22, '2020_12_02_160638_create_generate_requests_table', 2),
(23, '2020_12_02_165615_create_form_answers_table', 2);

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

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `product_title` varchar(250) NOT NULL,
  `product_url` text NOT NULL,
  `product_status` tinyint(2) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_title`, `product_url`, `product_status`, `created_at`, `updated_at`) VALUES
(1, 'kesh king new telsssss', 'https://gg.10dayshairoil.com/?gclid=CjwKCAiA-f78BRBbEiwATKRRBLEnh7rwjIfh3PTLw7vIf_irh6Sy_iYJWLFpy2zT8C1DDgfVXtZwTBoC6poQAvD_BwE', 1, NULL, '2020-11-03 14:36:23'),
(2, 'baalo ka tel 2', 'https://www.amazon.in/MR-GOLD-Home-Kitchen-Gingelly/dp/B07PDCL395/ref=sr_1_2_sspa?dchild=1&keywords=oil&qid=1604040486&sr=8-2-spons&psc=1&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUExVURBNEhOUUJQVEw5JmVuY3J5cHRlZElkPUEwMTE0MTc2M0FUM1hLN0FFVDJYVSZlbmNyeXB0ZWRBZElkPUEwOTU3MjA0MThQRzlNNEtKWFRHTSZ3aWRnZXROYW1lPXNwX2F0ZiZhY3Rpb249Y2xpY2tSZWRpcmVjdCZkb05vdExvZ0NsaWNrPXRydWU=', 1, NULL, '0000-00-00 00:00:00'),
(3, 'kesh king new tel', 'https://gg.10dayshairoil.com/?gclid=CjwKCAiA-f78BRBbEiwATKRRBLEnh7rwjIfh3PTLw7vIf_irh6Sy_iYJWLFpy2zT8C1DDgfVXtZwTBoC6poQAvD_BwE', 1, '2020-11-02 13:33:29', '2020-11-02 19:03:29'),
(4, 'kesh king new tel', 'https://gg.10dayshairoil.com/?gclid=CjwKCAiA-f78BRBbEiwATKRRBLEnh7rwjIfh3PTLw7vIf_irh6Sy_iYJWLFpy2zT8C1DDgfVXtZwTBoC6poQAvD_BwE', 1, '2020-11-02 13:34:32', '2020-11-02 19:04:32'),
(5, 'kesh king new tel', 'https://gg.10dayshairoil.com/?gclid=CjwKCAiA-f78BRBbEiwATKRRBLEnh7rwjIfh3PTLw7vIf_irh6Sy_iYJWLFpy2zT8C1DDgfVXtZwTBoC6poQAvD_BwE', 1, '2020-11-02 13:35:06', '2020-11-02 19:05:06');

-- --------------------------------------------------------

--
-- Table structure for table `product_associated_concern_mapping`
--

CREATE TABLE `product_associated_concern_mapping` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_concern_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_associated_concern_mapping`
--

INSERT INTO `product_associated_concern_mapping` (`id`, `product_id`, `product_concern_id`, `created_at`, `updated_at`) VALUES
(5, 2, 1, NULL, NULL),
(6, 3, 1, '2020-11-02 13:33:29', '2020-11-02 13:33:29'),
(7, 3, 2, '2020-11-02 13:33:29', '2020-11-02 13:33:29'),
(8, 3, 5, '2020-11-02 13:33:29', '2020-11-02 13:33:29'),
(9, 3, 6, '2020-11-02 13:33:29', '2020-11-02 13:33:29'),
(10, 4, 1, '2020-11-02 13:34:32', '2020-11-02 13:34:32'),
(11, 4, 2, '2020-11-02 13:34:32', '2020-11-02 13:34:32'),
(12, 4, 5, '2020-11-02 13:34:32', '2020-11-02 13:34:32'),
(13, 4, 6, '2020-11-02 13:34:32', '2020-11-02 13:34:32'),
(14, 5, 1, '2020-11-02 13:35:06', '2020-11-02 13:35:06'),
(15, 5, 2, '2020-11-02 13:35:06', '2020-11-02 13:35:06'),
(16, 5, 5, '2020-11-02 13:35:06', '2020-11-02 13:35:06'),
(17, 5, 6, '2020-11-02 13:35:06', '2020-11-02 13:35:06'),
(22, 1, 1, '2020-11-03 09:06:23', '2020-11-03 09:06:23'),
(23, 1, 2, '2020-11-03 09:06:23', '2020-11-03 09:06:23'),
(24, 1, 5, '2020-11-03 09:06:23', '2020-11-03 09:06:23'),
(25, 1, 6, '2020-11-03 09:06:23', '2020-11-03 09:06:23');

-- --------------------------------------------------------

--
-- Table structure for table `product_associated_types`
--

CREATE TABLE `product_associated_types` (
  `id` int(11) NOT NULL,
  `type_title` varchar(50) NOT NULL,
  `associated_type` tinyint(3) NOT NULL COMMENT '1->concern type (Scalp conscern),2->condition type',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `id` int(11) NOT NULL,
  `product_image_url` text NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_image_url`, `product_id`, `created_at`, `updated_at`) VALUES
(1, 'https://m.media-amazon.com/images/I/61CyFZqroNL._AC_UL320_.jpg', 1, NULL, NULL),
(2, 'https://m.media-amazon.com/images/I/61CyFZqroNL._AC_UL320_.jpg', 1, NULL, NULL),
(3, 'https://m.media-amazon.com/images/I/61CyFZqroNL._AC_UL320_.jpg', 1, NULL, NULL),
(4, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/ezzgo89QIEpJM6lFWfccB1TdlbKDzAskODnizxB4.png', 4, '2020-11-02 13:34:33', '2020-11-02 13:34:33'),
(5, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/PRHhYV7kUUNR0gUECjm9N671mXoss71CFdBsFeZU.png', 4, '2020-11-02 13:34:34', '2020-11-02 13:34:34'),
(6, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/OBxoSrDPQXHMGRaXmEYOUeE60CdZNcR4wgfB46k1.png', 5, '2020-11-02 13:35:09', '2020-11-02 13:35:09'),
(7, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/GwLZAe7rVDtvwvVMlDDEsatsALvk5fPwMD7BbnTf.png', 5, '2020-11-02 13:35:10', '2020-11-02 13:35:10'),
(8, 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/rzrMPiFh7o1LYa2F3WxmT5cTu0zTJnj94ayWTUZo.png', 1, '2020-11-03 09:06:25', '2020-11-03 09:06:25');

-- --------------------------------------------------------

--
-- Table structure for table `promotion_videos`
--

CREATE TABLE `promotion_videos` (
  `id` int(1) NOT NULL,
  `video_title` text NOT NULL,
  `video_url` varchar(255) NOT NULL,
  `video_level` tinyint(3) NOT NULL,
  `play_before_ques_id` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `promotion_videos`
--

INSERT INTO `promotion_videos` (`id`, `video_title`, `video_url`, `video_level`, `play_before_ques_id`, `created_at`, `updated_at`) VALUES
(1, 'video 3 sss', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/Yrou7FVRtd0fZD6NdNsLfmrHL4itCnIfe2hhaqKl.mp4', 1, 0, '2020-11-12 18:26:15', '2021-01-30 21:27:19'),
(2, 'video 1 sss', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/tfSWcWwY4SW244EtpkU7xtiqwEDqTCnsNMIUuv1e.mp4', 2, 10, '2020-11-12 18:44:24', '2020-11-12 18:44:24'),
(3, 'video 3 sss', 'https://bridgette-hill.s3.us-east-2.amazonaws.com/Dev/GVQd9kCUFtqCAq6vYXGQfVWABnT6pvkFkRHB8Q7s.mp4', 3, 0, '2020-12-07 17:23:07', '2020-12-07 17:23:07');

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
  `pre_question_id` bigint(20) DEFAULT NULL,
  `next_question_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ques`
--

INSERT INTO `ques` (`id`, `ques_title`, `ques_option_type`, `ques_ordering_id`, `ques_parent_option_id`, `is_sub_question`, `is_first_question`, `is_last_question`, `ques_level`, `ques_status`, `is_use_existing_car`, `condition_type`, `gender_id`, `from_age_condition`, `to_age_condition`, `pre_question_id`, `next_question_id`, `created_at`, `updated_at`) VALUES
(1, 'Do you spend more than 25 hours a week in working in any of these occupations?', '1', 1, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, 1, '2021-01-18 14:11:42', '2021-01-18 15:13:20'),
(2, 'How long has your concern existed?', '1', 2, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, 2, '2021-01-18 14:18:30', '2021-01-18 15:13:20'),
(3, 'How would you describe the amount of hair shedding your experience?', '1', 3, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, 4, '2021-01-18 15:05:18', '2021-01-18 15:13:20'),
(4, 'How much time do you spend on scalp care?', '1', 4, 0, 0, NULL, 0, 1, 1, 0, NULL, NULL, '0', '0', NULL, 5, '2021-01-18 15:09:31', '2021-01-18 15:13:20'),
(5, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', '1', 5, 0, 0, NULL, 1, 1, 1, 0, NULL, NULL, '0', '0', NULL, NULL, '2021-01-18 15:13:20', '2021-01-18 15:13:20');

-- --------------------------------------------------------

--
-- Table structure for table `ques_answers_consultations`
--

CREATE TABLE `ques_answers_consultations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ques_id` bigint(20) NOT NULL,
  `option_id` bigint(20) NOT NULL,
  `ques_answers_comments` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `question_for_admin` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answer_for_admin` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_associated_type_id` int(11) DEFAULT 0,
  `consultant_id` bigint(20) NOT NULL,
  `ques_answer_status` tinyint(20) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ques_answers_consultations`
--

INSERT INTO `ques_answers_consultations` (`id`, `ques_id`, `option_id`, `ques_answers_comments`, `question_for_admin`, `answer_for_admin`, `product_associated_type_id`, `consultant_id`, `ques_answer_status`, `created_at`, `updated_at`) VALUES
(102, 1, 2, NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Business Professional', 0, 1, 1, '2020-12-07 16:28:04', '2020-12-07 16:28:04'),
(103, 2, 9, NULL, 'How long has your concern existed?', 'Recently', 0, 1, 1, '2020-12-07 16:46:30', '2020-12-07 16:46:30'),
(104, 3, 15, NULL, 'How would you describe the amount of hair shedding your experience?', 'Nominal to Mild', 0, 1, 1, '2020-12-07 16:48:07', '2020-12-07 16:48:07'),
(105, 4, 18, NULL, 'How much time do you spend on scalp care?', 'None at All', 0, 1, 1, '2020-12-07 16:49:22', '2020-12-07 16:49:22'),
(106, 5, 21, NULL, 'Have you had any hair or scalp diagnoses from a hair transplant surgeon, dermatologist specializing in scalp or hair?', 'Yes', 0, 1, 1, '2020-12-07 17:25:12', '2020-12-07 17:25:12'),
(109, 6, 25, NULL, 'What information are you hoping to leave with today?', 'Purchase Personalized Consultation', 0, 1, 1, '2020-12-07 19:32:26', '2020-12-07 19:32:26'),
(114, 8, 28, NULL, 'Select to continue for personalization consultation', 'Create a New Consultation Analysis Report (CAR)', 0, 1, 1, '2020-12-08 04:36:41', '2020-12-08 04:36:41'),
(115, 1, 1, NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 3, 1, '2020-12-11 07:23:26', '2020-12-11 07:23:26'),
(116, 1, 1, NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 4, 1, '2020-12-11 07:23:40', '2020-12-11 07:23:40'),
(117, 1, 1, NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 5, 1, '2020-12-11 12:23:29', '2020-12-11 12:23:29'),
(118, 1, 1, NULL, 'Do you spend more than 25 hours a week in working in any of these occupations?', 'Athlete', 0, 6, 1, '2020-12-21 07:33:30', '2020-12-21 07:33:30'),
(119, 2, 9, NULL, 'How long has your concern existed?', 'Recently', 0, 6, 1, '2020-12-21 07:41:23', '2020-12-21 07:41:23');

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
(1, 'Athlete', 1, 1, 12, NULL, NULL, '0', 0, 0, 5, '2021-01-18 14:11:42', '2021-01-20 09:03:37'),
(2, 'Construction', 1, 1, 12, NULL, NULL, '0', 0, 0, 5, '2021-01-18 14:11:42', '2021-01-18 14:11:42'),
(3, 'Landscaping', 1, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 14:11:42', '2021-01-18 14:11:42'),
(4, 'Business Professional', 1, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 14:11:42', '2021-01-18 14:11:42'),
(5, 'Medical', 1, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 14:11:42', '2021-01-18 14:11:42'),
(6, 'Public Figure', 1, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 14:11:42', '2021-01-18 14:11:42'),
(7, 'Recently', 2, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 14:18:30', '2021-01-18 14:18:30'),
(8, '0-6 Months', 2, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 14:18:30', '2021-01-18 14:18:30'),
(9, '6-18 Months', 2, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 14:18:30', '2021-01-18 14:18:30'),
(10, 'Over 2 Years', 2, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 14:18:30', '2021-01-18 14:18:30'),
(11, 'Decades', 2, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 14:18:30', '2021-01-18 14:18:30'),
(12, 'Nominal', 3, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 15:05:18', '2021-01-18 15:05:18'),
(13, 'Nominal to Mild', 3, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 15:05:18', '2021-01-18 15:05:18'),
(14, 'Occasionally More Than Nominal to Mild', 3, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 15:05:18', '2021-01-18 15:05:18'),
(15, 'Over 2 Years', 3, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 15:05:18', '2021-01-18 15:05:18'),
(16, 'Excessive', 3, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 15:05:18', '2021-01-18 15:05:18'),
(17, 'None at All', 4, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 15:09:31', '2021-01-18 15:09:31'),
(18, '1-3 Times a Month', 4, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 15:09:31', '2021-01-18 15:09:31'),
(19, 'Weekly', 4, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 15:09:31', '2021-01-18 15:09:31'),
(20, 'Yes', 5, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 15:13:20', '2021-01-18 15:13:20'),
(21, 'No', 5, 1, NULL, NULL, NULL, '0', 0, 0, 5, '2021-01-18 15:13:20', '2021-01-18 15:13:20');

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
  `id` int(11) NOT NULL,
  `page_title` varchar(255) NOT NULL,
  `page_content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `static_pages`
--

INSERT INTO `static_pages` (`id`, `page_title`, `page_content`, `created_at`, `updated_at`) VALUES
(1, 'Information (Marketing)', '', NULL, NULL),
(2, 'hello page 2', 'hello page 2', '2020-11-17 10:42:18', '2020-11-17 10:42:18'),
(3, 'hello page 2', 'hello page 2', '2020-11-17 11:09:40', '2020-11-17 11:09:40'),
(4, 'hello page 2', 'hello page 2', '2020-11-17 11:10:41', '2020-11-17 11:10:41'),
(5, 'hello page 2', 'hello page 2', '2020-11-17 11:15:59', '2020-11-17 11:15:59'),
(6, 'hello page 2', 'hello page 2', '2020-11-17 11:16:18', '2020-11-17 11:16:18'),
(7, 'hello page 2', 'hello page 2', '2020-11-17 11:16:31', '2020-11-17 11:16:31'),
(9, 'Test Content', '<h2>Testing Content Header</h2>', '2021-01-08 18:30:00', NULL),
(10, 'Prevention', '</h2>Prevention</h2>', '2021-01-08 18:30:00', NULL),
(12, 'hello page 2', 'hello page 2', '2021-01-20 09:03:37', '2021-01-20 09:03:37');

-- --------------------------------------------------------

--
-- Table structure for table `static_page_linking`
--

CREATE TABLE `static_page_linking` (
  `id` int(11) NOT NULL,
  `static_page_id` int(11) NOT NULL,
  `option_id` varchar(10) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `static_page_linking`
--

INSERT INTO `static_page_linking` (`id`, `static_page_id`, `option_id`, `question_id`, `created_at`, `updated_at`) VALUES
(1, 1, '23', NULL, NULL, '2020-11-17 08:31:20'),
(2, 1, '4', NULL, NULL, '2020-11-17 08:31:20'),
(3, 1, NULL, 1, NULL, '2020-11-17 08:31:20'),
(4, 3, NULL, NULL, '2020-11-17 11:09:40', '2020-11-17 11:09:40'),
(5, 3, NULL, NULL, '2020-11-17 11:09:40', '2020-11-17 11:09:40'),
(6, 3, NULL, NULL, '2020-11-17 11:09:40', '2020-11-17 11:09:40'),
(10, 1, '23', 6, '2021-01-08 18:30:00', NULL),
(11, 2, '31', 12, '2021-01-08 18:30:00', NULL),
(13, 12, '1,2', 1, '2021-01-20 09:03:37', '2021-01-20 09:03:37');

-- --------------------------------------------------------

--
-- Table structure for table `themes`
--

CREATE TABLE `themes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `theme_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `header_card_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bottom_nav_background_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bottom_nav_text_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `themes_details`
--

CREATE TABLE `themes_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `theme_id` int(11) NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `profile_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0->incomplete,1->profile complete,2->blocked',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fname`, `lname`, `email`, `ethinicity`, `gender`, `mobile_number`, `address`, `state`, `country`, `zip_code`, `password_reset_token`, `email_verified_at`, `password`, `date_of_birth`, `profile_image`, `signup_type`, `social_media_id`, `profile_status`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'shubham', 'agnihohtrisss', 'shubham.agnihotri356@gmail.com', 'ssss', 'm', NULL, 'sasdasdsd', '6', '231', '332332', NULL, NULL, '$2y$10$tFksspGyC5RtlgWy049.dOl9aj1.Rw6wEjpcBYt545Lzmz3p3tjfi', '1995-11-10', 'https://image.shutterstock.com/image-vector/vector-simple-male-profile-icon-260nw-1388357696.jpg', 0, NULL, 1, NULL, '2020-10-22 10:10:30', '2020-11-02 11:57:20'),
(2, 'shubham', 'agnihohtrisss', 'shubham.agnihotri35@gmail.com', 'ssss', 'm', NULL, 'sasdasdsd', '6', '231', '332332', NULL, NULL, '$2y$10$tFksspGyC5RtlgWy049.dOl9aj1.Rw6wEjpcBYt545Lzmz3p3tjfi', '1995-11-10', 'https://image.shutterstock.com/image-vector/vector-simple-male-profile-icon-260nw-1388357696.jpg', 0, NULL, 1, NULL, '2020-10-22 10:10:30', '2020-11-02 11:57:20');

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
(2, 2, 2, NULL, NULL);

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
(1, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9nZW5lcmF0ZV9wYXNzd29yZCIsImlhdCI6MTYwMzM2MTQzMCwiZXhwIjoxNjAzMzY1MDMwLCJuYmYiOjE2MDMzNjE0MzAsImp0aSI6IkI0aWZFNnZTRDBPdkNHUloiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.65QkK8g9hr1ZdA8DdG3RyN_7WURbwZADg_sNZN-8_dM', NULL, NULL),
(2, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYwMzM2OTIzOSwiZXhwIjoxNjAzMzcyODM5LCJuYmYiOjE2MDMzNjkyMzksImp0aSI6Ik95NW9lV1ZpT211c0s0bWYiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.0wExHAA0t1vwZ6sQ33H-hSwlIWyf3mygzRHtpNMEIro', NULL, NULL),
(3, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYwMzM3NTE0NiwibmJmIjoxNjAzMzc1MTQ2LCJqdGkiOiJXZzY2ZEp6QXBnQWFEUUUwIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.fBSDKmltRbSGy7mBRWpAlyDvct-FOhRPhUpaP5D_Rww', NULL, NULL),
(5, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYwNzM0MDk3MCwibmJmIjoxNjA3MzQwOTcwLCJqdGkiOiJZUGxvTjRHTzJOVGVyZ0pJIiwic3ViIjoxLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.MZqWVwgsqYG0S-2y4e5NhvQao90vh1vdbatIzZgU1KM', NULL, NULL),
(6, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hZG1pblwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTIwODU3OTMsIm5iZiI6MTYxMjA4NTc5MywianRpIjoiRUhONE84dzFjT2luWkhWaiIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.CnGz6HsKPjuilc-NZ1-_pK0QFsT33eMlNxIx8z5R1lI', NULL, NULL),
(7, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hZG1pblwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTIwODU4MDcsIm5iZiI6MTYxMjA4NTgwNywianRpIjoiUldhTUdhcUR5UnFaZkJCSSIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.uQbZmf1ZwQPaHOAFhSXjHLbBFQBlQcpqP8Ud1uENCYo', NULL, NULL),
(8, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hZG1pblwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTIwODU5MDUsIm5iZiI6MTYxMjA4NTkwNSwianRpIjoiVVpwMjllOVhobFRUNkxXcyIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.1xbnVc3-ljnpZO-R4B7wF7kETyIhFm8koTQdMfRIRSU', NULL, NULL),
(9, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hZG1pblwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTIwODU5NTUsIm5iZiI6MTYxMjA4NTk1NSwianRpIjoicHFlN0p1VGZQcVYweWh5bCIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9._EApgqrW3uXWRFfiyvfWDkEWhxVE_HKuwV8lfxT-MGQ', NULL, NULL),
(10, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hZG1pblwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTIwODU5OTUsIm5iZiI6MTYxMjA4NTk5NSwianRpIjoiTGRkS09CbUx0bDBOZVVLUiIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.syQVGHf7JPp-nr6IVl_kf4ggGIIj-nVal_Q5pPIaCUA', NULL, NULL),
(11, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL2JyaWRnZXR0ZV9oaWxsXC9hcGlcL3YxXC9hZG1pblwvYXV0aFwvbG9naW4iLCJpYXQiOjE2MTIwODY1NjYsIm5iZiI6MTYxMjA4NjU2NiwianRpIjoiMG4yaXZmb0JmWVpsV2hudSIsInN1YiI6MSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.WfWUnjAvtpiS7DGOE-KDcNEupmzG-dgPvmZYNXnsixU', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `webview_urls`
--

CREATE TABLE `webview_urls` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `service_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `view_type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1=web view,2=sonabank app,3=installed native default app',
  `service_description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `android_url` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ios_url` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `page_number` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1=Home,2=Product,3=installed native default app',
  `button_content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) NOT NULL COMMENT '0=>parent,id =>actual id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `webview_urls`
--

INSERT INTO `webview_urls` (`id`, `service_title`, `service_type`, `view_type`, `service_description`, `android_url`, `ios_url`, `status`, `page_number`, `button_content`, `logo`, `parent_id`, `created_at`, `updated_at`) VALUES
(1, 'Open an account', 'open_account', 1, '', 'https://uopen.umonitor.com/uopen/nao/showWelcome.do;jsessionid=B0C3433CA25BB546F61909F74D2A76AE', 'https://uopen.umonitor.com/uopen/nao/showWelcome.do;jsessionid=B0C3433CA25BB546F61909F74D2A76AE', 1, 1, '', 'Vectoraccount.png', 0, NULL, NULL),
(2, 'Earn Money', 'earn_money', 1, '', 'https://uopen.umonitor.com/uopen/nao/welcome.do?auth=108e1cda8851eebb&bid=b2cb2d2809deef59', 'https://uopen.umonitor.com/uopen/nao/welcome.do?auth=108e1cda8851eebb&bid=b2cb2d2809deef59', 1, 1, '', 'Vectorearn_money.png', 0, NULL, NULL),
(3, 'Get Money', 'get_money', 1, '', 'https://umnasg7.umonitor.com/consumerloan/uLoan/welcome.do?auth=43834a129c00ded9', 'https://umnasg7.umonitor.com/consumerloan/uLoan/welcome.do?auth=43834a129c00ded9', 1, 1, '', 'Vectormoney.png', 0, NULL, NULL),
(4, 'Go to online banking', 'online_banking', 1, '', 'https://apps.apple.com/us/app/sonabank-mobile-banking/id725728307', 'https://apps.apple.com/us/app/sonabank-mobile-banking/id725728307', 1, 1, '', 'Vectoronline_banking.png', 0, NULL, NULL),
(5, 'Find an ATM', 'find_atm', 1, '', '', '', 1, 1, '', 'Vectoratm.png', 0, NULL, NULL),
(6, 'Recorder Checks', 'recorder_checks', 1, '', 'https://www.ordermychecks.com/login_a.jsp?cid=harlandclarkesite', 'https://www.ordermychecks.com/login_a.jsp?cid=harlandclarkesite', 1, 1, '', 'Vectorecords_checks.png', 0, NULL, NULL),
(7, 'What we pay', 'what_we_pay', 1, '', 'https://www.sonabank.com/_/kcms-doc/680/46433/deposit-rate-schedule.pdf', 'https://www.sonabank.com/_/kcms-doc/680/46433/deposit-rate-schedule.pdf', 1, 1, '', 'Vectorwhat_we_pay.png', 0, NULL, NULL),
(8, 'What we charge', 'what_we_charge', 1, '', 'https://www.sonabank.com/_/kcms-doc/680/46462/Sonabank-Consumer-Fee-Schedule.pdf', 'https://www.sonabank.com/_/kcms-doc/680/46462/Sonabank-Consumer-Fee-Schedule.pdf', 1, 1, '', 'Vectorwhat_we_charge.png', 0, NULL, NULL),
(9, 'Checking with the Works', 'checking_works', 1, 'Free Checking  with maximum benefits and no hassle\"No Overdraft Fees \"Free ATM Use Nationwide', 'https://www.sonabank.com/personal/personal-checking/checking-with-the-works.html', 'https://www.sonabank.com/personal/personal-checking/checking-with-the-works.html', 1, 2, 'Learn More', '', 0, NULL, NULL),
(10, 'Free Checking', 'free_checking', 1, 'No monthly service fee\"No minimum balance requirement\"Unlimited check writing', 'https://www.sonabank.com/personal/personal-checking/free-checking.html', 'https://www.sonabank.com/personal/personal-checking/free-checking.html', 1, 2, 'Learn More', '', 0, NULL, NULL),
(11, 'Sona Gold Checking', 'sona_gold_checking', 1, 'Exclusive to customers age 50 or better\"Earn competitive, tiered interest\"Unlimited check writing', 'https://www.sonabank.com/personal/personal-checking/premier-club-senior-checking.html', 'https://www.sonabank.com/personal/personal-checking/premier-club-senior-checking.html', 1, 2, 'Learn More', '', 0, NULL, NULL),
(12, 'V.I.P. Checking', 'vip_checking', 1, 'Available to our V.I.P customers\"Get the high interest-earning checking and value-added perks you deserve\"Complimentary extras including notary services, deposit boxes, checks & stop payments', 'https://www.sonabank.com/personal/personal-checking/vip-checking.html', 'https://www.sonabank.com/personal/personal-checking/vip-checking.html', 1, 2, 'Learn More', '', 0, NULL, NULL),
(13, 'Kasasa Cash', 'kasasa_cash', 1, 'Free checking that pays you high interest\"Refunds on ATM withdrawal fees, nationwide*\"No minimum balance requirement', 'https://www.sonabank.com/personal/personal-checking/free-checking-kasasa-cash.html', 'https://www.sonabank.com/personal/personal-checking/free-checking-kasasa-cash.html', 1, 2, 'Learn More', '', 0, NULL, NULL),
(14, 'Kasasa Cash Back', 'kasasa_cash_back', 1, 'Free checking that pays you high interest\"Refunds on ATM withdrawal fees, nationwide*\"No minimum balance requirement', 'https://www.sonabank.com/personal/personal-checking/free-checking-kasasa-cash-back.html', 'https://www.sonabank.com/personal/personal-checking/free-checking-kasasa-cash-back.html', 1, 2, 'Learn More', '', 0, NULL, NULL),
(15, 'Kasasa Tunes', 'kasasa_tunes', 1, 'Free checking that pays you to shop online\"Earn refunds for iTunes®, Amazon®, or Google Play™\"purchases every month*\"Refunds on ATM withdrawal fees, nationwide*', 'https://www.sonabank.com/personal/personal-checking/free-checking-kasasa-tunes.html', 'https://www.sonabank.com/personal/personal-checking/free-checking-kasasa-tunes.html', 1, 2, 'Learn More', '', 0, NULL, NULL);

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
-- Indexes for table `form_details`
--
ALTER TABLE `form_details`
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
-- Indexes for table `themes`
--
ALTER TABLE `themes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `themes_details`
--
ALTER TABLE `themes_details`
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
-- Indexes for table `webview_urls`
--
ALTER TABLE `webview_urls`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_appointments`
--
ALTER TABLE `admin_appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `appointment_prices`
--
ALTER TABLE `appointment_prices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `consultations`
--
ALTER TABLE `consultations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `consultation_notes`
--
ALTER TABLE `consultation_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `consultation_products`
--
ALTER TABLE `consultation_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `form_details`
--
ALTER TABLE `form_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `otps`
--
ALTER TABLE `otps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_associated_concern_mapping`
--
ALTER TABLE `product_associated_concern_mapping`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `promotion_videos`
--
ALTER TABLE `promotion_videos`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ques`
--
ALTER TABLE `ques`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ques_answers_consultations`
--
ALTER TABLE `ques_answers_consultations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `ques_conditions`
--
ALTER TABLE `ques_conditions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ques_options`
--
ALTER TABLE `ques_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `static_pages`
--
ALTER TABLE `static_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `static_page_linking`
--
ALTER TABLE `static_page_linking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `themes`
--
ALTER TABLE `themes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `themes_details`
--
ALTER TABLE `themes_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `webview_urls`
--
ALTER TABLE `webview_urls`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
