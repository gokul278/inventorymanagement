-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 13, 2023 at 09:23 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventorymanager`
--

-- --------------------------------------------------------

--
-- Table structure for table `bill_table`
--

CREATE TABLE `bill_table` (
  `bill_id` int(11) NOT NULL,
  `bill_identity` varchar(50) NOT NULL,
  `bill_date` varchar(50) NOT NULL,
  `product_id` varchar(50) NOT NULL,
  `bill_quantity` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `bill_table`
--

INSERT INTO `bill_table` (`bill_id`, `bill_identity`, `bill_date`, `product_id`, `bill_quantity`) VALUES
(36, '8000', '05/11/2023', '6785', '1'),
(37, '8000', '05/11/2023', '8368', '5'),
(38, '8001', '05/11/2023', '8368', '5'),
(39, '8001', '05/11/2023', '6785', '4'),
(40, '8002', '05/11/2023', '8368', '5'),
(41, '8002', '05/11/2023', '6785', '1'),
(42, '8003', '06/11/2023', '8368', '1'),
(43, '8003', '06/11/2023', '6785', '1'),
(44, '8003', '06/11/2023', '8345', '1'),
(45, '8004', '08/11/2023', '8365', '1'),
(46, '8004', '08/11/2023', '8345', '4'),
(47, '8005', '13/11/2023', '8345', '2'),
(48, '8005', '13/11/2023', '6785', '3'),
(49, '8006', '13/11/2023', '6785', '1'),
(50, '8006', '13/11/2023', '8345', '1'),
(51, '8006', '13/11/2023', '8365', '1'),
(52, '8006', '13/11/2023', '8368', '1');

-- --------------------------------------------------------

--
-- Table structure for table `product_table`
--

CREATE TABLE `product_table` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_cost` varchar(50) NOT NULL,
  `product_quantity` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `product_table`
--

INSERT INTO `product_table` (`product_id`, `product_name`, `product_cost`, `product_quantity`) VALUES
(6785, 'Milk', '30', '4'),
(8345, 'Egg', '5', '2'),
(8365, 'Bread', '40', '3'),
(8368, 'Rice', '50', '1');

-- --------------------------------------------------------

--
-- Table structure for table `user_table`
--

CREATE TABLE `user_table` (
  `user_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user_table`
--

INSERT INTO `user_table` (`user_id`, `name`, `username`, `password`) VALUES
(1, 'GOKUL', 'gokulhk278@gmail.com', 'Fox22558');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bill_table`
--
ALTER TABLE `bill_table`
  ADD PRIMARY KEY (`bill_id`);

--
-- Indexes for table `product_table`
--
ALTER TABLE `product_table`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `user_table`
--
ALTER TABLE `user_table`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bill_table`
--
ALTER TABLE `bill_table`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `product_table`
--
ALTER TABLE `product_table`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8369;

--
-- AUTO_INCREMENT for table `user_table`
--
ALTER TABLE `user_table`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
