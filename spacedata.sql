-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 24, 2018 at 10:46 PM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `spacetracker`
--

--
-- Dumping data for table `institution`
--

INSERT INTO `institution` (`institutionID`, `fullInstitutionName`, `launchProvider`, `government`, `abbreviatedName`, `employees`, `description`, `founded`) VALUES
(1, 'Space Exploration Technologies Corp', b'1', b'0', 'SpaceX', 7000, 'A space company', 2002),
(2, 'National Aeronautics and Space Administration', b'1', b'1', 'NASA', 17000, 'US Space Agency', 1958);

--
-- Dumping data for table `vehiclefamily`
--

INSERT INTO `vehiclefamily` (`vehicleFamilyID`, `name`, `block`, `description`, `version`, `institutionID`) VALUES
(1, 'Falcon 1', 1, 'First rocket developed and launched by SpaceX', 1, 1),
(2, 'Falcon 9', 1, NULL, NULL, 1),
(3, 'Falcon 9', 2, NULL, NULL, 1),
(4, 'Falcon 9', 3, NULL, NULL, 1),
(5, 'Falcon 9', 4, NULL, NULL, 1),
(6, 'Falcon 9', 5, NULL, NULL, 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
