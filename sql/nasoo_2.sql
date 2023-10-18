-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 08, 2022 at 12:06 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nasoo_2`
--

-- --------------------------------------------------------

--
-- Table structure for table `backup`
--

CREATE TABLE `backup` (
  `id` int(11) NOT NULL,
  `fname` varchar(100) NOT NULL,
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `userid` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` int(2) NOT NULL,
  `bname` varchar(50) NOT NULL,
  `bloc` varchar(100) DEFAULT '',
  `status` varchar(10) DEFAULT '',
  `email` varchar(100) DEFAULT '',
  `contact` varchar(100) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cart_temp`
--

CREATE TABLE `cart_temp` (
  `id` int(11) NOT NULL,
  `sid` varchar(30) NOT NULL,
  `pid` varchar(30) NOT NULL DEFAULT '',
  `qty` int(3) DEFAULT 0,
  `status` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `cname` varchar(50) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `id` int(1) NOT NULL,
  `cname` varchar(100) NOT NULL DEFAULT '',
  `ccont` varchar(50) NOT NULL DEFAULT '',
  `cmail` varchar(50) NOT NULL DEFAULT '',
  `cloc` varchar(100) NOT NULL DEFAULT '',
  `caddr` varchar(200) NOT NULL DEFAULT '',
  `clogo` varchar(200) NOT NULL DEFAULT '',
  `tag` varchar(200) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `cid` varchar(50) NOT NULL,
  `cname` varchar(100) NOT NULL DEFAULT '',
  `contact` varchar(20) NOT NULL DEFAULT '',
  `location` varchar(50) NOT NULL DEFAULT '',
  `shop` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customer_invoice`
--

CREATE TABLE `customer_invoice` (
  `id` int(11) NOT NULL,
  `invoiceid` varchar(30) NOT NULL,
  `custname` varchar(100) NOT NULL DEFAULT '',
  `cont` varchar(50) NOT NULL DEFAULT '',
  `invdate` date DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `salesperson` varchar(30) NOT NULL DEFAULT '',
  `totalamount` decimal(10,2) DEFAULT 0.00,
  `totaltax` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid` decimal(10,2) DEFAULT 0.00,
  `status` varchar(20) NOT NULL DEFAULT '',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `shop` varchar(50) DEFAULT '',
  `organ` varchar(50) NOT NULL DEFAULT '',
  `orgcont` varchar(50) NOT NULL DEFAULT '',
  `orgloc` varchar(100) NOT NULL DEFAULT '',
  `orgtype` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customer_quotation`
--

CREATE TABLE `customer_quotation` (
  `id` int(11) NOT NULL,
  `invoiceid` varchar(30) NOT NULL,
  `custname` varchar(100) NOT NULL DEFAULT '',
  `cont` varchar(50) NOT NULL DEFAULT '',
  `invdate` date DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `salesperson` varchar(30) NOT NULL DEFAULT '',
  `totalamount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` varchar(20) NOT NULL DEFAULT '',
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `shop` varchar(50) NOT NULL DEFAULT '',
  `organ` varchar(50) NOT NULL DEFAULT '',
  `orgcont` varchar(50) NOT NULL DEFAULT '',
  `orgloc` varchar(100) NOT NULL DEFAULT '',
  `orgtype` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cust_login`
--

CREATE TABLE `cust_login` (
  `id` int(11) NOT NULL,
  `custname` varchar(200) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL,
  `pword` varchar(500) NOT NULL DEFAULT '',
  `contact` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_details`
--

CREATE TABLE `invoice_details` (
  `id` int(11) NOT NULL,
  `invoiceid` varchar(30) NOT NULL DEFAULT '',
  `pid` varchar(30) NOT NULL DEFAULT '',
  `qty` int(5) NOT NULL DEFAULT 0,
  `sprice` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_payment`
--

CREATE TABLE `invoice_payment` (
  `id` int(11) NOT NULL,
  `invoiceid` varchar(50) NOT NULL DEFAULT '',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paydate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_tax`
--

CREATE TABLE `invoice_tax` (
  `id` int(11) NOT NULL,
  `invid` varchar(100) NOT NULL,
  `taxid` varchar(10) NOT NULL,
  `dval` decimal(10,2) NOT NULL,
  `damount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `inv_temp`
--

CREATE TABLE `inv_temp` (
  `id` int(11) NOT NULL,
  `pid` varchar(50) NOT NULL DEFAULT '',
  `userid` varchar(20) NOT NULL DEFAULT '',
  `sid` varchar(50) NOT NULL DEFAULT '',
  `qty` int(5) NOT NULL DEFAULT 0,
  `shop` varchar(50) NOT NULL DEFAULT '',
  `sprice` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cprice` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `memo`
--

CREATE TABLE `memo` (
  `id` int(11) NOT NULL,
  `userid` varchar(50) NOT NULL DEFAULT '',
  `usr` varchar(20) NOT NULL DEFAULT '',
  `title` varchar(100) NOT NULL DEFAULT '',
  `msg` varchar(300) NOT NULL DEFAULT '',
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(10) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `id` int(4) NOT NULL,
  `userid` varchar(50) NOT NULL DEFAULT '',
  `message` text NOT NULL DEFAULT '',
  `caption` varchar(200) NOT NULL DEFAULT '',
  `status` varchar(10) NOT NULL DEFAULT '',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `enddate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `ordernum` varchar(50) NOT NULL,
  `totalamount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `userid` varchar(50) NOT NULL DEFAULT '',
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(10) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pos_payment`
--

CREATE TABLE `pos_payment` (
  `id` int(11) NOT NULL,
  `sid` varchar(50) NOT NULL,
  `tend` decimal(10,2) NOT NULL DEFAULT 0.00,
  `dtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `dbal` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pos_sales`
--

CREATE TABLE `pos_sales` (
  `id` int(11) NOT NULL,
  `pid` varchar(50) NOT NULL DEFAULT '',
  `cid` varchar(50) NOT NULL DEFAULT '',
  `userid` varchar(20) NOT NULL DEFAULT '',
  `sid` varchar(50) NOT NULL DEFAULT '',
  `qty` int(5) NOT NULL DEFAULT 0,
  `shop` varchar(50) NOT NULL DEFAULT '',
  `sales_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `cprice` decimal(10,2) NOT NULL DEFAULT 0.00,
  `sprice` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pos_tax`
--

CREATE TABLE `pos_tax` (
  `id` int(11) NOT NULL,
  `sid` varchar(100) NOT NULL,
  `taxid` varchar(10) NOT NULL,
  `dval` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pos_temp`
--

CREATE TABLE `pos_temp` (
  `id` int(11) NOT NULL,
  `pid` varchar(50) NOT NULL DEFAULT '',
  `userid` varchar(20) NOT NULL DEFAULT '',
  `sid` varchar(50) NOT NULL DEFAULT '',
  `qty` int(5) NOT NULL DEFAULT 0,
  `shop` varchar(50) NOT NULL DEFAULT '',
  `sprice` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cprice` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `pid` varchar(50) NOT NULL DEFAULT '',
  `qty` int(4) NOT NULL DEFAULT 0,
  `status` varchar(10) NOT NULL DEFAULT '',
  `shop` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `products_master`
--

CREATE TABLE `products_master` (
  `id` int(11) NOT NULL,
  `pid` varchar(50) NOT NULL DEFAULT '',
  `barcode` varchar(50) NOT NULL DEFAULT '',
  `pname` varchar(100) NOT NULL DEFAULT '',
  `sprice` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cprice` decimal(10,2) NOT NULL DEFAULT 0.00,
  `qty` int(4) NOT NULL DEFAULT 0,
  `cat` varchar(10) NOT NULL DEFAULT '',
  `pimg` varchar(100) NOT NULL DEFAULT '',
  `status` varchar(10) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products_master`
--

INSERT INTO `products_master` (`id`, `pid`, `barcode`, `pname`, `sprice`, `cprice`, `qty`, `cat`, `pimg`, `status`) VALUES
(1, '202210280001', '', ' (OMEGA)', '104.72', '80.80', 60, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2, '202210280002', '', ' CHINESE ROBB OINTMENT ESSENTIAL (JAR) 3ML S/S', '12.31', '9.09', 221, '4', 'assets/data/products/noimage.png', 'ACTIVE'),
(3, '202210280003', '', ' EVENING PRIMROSE  (H/AID)', '84.21', '62.18', 3, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(4, '202210280004', '', ' Gliclazide ( modified- Release)30mg14s', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(5, '202210280005', '', ' HIMALAYA PILEX TAB 100S', '64.44', '46.63', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(6, '202210280006', '', ' Himalaya Speman Tab', '76.45', '56.45', 2, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(7, '202210280007', '', ' Joy Vikil 20 Immune Booster ', '48.26', '36.00', 52, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(8, '202210280008', '', ' lH Ovulation Test Kit ( Acro)', '12.31', '9.09', 128, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(9, '202210280009', '', ' NIVEA LOTION NOURISHING COCOA (BROWN) 400ML', '45.21', '24.54', 7, '2', 'assets/data/products/noimage.png', 'ACTIVE'),
(10, '202210280010', '', ' SUDO CREAM 250GM', '65.41', '48.27', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(11, '202210280011', '', ' Vitamin C tab Ascorbin', '3.08', '2.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(12, '202210280012', '', '21st Century Collagen plus C', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(13, '202210280013', '', '3cp Antiseptic Solution 100ml', '20.93', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(14, '202210280014', '', '3CP ANTISEPTIC SOLUTION 200ML', '51.11', '32.72', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(15, '202210280015', '', '3Fer Syrup', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(16, '202210280016', '', '5D (Glucose Infusion) 500ml', '11.08', '8.18', 35, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(17, '202210280017', '', '747 Joint Support', '34.47', '25.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(18, '202210280018', '', 'ABIDEC MULTI VIT SYRUP', '96.24', '71.05', 31, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(19, '202210280019', '', 'Abidec Multivitamins Drops 25ml', '99.73', '73.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(20, '202210280020', '', 'ABONIKI BALM', '8.08', '5.45', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(21, '202210280021', '', ' COTTON WOOL 100G (HOPELINE/UNION)', '5.70', '3.64', 46, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(22, '202210280022', '', ' COTTON WOOL 200G(ALL)', '24.69', '15.45', 32, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(23, '202210280023', '', 'COTTON WOOL 25G (EASYCARE)', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(24, '202210280024', '', 'Absorbent Cotton Wool 500g(Union/Easycare) 500ml', '55.41', '40.91', 14, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(25, '202210280025', '', ' COTTON WOOL 50G (UNION/EASYCARE)', '9.85', '5.45', 73, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(26, '202210280026', '', 'Abyvita Capsules', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(27, '202210280027', '', 'Accurate Cassette One Step Test30/pck (all)', '4.92', '3.64', 180, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(28, '202210280028', '', 'Aciclovir (Ranbaxy) 200mg Tabs 5s 5/pck', '9.85', '7.27', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(29, '202210280029', '', 'Aciclovir 200mg 1s (Accord)', '2.45', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(30, '202210280030', '', 'Aciclovir 200mg 1s (Exeter)', '2.22', '1.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(31, '202210280031', '', 'Aciclovir 400mg(ranbaxy)14s 4/pck', '24.62', '18.18', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(32, '202210280032', '', 'Aciclovir Cream 5 percent 10g', '99.77', '84.14', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(33, '202210280033', '', 'Acidom (Omeprazole) Caps 10s 2/pck', '19.71', '14.54', 36, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(34, '202210280034', '', 'Acne Soap', '30.77', '22.73', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(35, '202210280035', '', 'ACTIFED 60MG TAB 12S(YELLOW)', '36.56', '27.00', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(36, '202210280036', '', 'Actifed Cold syrp 100ML  UK', '47.64', '35.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(37, '202210280037', '', 'Actifed Dry cough & cold syrp (Yellow) 100ML', '72.02', '53.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(38, '202210280038', '', 'Actifed Dry Cough Multi Action Syr. (Red)', '84.21', '62.18', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(39, '202210280039', '', 'Actifed Multi-Action Tab.', '84.21', '62.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(40, '202210280040', '', 'Actifed Wet cough & cold  syrp (Yellow) 200ML', '61.83', '45.65', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(41, '202210280041', '', 'Actilife multivit tab', '25.87', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(42, '202210280042', '', 'Activated Charcoal 10s', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(43, '202210280043', '', 'Activated Charcoal Mouth Wash', '32.01', '23.63', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(44, '202210280044', '', 'Actrapid HM 100iu', '48.21', '35.59', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(45, '202210280045', '', 'Acyclovir Denk 200mg Tabs 5s', '11.70', '8.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(46, '202210280046', '', 'Adalat LA 60MG 10S', '54.85', '40.50', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(47, '202210280047', '', 'Adams Secret 1s', '34.47', '25.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(48, '202210280048', '', 'Addyzoa Tab-20', '92.29', '68.14', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(49, '202210280049', '', 'Adom Koo Cap 30s', '34.47', '25.45', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(50, '202210280050', '', 'Adom Koo Mixture', '23.21', '11.82', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(51, '202210280051', '', 'Adom Natural Man ', '30.77', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(52, '202210280052', '', 'Adom W&G Capsules', '22.78', '16.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(53, '202210280053', '', 'Adult Daipers ( Comfery) Large', '124.34', '91.81', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(54, '202210280054', '', 'Adult Daipers ( Comfery) Medium', '124.34', '91.81', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(55, '202210280055', '', 'Adult Daipers (Icona) All', '113.25', '83.63', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(56, '202210280056', '', 'Adult Diapers (Rapper) 1s', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(57, '202210280057', '', 'ADVANTAN (METHYLPREDNISOLONE) CREAM 15G', '47.64', '35.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(58, '202210280058', '', 'Advantan (Methylprednisolone) Cream 30g', '98.62', '72.81', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(59, '202210280059', '', 'Advil PM 20s', '77.57', '57.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(60, '202210280060', '', 'Advil PM Sach. 2s', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(61, '202210280061', '', 'Advil Tab. 24s', '97.64', '55.45', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(62, '202210280062', '', 'Advil Tabs 2s', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(63, '202210280063', '', 'Aerius 150ml (MSD)', '97.52', '71.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(64, '202210280064', '', 'Aerius 5mg 1s', '9.85', '7.27', 50, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(65, '202210280065', '', 'AERIUS SYR. 60ML', '68.40', '42.54', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(66, '202210280066', '', 'AEROBIC OXYGEN 60ML', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(67, '202210280067', '', 'Agbeve Tonic 330ml', '16.01', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(68, '202210280068', '', 'Ajanta Stamina', '63.41', '46.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(69, '202210280069', '', 'Alafia Bitters', '11.08', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(70, '202210280070', '', 'Alcohol  (Barbers choice))', '24.62', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(71, '202210280071', '', 'Alcohol 500ml (Phersons)', '22.78', '16.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(72, '202210280072', '', 'ALDOMET (METHYLDOPA) 250MG 10S 6/PCK', '26.12', '27.27', 120, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(73, '202210280073', '', 'AldometMethyldopa 500mg Aspen(10s 3/pck)', '62.05', '50.90', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(74, '202210280074', '', 'Alka 5 Syr. 100ml', '68.70', '50.72', 38, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(75, '202210280075', '', 'Alka Seltzer Aspirin 2s 20/pck', '9.85', '7.27', 310, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(76, '202210280076', '', 'Allere Eye Drops', '19.71', '14.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(77, '202210280077', '', 'Allopurinol 300mg UK', '32.01', '23.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(78, '202210280078', '', 'Allopurinol Tab 100mg (Crescent) 14s', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(79, '202210280079', '', 'Alpha Garlic Odourless Cap', '28.32', '20.91', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(80, '202210280080', '', 'Alpha Omega 3.6.9 (BN)', '32.01', '23.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(81, '202210280081', '', 'Alphagan Eye Drop 1.5mg 5ml', '288.06', '212.71', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(82, '202210280082', '', 'Always Jumbo Saving (Pink) 2in1', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(83, '202210280083', '', 'Always Maxi Thick (Single)', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(84, '202210280084', '', 'Always Maxi Thick Double Pack', '13.54', '10.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(85, '202210280085', '', 'Always Ultra (Single)', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(86, '202210280086', '', 'Always Ultra (Value Pack)', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(87, '202210280087', '', 'Amalfi Bath Gel 750ml', '27.09', '20.00', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(88, '202210280088', '', 'Amaryl (Glimepiride) 2mg 1S 30/pck', '6.15', '4.55', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(89, '202210280089', '', 'AMARYL (GLIMEPIRIDE) 3MG 1S 30/PCK', '5.10', '3.25', 240, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(90, '202210280090', '', 'Amaryl 1mg 1S 30/pck', '2.45', '1.82', 300, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(91, '202210280091', '', 'Amaryl 4MG 1S', '12.31', '9.09', 250, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(92, '202210280092', '', 'amciclox 100ml (Letap)', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(93, '202210280093', '', 'Amedin 10mg 28S', '29.54', '21.82', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(94, '202210280094', '', 'Amedin 5mg 28S', '18.47', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(95, '202210280095', '', 'American Designer Bags (Big)', '369.32', '272.70', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(96, '202210280096', '', 'American Designer Bags (small)', '110.80', '81.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(97, '202210280097', '', 'Amiclox Cap ECL 10s', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(98, '202210280098', '', 'Amiclox Sup 100ml', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(99, '202210280099', '', 'Amino Pep forte Syr.', '24.62', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(100, '202210280100', '', 'Amitriptyline (Crescent/Teva/accord) 25mg 28s', '18.47', '13.64', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(101, '202210280101', '', 'Amitriptyline 50mg (Northstar/Teva)14s 2/pck', '20.93', '15.45', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(102, '202210280102', '', 'Amlo Denk 10mg 10S', '31.02', '25.45', 22, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(103, '202210280103', '', 'Amlo Denk 5mg 10S', '14.78', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(104, '202210280104', '', 'Amlodipine 10mg (besilate) 28s', '11.70', '8.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(105, '202210280105', '', 'Amlodipine 10mg (Teva/Bristol) 28s', '15.70', '13.64', 79, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(106, '202210280106', '', 'Amlodipine 10mg 28s(Sandoz)', '11.08', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(107, '202210280107', '', 'Amlodipine 5mg (besilate) 28s', '9.85', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(108, '202210280108', '', 'Amlodipine 5mg (Teva) 28s', '14.56', '11.82', 66, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(109, '202210280109', '', 'Amoksiclav Inj.1.2g 1s (Troge)', '16.01', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(110, '202210280110', '', 'AMOKSIKLAV SUSP 457MG', '65.55', '41.63', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(111, '202210280111', '', 'AMOKSIKLAV 1000MG TAB', '105.87', '78.17', 32, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(112, '202210280112', '', 'Amoksiklav Susp 156mg/5ml', '32.01', '23.63', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(113, '202210280113', '', 'Amoksiklav Susp 228mg 70ml', '44.32', '32.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(114, '202210280114', '', 'AMOKSIKLAV TABS 625MG 14S', '66.68', '40.91', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(115, '202210280115', '', 'Amoxicillin 125mg Susp. (exeter)', '13.54', '10.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(116, '202210280116', '', 'Amoxicillin 125mg/5ml Susp. (UK)', '16.01', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(117, '202210280117', '', 'Amoxicillin 250mg Caps 21s', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(118, '202210280118', '', 'Amoxicillin 500mg (Bristol) 21s', '16.01', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(119, '202210280119', '', 'Amoxicillin 500mg (local) 10s', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(120, '202210280120', '', 'Amoxicillin 500mg(Exeter) 21s', '18.47', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(121, '202210280121', '', 'Amoxicillin(Amoxylex) Dry Syrup powder 125mg/5mg/10mg (LUEX)', '9.85', '7.27', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(122, '202210280122', '', 'Amoxycillin 500mg uk (Noumed)', '33.24', '24.54', 2, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(123, '202210280123', '', 'Amoxycillin Syrp (M &G. Letap) 100mg', '9.85', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(124, '202210280124', '', 'Amoxyl 500mg UK (VEGA) 21s', '20.31', '15.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(125, '202210280125', '', 'Anafranil Tab 25mg 1S', '4.92', '3.64', 145, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(126, '202210280126', '', 'Andrews Liver Salt (lemon) 1s', '2.45', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(127, '202210280127', '', 'Andrews Liver salt (plain) 1s', '2.45', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(128, '202210280128', '', 'Angel Soup', '6.15', '4.55', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(129, '202210280129', '', 'Anomex-Plus supp 1s', '1.85', '1.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(130, '202210280130', '', 'Anthisan Cream 25g', '52.94', '39.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(131, '202210280131', '', 'Anti-Mosquito (Longrich) 195ml', '36.93', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(132, '202210280132', '', 'Anti Gas Softgel', '20.93', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(133, '202210280133', '', 'Anusol  UK 25g (Ointment & Cream)', '80.89', '66.36', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(134, '202210280134', '', 'ANUSOL HC SUPPO 1S', '3.80', '2.73', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(135, '202210280135', '', 'APC Tap 4S 10/Pck', '2.45', '1.82', 156, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(136, '202210280136', '', 'Apdyl H 100ml', '16.62', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(137, '202210280137', '', 'Apdyl H cough 200ml', '30.77', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(138, '202210280138', '', 'Apetamin Syrup 200ml', '55.41', '40.91', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(139, '202210280139', '', 'Apflu Syr 100ml', '18.47', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(140, '202210280140', '', 'Aprovasc 150mg/10mg 1s', '7.14', '5.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(141, '202210280141', '', 'Aprovasc 150mg/5mg 1s', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(142, '202210280142', '', 'Aprovasc 300mg/10mg 1s', '9.85', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(143, '202210280143', '', 'Aprovasc 300mg/5mg 1s', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(144, '202210280144', '', 'Aprovel 150mg 1s 20/pck', '9.85', '7.27', 100, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(145, '202210280145', '', 'Aprovel 300mg 1s', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(146, '202210280146', '', 'Aptamil Pronutra 1', '0.00', '2.73', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(147, '202210280147', '', 'Aptizooom Syrup', '78.79', '58.18', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(148, '202210280148', '', 'Aquafresh big teeth 50ml', '12.31', '9.09', 60, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(149, '202210280149', '', 'Aquafresh Big Teeth Paste (Adult)', '18.47', '13.64', 56, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(150, '202210280150', '', 'Aquafresh Big Teeth Paste (Kids 6+)', '18.47', '13.64', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(151, '202210280151', '', 'Aquafresh little teeth 50g', '12.93', '9.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(152, '202210280152', '', 'Aquafresh milk teeth 50g', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(153, '202210280153', '', 'Aquafresh mouth wash', '24.62', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(154, '202210280154', '', 'Aquafresh Toothpaste 0-2years', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(155, '202210280155', '', 'Aquafresh Toothpaste 100ml', '22.17', '16.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(156, '202210280156', '', 'AQUATAB 10/PK 10S', '4.76', '3.64', 128, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(157, '202210280157', '', 'Aqueous Cream 100g', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(158, '202210280158', '', 'Artesun (Artesunate) 30MG Inj.(Fosun Pharma)', '25.43', '24.54', 7, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(159, '202210280159', '', 'Artesun (Artesunate)(Lavina) 120MG Inj', '19.71', '14.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(160, '202210280160', '', 'Artesun (Artesunate)120MG Inj.(Fosun Pharma)', '51.21', '47.27', 22, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(161, '202210280161', '', 'Artesun (Artesunate)kamtsen 120MG Inj', '19.71', '14.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(162, '202210280163', '', 'Artesunate 60mg (Ernest Chemist)', '14.15', '10.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(163, '202210280164', '', 'Arthosan Gel 100mg', '99.73', '73.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(164, '202210280165', '', 'Arthosan Tablet', '299.16', '220.89', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(165, '202210280166', '', 'Arthrosamine Plus Caps.', '492.43', '363.60', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(166, '202210280167', '', 'ARTHROTEC (DICLOFENAC /MISOPROSTOL) 75 10S  2/PCK', '109.00', '81.58', 24, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(167, '202210280168', '', 'Arziglobin Caps. 30s', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(168, '202210280169', '', 'Ascoryl Plus Syr. 125ml', '22.17', '16.36', 32, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(169, '202210280170', '', 'Ascoryl vit C 125ml', '18.47', '13.64', 35, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(170, '202210280171', '', 'Ascovite 500mg Chewablw 4s', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(171, '202210280172', '', 'Ashton & PastonTeething Podwer  1s 20/pck', '6.15', '4.55', 720, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(172, '202210280173', '', 'Asmadrin Tab 4s', '2.45', '1.82', 132, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(173, '202210280174', '', 'Asmanol Tab Strip 4s 25/pck', '1.23', '0.91', 285, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(174, '202210280175', '', 'Aspirin Cardio 100mg 30s', '46.78', '34.54', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(175, '202210280176', '', 'Aspirin Disp 75mg (Aspar) 13s 8/pck', '6.15', '4.55', 206, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(176, '202210280177', '', 'Aspirin Disp 75mg (Bristol) 14s', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(177, '202210280178', '', 'Aspirin Disp 75mg(accord) 12s (M&A)', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(178, '202210280179', '', 'Asthalex Syrup 100ml', '12.31', '9.09', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(179, '202210280180', '', 'Astonish Hand Wash (Moisture Protect) 650ml', '17.23', '12.73', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(180, '202210280181', '', 'ASTYMIN C DROP ', '35.15', '21.82', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(181, '202210280182', '', 'Astymin Syrup', '43.87', '36.00', 3, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(182, '202210280183', '', 'ATACAND 16MG TAB 1S 28/PK', '19.00', '12.00', 224, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(183, '202210280184', '', 'ATACAND 32MG 1S', '11.08', '8.18', 0, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(184, '202210280185', '', 'Atacand Plus 16/12.5 1s', '13.79', '10.18', 193, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(185, '202210280186', '', 'Atacand Plus 32/25mg 1S', '11.08', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(186, '202210280187', '', 'Atacand Plus 32mg/12.5 1s 28/pk', '9.85', '7.27', 140, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(187, '202210280188', '', 'Atacand Tab 8mg 1s 28/pk', '11.69', '8.63', 225, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(188, '202210280189', '', 'Atenolol 100mg 28s (ALMUS)', '22.17', '16.36', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(189, '202210280190', '', 'Atenolol 100mg 28s (Bristol/Teva) ', '24.62', '18.18', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(190, '202210280191', '', 'Atenolol 100mg 28s (cresent)', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(191, '202210280192', '', 'Atenolol 25mg 28s (Crescent)', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(192, '202210280193', '', 'Atenolol 25mg 28s (Teva)', '18.47', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(193, '202210280194', '', 'Atenolol 50mg 28s (ALMUS)', '18.47', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(194, '202210280195', '', 'ATENOLOL 50MG 28S (CRESCENT)', '16.62', '11.82', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(195, '202210280196', '', 'Atenolol 50mg 28s UK(Bristol)', '16.01', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(196, '202210280197', '', 'Atorvastatin 10mg 28s (Northstar)', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(197, '202210280198', '', 'Atorvastatin 10mg 28s (UK)', '9.85', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(198, '202210280199', '', 'Atorvastatin 10mg 28s(teva)', '13.79', '10.18', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(199, '202210280200', '', 'Atorvastatin 20mg (Teva & jcsh) 28s', '28.32', '20.91', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(200, '202210280201', '', 'Atorvastatin 40mg (Teva)', '35.45', '26.18', 2, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(201, '202210280202', '', 'Atorvastatin 80mg 28s (Teva)', '29.91', '22.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(202, '202210280203', '', 'Atorvastin 10 mg 28s (Ranbaxy)', '11.08', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(203, '202210280204', '', 'Attraction Set (Avon)', '131.85', '97.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(204, '202210280205', '', 'Atwood Bitters', '106.36', '78.54', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(205, '202210280206', '', 'Augmentin Susp 228 mg', '148.96', '109.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(206, '202210280207', '', 'Augmentin susp 457mg', '169.52', '125.17', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(207, '202210280208', '', 'AUGMENTIN TAB 1G', '206.90', '143.16', 53, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(208, '202210280209', '', 'Augmentin Tab 625mg', '163.71', '139.90', 22, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(209, '202210280210', '', 'Aunty Mary Gripe Mixture 160ml', '25.87', '19.09', 27, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(210, '202210280211', '', 'AVAMYS NASAL SPRAY (FLUTICASONE) 27.5MCG', '166.24', '105.86', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(211, '202210280212', '', 'Avarin 300mg', '17.23', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(212, '202210280213', '', 'Avomine tabs 25mg 10s', '54.17', '40.00', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(213, '202210280214', '', 'Avon- Senses', '32.13', '23.72', 75, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(214, '202210280215', '', 'Avon-Body Lotion', '62.05', '45.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(215, '202210280216', '', 'Avon-Bubble Baths', '35.69', '26.36', 50, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(216, '202210280217', '', 'Avon-Care Body Lotion', '49.86', '36.81', 56, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(217, '202210280218', '', 'Avon-Care Body Wash skin Defence (Anti- Bacterial)', '44.32', '32.72', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(218, '202210280219', '', 'Avon-Care Body Wash With Cocoa Butter/coconut', '35.69', '26.36', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(219, '202210280220', '', 'Avon-Care Hand Wash', '29.54', '21.82', 60, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(220, '202210280221', '', 'Avon-Care Multi Purpose', '39.39', '29.09', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(221, '202210280222', '', 'Avon-Edu De Bouquet Perfume', '105.25', '77.72', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(222, '202210280223', '', 'Avon-Elite Gentlemen', '49.25', '36.36', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(223, '202210280224', '', 'Avon-Feminine Wash(simply delicate)', '53.19', '39.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(224, '202210280225', '', 'Avon-Hair Care set', '134.08', '98.99', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(225, '202210280226', '', 'Avon-Hair Mask with Avocado 400ml', '59.10', '43.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(226, '202210280227', '', 'Avon-Hair Serum set', '70.17', '51.81', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(227, '202210280228', '', 'Avon-Hand Cream Silicone glove ', '25.87', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(228, '202210280229', '', 'Avon-Scented Spritz', '29.54', '21.82', 55, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(229, '202210280230', '', 'Avon-Secret Perfume', '89.75', '66.27', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(230, '202210280231', '', 'Avon-Skin So Soft', '87.42', '64.54', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(231, '202210280232', '', 'Avon Aqua Perfum', '116.96', '86.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(232, '202210280233', '', '0', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(233, '202210280234', '', 'Avon Femme Perfum', '116.96', '86.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(234, '202210280235', '', 'Avon Individual Blue', '91.96', '67.90', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(235, '202210280236', '', 'Avon Little Dress Perfum', '85.31', '62.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(236, '202210280237', '', 'Avon Men Shave Gel', '19.96', '14.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(237, '202210280238', '', 'Avon Naturals ', '26.58', '19.63', 55, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(238, '202210280239', '', 'Avon Secrte Fantacy', '72.02', '53.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(239, '202210280240', '', 'Avon Skin So Soft Silky Oil 150ml (Avon)', '59.83', '44.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(240, '202210280241', '', 'Avon Viva Perfum', '98.62', '72.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(241, '202210280242', '', 'Axacef (Cefuroxime) 250mg 1s', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(242, '202210280243', '', 'AXACEF (CEFUROXIME)500MG 1S 10/PCK', '8.74', '5.58', 139, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(243, '202210280244', '', 'Axe Deo Spray (All)', '36.93', '27.27', 117, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(244, '202210280245', '', 'Ayu Rhoids Caps.', '49.30', '36.41', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(245, '202210280246', '', 'Ayulabs Gripe Water', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(246, '202210280247', '', 'Ayulax', '49.30', '36.41', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(247, '202210280248', '', 'Ayuvigo Caps.', '49.30', '36.41', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(248, '202210280249', '', 'Azathioprine 25mg (Teva)', '9.85', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(249, '202210280250', '', 'AZILEX 200MG/5ML SUSP (AZITHROMYCIN)', '54.87', '20.00', 33, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(250, '202210280251', '', 'AZILEX 250MG CAPS', '44.89', '16.36', 36, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(251, '202210280252', '', 'Azithromycin 250mg (Teva) 4s', '16.01', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(252, '202210280253', '', 'Azithromycin 250mg Tab ', '24.62', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(253, '202210280254', '', 'Azithromycin 500mg (Teva)', '29.54', '21.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(254, '202210280255', '', 'Azithromycin susp ( Sandoz)', '54.85', '45.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(255, '202210280256', '', 'Azomax 500mg cap 3s', '45.55', '33.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(256, '202210280257', '', 'AZOMAX SUSP (LEK)', '66.21', '47.45', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(257, '202210280258', '', 'Azopt 1 percent(novartis)', '105.30', '85.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(258, '202210280259', '', 'B B Cocktail', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(259, '202210280260', '', 'B Co (local) 10S 50/pck', '1.23', '0.91', 365, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(260, '202210280261', '', 'B COMPLEX STRONG (KRKA)', '71.72', '35.45', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(261, '202210280262', '', 'BABY COUGH LINCTUS 125ML ECL', '15.20', '9.09', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(262, '202210280263', '', 'Bactiflox (Cipro) 500mg 1s', '11.56', '8.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(263, '202210280264', '', 'Bactroban Cream (jsk)', '144.60', '88.97', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(264, '202210280265', '', 'Bactroban Cream(mupirocin) 15g', '105.25', '77.72', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(265, '202210280266', '', 'BALANCED OMEGA 3-6-9 CAPS. 60S (HEALTH AID)', '127.42', '94.08', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(266, '202210280267', '', 'Bamboo Charcoal Soap (Longrich) 1s', '16.62', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(267, '202210280268', '', 'Basecold Syrup 60ml', '9.85', '7.27', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(268, '202210280269', '', 'BASECOLD TAB', '4.92', '3.64', 34, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(269, '202210280270', '', 'Basic Nutrition vit D', '75.09', '55.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(270, '202210280271', '', 'Bath & Body Works Handwash (moonlight path)', '86.43', '63.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(271, '202210280272', '', 'Bath & Body Works Splash', '105.25', '77.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(272, '202210280273', '', 'Bath Salt', '39.39', '29.09', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(273, '202210280274', '', 'Bebylin Dry Cough 150ml (Dexthrome)', '71.41', '52.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(274, '202210280275', '', 'BECOACTIN TAB 30S', '25.18', '15.91', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(275, '202210280276', '', 'BECOATIN SYRUP 200ML', '25.65', '15.45', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(276, '202210280277', '', 'Beconase(Aqueous Nasal Spray)', '55.41', '40.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(277, '202210280278', '', 'Beecham Cold & Flu Hot Blackcurrent(Schet) 5/pck', '35.69', '26.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(278, '202210280279', '', 'Beechams All in 1 Syrup 160ml', '130.50', '96.35', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(279, '202210280280', '', 'BEECHAMS COLD & FLU (HOT LEMON HONEY) 5/PCK SACHETS', '35.69', '26.36', 42, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(280, '202210280281', '', 'Beechams Max Strength (All in 1 tab.gsk', '72.02', '53.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(281, '202210280282', '', 'Beehive Balsam Cough Syr.', '48.76', '32.72', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(282, '202210280283', '', 'BEL-AQUA WATER 500ML', '1.90', '1.82', 982, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(283, '202210280284', '', 'BEL-AQUA WATER 750ML', '2.86', '2.73', 1040, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(284, '202210280285', '', 'BELLA COUGH SYR.', '14.78', '10.91', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(285, '202210280286', '', 'Bellis Rubbing Alcohol 500ml Spray', '33.24', '24.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(286, '202210280287', '', 'Bells Baby Cough Syr 100ml', '28.32', '20.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(287, '202210280288', '', 'BELLS BABY GRIPE WATER', '25.87', '19.09', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(288, '202210280289', '', 'Bells Children Cough 100ml', '23.39', '17.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(289, '202210280290', '', 'Bells Olive oil 70ml', '16.01', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(290, '202210280291', '', 'BELLS TEETHING MIXTURE 100ML', '45.59', '28.18', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(291, '202210280292', '', 'BELLS VITAMIN C SYRUP 100ML (ALL)', '37.06', '23.54', 27, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(292, '202210280293', '', 'Ben', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(293, '202210280294', '', 'Bendro 2.5mg (Crescent/northstar) 28s', '14.78', '10.91', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(294, '202210280295', '', 'Bendro 2.5mg 28s (EC)', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(295, '202210280296', '', 'Bendro 2.5mg 28s (Accord)', '17.23', '12.73', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(296, '202210280297', '', 'Bendro 5mg 28s UK (Bristol)', '23.39', '17.27', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(297, '202210280298', '', 'BENDROFLUAZIDE 2.5MG TABS 28S (ACTAVIS)', '11.40', '7.18', 12, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(298, '202210280299', '', 'Bendroflumethiazide 5mg(Pxfarma)', '19.09', '14.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(299, '202210280300', '', 'Benylin 4Flu Liquid 200ml', '119.65', '98.17', 31, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(300, '202210280301', '', 'Benylin 4flu Syr. 100ml', '74.24', '54.81', 26, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(301, '202210280302', '', 'Benylin 4flu tab', '70.91', '52.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(302, '202210280303', '', 'Benylin Allergy- Children uk', '84.21', '62.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(303, '202210280304', '', 'Benylin Chesty cold', '59.10', '43.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(304, '202210280305', '', 'Benylin Chesty Cough (Non-Drowsy) 150ml', '104.16', '76.90', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(305, '202210280306', '', 'Benylin Chesty cough Adult 150ml Drowsy ', '67.59', '49.90', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(306, '202210280307', '', 'Benylin Chesty cough original 150ml', '62.05', '45.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(307, '202210280308', '', 'BENYLIN CHILDREN CHESTY COUGH(GUAFENESIN)6+YRS', '71.25', '45.45', 2, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(308, '202210280309', '', 'Benylin Children Dry Cough & SoreThroat Syrup ', '81.99', '60.54', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(309, '202210280310', '', 'Benylin Children Night Cough syrup', '93.06', '68.72', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(310, '202210280311', '', 'BENYLIN INFANT 125ML', '85.50', '54.54', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(311, '202210280312', '', 'Benylin Cold & FluMax caps', '78.67', '58.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(312, '202210280313', '', 'Benylin Day & Night tab ', '75.09', '55.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(313, '202210280314', '', 'Benylin Dry & Tickly Cough 150ml(Glycerol & Sucrose)', '121.88', '89.99', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(314, '202210280315', '', 'BENYLIN DRY COUGH 2+ (DEXTHROMETOPHAN)  ', '96.89', '61.81', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(315, '202210280316', '', 'Benylin Dry Cough Night 150ml', '84.40', '55.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(316, '202210280317', '', 'Benylin Infant Cough (Apple) 3+mnth 125mlGlycerol (Day/Night)', '85.31', '62.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(317, '202210280318', '', 'Benylin Mucus Cough Max. 100ml( Menthol flavor)', '126.31', '93.26', 7, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(318, '202210280319', '', 'Benylin Mucus Cough Max.(honey&lemon) 100ml', '108.59', '80.17', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(319, '202210280320', '', 'Benylin Mucus Decongestant 100ml', '117.45', '86.72', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(320, '202210280321', '', 'Benylin Mucus Night 150ml', '68.70', '50.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(321, '202210280322', '', 'Benylin Original 100ml', '129.63', '95.72', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(322, '202210280323', '', 'Benylin Paediatry', '45.55', '33.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(323, '202210280324', '', 'Benylin Wet cough menthol 100ml ', '52.94', '39.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(324, '202210280326', '', 'BENZATHINE PENICILLINE INJ. 2.4G', '13.78', '10.00', 24, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(325, '202210280327', '', 'Benzyl benzoate', '14.78', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(326, '202210280328', '', 'Benzyl Benzoate  Lotion (Exeter)', '27.09', '20.00', 14, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(327, '202210280329', '', 'Bestvit C Effervicent. 1000mg', '45.55', '33.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(328, '202210280330', '', 'Betacort eye/ear/nasal drop(korlyns)', '44.32', '32.72', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(329, '202210280331', '', 'Betagan Eye Drop 10ml', '44.32', '32.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(330, '202210280332', '', 'Betaloc (Metoprolol) 50mg', '151.21', '38.50', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(331, '202210280333', '', 'Betaloc Zok 100mg ( Metoprolo)l ', '78.48', '57.95', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(332, '202210280334', '', 'Betnovate 0.1 percent Cream 15g', '33.24', '24.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(333, '202210280335', '', 'Betnovate Cream (gsk)', '49.25', '36.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(334, '202210280336', '', 'Betoptic Eye Drop', '33.24', '24.54', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(335, '202210280337', '', 'BG Glutamin Plus tab', '45.55', '33.63', 27, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(336, '202210280338', '', 'Big Ben Caps 1s', '5.54', '4.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(337, '202210280339', '', 'Bio Oil 125ml', '78.79', '58.18', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(338, '202210280340', '', 'Bio Oil 200ml', '155.12', '114.53', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(339, '202210280341', '', 'Bio Oil 25ml', '28.32', '20.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(340, '202210280342', '', 'Bio Oil 60ml', '54.17', '40.00', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(341, '202210280343', '', 'Bioderma 100ml', '28.32', '20.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(342, '202210280344', '', 'Bioderma 250ml (Sensibio H2O)', '48.75', '36.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(343, '202210280345', '', 'Bioderma 500ml (Sensibio H2O)', '65.36', '48.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(344, '202210280346', '', 'BIOFERON CAP 30S', '42.55', '25.41', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(345, '202210280347', '', 'Bioferon Syrup 200ml', '43.09', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(346, '202210280348', '', 'BIOQUICK PREG.TEST KITS', '19.00', '12.73', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(347, '202210280349', '', 'Biovid Forte 10S', '19.71', '14.54', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(348, '202210280350', '', 'Bisoprolol 10mg (Accord)', '14.78', '10.91', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(349, '202210280352', '', 'Bisoprolol 10mg 28s (Sandoz)', '28.32', '20.91', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(350, '202210280353', '', 'Bisoprolol 10mg 28s(Exeter)', '20.93', '15.45', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(351, '202210280354', '', 'Bisoprolol 10mg 28s(northstar))', '14.78', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(352, '202210280355', '', 'Bisoprolol 2.5mg 28s (Teva)', '16.01', '11.82', 2, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(353, '202210280356', '', 'Bisoprolol 5mg 28s (Accord)', '9.85', '7.27', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(354, '202210280357', '', 'Bisoprolol 5mg 28s (Exeter)', '14.78', '10.91', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(355, '202210280358', '', 'Bisoprolol 5mg 28s sandoz', '16.01', '11.82', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(356, '202210280359', '', 'Blood Sugar Test', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(357, '202210280360', '', 'Blue Aid Cod Liver Oil 100ml', '27.09', '20.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(358, '202210280361', '', 'Blue Jeans Can Drink', '14.78', '10.91', 61, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(359, '202210280362', '', 'Bodman Splash', '55.41', '40.91', 90, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(360, '202210280363', '', 'Body Splash (All)', '44.32', '32.72', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(361, '202210280364', '', 'BONAPLEX SYRUP 200ML', '39.42', '29.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(362, '202210280366', '', 'Bonjela choline Salicylate Adult Gel 15gm', '99.73', '81.81', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(363, '202210280367', '', 'Bonjela Junior Gel', '85.76', '81.81', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(364, '202210280368', '', 'Bonjela Soothing Teething Gel 6+mnths 15g', '64.83', '53.18', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(365, '202210280369', '', 'Bonliv Tab. 20s', '50.48', '37.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(366, '202210280370', '', 'Borges Cider Vinegar 250ml', '19.71', '14.54', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(367, '202210280371', '', 'Borges Cider Vinegar 355mlml', '22.17', '16.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(368, '202210280372', '', 'Borges Olive Oil  with Galic 500ml', '68.94', '50.90', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(369, '202210280373', '', 'Borges Olive Oil 125ml', '30.77', '22.73', 7, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(370, '202210280374', '', 'Borges Olive Oil 1L', '131.85', '97.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(371, '202210280375', '', 'Borges Olive Oil 250ml', '49.25', '36.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(372, '202210280376', '', 'Borges Olive Oil 500ml', '91.05', '79.08', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(373, '202210280377', '', 'Borges Olive Oil with Garlic 250ml', '51.70', '38.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(374, '202210280378', '', 'Boric Acid  Spirit Ear Drop', '8.62', '6.36', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(375, '202210280379', '', 'BP Machine (Electronic', '439.49', '324.51', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(376, '202210280380', '', 'Br', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(377, '202210280381', '', 'Bragg Apple Cider Vinegar 473ml', '72.02', '53.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(378, '202210280382', '', 'Bragg Apple Cider Vinegar 946ml', '119.65', '88.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(379, '202210280383', '', 'Brainwise syp 150mg', '86.18', '63.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(380, '202210280384', '', 'Brenex Syp', '32.01', '23.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(381, '202210280385', '', 'Bro Zedex Syr 100ml', '29.54', '21.82', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(382, '202210280386', '', 'Broncold Syrup (Health Aid)Non-Drowsy', '66.47', '49.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(383, '202210280387', '', 'Brut After-shave 100ml', '23.39', '17.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(384, '202210280388', '', 'Brut Deo Spray 200ml', '17.23', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(385, '202210280389', '', 'Bump Control (NYXON)', '49.25', '36.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(386, '202210280390', '', 'Buscomed IBS Tab 10mg 10s', '39.39', '29.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(387, '202210280391', '', 'Buscomed Tab 10mg 10sB (Local)', '9.85', '7.27', 130, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(388, '202210280392', '', 'Buscopan  IBS  Relief 10mg 10s', '44.32', '32.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(389, '202210280393', '', 'Buscopan 10mg 14s (56tabs)SANOFI', '32.01', '23.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(390, '202210280394', '', 'Buscopan Cramps 10s 2/pck', '61.55', '45.45', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(391, '202210280395', '', 'Buscopan Injection(Hyoscine Butylbromide) 20mg/ml', '6.15', '4.55', 95, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(392, '202210280396', '', 'Buttercup Cough Syr 150ml', '137.39', '101.44', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(393, '202210280397', '', 'Buttercup Cough Syr. 200ml', '117.45', '86.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(394, '202210280398', '', 'Buttercup Cough Syr. 75ml', '81.99', '60.54', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(395, '202210280399', '', 'BX Syrup 100ml', '12.31', '9.09', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE');
INSERT INTO `products_master` (`id`, `pid`, `barcode`, `pname`, `sprice`, `cprice`, `qty`, `cat`, `pimg`, `status`) VALUES
(396, '202210280400', '', 'BX SYRUP 200ML', '19.00', '20.91', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(397, '202210280401', '', 'C-Press Drops', '61.55', '45.45', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(398, '202210280402', '', 'C ', '54.17', '40.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(399, '202210280403', '', 'C H eye Drop', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(400, '202210280404', '', 'C Pheniramine srp 125ml', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(401, '202210280405', '', 'Ca', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(402, '202210280406', '', 'Ca-Sandoz 1000mg', '48.02', '35.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(403, '202210280407', '', 'Caduet Tab 10/10mg 1s', '19.09', '14.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(404, '202210280408', '', 'Caduet Tab 5/10mg', '10.71', '7.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(405, '202210280410', '', 'Cafalgin Syr', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(406, '202210280411', '', 'CAFERGOT TAB. 1MG 30S 3/PCK', '33.25', '24.54', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(407, '202210280412', '', 'Calamine Ointment', '16.01', '11.82', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(408, '202210280413', '', 'CALCOUGH INFANT SYR.125ML (1YR+) UK (BLACKCURRANT FLAVOUR)', '75.19', '44.42', 19, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(409, '202210280414', '', 'Calcough Infant Syr.125ml (3mnths+)Apple flavour UK', '90.86', '67.08', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(410, '202210280415', '', 'Calcury Tabs', '71.88', '33.18', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(411, '202210280416', '', 'Calpol 2+ Sachet 1S', '5.54', '4.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(412, '202210280417', '', 'CALPOL 2+MNTH SYRP 100ML', '91.19', '58.09', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(413, '202210280418', '', 'Calpol 6+ Syr. 80ml', '64.37', '67.90', 27, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(414, '202210280419', '', 'CALPOL SALINE NASAL DROP', '63.90', '35.40', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(415, '202210280420', '', 'Calpol saline nasal spray ', '83.65', '64.63', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(416, '202210280421', '', 'Calprofen Susp/Syrup 100ml 3+', '85.31', '62.99', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(417, '202210280422', '', 'Camel Antiseptic 125ml', '11.08', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(418, '202210280423', '', 'Camel Antiseptic 250ml', '16.62', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(419, '202210280424', '', 'Camel Antiseptic 500ml', '39.39', '29.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(420, '202210280425', '', 'Camel Bar Soap 175g', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(421, '202210280426', '', 'Canderel 100s/150s', '24.00', '17.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(422, '202210280427', '', 'Canderel 300s', '58.73', '48.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(423, '202210280428', '', 'CANDIBIOTIC EAR DROPS (FRIDGE)5ML', '54.30', '38.32', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(424, '202210280429', '', 'Candid B Cream 15g', '20.93', '15.45', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(425, '202210280430', '', 'Candid broad spectrum Cream 20gm', '17.23', '12.73', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(426, '202210280431', '', 'Candid Lotion 20ml', '23.39', '17.27', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(427, '202210280432', '', 'Candid Powder 30g', '20.93', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(428, '202210280433', '', 'Candid TV Shampoo', '25.87', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(429, '202210280434', '', 'Candid V Gel 30g', '33.87', '25.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(430, '202210280435', '', 'Candid V1 500mg', '13.54', '10.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(431, '202210280436', '', 'Candid V3 200mg', '13.54', '10.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(432, '202210280437', '', 'Candid V6 Pess 100mg 6s', '17.23', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(433, '202210280438', '', 'Candiderm Cream 15g', '18.47', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(434, '202210280439', '', 'Canesten 2 percent Thrush Cream 20g', '159.54', '130.90', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(435, '202210280440', '', 'Canesten 200m Pess. 3s', '38.17', '28.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(436, '202210280441', '', 'Canesten Cream 20g', '76.45', '59.72', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(437, '202210280442', '', 'Canesten Thrush Pessary 500mg', '176.51', '144.80', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(438, '202210280443', '', 'Cannula (Blue) 1s', '1.85', '1.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(439, '202210280444', '', 'Canped Diapers Large 30s', '155.55', '127.62', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(440, '202210280445', '', 'Canped Diapers Large 8s', '46.78', '34.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(441, '202210280446', '', 'Canped Diapers Medium 30s', '140.34', '103.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(442, '202210280447', '', 'Canped pull-up medium 10s', '46.78', '34.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(443, '202210280448', '', 'Captopril 25mg 14s (Bristol)', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(444, '202210280449', '', 'Carbamazepine 200mg 10s', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(445, '202210280450', '', 'Carbimazole 5mg 25s', '23.39', '17.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(446, '202210280451', '', 'Carbiroid 5mg carbimazole( hovid) 20s 5/pck', '11.08', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(447, '202210280452', '', 'Cardio Advance supplements(life Essentials)', '174.82', '129.08', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(448, '202210280453', '', 'Cardioace Plus Caps', '192.22', '141.95', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(449, '202210280454', '', 'Cardiopat Caps', '68.33', '33.63', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(450, '202210280455', '', 'Carvedi-Denk 6.25mg 10s 3/pck', '14.78', '10.91', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(451, '202210280456', '', 'Carvedi Denk 25mg 10s 3/pck', '36.93', '27.27', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(452, '202210280457', '', 'Carvedilol 12.5mg 28s (Teva)', '16.62', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(453, '202210280458', '', 'Carvedilol 12.5mg 7s (Milpharm)', '9.23', '6.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(454, '202210280459', '', 'Carvedilol 25mg 14s (Mipharm)', '22.17', '16.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(455, '202210280460', '', 'Carvedilol 25mg 14s (Teva)', '23.39', '17.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(456, '202210280461', '', 'Carvedilol 3.125mg (Exeter/Bristol) 14s', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(457, '202210280462', '', 'Carvedilol 6.25mg  (Ennogen)14s 2/pck', '14.78', '10.91', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(458, '202210280463', '', 'Carvedilol 6.25mg 28s (Teva)', '16.01', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(459, '202210280464', '', 'CASTOR OIL 70ML (ARYTON)', '33.24', '24.54', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(460, '202210280465', '', 'CASTOR OIL 70ML (BELLS)', '26.12', '16.63', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(461, '202210280466', '', 'Cataflam Tab 50mg 10S 2/pck', '43.09', '31.82', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(462, '202210280467', '', 'Cebrotonin(Piracetam) Tab 800mg 10s 3/pck', '44.32', '32.72', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(463, '202210280468', '', 'Ceelin Plus chewable Tab. 10s', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(464, '202210280469', '', 'Ceelin Plus Syr. 100ml', '19.71', '14.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(465, '202210280470', '', 'Ceftriaxone 1g (Stericef)', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(466, '202210280471', '', 'Cefuroxime 750mg Injection(Gucefor)', '9.85', '7.27', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(467, '202210280472', '', 'CELEBREX 200MG(PACK)', '166.12', '121.08', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(468, '202210280473', '', 'Celecoxib 200mg (Exerter) 10s', '20.67', '12.73', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(469, '202210280474', '', 'Celecoxib tab 10s Brown &Burk', '18.96', '10.14', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(470, '202210280475', '', 'Celestamine .25/2mg 30s', '50.41', '37.23', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(471, '202210280476', '', 'Cellgevity ', '192.46', '157.89', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(472, '202210280477', '', 'Centol Sanitizer Spray 750ml', '49.25', '36.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(473, '202210280478', '', 'Centrum Silver (Men)', '125.21', '92.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(474, '202210280479', '', 'Cerelac (all) Tin', '18.47', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(475, '202210280480', '', 'Cerumol Ear Drops', '43.87', '36.00', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(476, '202210280481', '', 'Cetapol PM Syrup', '14.78', '10.91', 26, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(477, '202210280482', '', 'Cetapol Syrup 100ml', '9.85', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(478, '202210280483', '', 'Cetirizine Syr. 200ml', '20.93', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(479, '202210280484', '', 'Cetirizine tab (bells) 10s', '2.45', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(480, '202210280485', '', 'Cetrizan 10mg 10s', '3.95', '2.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(481, '202210280486', '', 'CETRIZAN SYR. ', '11.69', '7.45', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(482, '202210280487', '', 'Chap Sticks', '13.54', '10.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(483, '202210280488', '', 'Chewette 1000mg Sachet Eff.', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(484, '202210280489', '', 'Chewette C', '1.97', '1.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(485, '202210280490', '', 'Chili feminin Wash', '32.01', '23.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(486, '202210280491', '', 'Chinese Green Tea', '23.39', '17.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(487, '202210280492', '', 'CHINESE ROBB OINTMENT ESSENTIAL (JAR) 8ML L/S', '9.85', '7.27', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(488, '202210280493', '', 'CHLOPROMAZINE 50ML TAB (ECL) 10S', '1.42', '0.91', 50, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(489, '202210280494', '', 'Chloramph. / Tetra. Eye Oint.', '6.15', '4.55', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(490, '202210280495', '', 'CHLORAMPHENICOL CAPS 250ML10S 50/PCK', '4.76', '215.52', 196, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(491, '202210280496', '', 'CHLORAMPHENICOL EAR DROP( BASECHLOR/ROGOPHEN) 10ML', '4.92', '3.64', 27, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(492, '202210280497', '', 'CHLORAMPHENICOL EYE DROP( BASECHLOR/FICHLOR)) 10ML', '6.15', '4.55', 3, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(493, '202210280498', '', 'chlordiazepoxide 10s', '2.45', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(494, '202210280499', '', 'Chlorxy-G gel 10g', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(495, '202210280500', '', 'Chlorxy G gel 25g', '16.62', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(496, '202210280501', '', 'Chocho Cream 110g', '16.01', '11.82', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(497, '202210280502', '', 'Chocho Cream B/S Container', '21.03', '20.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(498, '202210280503', '', 'Chocho Cream Tube 29g s/s', '12.31', '9.09', 35, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(499, '202210280504', '', 'CHOCHO SOAP', '9.50', '5.80', 60, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(500, '202210280505', '', 'Chocho Whyte Tea', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(501, '202210280506', '', 'Chocolate Golden Tree . B/S', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(502, '202210280507', '', 'Cholesta-lo Supplement (Life Essentials)', '138.50', '102.26', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(503, '202210280508', '', 'choramphenicol 250mg 10s', '3.08', '2.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(504, '202210280509', '', 'Cialis (Tadalafil) Tab 20mg 1S', '111.69', '91.63', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(505, '202210280510', '', 'Ciloxan 0.3 percent Eye Drop (Alcon)', '30.77', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(506, '202210280511', '', 'Cipac(Ciprpfloxacin) Eye Drop 10ml(Kofikrom pharmacy)', '4.92', '3.64', 50, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(507, '202210280512', '', 'CIPRINOL (CIPRO.) 10TABS 500MG 1S KRKA', '14.25', '10.91', 148, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(508, '202210280513', '', 'Cipro Denk 10Tabs 500mg 1s', '9.36', '6.91', 180, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(509, '202210280514', '', 'CIPROBAY (CIPROFLOXACIN) 500MG 1S 10/PCK', '25.65', '16.36', 184, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(510, '202210280515', '', 'Ciprofloxacin Infusion', '8.62', '6.36', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(511, '202210280516', '', 'Ciprolex  30.3 percent Eye/Ear Drops 5ml', '20.93', '15.45', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(512, '202210280517', '', 'CIPROLEX TAB 500MG 10S', '27.55', '21.82', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(513, '202210280518', '', 'Ciprolex TZ', '43.34', '50.00', 71, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(514, '202210280519', '', 'Cirotamin Tabs', '18.47', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(515, '202210280520', '', 'Cirotamin Tonic 200ml', '30.77', '22.73', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(516, '202210280521', '', 'Citro-C  25/pck sachet 10s', '3.70', '2.73', 678, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(517, '202210280522', '', 'Citro c Syrup 100ml', '18.47', '13.64', 35, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(518, '202210280523', '', 'CLAMIDE (GLIBENCLAMIDE) 5MG TAB 10S 10/PCK', '3.32', '2.00', 160, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(519, '202210280524', '', 'CLARITHROMYCIN 500MG (B-CLAR)', '36.62', '24.65', 160, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(520, '202210280525', '', 'Clarithromycin 500mg 14s (imres)', '65.62', '51.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(521, '202210280526', '', 'Clarithromycin 500mg 14s (Ranbaxy)', '57.86', '45.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(522, '202210280527', '', 'Clarithromycin 500mg 14s (Sandoz)', '49.86', '36.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(523, '202210280528', '', 'Clarithromycin susp 125ml (Rabax', '66.56', '58.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(524, '202210280529', '', 'CLARITYNE (BAYER)SYRUP 100ML', '96.81', '59.18', 13, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(525, '202210280530', '', 'Clarityne 10mg Sachet 1s', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(526, '202210280531', '', 'Clarityne Tab 10mg (Allergy Non-Drowsy) 1s', '6.19', '6.82', 111, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(527, '202210280532', '', 'Clavulin 228mg Susp.', '42.12', '31.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(528, '202210280533', '', 'Clavulin 625mg Tab.gsk', '58.83', '48.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(529, '202210280534', '', 'Cleanse Facial wash', '64.01', '47.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(530, '202210280535', '', 'Cleansing Charcold Toothpaste plus Brush', '24.62', '18.18', 45, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(531, '202210280536', '', 'Clear Inhaler', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(532, '202210280537', '', 'Clexane 2000UI /0.4ml 1s', '41.85', '30.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(533, '202210280538', '', 'Clexane 4000UI /0.4ml 1s', '80.34', '62.18', 22, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(534, '202210280539', '', 'Clexane 8000anti-Xa IU 0.8ml 1s 2/pck', '137.78', '120.26', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(535, '202210280540', '', 'Clindamycin 300mg 10s (Exeter) 10/pck', '20.93', '15.45', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(536, '202210280541', '', 'Clofort (Cefaclor) 500mg cap.', '52.94', '39.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(537, '202210280542', '', 'Clomid 50mg Tab 1S 10/pck', '14.78', '10.91', 160, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(538, '202210280543', '', 'Clomipramine 25mg {Teva} 14S', '17.23', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(539, '202210280544', '', 'Clopidogrel 75mg UK 28s', '25.87', '19.09', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(540, '202210280545', '', 'Close up (Red) 160g', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(541, '202210280546', '', 'Close Up Cool Breeze 125g (Blue)', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(542, '202210280547', '', 'Clotri Denk (Clotrimazole) 1 percent Cream 20g', '63.83', '29.45', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(543, '202210280548', '', 'Clotri Denk Pess 6S', '58.23', '29.87', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(544, '202210280549', '', 'Co-Codamol 30/500 10s 10/pck(workhardt)', '20.93', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(545, '202210280550', '', 'CO-CODAMOL 8/500 8S 10/PCK', '12.82', '81.81', 92, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(546, '202210280551', '', 'Co Aprovel 150/12.5mg 1s', '5.91', '4.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(547, '202210280552', '', 'Co diovan tab 160mg/12.5 mg 1s', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(548, '202210280553', '', 'Co diovan tab 80mg/12.5 mg 1s', '6.15', '4.55', 130, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(549, '202210280554', '', 'Co Entramol (Para & Codein) 12s', '8.00', '5.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(550, '202210280555', '', 'COA FS LIQUID', '145.80', '114.53', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(551, '202210280556', '', 'Coartem 20/120mg 12s Dispersible (Blue)', '43.09', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(552, '202210280557', '', 'Coartem 20/120mg 18S', '34.47', '25.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(553, '202210280558', '', 'COARTEM 80/480MG TAB 6S', '133.32', '72.72', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(554, '202210280559', '', 'Coartem Dispersible 20/120mg Tab 6s (Yellow)NOVARTIS', '43.09', '31.82', 52, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(555, '202210280560', '', 'Coconut oil 1L. (Host)', '36.93', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(556, '202210280561', '', 'Coconut oil 2Lit. (Host)', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(557, '202210280562', '', 'Coconut Oil 500ml (Host)', '20.93', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(558, '202210280563', '', 'Code Free Plus Strips 50s', '187.47', '147.26', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(559, '202210280564', '', 'Coffee Mate 1.9kg', '138.86', '109.08', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(560, '202210280565', '', 'col', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(561, '202210280566', '', 'Coldiron Syp 125ml', '16.01', '11.82', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(562, '202210280567', '', 'COLDRILIF CAP 10S', '7.12', '4.35', 88, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(563, '202210280568', '', 'COLDRILIF SYR 60ML', '14.78', '10.91', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(564, '202210280569', '', 'Colestop (Atorvastatin) lek 20mg 3/pck10s', '23.70', '17.50', 75, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(565, '202210280570', '', 'Colestop(Atorvastatin) 10mg 3/pck 10s', '24.59', '26.36', 31, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(566, '202210280571', '', 'colgate 2-5year (Brush)', '9.85', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(567, '202210280572', '', 'COLGATE BRUSH (SINGLE)', '7.60', '5.45', 36, '2', 'assets/data/products/noimage.png', 'ACTIVE'),
(568, '202210280573', '', 'Colgate Brush charcoal', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(569, '202210280574', '', 'Colgate Brush Double (Value Pac)', '12.31', '9.09', 392, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(570, '202210280575', '', 'colgate brush double action', '7.39', '5.45', 163, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(571, '202210280576', '', 'COLGATE BRUSH EXTRA SOFT KIDS', '7.60', '3.64', 144, '2', 'assets/data/products/noimage.png', 'ACTIVE'),
(572, '202210280577', '', 'COLGATE BRUSH TWISTER', '8.55', '6.36', 140, '2', 'assets/data/products/noimage.png', 'ACTIVE'),
(573, '202210280578', '', 'COLGATE BRUSH ZIGZAG', '12.31', '9.09', 48, '2', 'assets/data/products/noimage.png', 'ACTIVE'),
(574, '202210280579', '', 'COLGATE CAVITY  PASTE', '12.35', '7.27', 48, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(575, '202210280580', '', 'Colgate Charcoal Gentle Clean Paste.', '16.01', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(576, '202210280581', '', 'COLGATE HERBAL TOOTHPASTE 140G (MEDIUM)', '14.78', '12.73', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(577, '202210280582', '', 'Colgate Herbal toothpaste 230g(big)', '17.23', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(578, '202210280583', '', 'Colgate Herbal ToothPaste 70g(small)', '13.54', '10.00', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(579, '202210280584', '', 'Colgate Max Fresh toothpaste', '13.54', '10.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(580, '202210280585', '', 'Colgate Mouth Wash 250ml', '30.77', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(581, '202210280586', '', 'Colgate Mouth Wash 500ml', '49.86', '36.81', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(582, '202210280587', '', 'Colgate Natural Charcoal Paste', '23.39', '17.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(583, '202210280588', '', 'Colgate Paste Baby 0-2yrs Paste', '17.23', '12.73', 2, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(584, '202210280589', '', 'Colgate Paste for kids(Bubble fruit)', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(585, '202210280590', '', 'COLGATE PASTE TRIPLE ACTION', '12.35', '9.09', 72, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(586, '202210280592', '', 'Colgate pemon paste', '18.47', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(587, '202210280593', '', 'Colgate Smile Junior 6yr+', '17.23', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(588, '202210280594', '', 'Colgate Total Paste', '22.17', '16.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(589, '202210280595', '', 'Colodium', '6.15', '4.55', 102, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(590, '202210280596', '', 'Combantrin Tab', '24.62', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(591, '202210280597', '', 'Combat-N 30g cream', '9.23', '6.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(592, '202210280598', '', 'Combigan Eye Drops', '320.20', '236.43', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(593, '202210280599', '', 'COMIT 50MG TAB', '19.96', '12.27', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(594, '202210280600', '', 'Compact Anti-Bactirial Wipes', '43.09', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(595, '202210280601', '', 'Complan 4x 55g', '62.79', '46.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(596, '202210280602', '', 'Complan Original 425g', '72.02', '53.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(597, '202210280603', '', 'Confido', '47.64', '35.18', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(598, '202210280604', '', 'CONGESTYL SUSP 60ML(NASAL& COMMON COLD)', '33.25', '20.91', 36, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(599, '202210280605', '', 'Congestyl Tab.', '17.62', '11.82', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(600, '202210280606', '', 'Contac Dual Relief 18s', '73.86', '54.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(601, '202210280607', '', 'Contempo Condoms(all)', '16.01', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(602, '202210280608', '', 'Contiflo (Tamsulosin) XL 400mg  (Ranbaxy)10s 3/pck', '17.23', '12.73', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(603, '202210280609', '', 'Cool Eyes Drop', '27.69', '20.45', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(604, '202210280610', '', 'Corbis (Bisoprolol)(Unichem) 5mg Tab 10s', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(605, '202210280611', '', 'Corbis 10mg 10s', '14.78', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(606, '202210280612', '', 'Cordipin Retard 20mg Tab. 15s 2/pck', '23.39', '17.27', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(607, '202210280613', '', 'Cororange Cap', '10.46', '7.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(608, '202210280614', '', 'CORORANGE DROPS 15ML', '13.30', '15.45', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(609, '202210280615', '', 'Cororange plus Syrup 200ml', '22.17', '16.36', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(610, '202210280616', '', 'Corsodyl Mouth Wash 300ml', '72.02', '53.18', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(611, '202210280617', '', 'Corsodyl mouthwash 500ml', '83.09', '61.36', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(612, '202210280618', '', 'Cotton Buds 100S (Johnson)', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(613, '202210280619', '', 'Coveram 10mg 30S', '192.67', '151.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(614, '202210280620', '', 'Coveram 10mg 30s', '192.67', '151.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(615, '202210280621', '', 'Coversyl 10mg 30s', '249.30', '184.07', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(616, '202210280622', '', 'Coversyl 5mg Tab 30S', '140.60', '110.44', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(617, '202210280623', '', 'Coversyl Plus 10mg/2.5mg 30S', '234.87', '184.49', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(618, '202210280624', '', 'Coversyl Plus 5mg/1.25mg 30S', '157.34', '116.17', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(619, '202210280625', '', 'Coversyl Plus 5mg/1.25mg 30s', '157.34', '116.17', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(620, '202210280626', '', 'Covonia  Bronchial Balsam original 150ml', '46.17', '34.09', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(621, '202210280627', '', 'Covonia  Herbal Mucus Cough 300ml', '73.86', '54.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(622, '202210280628', '', 'Covonia Catarrh 100ml', '46.78', '34.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(623, '202210280629', '', 'Covonia Chesty 150ml', '46.78', '34.54', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(624, '202210280630', '', 'Covonia Chesty Sugar Free 150ml', '38.17', '28.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(625, '202210280631', '', 'Covonia Dry tickly 150ml', '39.88', '29.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(626, '202210280632', '', 'Covonia Mucus 150ml', '54.15', '42.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(627, '202210280633', '', 'Covonia Night Time 150ml', '44.92', '33.18', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(628, '202210280634', '', 'Covonia Sugar Free dry 150ml', '34.47', '25.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(629, '202210280635', '', 'Creatine X3 60s', '101.55', '79.77', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(630, '202210280636', '', 'CREPE BANDAGE (GREENLIFE-CANADA) 15CM*4.5M ', '7.75', '6.30', 0, '1', 'assets/data/products/noimage.png', 'INACTIVE'),
(631, '202210280637', '', 'Crepe Bandage (Unirob)3inches', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(632, '202210280638', '', 'Crepe Bandage (Unirob)4inches', '8.00', '5.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(633, '202210280639', '', 'CREPE BANDAGE 2 (5CM*4.5CM', '6.66', '4.55', 44, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(634, '202210280640', '', 'CREPE BANDAGE 4\'\'', '12.31', '9.09', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(635, '202210280641', '', 'Crepe Bandage 8 (Cotton/Off-White)', '17.23', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(636, '202210280642', '', 'CREPE ELASTIC BANDAGE 10CM*4M(UNION)', '13.33', '5.45', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(637, '202210280643', '', 'CREPE ELASTIC BANDAGE 15CM*4.5CM (UNION)', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(638, '202210280644', '', 'HEAVY ELASTIC BANDAGE 20CM*4.5M', '35.35', '23.23', 44, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(639, '202210280645', '', 'CREPE ELASTIC BANDAGE 3CM*4.5YD(UNIROB)', '5.54', '4.09', 52, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(640, '202210280646', '', 'Crepe Elastic Bandage 7.5cm*4.5', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(641, '202210280647', '', 'Crepe Elastic Bandage(5cm*4.5m)', '6.15', '4.55', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(642, '202210280648', '', 'Crestor 5mg 1S', '8.62', '6.36', 280, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(643, '202210280649', '', 'Crestor Tab 10mg 1S 28/pck', '10.04', '6.18', 415, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(644, '202210280650', '', 'Crestor Tab 20mg 1S 28/pck', '11.90', '12.73', 170, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(645, '202210280651', '', 'Cromax 2 Eye Drops', '57.62', '42.54', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(646, '202210280652', '', 'Cromax 4 Eye Drops', '62.18', '45.90', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(647, '202210280653', '', 'Crystaline Pen. Inj. 1mu 1s', '1.23', '0.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(648, '202210280654', '', 'Cusimolol 0.5 percent Eye Drop', '24.62', '18.18', 17, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(649, '202210280655', '', 'Cussons Baby Jelly 85ml', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(650, '202210280656', '', 'Cussons Baby Lotion 200ml', '9.85', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(651, '202210280657', '', 'Cyclogest 200mg 1S pessaries 15/pck', '14.78', '10.91', 300, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(652, '202210280658', '', 'Cyclogest 400mg 1S pessaries 15/pck', '27.69', '20.45', 105, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(653, '202210280659', '', 'Cyfen syrup 200ml', '25.87', '19.09', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(654, '202210280660', '', 'Cyprodine Caps 30S', '67.69', '42.54', 14, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(655, '202210280661', '', 'Cyprodine Syp 200ml', '67.69', '42.54', 3, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(656, '202210280662', '', 'Cypron plus syp', '16.01', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(657, '202210280663', '', 'Cypron Plus tab', '3.08', '2.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(658, '202210280664', '', 'Cystone Tab. 100s (10)', '45.55', '33.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(659, '202210280665', '', 'Cytotec (Misoprostol) 200mg 1s', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(660, '202210280666', '', 'D Artepp 40/320 1s', '3.08', '2.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(661, '202210280667', '', 'D artepp 80/640mg 1s', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(662, '202210280668', '', 'D&E Lubricant ', '29.54', '21.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(663, '202210280669', '', 'Daflon 500mg 1s 30/pck', '6.15', '4.55', 300, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(664, '202210280670', '', 'Daktacort (Miconazole) topical Cream 15g(Janssen)', '48.45', '33.75', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(665, '202210280671', '', 'Daktarin (Miconazole) topical Cream 15g(Janssen)', '47.69', '33.23', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(666, '202210280672', '', 'Daktarin Oral Gel 40g', '72.57', '53.59', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(667, '202210280673', '', 'Daktarin Tinture ', '176.54', '138.67', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(668, '202210280674', '', 'Dalacin C 150mg 10s 10/Pck', '59.01', '46.36', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(669, '202210280675', '', 'Dalacin C 300mg Caps. 1s(16/pck.)', '15.26', '14.09', 184, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(670, '202210280676', '', 'Dalacin C Inj 300mg/2ml', '94.79', '69.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(671, '202210280677', '', 'Dalacin c Susp. 75mg/5ml', '86.79', '68.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(672, '202210280678', '', 'Dan Rub', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(673, '202210280679', '', 'Dandelion Tea 25 Bags', '16.62', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(674, '202210280680', '', 'Dandelion Tea 50s Bags', '33.24', '24.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(675, '202210280681', '', 'Danegan Syrp (Promethazine )', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(676, '202210280682', '', 'Daonil Tab 5mg 10S sanofi', '11.42', '15.91', 90, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(677, '202210280683', '', 'Dawn Of Life 200ml', '22.17', '16.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(678, '202210280684', '', 'Day & Night Nurse Caps.', '138.52', '108.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(679, '202210280685', '', 'DAY NURSE CAPS', '99.44', '71.01', 18, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(680, '202210280686', '', 'Day Nurse syp.(Non-Drowsy)240ml gsk', '156.76', '116.17', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(681, '202210280687', '', 'Decatylen Lozenge 10s', '34.47', '25.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(682, '202210280688', '', 'Deep Freeze Gel 100g', '79.85', '62.72', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(683, '202210280689', '', 'Deep Freeze Gel 35g', '43.09', '31.82', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(684, '202210280690', '', 'Deep Freeze Spray 150ml', '77.59', '60.95', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(685, '202210280691', '', 'DEEP HEAT RUB 100G', '45.35', '28.93', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(686, '202210280692', '', 'Deep Heat Rub 15g', '14.78', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(687, '202210280693', '', 'Deep Heat Rub 35g', '38.17', '28.18', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(688, '202210280694', '', 'Deep Heat Rub 67g', '45.55', '33.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(689, '202210280695', '', 'Deep Heat Spray 150ml', '66.03', '60.95', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(690, '202210280696', '', 'Demacot Cream 15g', '20.93', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(691, '202210280697', '', 'Dental Floss', '24.62', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(692, '202210280698', '', 'Depo Medrol Inj.40mg/ml', '54.39', '42.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(693, '202210280699', '', 'Dermiron Plus Cream', '8.62', '6.36', 26, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(694, '202210280700', '', 'Dermofix Cream 20g', '43.09', '31.82', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(695, '202210280701', '', 'Dermovate 0.05 percent Cream 25g', '55.55', '43.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(696, '202210280702', '', 'Dettol 125ml ', '24.62', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(697, '202210280703', '', 'DETTOL 1LT', '120.54', '81.81', 12, '2', 'assets/data/products/noimage.png', 'ACTIVE'),
(698, '202210280704', '', 'Dettol 250ml Original', '32.01', '23.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(699, '202210280705', '', 'DETTOL 30 PERCENTEXTRA FREE 165ML', '31.35', '20.00', 64, '2', 'assets/data/products/noimage.png', 'ACTIVE'),
(700, '202210280706', '', 'DETTOL 500ML ORIGINAL', '75.23', '47.45', 28, '2', 'assets/data/products/noimage.png', 'ACTIVE'),
(701, '202210280707', '', 'DETTOL 750ML', '82.78', '56.45', 12, '2', 'assets/data/products/noimage.png', 'ACTIVE'),
(702, '202210280708', '', 'Dettol Soap', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(703, '202210280709', '', 'Dexatrol Eye Drops 5ml', '29.54', '21.82', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(704, '202210280710', '', 'Dexatrol Eye Oint', '22.17', '16.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(705, '202210280711', '', 'Dexone Tablet 0.5mg', '3.70', '2.73', 35, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(706, '202210280712', '', 'Dexorange Plus Syrp 200ml', '27.69', '20.45', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(707, '202210280713', '', 'Dextrose 5 percent infusion 500ml', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(708, '202210280714', '', 'Dextrose Sline (DNS) Infusion500ml', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(709, '202210280715', '', 'Diabetmin Tab 500mg hovid 10/pck10S', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(710, '202210280716', '', 'Diabetone Cap. UK 30s', '53.73', '39.68', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(711, '202210280717', '', 'Diagellates 125ml', '25.87', '19.09', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(712, '202210280718', '', 'DIAGELLATES 250ML', '36.10', '22.73', 24, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(713, '202210280719', '', 'Diagellates 500ml', '77.57', '57.27', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(714, '202210280720', '', 'Diamicron MR 30mg 1S 56/pck', '4.32', '3.18', 516, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(715, '202210280721', '', 'Diamicron MR 60mg 1S 30/pck', '4.95', '3.66', 500, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(716, '202210280722', '', 'Diane 35', '71.41', '52.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(717, '202210280723', '', 'Diazepam 10 Tab. 10S', '1.23', '0.91', 65, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(718, '202210280724', '', 'Diazepam 5 Tab. 10S', '1.23', '0.91', 225, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(719, '202210280725', '', 'DICLO DENK  (RECTAL) SUPP 100MG 1S 10/PCK', '7.12', '5.45', 246, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(720, '202210280726', '', 'Diclo Denk 75mg Injection 1s', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(721, '202210280727', '', 'Diclo Denk tab (Retard) 100mg 10s', '30.89', '21.09', 63, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(722, '202210280728', '', 'Diclo Denk Tab 50mg 10S', '9.85', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(723, '202210280729', '', 'Diclofenac 150mg (Sandoz) 10s', '17.23', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(724, '202210280730', '', 'DICLOFENAC 75MG (SANDOZ) 10S 2/PCK', '16.15', '9.54', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(725, '202210280731', '', 'Diclofenac Inj.10/pk 75mg (Troge) 1s', '1.23', '0.91', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(726, '202210280732', '', 'Diclofenac Sodium 50mg (Teva)', '13.54', '10.00', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(727, '202210280733', '', 'Diclolex Power Heat GEL30g', '12.31', '9.09', 7, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(728, '202210280734', '', 'Diclolex Tab 100mg', '3.70', '2.73', 26, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(729, '202210280735', '', 'Dicolex 100mg ', '2.45', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(730, '202210280736', '', 'Diflucan Cap 150mg', '209.72', '128.70', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(731, '202210280737', '', 'DIGOXIN 125MG UK BRISTIL 14S', '14.73', '9.09', 16, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(732, '202210280738', '', 'Digoxin 250mcg 14s UK', '16.62', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(733, '202210280739', '', 'Dihydrocodine 30mg 10s', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(734, '202210280740', '', 'Dilatrend (Carvedilol) 25mg 1S', '9.85', '7.27', 190, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(735, '202210280741', '', 'Dilatrend Carvedilol 12.5mg 30/pck 1S', '8.00', '5.91', 175, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(736, '202210280742', '', 'Dilatrend Carvedilol 6.25mg 1', '5.54', '4.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(737, '202210280743', '', 'Diovan tabs 160mg 1S', '7.39', '5.45', 140, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(738, '202210280744', '', 'Diovan tabs 80mg 1S', '7.39', '5.45', 140, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(739, '202210280745', '', 'Diphex Bronch. Syrup 100ml', '14.15', '10.45', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(740, '202210280746', '', 'Diphex Junior cough syrup. 100ml', '11.70', '8.64', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(741, '202210280747', '', 'Diprosin Cream 30g', '4.92', '3.64', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(742, '202210280748', '', 'Diproson Cream 400gm', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(743, '202210280749', '', 'DIPROSON LOTION 30ML', '8.55', '5.00', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(744, '202210280750', '', 'Disposable Face Mask 1s', '0.63', '0.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(745, '202210280751', '', 'Disposable Face Mask Pack 50s', '20.93', '15.45', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(746, '202210280752', '', 'Disposable Mask Pack ( kids) ', '14.78', '10.91', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(747, '202210280753', '', 'Disposable Mask Pack (Earloop) ', '14.78', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(748, '202210280754', '', 'Disposable Mask Pack KN 95 ', '19.96', '16.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(749, '202210280755', '', 'Disposable Pants', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(750, '202210280756', '', 'Dithranol Ointment', '9.85', '7.27', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(751, '202210280757', '', 'DOMI 10 SUPP 5/PCK 1S', '4.76', '3.18', 78, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(752, '202210280758', '', 'Domi 30 Supp 1S', '4.32', '3.18', 76, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(753, '202210280759', '', 'Dopatab (Methyldopa) 250mg 10s 10/pck', '10.46', '7.73', 170, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(754, '202210280760', '', 'DORETA 37.5/325MG 2/PCK  10S', '52.15', '39.54', 44, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(755, '202210280761', '', 'Dormicum (Midazolam)15mg', '11.08', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(756, '202210280762', '', 'Dostinex 0.5mg 1s', '70.31', '55.23', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(757, '202210280763', '', 'Dove Baby Shampoo 200ml', '17.23', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(758, '202210280764', '', 'Dove Bath gel 750ml', '48.76', '36.36', 45, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(759, '202210280765', '', 'Dove Deo Spray (Men/Women)', '32.01', '23.63', 90, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(760, '202210280766', '', 'Dove Deo Stick', '9.85', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(761, '202210280767', '', 'Dove Indulging Cream Bath 500ml', '39.28', '26.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(762, '202210280768', '', 'Dove Roll on', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(763, '202210280769', '', 'Doxazosin 2mg 28s', '16.01', '11.82', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(764, '202210280770', '', 'Doxazosin 4mg 28s (Milpharm)', '16.62', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(765, '202210280771', '', 'Doxazosin 4mg 28s (Teva)', '25.87', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(766, '202210280772', '', 'DOXYCYCLINE 100MG (ECL)LOCAL 10S 20/PCK', '6.66', '4.55', 158, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(767, '202210280773', '', 'Doxycycline 100mg (Exerter/accord/kent) 10s', '20.93', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(768, '202210280774', '', 'Doxycycline 200mg (ECL) 10S', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(769, '202210280775', '', 'Doxycycline 50mg (Accord) 14s 2/pck', '24.00', '17.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(770, '202210280776', '', 'Dragon lozenges  1s 4/pck', '16.01', '11.82', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(771, '202210280777', '', 'DRAGON SPRAY', '66.97', '42.63', 75, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(772, '202210280778', '', 'Dragon Tablets 1s 4/pck', '10.46', '7.73', 9, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(773, '202210280779', '', 'DREZ OINT. 10G', '23.95', '10.00', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(774, '202210280780', '', 'DREZ OINT. 30G', '45.65', '18.18', 56, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(775, '202210280781', '', 'DREZ POWDER 10G', '34.79', '11.00', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(776, '202210280782', '', 'Drez Solution 100ml B/S', '58.18', '24.54', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(777, '202210280783', '', 'DREZ SOLUTION 30ML S/S', '34.20', '14.54', 24, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(778, '202210280785', '', 'DREZ V GEL 30G', '76.66', '27.27', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(779, '202210280786', '', 'Dristan Nasal Spray 15ml', '59.83', '44.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(780, '202210280787', '', 'Dry Cry Eye Drops', '15.39', '11.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(781, '202210280788', '', 'Dulcolax 10mg Supp. 1s', '5.54', '4.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(782, '202210280789', '', 'DULCOLAX 5MG TAB UK 1S 20/PCK', '1.76', '1.12', 140, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(783, '202210280790', '', 'Duphalac 300ml', '43.09', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(784, '202210280791', '', 'Durex 2 in 1 Massage Gel 200ml', '109.56', '80.90', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(785, '202210280792', '', 'DUREX CONDOMS 3S (ALL)', '20.90', '10.91', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(786, '202210280793', '', 'Durex Extra Safe 6s', '66.47', '49.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(787, '202210280794', '', 'Durex Intimate Condom 12s', '48.21', '35.59', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(788, '202210280795', '', 'Durol 300ml', '21.54', '15.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(789, '202210280796', '', 'Durol Junior 200ml syp.', '12.31', '9.09', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(790, '202210280797', '', 'Durol tonic 200ml (Dannex)', '20.31', '15.00', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(791, '202210280798', '', 'Duromine 30mg 1S', '24.62', '18.18', 75, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(792, '202210280799', '', 'Dyclo Spray 60ml', '86.43', '63.81', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE');
INSERT INTO `products_master` (`id`, `pid`, `barcode`, `pname`, `sprice`, `cprice`, `qty`, `cat`, `pimg`, `status`) VALUES
(793, '202210280800', '', 'DYKLO SPRAY 60ML', '104.70', '85.90', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(794, '202210280801', '', 'DYMOL 50/500MG TAB', '8.08', '5.10', 62, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(795, '202210280802', '', 'Dynamogen supp 1s 20/pck', '8.62', '6.36', 225, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(796, '202210280803', '', 'DYNEWELL SYP. 200ML', '11.64', '6.36', 62, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(797, '202210280804', '', 'DYNEWELL TAB 10S 50/PCK', '0.96', '0.45', 100, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(798, '202210280805', '', 'E45 Cream 125g', '49.25', '36.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(799, '202210280806', '', 'Easy Check Ovulation Kit 2s', '39.39', '29.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(800, '202210280807', '', 'EASY One Step Pregnancy Test Kit 50/pck', '8.62', '6.36', 602, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(801, '202210280808', '', 'EASY TOUCH GLUCOMETER', '172.36', '127.26', 24, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(802, '202210280809', '', 'EASY TOUCH GLUCOMETER STRIPS', '172.36', '127.26', 64, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(803, '202210280810', '', 'Easylife Ferovita Syrup', '44.32', '32.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(804, '202210280811', '', 'Easylife/Valupak VitaminC + 10mg Zinc 1000mg', '35.45', '26.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(805, '202210280812', '', 'Easyon Starch ', '24.62', '18.18', 46, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(806, '202210280813', '', 'Ecowas Examination Gloves 1s', '2.45', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(807, '202210280814', '', 'Ecowax Examination Gloves pack', '93.06', '68.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(808, '202210280815', '', 'Efpac Junior 100ml', '7.06', '10.00', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(809, '202210280816', '', 'Efpac Tab  sachet 10s 30/pck', '3.70', '2.73', 289, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(810, '202210280817', '', 'Ekuro Bewu Cream', '15.39', '11.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(811, '202210280818', '', 'Elbow Support ', '18.47', '13.64', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(812, '202210280819', '', 'Electronic Blood Pressure Monitor', '307.77', '227.25', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(813, '202210280820', '', 'Electronic Blood Pressure Monitor ( Aviche)', '430.88', '318.15', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(814, '202210280821', '', 'ELOCON CREAM 30G', '77.57', '57.27', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(815, '202210280822', '', 'Emgikof Syrup 100ml (All)', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(816, '202210280823', '', 'Enacef (Cefuroxime) Susp. 50ml', '29.54', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(817, '202210280824', '', 'Enacef 500mg 10tabs ECL 1s', '7.39', '5.45', 190, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(818, '202210280825', '', 'Enacin (Clindamycin) 300mg 10s', '12.93', '9.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(819, '202210280826', '', 'Enacin C (Clindamycin) 150mg 10s', '9.85', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(820, '202210280827', '', 'Enafen (Ibuprofen ) 400mg 10s', '1.23', '0.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(821, '202210280828', '', 'Enafix (Cefixime) Sups 100ml', '24.62', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(822, '202210280829', '', 'Enalapril 10mg 28s (Milharm)', '27.69', '20.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(823, '202210280830', '', 'Enalapril 5mg 28s (Teva)', '27.09', '20.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(824, '202210280831', '', 'Enamycin 250mg Tab 10s', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(825, '202210280832', '', 'Enamycin125 susp 100ml(ECL)', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(826, '202210280833', '', 'ENAT 400MG CAPS', '83.21', '52.36', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(827, '202210280834', '', 'Encephabol Syr', '160.66', '118.62', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(828, '202210280835', '', 'Energizer 9V', '20.31', '15.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(829, '202210280836', '', 'Energizer AA 4', '16.62', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(830, '202210280837', '', 'Energizer AA 6S', '22.78', '16.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(831, '202210280838', '', 'Energizer AAA 2S', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(832, '202210280839', '', 'Energizer AAA 4s', '16.62', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(833, '202210280840', '', 'Enoral (Ketaconazole) 200mg', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(834, '202210280841', '', 'Enterogermina Oral Susp 5ml 10/pck', '8.00', '5.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(835, '202210280842', '', 'Entramol D (Para & Dihydramine) 12s', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(836, '202210280843', '', 'Entramol Extra (Para & Ephedrin) 12s', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(837, '202210280844', '', 'Entramol Plus (Para & Cafein) 12s', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(838, '202210280845', '', 'Entrance Liver Salt 1s', '0.63', '0.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(839, '202210280846', '', 'Envico cold and flu Syrup', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(840, '202210280847', '', 'EPANOL PARA SYRUP 100ML ECL', '10.45', '5.45', 24, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(841, '202210280848', '', 'Ephedrin nasal drop 1 percent local', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(842, '202210280849', '', 'Epiciprim Eye Ointment ', '14.78', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(843, '202210280850', '', 'Epiciprin Eye Drop', '23.39', '17.27', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(844, '202210280851', '', 'EPICROM EYE DROP 2% 10ML', '30.40', '19.09', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(845, '202210280852', '', 'EPICROM EYE DROP 4 PERCENT', '35.91', '22.75', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(846, '202210280853', '', 'epidem cream 30G', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(847, '202210280854', '', 'Epiderm Cream 15g', '6.15', '4.55', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(848, '202210280855', '', 'Epiderm Cream 30g', '10.46', '7.73', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(849, '202210280856', '', 'Epifenac 1mg/ml', '43.09', '31.82', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(850, '202210280857', '', 'Epilim syrup 300ml', '196.67', '145.22', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(851, '202210280859', '', 'EPILIM TAB 200ML 10S', '47.02', '28.63', 53, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(852, '202210280860', '', 'Epson Salt 300g UK', '35.69', '26.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(853, '202210280861', '', 'Erythromycin (Letap) Syrup 100ml', '4.92', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(854, '202210280862', '', 'Erythromycin(Enamycin) Susp ECL', '9.85', '7.27', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(855, '202210280863', '', 'Escape Disp. Panties', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(856, '202210280864', '', 'Eskabrium(Chlordiazeporide)10mg cap.', '0.99', '0.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(857, '202210280865', '', 'Eskadol Nyte 10s', '2.45', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(858, '202210280866', '', 'Eskypan  10mg tab', '6.15', '4.55', 75, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(859, '202210280867', '', 'Eurax Cream 30g', '64.01', '47.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(860, '202210280868', '', 'Eusol Lotion 200ml', '3.08', '2.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(861, '202210280869', '', 'Euthymol Tooth Paste', '43.09', '31.82', 33, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(862, '202210280870', '', 'Evanova Caps', '60.32', '44.54', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(863, '202210280871', '', 'Evening Primrose (Basic Nutrition)', '20.93', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(864, '202210280872', '', 'Evening Promise (Valupak) ', '22.17', '16.36', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(865, '202210280873', '', 'Eversheen Cocoa Bt  Lottion B/S', '25.87', '19.09', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(866, '202210280874', '', 'Eversheen Cocoa Bt Cream B/S ', '24.62', '18.18', 26, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(867, '202210280875', '', 'Eversheen Cocoa Bt Cream S/S', '13.54', '10.00', 50, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(868, '202210280876', '', 'Exclear nasa drop ', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(869, '202210280877', '', 'Exclofen (Diclofenac) Eye Drops', '11.08', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(870, '202210280878', '', 'Exetrim Susp. 240mg/5ml', '11.08', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(871, '202210280879', '', 'Exforge 10/160/12.5mg (HCT) 1S 28/pck Novartis', '11.63', '10.91', 88, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(872, '202210280880', '', 'Exforge 10/160/25mg HCT 1S 28/pck Novartis', '8.24', '6.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(873, '202210280881', '', 'Exforge 10mg/160mg 1S 28/pck Novartis', '11.63', '10.91', 123, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(874, '202210280882', '', 'Exforge 5/160/12.5mg 1S 28/pck', '11.82', '9.09', 420, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(875, '202210280883', '', 'Exforge 5/160/25 1s', '9.85', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(876, '202210280884', '', 'Exforge 5mg/160mg 28tabs 1s(Amlodipine)novartis', '9.85', '7.27', 145, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(877, '202210280885', '', 'Extra Dark Chocolate (Niche)', '9.23', '6.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(878, '202210280886', '', 'Extraflex glucosamine', '62.79', '46.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(879, '202210280887', '', 'Extrammune syrup', '61.55', '45.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(880, '202210280888', '', 'Extrammune Tab. 20s', '50.48', '37.27', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(881, '202210280889', '', 'exure Natural Pleasure Condom', '25.87', '19.09', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(882, '202210280890', '', 'Exylin Dry Cough 100ml', '14.78', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(883, '202210280891', '', 'Exylin Orig. Cough 100ml', '14.78', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(884, '202210280892', '', 'Eyecopen Caps 30S', '45.20', '30.91', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(885, '202210280893', '', 'Ezipen Tab (M&G) 5/pck6s', '4.32', '3.18', 60, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(886, '202210280894', '', 'Fabric Nose Mask', '3.70', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(887, '202210280895', '', 'Face Sheild', '49.25', '36.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(888, '202210280896', '', 'Facial Scrub/wash (Exfolate)', '64.01', '47.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(889, '202210280897', '', 'Fama Cold Tabs 4S', '2.45', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(890, '202210280898', '', 'Far Away Perfum. (Avon) all', '88.64', '65.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(891, '202210280899', '', 'Fastum (Ketoprofen) gel 2.5 percent', '34.47', '25.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(892, '202210280900', '', 'Fat Burner', '83.09', '61.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(893, '202210280901', '', 'Febreze Airfresher', '36.93', '27.27', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(894, '202210280902', '', 'Feldene (Piroxicam) Caps 20mg', '94.18', '77.27', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(895, '202210280903', '', 'Fem X Tabs', '128.53', '94.90', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(896, '202210280904', '', 'Femfresh Deodorant 150ml', '40.63', '30.00', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(897, '202210280905', '', 'Femfresh Intimate Care', '44.32', '32.72', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(898, '202210280907', '', 'Feminax Express', '46.78', '34.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(899, '202210280908', '', 'Feminine wash (Beauty)', '14.78', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(900, '202210280909', '', 'Fenbase Extra 10S', '4.92', '3.64', 265, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(901, '202210280910', '', 'Feroglobin 500 Syrup (Family Size)', '186.13', '137.44', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(902, '202210280911', '', 'Feroglobin Caps 30S', '91.06', '67.90', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(903, '202210280912', '', 'Feroglobin Plus Syrup 200ml', '147.00', '109.63', 17, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(904, '202210280913', '', 'FEROGLOBIN SYRUPLIQUID 200ML', '89.68', '60.78', 38, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(905, '202210280914', '', 'Ferovita Drops', '36.93', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(906, '202210280915', '', 'Ferrodex Syrup 200ml', '12.31', '9.09', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(907, '202210280916', '', 'Ferrous Sulphate 200mg 28s (Essential)', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(908, '202210280917', '', 'Ferrous Sulphate UK', '14.78', '10.91', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(909, '202210280918', '', 'Ferrovita  B12 Blood Syrup 200ml', '49.25', '36.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(910, '202210280919', '', 'ferrovita caps', '1.23', '0.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(911, '202210280920', '', 'Fersolate Tab (Exeter)', '7.39', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(912, '202210280921', '', 'Fertilo Forte 1s', '3.08', '2.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(913, '202210280922', '', 'Festival Crush Splash', '88.64', '65.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(914, '202210280923', '', 'Fiesta Condom', '4.43', '5.45', 241, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(915, '202210280924', '', 'fiesta lubricant', '34.47', '25.45', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(916, '202210280925', '', 'Finasteride 5mg 14s (aurobido)', '11.70', '8.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(917, '202210280926', '', 'Finasteride 5mg 14s (Dr Reddys)', '13.54', '10.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(918, '202210280927', '', 'Finasteride 5mg 14s (Milpharm)', '33.24', '24.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(919, '202210280928', '', 'Finasteride 5mg 14s (Teva)', '14.78', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(920, '202210280929', '', 'FINASTERIDE 5MG 14S UK (CIPLA/EXETER)', '17.10', '10.00', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(921, '202210280930', '', 'FISHERMANS FRIEND (ALL)', '16.62', '12.27', 553, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(922, '202210280931', '', 'Flagentyl (Secnidaole) 500mgTab.', '57.24', '42.27', 31, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(923, '202210280932', '', 'FLAGYL SUSP 100ML', '75.70', '55.90', 11, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(924, '202210280933', '', 'Flarex 0.1 percent Eye Drop', '30.77', '22.73', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(925, '202210280934', '', 'Flat Tummy Herbal Tea', '52.94', '39.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(926, '202210280935', '', 'Flemex 5 percent Adult Cough Syrup ', '14.15', '10.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(927, '202210280936', '', 'Flemex Junior Syr.', '13.54', '10.00', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(928, '202210280937', '', 'Fleming  228.5 susp', '34.47', '25.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(929, '202210280938', '', 'FLEMING 625 SUSP ', '49.87', '31.61', 15, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(930, '202210280939', '', 'Flotac (Diclofenac) Caps 75mg 10s 2/pck', '80.12', '52.36', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(931, '202210280940', '', 'Floxapen Susp 125mg/5ml', '30.17', '22.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(932, '202210280941', '', 'Flucloxacillin 500mg 28s Medreich-Uk', '54.30', '40.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(933, '202210280942', '', 'Flucloxacillin 500mg 28s uk-Exerter', '38.77', '28.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(934, '202210280943', '', 'Flucona Denk 100mg', '33.41', '27.41', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(935, '202210280944', '', 'FLUCONAZOLE 150MG UK 1S (ALL)', '19.66', '12.73', 32, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(936, '202210280945', '', 'Fluconazole Denk 150mg caps', '45.09', '30.00', 64, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(937, '202210280946', '', 'Flucor Day Oil/Gel', '28.32', '20.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(938, '202210280947', '', 'Flucor Night Gel 8S', '31.02', '25.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(939, '202210280948', '', 'Fluogel Paste 75g', '10.46', '7.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(940, '202210280949', '', 'Fluoxetine 20mg UK 30s', '17.23', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(941, '202210280950', '', 'FLUREST TABS 10S', '28.21', '18.18', 52, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(942, '202210280951', '', 'FLUXACIN 250MG 10S (LOCALS)', '2.45', '1.82', 0, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(943, '202210280952', '', 'FLUXACIN 250MG 10S', '3.08', '2.27', 0, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(944, '202210280953', '', 'FLUXACIN 500MG CAP.(ECL) 10S 20/PCK', '14.96', '8.18', 60, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(945, '202210280954', '', 'FLUXACIN125MG (FLUCLOXACILLIN) 100ML SUSP.', '18.29', '10.00', 15, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(946, '202210280955', '', 'Fluxamox  500mg ECL 10s', '9.85', '7.27', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(947, '202210280956', '', 'Fluxamox Susp 250mlg 100ml (local)', '25.87', '15.91', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(948, '202210280957', '', 'fluxapen( Flucloxacillin) 100ml', '30.77', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(949, '202210280958', '', 'FML-Neo Eye Drops 5ml', '75.35', '55.63', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(950, '202210280959', '', 'Folic Acid (Locals) 10s', '0.63', '0.45', 101, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(951, '202210280960', '', 'Folic Acid (Valupak ) Tab 30s', '19.09', '14.09', 14, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(952, '202210280961', '', 'FOLIC ACID (VALUPAK) 90S', '28.32', '20.91', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(953, '202210280962', '', 'FOLIC ACID 28S (ACCORD/ALMUS) ', '16.62', '12.27', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(954, '202210280963', '', 'Folic Acid 28s (Crescent)', '17.62', '11.82', 53, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(955, '202210280964', '', 'Folic Acid 28s (wockhardt)', '14.78', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(956, '202210280965', '', 'Folic Acid Syp (Macrafolin)', '6.15', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(957, '202210280966', '', 'folic acid syrup uk 150ml', '142.92', '117.26', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(958, '202210280967', '', 'FOLIGROW CAPS. 30S', '33.87', '25.00', 12, '4', 'assets/data/products/noimage.png', 'ACTIVE'),
(959, '202210280968', '', 'FOLIGROW JUNIOR SYRUP 100ML', '27.55', '18.18', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(960, '202210280969', '', 'Foot powder Spray ', '43.09', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(961, '202210280970', '', 'Foot Powder Spray (Health Smart)', '20.31', '15.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(962, '202210280971', '', 'Fortilovit F plus', '890.06', '657.21', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(963, '202210280972', '', 'Fortilovit M plus', '769.43', '568.13', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(964, '202210280973', '', 'Forxiga (Dapagliflozin) 10mg 1s 28/pck', '24.37', '20.00', 150, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(965, '202210280974', '', 'Free Flex Ultra Caps. 60s', '132.96', '98.17', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(966, '202210280975', '', 'FRELET (CLOPIDOGREL)75MG', '35.62', '22.73', 13, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(967, '202210280976', '', 'Fresh and fruity paste', '27.69', '20.45', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(968, '202210280977', '', 'Frusemide 20mg uk(Actavis) 28s', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(969, '202210280978', '', 'Frusemide 40mg uk(Actavis) 28s', '12.31', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(970, '202210280979', '', 'Funbact-A Cream 30g', '14.78', '10.91', 48, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(971, '202210280980', '', 'Furosemide 20mg 28s (teva/bristol)', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(972, '202210280981', '', 'Furosemide 20mg 28s( Crescent', '16.62', '12.27', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(973, '202210280982', '', 'Furosemide 40mg (Bristol) 28s', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(974, '202210280983', '', 'Furosemide 40mg (Exeter) 28s', '8.62', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(975, '202210280984', '', 'Furosemide 40mg (teva) 28s', '17.23', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(976, '202210280985', '', 'Furosemide 40mg 28s( Crescent)', '14.15', '10.45', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(977, '202210280986', '', 'Furosemide 40mg 28s(Almus)', '11.08', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(978, '202210280987', '', 'Furosemide 40mg( Ernest chemists) 10s', '0.75', '0.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(979, '202210280988', '', 'Gacet Supp 1g 1S 5/pck', '7.39', '5.45', 151, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(980, '202210280989', '', 'GALFER  SYRP', '147.89', '94.08', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(981, '202210280990', '', 'Galfer 305mg capsules', '98.48', '72.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(982, '202210280991', '', 'Galvus 50mg 14s', '70.17', '51.81', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(983, '202210280992', '', 'GALVUS MET 50/1000MG 10S(6)', '65.83', '47.09', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(984, '202210280993', '', 'Galvus Met 50/500mg 10s', '70.91', '58.18', 75, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(985, '202210280994', '', 'Gamalate B6 10s', '30.77', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(986, '202210280995', '', 'Gana Balm 100g b/s', '34.47', '25.45', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(987, '202210280996', '', 'Gana Balm 20g S/s', '9.85', '7.27', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(988, '202210280997', '', 'Ganforte Eye Drops 3ml', '183.94', '135.80', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(989, '202210280998', '', 'Gastracid Liquid 200ml', '11.08', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(990, '202210280999', '', 'Gastrone Plus Susp. 200ml', '32.50', '21.82', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(991, '202210281000', '', 'Gastrone Syr 200ml', '31.91', '19.70', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(992, '202210281001', '', 'GAUZ MESH 6', '33.00', '22.00', 12, '1', 'assets/data/products/noimage.png', 'INACTIVE'),
(993, '202210281002', '', 'Gauze Bandage 3 (7.5cm*4.5m)', '1.96', '1.52', 53, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(994, '202210281003', '', 'GAUZE BANDAGE12\'\' 1S', '2.02', '1.01', 304, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(995, '202210281004', '', 'Gauze Bandage 6(15cm*3m)', '3.93', '3.03', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(996, '202210281005', '', 'Gaviscon  advance syp 250ml', '91.30', '78.28', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(997, '202210281006', '', 'GAVISCON DOUBLE ACTION SUSP.150ML', '112.11', '74.64', 13, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(998, '202210281007', '', 'Gaviscon Double Action tabs 12s', '43.59', '33.63', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(999, '202210281008', '', 'Gaviscon double action tabs 8s(24)', '32.99', '25.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1000, '202210281009', '', 'Gaviscon Peppermint 12s 2/pck', '31.22', '24.09', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1001, '202210281010', '', 'Gaviscon Peppermint syp 200ml', '81.64', '69.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1002, '202210281011', '', 'Gaviscon peppermint Tabs 24s', '51.25', '39.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1003, '202210281012', '', 'Gaviscon peppermint Tabs 8s uk', '68.33', '52.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1004, '202210281013', '', 'Gebedol Extra', '9.16', '7.07', 123, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1005, '202210281014', '', 'Gebedol Forte 10S', '5.23', '4.04', 125, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1006, '202210281015', '', 'GEBEDOL PLAIN 6/PK TAB 10S', '5.05', '4.04', 262, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1007, '202210281016', '', 'Gen M Syrp', '32.94', '37.37', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1008, '202210281017', '', 'Gen M Tab 80/480', '38.48', '49.49', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1009, '202210281018', '', 'Genecure 442 Caps', '17.02', '13.13', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1010, '202210281019', '', 'Gentamycin Eye Drop', '9.82', '7.58', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1011, '202210281020', '', 'Gentamycin inj 80mg/2ml 1s', '0.66', '0.51', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1012, '202210281021', '', 'GENTIAN VIOLET (GV PAINT) 60ML', '4.04', '2.53', 52, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1013, '202210281022', '', 'Gillete 2 Blade', '10.47', '8.08', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1014, '202210281023', '', 'Gillette stick', '45.81', '35.35', 7, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1015, '202210281024', '', 'Giloba Caps. 30s', '145.18', '79.79', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1016, '202210281025', '', 'Ginger Drink', '7.86', '6.06', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1017, '202210281026', '', 'Gingo Biloba caps', '96.01', '74.08', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1018, '202210281027', '', 'Ginsomin Caps', '122.46', '69.99', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1019, '202210281028', '', 'Ginsomin Eve Caps', '143.49', '110.72', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1020, '202210281029', '', 'GIVERS KOO CAPS', '33.33', '22.22', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1021, '202210281030', '', 'Givers Power Caps', '39.27', '30.30', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1022, '202210281031', '', 'Glasses @ 180 (Samall)', '235.61', '181.80', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1023, '202210281032', '', 'Glasses @ 250 (big-pink)', '327.24', '252.50', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1024, '202210281033', '', 'Glasses @190 (medium)', '248.70', '191.90', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1025, '202210281034', '', 'Glibenclamide tab I.P. 5mg 30s 20/pck(Emcure)', '22.91', '17.68', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1026, '202210281035', '', 'Glibenil 5mg 10S', '0.79', '0.61', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1027, '202210281036', '', 'Glibenil 5mg( Ernest)10S', '0.79', '0.61', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1028, '202210281037', '', 'Glibetics 5mg 10S(KINA)', '0.66', '0.51', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1029, '202210281038', '', 'Gliclazide 80mg (Genesis) 4/pck 15s', '9.16', '7.07', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1030, '202210281039', '', 'Gliclazide 80mg(Bristol)  28s', '32.72', '25.25', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1031, '202210281040', '', 'Gliclazide 80mg(Nuomed)  28s', '13.09', '10.10', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1032, '202210281041', '', 'Gliclazide 80mg(teva)  14s 2/pcks', '10.47', '8.08', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1033, '202210281042', '', 'GLOVES (ALL TYPES)100S', '71.99', '55.55', 34, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1034, '202210281043', '', 'GLUCO NAT D/C/P', '24.75', '16.67', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1035, '202210281044', '', 'Gluco Tab. 40mg', '13.09', '10.10', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1036, '202210281045', '', 'Glucolife C', '30.62', '12.12', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1037, '202210281046', '', 'Glucolife D', '30.62', '12.12', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1038, '202210281047', '', 'Glucolife plain 400g', '42.11', '16.67', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1039, '202210281048', '', 'Glucophage (Metformin) 500MG 2/pck 15s', '7.78', '6.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1040, '202210281049', '', 'Glucophage 500MG 4/pck 21s', '26.84', '20.71', 9, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1041, '202210281050', '', 'Glucophage(Metformin)  SR 1000mg 14s', '68.92', '59.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1042, '202210281051', '', 'Glucophage(Metformin)  SR 1000mg 15s 2/pck', '36.58', '31.36', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1043, '202210281052', '', 'Glucose (All)', '13.09', '10.10', 35, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1044, '202210281053', '', 'Glucovance 500/2.5mg 15', '37.96', '29.29', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1045, '202210281054', '', 'Glycerine (Care+) 200ml', '24.87', '19.19', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1046, '202210281055', '', 'Glycerol 1g Supp. 1s', '2.62', '2.02', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1047, '202210281056', '', 'GMK Opoku ( Transforming Org.& Nations) @ 40', '78.54', '60.60', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1048, '202210281057', '', 'GMK Opoku (Achieve your lifes purpose) @ 50', '78.54', '60.60', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1049, '202210281058', '', 'GMK Opoku( Monitoring & Evaluation)', '104.72', '80.80', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1050, '202210281059', '', 'Go cough 125ml syr', '10.47', '8.08', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1051, '202210281060', '', 'Gofex (Ibuprofen) 400mg 10s 6/pck', '16.30', '15.15', 90, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1052, '202210281061', '', 'GOGYNAX (CLOTRIMAZOLE 2 PERCENT) CREAM', '9.09', '6.06', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1053, '202210281062', '', 'GOGYNAX VAGINA(INSERT) PESS', '7.58', '4.95', 36, '4', 'assets/data/products/noimage.png', 'ACTIVE'),
(1054, '202210281063', '', 'Gramocef O (Cefuroxime) 200mg 1s', '7.33', '5.66', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1055, '202210281064', '', 'Green Petal Handwash 2 Lit.', '24.22', '18.69', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1056, '202210281065', '', 'Green Petal Liquid Soap 4.5 Lit', '39.27', '30.30', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1057, '202210281066', '', ' WOODWARD GRIPE WATER ', '69.35', '43.63', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1058, '202210281067', '', 'Griseofulvin 500mg 10s(O FULVIN)', '8.50', '6.57', 50, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1059, '202210281068', '', 'Griseofulvin Susp.125mg/5ml', '18.32', '14.14', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1060, '202210281069', '', 'Grison susp( griseofulvin)', '23.56', '18.18', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1061, '202210281070', '', 'Gsunate 120mg Injection', '43.20', '33.33', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1062, '202210281071', '', 'Gsunate inj. 60mg', '28.80', '22.22', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1063, '202210281072', '', 'Gudapet Syrup', '7.86', '6.06', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1064, '202210281073', '', 'Gv Fluc 120mg cap', '5.23', '4.04', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1065, '202210281074', '', 'Gv Fluc Susp.', '19.63', '15.15', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1066, '202210281076', '', 'Gvither Inj.10/pk (80mg) 1s(BlissGVSPharma)', '9.16', '7.07', 90, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1067, '202210281077', '', 'Gyanwaa Mask (Adult)', '19.63', '15.15', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1068, '202210281078', '', 'Gyanwaa Mask (Kids)', '17.02', '13.13', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1069, '202210281079', '', 'Gyno Daktarin Cream 40g', '79.52', '68.18', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1070, '202210281080', '', 'Gyno Daktarin Ovules 400mg 3S', '48.77', '41.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1071, '202210281081', '', 'Gyno Daktarin vaginal Cream 20mg', '116.62', '99.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1072, '202210281082', '', 'GYNO MYCOLEX PESS 400MG3S', '45.45', '30.30', 28, '4', 'assets/data/products/noimage.png', 'ACTIVE'),
(1073, '202210281083', '', 'Gyprone Plus Syrup', '17.02', '13.13', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1074, '202210281084', '', 'Gyprone Plus Tab 20s', '3.93', '3.03', 125, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1075, '202210281085', '', 'HAEMOGLOBIN + B12 (AYRTONS SAUNDERS UK)', '26.26', '17.53', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1076, '202210281086', '', 'Haemoglobin Syrup (Ayrton)', '10.47', '8.08', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1077, '202210281087', '', 'Haemoglobin Syrup(Letap)', '12.56', '8.08', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1078, '202210281088', '', 'Haemoglobin Syrup(MPG)', '15.71', '12.12', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1079, '202210281089', '', 'Hairfolic Woman Caps.', '262.71', '202.71', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1080, '202210281090', '', 'Haliborange Syp ', '161.40', '124.53', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1081, '202210281091', '', 'Hand Sanitizer (LOréal Paris)', '13.09', '10.10', 31, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1082, '202210281092', '', 'Hapiman Caps', '18.32', '14.14', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1083, '202210281093', '', 'Hayzine Syrup', '1.96', '1.52', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1084, '202210281094', '', 'Health Aid  vit D3 30S', '73.31', '56.56', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1085, '202210281095', '', 'health life Vit C (Tin)', '45.94', '39.39', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1086, '202210281096', '', 'Hemoglobine B12 200ml', '7.86', '6.06', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1087, '202210281097', '', 'Hepto Pep Syr 200ml', '28.80', '22.22', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1088, '202210281098', '', 'Herbal Sliming Tea', '64.14', '49.49', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1089, '202210281099', '', 'Hi Lady Virgin', '30.76', '23.74', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1090, '202210281100', '', 'Hibiscus Tea 20 Bags', '17.68', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1091, '202210281101', '', 'Hibiscus Tea 40 Bags', '35.34', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1092, '202210281102', '', 'HIMALAYA BONNISAN GRIPE WATER', '28.28', '24.24', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1093, '202210281103', '', 'Himalaya Evecare Syrup 200ml', '68.06', '52.52', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1094, '202210281104', '', 'Himalaya Evecare Tab 30s', '68.33', '52.72', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1095, '202210281105', '', 'Liv 52 Syrup', '47.77', '36.87', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1096, '202210281106', '', 'Liv 52 Tabs', '67.14', '51.81', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1097, '202210281107', '', 'Himalaya Mentat Syp. 100ml', '47.13', '36.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1098, '202210281108', '', 'Himalaya Mentat Tab. 50s', '38.61', '29.80', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1099, '202210281109', '', 'Histazine 10mg Tab 10s 10/pck', '1.31', '1.01', 219, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1100, '202210281110', '', 'HISTAZINE SYRUP 60ML', '14.54', '7.58', 48, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1101, '202210281111', '', 'Histergan Cream 25g', '45.94', '39.39', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1102, '202210281112', '', 'Homtamin ginseng 1s', '13.09', '10.10', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1103, '202210281113', '', 'Honey (Cheriel) bottle s/s', '28.80', '22.22', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1104, '202210281114', '', 'Hostan 250mg Caps 10s', '3.93', '3.03', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1105, '202210281115', '', 'Hot Water Bottle (Jacket)', '73.31', '56.56', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1106, '202210281116', '', 'Huichun Caps', '40.58', '31.31', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1107, '202210281117', '', 'Hyd', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1108, '202210281118', '', 'Hydralazine Tab. 25mg 56s', '136.66', '117.16', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1109, '202210281119', '', 'Hydrocortisone 1 percent Cream 15g (Co pharm)', '10.47', '8.08', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1110, '202210281120', '', 'Hydrocortisone 1 percent Cream 30g (Co Pharma) ', '47.13', '36.36', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1111, '202210281121', '', 'HYDROCORTISONE 1% CREAM 30G UK', '50.00', '34.34', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1112, '202210281122', '', 'Hydrocortisone 1 percent Cream 30g exeter', '45.81', '35.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1113, '202210281123', '', 'Hydrocortisone Inj. 100mg 1S (23)', '6.54', '5.05', 32, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1114, '202210281124', '', 'Hydrocortisone Inj. 100mg(Pharm-Inter)1S', '7.20', '5.56', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1115, '202210281125', '', 'Hydrogen Peroxide 200ml Bellsuk', '31.41', '24.24', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1116, '202210281126', '', 'Hydrogen Peroxide 200ml ECL', '10.47', '8.08', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1117, '202210281127', '', 'Hygimax Herbal Ferminine 100ml wash', '40.58', '31.31', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1118, '202210281128', '', 'Hyponidd Tab', '40.58', '31.31', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1119, '202210281129', '', 'Hytrin (Terazosin) 2mg 14s', '31.41', '24.24', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1120, '202210281130', '', 'Hytrin (Terazosin) 5mg 14s', '49.74', '38.38', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1121, '202210281131', '', 'Ibex Caps 12s', '14.40', '11.11', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1122, '202210281132', '', 'Ibucap Caps. 10s 20/pck', '5.23', '4.04', 396, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1123, '202210281133', '', 'Ibuprofen 200mg (Local) 10S', '0.92', '0.71', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1124, '202210281134', '', 'Ibuprofen 200mg 16s UK(galpharm/flamengo)', '13.09', '10.10', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1125, '202210281135', '', 'Ibuprofen 400mg All. 12s UK (Flamingo)', '7.86', '6.06', 13, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1126, '202210281136', '', 'Ibuprofen 4mg (Relon Chem) 12s', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1127, '202210281137', '', 'Ibuprofen Denk 600mg 10', '24.87', '19.19', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1128, '202210281138', '', 'IBUPROFEN JNR SYR. 100ML 3+MNTHS (ALL FLAVOURS)', '57.57', '38.38', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1129, '202210281139', '', 'Icthamol Ointment', '20.95', '16.16', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1130, '202210281140', '', 'IDEOS CAPSULES', '157.56', '80.80', 9, '5', 'assets/data/products/noimage.png', 'ACTIVE'),
(1131, '202210281141', '', 'Idicef Susp. (Cefixime)', '9.16', '7.07', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1132, '202210281142', '', 'Imax Herbal Delay Spray 8ml', '56.29', '43.43', 44, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1133, '202210281143', '', 'IMBOOST HERBAL MIXTURE', '23.74', '15.55', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1134, '202210281144', '', 'Imipramine 10mg 28S', '21.59', '16.67', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1135, '202210281145', '', 'Imipramine 25mg 28s', '13.09', '10.10', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1136, '202210281146', '', 'Immunace Caps 5s', '13.09', '10.10', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1137, '202210281147', '', 'Immunace Extra Caps', '196.34', '151.50', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1138, '202210281148', '', 'Immunocin Caps 30s', '65.45', '50.50', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1139, '202210281149', '', 'Imodium Caps (Pack)janssen', '28.80', '22.22', 14, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1140, '202210281150', '', 'Imperal Leather Roll On', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1141, '202210281151', '', 'Imperial Leather Bar Soap 200g', '7.86', '6.06', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1142, '202210281152', '', 'IMPRESSER CAPS 15S 2/PCK', '37.27', '26.77', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1143, '202210281153', '', 'Impresser Oil', '80.59', '69.08', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1144, '202210281154', '', 'Indomethacin 25mg 10s', '1.31', '1.01', 197, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1145, '202210281155', '', 'Infa V ointment', '40.58', '31.31', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1146, '202210281156', '', 'Infa V Pess', '45.81', '35.35', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1147, '202210281157', '', 'Infacol Drops 85ml', '73.68', '63.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1148, '202210281158', '', 'INFUSION SET(GIVING SET)', '3.03', '2.02', 244, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1149, '202210281159', '', 'Inoxime (Cefixime) 200mg tab', '17.02', '13.13', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1150, '202210281160', '', 'Instant Foam Sanitizer', '26.18', '20.20', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1151, '202210281161', '', 'insulin syringe 31g/1ml', '1.96', '1.52', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1152, '202210281162', '', 'Intavita Caps.', '27.49', '21.21', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1153, '202210281163', '', 'Ir', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1154, '202210281164', '', 'IRISH SHOWER GEL 532ML(MEXICO)', '54.97', '42.42', 64, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1155, '202210281165', '', 'Irish Spring 3s pack', '35.34', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1156, '202210281166', '', 'Irish Spring Soap 1s 3/pck(Ecowas)', '10.47', '8.08', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1157, '202210281167', '', 'Irovit Drops', '60.08', '46.36', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1158, '202210281168', '', 'ISORDIL 10MG TAB  1S TEVA 50/PCK', '3.79', '2.53', 200, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(1159, '202210281169', '', 'Isosorbide Dinitrate 10mg 1s', '5.23', '4.04', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1160, '202210281170', '', 'Isosorbide Dinitrate 20mg 1s', '3.40', '2.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1161, '202210281171', '', 'istard 30', '62.83', '48.48', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1162, '202210281172', '', 'Itraconazole 100mg(Teva) (UK) 1s', '4.59', '3.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1163, '202210281173', '', 'Izosorbid 10mg 1s', '5.23', '4.04', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1164, '202210281174', '', 'JET 2 INHALER', '13.09', '10.10', 26, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1165, '202210281175', '', 'JET 2 LOZENGES 6S 25/PCK', '3.03', '2.02', 204, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1166, '202210281176', '', 'jf', '9.16', '7.07', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1167, '202210281177', '', 'Johnson Baby Lotion 300ml', '16.36', '12.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1168, '202210281178', '', 'Johnson Baby Oil 500ml', '47.13', '36.36', 7, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1169, '202210281179', '', 'Johnson Bath Top to Toe', '52.36', '40.40', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1170, '202210281180', '', 'Johnson Powder 500ml', '39.27', '30.30', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1171, '202210281181', '', 'Jointace Gel 75ml', '112.57', '86.86', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1172, '202210281182', '', 'Jointace Gluco.+ Chond. Cap. 30s', '128.94', '99.49', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1173, '202210281183', '', 'Jointace Omega 3', '154.46', '119.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1174, '202210281184', '', 'Jointcare (Vitabiotics) Cap. 30s', '128.28', '98.98', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1175, '202210281185', '', 'Jointcare (VitaHealth) Cap. 30s', '62.83', '48.48', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1176, '202210281186', '', 'Jointflex Plus Cap. 30s', '104.72', '80.80', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1177, '202210281187', '', 'Joy Ointment 40g', '6.54', '5.05', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1178, '202210281188', '', 'Jumbo Tissue small', '13.09', '10.10', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1179, '202210281189', '', 'Kalamina Lotion 120ml', '21.73', '10.10', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1180, '202210281190', '', 'Kalamina Lotion 200ml', '36.94', '17.17', 72, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1181, '202210281191', '', 'Kalms Night Tabs. 1s', '2.62', '2.02', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1182, '202210281192', '', 'Kamaclox Mouth wash', '17.02', '13.13', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1183, '202210281193', '', 'KAMAGRA 100MG TAB. 1S 4/PCK', '16.16', '13.64', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1184, '202210281194', '', 'KAMAGRA 50MG TAB. 1S', '12.63', '11.11', 32, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1185, '202210281195', '', 'Kamagra Jelly 100mg 7s', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1186, '202210281196', '', 'Kamagra Jelly 50mg (orange/mint) 1s 5/pck', '13.09', '10.10', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1187, '202210281197', '', 'Kefrox 125mg (Cefuroxime) Susp. 70ml', '18.32', '14.14', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1188, '202210281198', '', 'Kel Chaecoal Paste (Adult)', '26.18', '20.20', 51, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1189, '202210281199', '', 'Kel kids Paste', '18.32', '14.14', 50, '1', 'assets/data/products/noimage.png', 'ACTIVE');
INSERT INTO `products_master` (`id`, `pid`, `barcode`, `pname`, `sprice`, `cprice`, `qty`, `cat`, `pimg`, `status`) VALUES
(1190, '202210281200', '', 'Ketazol Cream 30gm', '14.40', '11.11', 43, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1191, '202210281201', '', 'Ketazol Tab', '7.86', '6.06', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1192, '202210281202', '', 'Ki', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1193, '202210281203', '', 'Kidicare 200ml', '24.54', '18.94', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1194, '202210281204', '', 'KIDICS SYRUP 200ML', '22.25', '17.17', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1195, '202210281205', '', 'Kidivite 100ml', '7.86', '6.06', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1196, '202210281206', '', 'Kidivite Baby Multi (12) Syr.200ml', '25.65', '28.28', 33, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1197, '202210281207', '', 'Kidivite Baby Multi (14) Syr.200ml', '25.65', '28.28', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1198, '202210281208', '', 'Kidivite Drop', '23.56', '18.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1199, '202210281209', '', 'Kinel Sanitizer Sray 150ml', '19.63', '15.15', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1200, '202210281210', '', 'Kingdom Garlic caps', '31.41', '24.24', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1201, '202210281211', '', 'Kiss Condom', '5.23', '4.04', 43, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1202, '202210281212', '', 'Klire 4 Way Cough 125ml', '17.68', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1203, '202210281213', '', 'Klire Pain Tab', '5.23', '4.04', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1204, '202210281214', '', 'Klovinal Pess.', '38.02', '33.33', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1205, '202210281215', '', 'Knee  stabilizer- flamingo', '176.71', '136.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1206, '202210281216', '', 'Knee  wrap hinged', '176.71', '136.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1207, '202210281217', '', 'KOFFEX ADULT SYR.', '16.16', '10.61', 48, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1208, '202210281218', '', 'Koffex Junior', '7.20', '5.56', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1209, '202210281219', '', 'KOFLET SYRUP 100ML', '33.38', '25.76', 34, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1210, '202210281220', '', 'KOFOF CHESTY FAMILY SYP', '9.09', '5.86', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1211, '202210281221', '', 'Kofof Infant Syrup', '7.86', '6.06', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1212, '202210281222', '', 'KOFOF Suppresant Child Cough Syrup', '7.86', '6.06', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1213, '202210281223', '', 'KOFOF SYRUP (ADULT)', '12.12', '7.07', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1214, '202210281224', '', 'Kombiglyze 2.5/1000mg 1S', '7.86', '6.06', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1215, '202210281225', '', 'Kombiglyze XR 5mg/1000mg 1s', '12.30', '9.49', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1216, '202210281226', '', 'Kwick Action tab', '2.62', '2.02', 588, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1217, '202210281227', '', 'KY Gel 50g Johnson', '45.81', '35.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1218, '202210281228', '', 'KY GEL 82G', '102.52', '68.25', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1219, '202210281229', '', 'KY Jelly 50ml(kynect)', '51.83', '44.44', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1220, '202210281230', '', 'KY Jelly 75g (knect)', '263.89', '113.12', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1221, '202210281231', '', 'KY Jelly 75ml', '99.49', '38.38', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1222, '202210281232', '', 'L MONTUS', '62.55', '53.63', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1223, '202210281233', '', 'L MONTUS (KIDS) 10S', '47.86', '35.45', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1224, '202210281234', '', 'Lactacyd Femini Wash', '34.04', '26.26', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1225, '202210281235', '', 'Lactulose (Medulac)', '36.65', '28.28', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1226, '202210281236', '', 'Lactulose 300ml (Sandoz)', '48.88', '41.92', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1227, '202210281237', '', 'Lactulose 300ml (Teva)', '45.81', '35.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1228, '202210281238', '', 'Lactulose 300ml(crescent )', '0.00', '0.00', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1229, '202210281239', '', 'Lactulose 500ml (Mayer)', '58.90', '50.50', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1230, '202210281240', '', 'Lactulose 500ml (Sandoz)`', '78.54', '60.60', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1231, '202210281241', '', 'LADINAS TAB', '7.27', '4.85', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1232, '202210281242', '', 'Lady Speed Stick', '26.18', '20.20', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1233, '202210281243', '', 'Lamisil Cream 15g', '88.35', '68.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1234, '202210281244', '', 'Lantus Solostar Pen 100ml', '156.68', '120.90', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1235, '202210281245', '', 'Lariam 8Tab 1s', '108.85', '84.84', 36, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1236, '202210281246', '', 'Latanoprost+Timol 0.5 percent Eye Drop', '55.95', '47.98', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1237, '202210281247', '', 'Latex', '57.59', '44.44', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1238, '202210281248', '', 'Lavet Feminine wash', '30.11', '23.23', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1239, '202210281249', '', 'Le', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1240, '202210281250', '', 'Leena Cap', '7.86', '6.06', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1241, '202210281251', '', 'Leena Syrup 200ml', '22.25', '17.17', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1242, '202210281252', '', 'lemsip Cough 180ml(mucus cough&catarrh)', '112.57', '86.86', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1243, '202210281253', '', 'Lemsip Max Caps 16s', '69.50', '53.63', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1244, '202210281254', '', 'LEMSIP MAX COLD & FLU (POWDER) 1S 10/PCK', '10.10', '7.58', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1245, '202210281255', '', 'Lenor 10/pk', '8.50', '6.57', 17, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1246, '202210281256', '', 'Leopard Balm 30g', '15.71', '12.12', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1247, '202210281257', '', 'Leorub gel 30g', '5.23', '4.04', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1248, '202210281258', '', 'Letalin Expectorant', '5.23', '4.04', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1249, '202210281259', '', 'Letavin tab 125mg (Griseofulvin) letap 50/pck', '2.09', '1.62', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1250, '202210281260', '', 'Levobact (Levofloxacin) 500mg', '67.14', '51.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1251, '202210281261', '', 'Levobact Infusion 500mg/100ml', '60.43', '51.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1252, '202210281262', '', 'Levofloxacin 500mg (Exeter)', '31.41', '24.24', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1253, '202210281263', '', 'Levon 2', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1254, '202210281264', '', 'Levothyroxine 100mcg 28s(mercurypharma)', '32.72', '25.25', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1255, '202210281265', '', 'Levothyroxine 50mcg 28s (northstar/accord)', '24.87', '19.19', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1256, '202210281266', '', 'Lexofen Plus Tab. 20s', '10.47', '8.08', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1257, '202210281267', '', 'Lexofen Susp 100ml', '27.49', '21.21', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1258, '202210281268', '', 'Lexotanil Tab 1.5mg 10s 3/pck', '23.56', '18.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1259, '202210281269', '', 'Lexporin Skin Ointment 20g', '43.85', '33.84', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1260, '202210281270', '', 'Lexsporin Powder', '24.87', '19.19', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1261, '202210281271', '', 'LG Glizone (Pioglitazone) 15mg 30s', '14.40', '11.11', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1262, '202210281272', '', 'LG GLIZONE (PIOGLITAZONE) 30MG 30S', '18.48', '12.22', 32, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(1263, '202210281273', '', 'Li', '19.63', '15.15', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1264, '202210281274', '', 'Lifestyle Condoms 3s', '9.16', '7.07', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1265, '202210281275', '', 'Lifeway Raw Honey 500ml', '41.88', '32.32', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1266, '202210281276', '', 'Ligaba (Pregabalin) 75mg 10s 3/pck MEGA', '118.54', '31.67', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1267, '202210281277', '', 'Linctus Adult {Danex}', '6.54', '5.05', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1268, '202210281278', '', 'Linctus BP (NUMARK) 200ML', '53.01', '40.91', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1269, '202210281279', '', 'Linctus Junior {Danex}', '5.23', '4.04', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1270, '202210281281', '', 'Lipitor (Atorvastatin) 20mg 30/pck 1S', '17.35', '17.17', 350, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1271, '202210281282', '', 'Lipitor (Atorvastatin) 40mg Tab 1S', '15.71', '12.12', 275, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1272, '202210281283', '', 'Lipitor (Atorvastatin) Tab 10mg 1S Pfizer', '11.78', '9.09', 222, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1273, '202210281284', '', 'LIPSORE (RELONCHEM) 5% CREAM 2G', '15.15', '9.09', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1274, '202210281285', '', 'Liquid Parafin 100ml', '15.71', '12.12', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1275, '202210281286', '', 'Liquifruta 100mls', '33.38', '25.76', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1276, '202210281287', '', 'Liquifruta 100mls', '33.38', '25.76', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1277, '202210281288', '', 'Liquifruta 200ml', '49.74', '38.38', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1278, '202210281289', '', 'lisinopril 10mg (Almus) 28s', '24.87', '19.19', 42, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1279, '202210281290', '', 'lisinopril 10mg (Teva)', '34.04', '26.26', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1280, '202210281291', '', 'Lisinopril 10mg 28s (milpharm))', '19.63', '15.15', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1281, '202210281292', '', 'Lisinopril 10mg Tab 28s (Crescent)', '19.63', '15.15', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1282, '202210281293', '', 'Lisinopril 20mg Tab 28s (teva) and others', '28.80', '22.22', 27, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1283, '202210281294', '', 'Lisinopril 5mg 28s (bristol)', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1284, '202210281295', '', 'Lisinopril 5mg 28s (Milpharm)', '13.09', '10.10', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1285, '202210281296', '', 'Lisinopril 5mg 28s (Teva)', '18.32', '14.14', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1286, '202210281297', '', 'Lisinopril 5mg Tab 28s (Almus)', '17.02', '13.13', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1287, '202210281298', '', 'Lisinova HTZ Forte 20mg/12.5mg 10s', '21.59', '16.67', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1288, '202210281299', '', 'Listerine M/W 250ml (freshBurst /Coolmint & Spearmint)', '32.07', '24.75', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1289, '202210281300', '', 'Listerine M/W 250ml (Total Care& Total teeth/Mint&greenteeth)', '39.27', '30.30', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1290, '202210281301', '', 'Listerine M/W 500ml', '64.79', '55.55', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1291, '202210281302', '', 'Lithium Battery 1s', '7.86', '6.06', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1292, '202210281303', '', 'livercare ', '86.40', '66.66', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1293, '202210281304', '', 'Livertone Junior Syrup', '12.46', '7.58', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1294, '202210281305', '', 'LIVING BITTERS CAPS.', '44.50', '34.34', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1295, '202210281306', '', 'Living Bitters Tonic', '32.72', '25.25', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1296, '202210281307', '', 'Livolin Forte Caps.', '134.31', '76.76', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1297, '202210281308', '', 'Livomyn Tab.', '37.96', '29.29', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1298, '202210281309', '', 'Livopat cap 30s', '54.71', '21.21', 7, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1299, '202210281310', '', 'Lofnac 100 Supp 1S', '1.58', '1.21', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1300, '202210281311', '', 'Lofnac 100mg (diclofenac)', '5.23', '4.04', 96, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1301, '202210281312', '', 'Lofnac Gel 30g', '17.02', '13.13', 26, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1302, '202210281313', '', 'Lofnac Tab 50mg 10S', '3.93', '3.03', 65, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1303, '202210281314', '', 'Lonart Forte Tab', '32.72', '25.25', 27, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1304, '202210281315', '', 'Lonart Suspension 60ml', '22.91', '25.25', 22, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1305, '202210281316', '', 'Lonart Tab DS 6S', '31.15', '34.34', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1306, '202210281317', '', 'Longrich Toothpaste 100g S/S', '24.87', '19.19', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1307, '202210281318', '', 'Longrich Toothpaste 200g B/S', '47.71', '40.91', 13, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1308, '202210281319', '', 'Loratadine 10mg (Ranbaxy)', '5.23', '4.04', 36, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1309, '202210281320', '', 'Loratadine 10mg 10s (UK)/Almus', '6.54', '5.05', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1310, '202210281321', '', 'Loratadine 10mg 10s Allergies relief', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1311, '202210281322', '', 'Loratadine Syr. (Sandoz)', '37.11', '28.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1312, '202210281323', '', 'Loratidine 10mg 10s (Relon-Chem)', '4.71', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1313, '202210281324', '', 'lorazepam 2mg Tabs 10s 50/pck', '2.35', '1.82', 350, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1314, '202210281325', '', 'LOSAR DENK 100MG 14S', '44.18', '15.14', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1315, '202210281326', '', 'LOSAR DENK 50MG 14S', '27.00', '9.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1316, '202210281327', '', 'Losartan 100mg 14s (crescent)', '16.49', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1317, '202210281328', '', 'Losartan Pot. 50mg (exeter)10s  3/pck', '7.66', '5.91', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1318, '202210281329', '', 'Losartan Pot. 50mg (Teva)10s  2/pck', '32.99', '25.45', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1319, '202210281330', '', 'Losartan Pota. 100mg 14s (Teva) 2/pk', '37.11', '31.82', 37, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1320, '202210281331', '', 'Losartan Pota. 100mg 14s (exeter)', '10.59', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1321, '202210281332', '', 'Losartan Pota. 100mg 14s (Mylan)', '19.43', '15.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1322, '202210281333', '', 'Losartan Pota. 50mg 14s (Medreich)', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1323, '202210281334', '', 'Lozaty Lozenges 24s Honey & lemon', '15.32', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1324, '202210281335', '', 'Lubri Gel Jelly (USA - Dr Sheffield)', '35.34', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1325, '202210281336', '', 'Lubrimax Jelly 50mg', '32.99', '25.45', 46, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1326, '202210281337', '', 'Lubrimax Jelly 70mg', '37.69', '29.09', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1327, '202210281338', '', 'Lucozade 1litre', '24.75', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1328, '202210281339', '', 'Lucozade Btt. 380ml', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1329, '202210281340', '', 'Lucozade Can', '8.24', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1330, '202210281341', '', 'Luex Adult & Children 6+yrs Night time Cough&Cold Syrup 100ml', '12.96', '10.00', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1331, '202210281342', '', 'Luex Adult Syr. dry Cough 150ml', '28.27', '21.82', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1332, '202210281343', '', 'Luex Baby Cough 100ml', '24.75', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1333, '202210281344', '', 'Luex Children Chesty Cough syrup 6+12yrs100ml', '12.96', '10.00', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1334, '202210281345', '', 'Luex Children Dry Cough syrup 100ml', '24.75', '19.09', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1335, '202210281346', '', 'Lufart 20/120 (Entrance)', '8.24', '6.36', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1336, '202210281347', '', 'LUFART DS TABS', '27.27', '14.09', 42, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1337, '202210281348', '', 'Lufart Susp. 60ml', '18.26', '14.09', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1338, '202210281349', '', 'Lumigan 0.01 percent Eye Drops 2.5ml', '240.47', '206.16', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1339, '202210281350', '', 'Lumigan 0.03 percent Eye Drops', '253.83', '217.61', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1340, '202210281351', '', 'LYDIA DAILY PILLS DKT', '5.89', '4.55', 3, '4', 'assets/data/products/noimage.png', 'ACTIVE'),
(1341, '202210281352', '', 'LYDIA POST PILL', '12.27', '7.95', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1342, '202210281353', '', 'Lynux Ointment 20g', '56.55', '43.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1343, '202210281354', '', 'LYRICA (PREGABALIN) 25MG TAB 1S', '12.73', '9.09', 224, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1344, '202210281355', '', 'Lyrica (Pregabalin) Tabs 75mg 1s 28/pck', '20.67', '13.18', 225, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1345, '202210281356', '', 'Lyrica caps 150mg 1s 28/pk', '20.03', '15.45', 160, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1346, '202210281357', '', 'M-Energex 1s', '29.45', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1347, '202210281358', '', 'M 10s', '8.24', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1348, '202210281359', '', 'M2 Tone Tab', '111.65', '73.63', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1349, '202210281360', '', 'Maalox Plus susp 180ml', '55.37', '42.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1350, '202210281361', '', 'MAALOX PLUS SUSP BOX 250ML', '73.71', '48.18', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1351, '202210281362', '', 'Maalox Susp Sachet 1s 20/pck', '3.54', '2.73', 210, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1352, '202210281363', '', 'Magacid (Fastmelt) 1s', '1.18', '0.91', 205, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1353, '202210281364', '', 'Magacid Plus Susp', '15.32', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1354, '202210281365', '', 'Magacid Susp 150ml', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1355, '202210281366', '', 'MAGACID SUSP. 200ML', '16.55', '11.04', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1356, '202210281367', '', 'Magacid Tab 6S', '1.77', '1.36', 107, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1357, '202210281368', '', 'Magic Shaving Cream', '24.75', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1358, '202210281369', '', 'Magic Shaving Powder', '29.45', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1359, '202210281371', '', 'MAJOR (EPHEDRINE) NASAL DROPS 18ML', '10.91', '7.73', 32, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1360, '202210281372', '', 'Major Liverplex B 200ML', '12.96', '10.00', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1361, '202210281373', '', 'Malafan/Malarid Tab 3S', '2.35', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1362, '202210281374', '', 'Malar 2 DS 80/480 6s', '18.26', '14.09', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1363, '202210281375', '', 'MALAR 2 FORTE TAB 12S', '15.00', '9.82', 50, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1364, '202210281376', '', 'Malar 2 Susp 60ml', '17.68', '13.64', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1365, '202210281377', '', 'MALARIA TEST KIT ( TAKE OUT)', '7.27', '3.69', 77, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1366, '202210281378', '', 'Malaria Test Kit (PP)', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1367, '202210281379', '', 'Malaria Test Kit SD', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1368, '202210281380', '', 'Malin Adult Syrup(cold&catarrh)', '17.68', '13.64', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1369, '202210281381', '', 'Malin Baby 125ml', '15.32', '11.82', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1370, '202210281382', '', 'Malin Junor ', '10.59', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1371, '202210281383', '', 'Man-Up Caps 60s', '121.94', '94.08', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1372, '202210281384', '', 'MARK 2 INHALER', '10.59', '8.18', 119, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1373, '202210281385', '', 'Martins Liver Salt (All)', '1.18', '0.91', 117, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1374, '202210281386', '', 'Masaada syrp', '20.61', '15.91', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1375, '202210281387', '', 'MAXIDEX EYE DROPS 5ML', '27.68', '21.36', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1376, '202210281388', '', 'Maxidex Eye Ointment 3.5g', '40.05', '30.91', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1377, '202210281389', '', 'Maxisporin Eye Drops', '46.76', '40.09', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1378, '202210281390', '', 'MAXITROL 5ML EYE DROPS', '42.41', '32.72', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1379, '202210281391', '', 'Maxitrol Eye Ointment', '35.34', '27.27', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1380, '202210281392', '', 'MaxMox (Amoxicillin) Susp', '8.24', '6.36', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1381, '202210281393', '', 'Maxmox Amoxycillin 500mg Eskay', '10.59', '8.18', 48, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1382, '202210281394', '', 'MAYFER SYR. ', '17.27', '11.32', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1383, '202210281395', '', 'Medglobin  cap ', '17.68', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1384, '202210281396', '', 'Medglobin syrp ', '23.56', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1385, '202210281397', '', 'Medisoft Repellant', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1386, '202210281398', '', 'Medrol Tab 4mg 1s', '1.53', '1.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1387, '202210281399', '', 'Menopace Plus Caps', '179.18', '138.26', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1388, '202210281400', '', 'Menthodex Lozenges H/L(Yellow)', '25.92', '20.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1389, '202210281401', '', 'MENTHODEX SYR. 200ML', '46.36', '30.91', 27, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1390, '202210281402', '', 'Menthodex Syrup 100ml', '28.27', '21.82', 22, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1391, '202210281403', '', 'Menthol Crystals (Care+)', '30.63', '23.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1392, '202210281404', '', 'Menthol Crystals (Menthodex) 5g', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1393, '202210281405', '', 'Menthox Cough Adult 125ml(super strong)', '10.59', '8.18', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1394, '202210281406', '', 'Menthox cough syr Children 60ml', '7.66', '5.91', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1395, '202210281407', '', 'MENTHOX LOZENGES(SUPER STRONG COUGH)', '1.18', '0.91', 37, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1396, '202210281408', '', 'Mercy Cream 80g (Container)', '20.03', '15.45', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1397, '202210281409', '', 'Mercy Ointment (Tube)', '7.07', '5.45', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1398, '202210281410', '', 'Mercy Soap', '7.07', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1399, '202210281411', '', 'METAGYL 200MG 10S ECL 50/PCK', '2.35', '1.82', 175, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(1400, '202210281412', '', 'Metagyl 400mg Tab 10s 28/pck', '3.54', '2.73', 110, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1401, '202210281413', '', 'Metagyl Susp 100ml', '11.78', '9.09', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1402, '202210281414', '', 'METFORMIN DENK 500MG 10S 10/PCK', '15.71', '10.47', 257, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1403, '202210281415', '', 'Metformin Denk Tab 1000mg 15s 2/pck', '42.51', '36.81', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1404, '202210281416', '', 'METFORMIN DENK TAB 850MG 15S', '35.29', '17.40', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1405, '202210281417', '', 'Methyl Salicylate Oint.50 percent', '9.42', '7.27', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1406, '202210281418', '', 'Methylated Spirit 125ml ECL', '9.42', '7.27', 36, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1407, '202210281419', '', 'Methylated Spirite 100ml unicom', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1408, '202210281420', '', 'Methylated Spirite 1L', '51.95', '44.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1409, '202210281421', '', 'METHYLATED SPIRITE 200ML (ECL &UNICOM)', '13.64', '12.27', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1410, '202210281422', '', 'METHYLATED SPIRITE 60ML (MALTITI & UNICOM)', '4.55', '2.73', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1411, '202210281423', '', 'Metoclopramide 10mg (Cresent) 28s', '23.56', '18.18', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1412, '202210281424', '', 'Metoclopramide 10mg (ECL) 10s 10/pck', '3.54', '2.73', 50, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1413, '202210281425', '', 'Metoclopramide 10mg (Exeter) 28s', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1414, '202210281426', '', 'Metoclopramide Inj 1s 10/pck (exeter)', '5.89', '4.55', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1415, '202210281427', '', 'Metoprolol (Teva) 100mg 14s', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1416, '202210281428', '', 'Metoprolol 25mg (Betaloc)', '62.03', '53.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1417, '202210281429', '', 'Metran Caps. 10s', '15.68', '12.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1418, '202210281430', '', 'METROLEX F JUNIOR (SUSP)', '27.27', '18.18', 23, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(1419, '202210281431', '', 'METROLEX F TAB 21S', '23.56', '18.18', 20, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(1420, '202210281432', '', 'METRONIDAZOLE 400MG 21S (EXETER)', '15.32', '11.82', 17, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(1421, '202210281433', '', 'Metronidazole 400mg 21s(crescent)', '42.41', '32.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1422, '202210281434', '', 'Metronidazole Infusion/Inj. (All)', '7.07', '5.45', 50, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1423, '202210281435', '', 'Metronidazole susp 125mL (MGP)', '5.89', '4.55', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1424, '202210281436', '', 'Microgynon Fe Tabs 30S', '9.42', '7.27', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1425, '202210281437', '', 'Milk Chocolate -All (Niche)', '7.66', '5.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1426, '202210281438', '', 'Milk of Magnesia (Philip) 200ml', '101.25', '86.81', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1427, '202210281439', '', 'Milk Of Magnesia (Starwin) 120ml', '15.32', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1428, '202210281440', '', 'Milk Of Magnesia (Starwin) 360ml', '40.64', '31.36', 57, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1429, '202210281441', '', 'Milton Tab 28s', '25.92', '20.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1430, '202210281442', '', 'Mim Drops', '7.07', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1431, '202210281443', '', 'Mimoral (Chymoral) Tab', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1432, '202210281444', '', 'Mimorange (Multivite) syr.', '10.59', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1433, '202210281445', '', 'Minadex Syr. 100ml', '45.94', '35.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1434, '202210281446', '', 'Minamino Syp 200ml.', '50.89', '43.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1435, '202210281447', '', 'Minavex syr 200ml', '45.48', '35.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1436, '202210281448', '', 'Miraferrum Forte Caps', '41.23', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1437, '202210281449', '', 'Mist Expect Sed. 200ml', '7.66', '5.91', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1438, '202210281450', '', 'Mist F.A.C. 200ML (14)', '2.95', '2.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1439, '202210281451', '', 'MIST POTASSIUM CITRATE 200ML', '8.18', '6.36', 52, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1440, '202210281452', '', 'MIST SENNA CO 120ML', '8.18', '6.36', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1441, '202210281453', '', 'Mist Trisilicate (Darl) 200ml', '4.71', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1442, '202210281454', '', 'Mist. Magnesium Tricilicate Susp. (Mal Titi)', '8.24', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1443, '202210281455', '', 'Mist. Magnesium Tricilicate Susp.(JKT) Phersons', '8.24', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1444, '202210281456', '', 'Mixtard 30(Flexpen)', '53.01', '40.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1445, '202210281457', '', 'Mixtard 30 100iu 1vial', '61.55', '52.77', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1446, '202210281458', '', 'Moduretic (Co-Amilozide) 14s', '17.68', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1447, '202210281459', '', 'Morgans Antibacteria Soap 80g', '11.78', '9.09', 35, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1448, '202210281460', '', 'Morgans Pomade 100g', '28.87', '22.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1449, '202210281461', '', 'Morgans Pomade 200g (Darkens Grey Hair)', '47.71', '36.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1450, '202210281462', '', 'Morgan Grey Away Spray 120ml', '51.25', '39.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1451, '202210281463', '', 'Morgans Hair Darking Serum 250ml', '44.77', '34.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1452, '202210281464', '', 'Moringa Tea 25s', '16.49', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1453, '202210281465', '', 'Moringa Tea 50s', '32.99', '25.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1454, '202210281467', '', 'Mosquito net(rectangular-double)', '36.52', '28.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1455, '202210281468', '', 'Mosquito net(rectangular-single)', '32.99', '25.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1456, '202210281469', '', 'Motillium Syrup', '50.07', '38.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1457, '202210281470', '', 'Motillium Tab 10mg 10S', '20.03', '15.45', 50, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1458, '202210281471', '', 'Mouth wash ( Ernest Che)', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1459, '202210281472', '', 'Mouth Wash (Cleansing)', '23.56', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1460, '202210281473', '', 'MR Q AMP 1S 10/PCK', '8.48', '7.27', 132, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1461, '202210281474', '', 'MUCOLEX EXP ADULT 125ML', '24.54', '17.94', 3, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1462, '202210281475', '', 'Mucolex Junior 150ml', '27.10', '20.91', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1463, '202210281476', '', 'MULTIVITAMIN TAB (EC/ LOCAL) 10S 50/PCK', '0.60', '0.45', 294, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1464, '202210281477', '', 'Mupirocin ontment 15g', '36.52', '28.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1465, '202210281479', '', 'Mycocort Cream 20g', '38.59', '33.09', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1466, '202210281480', '', 'MYCOLEX 2 PERCENT CREAM 20G', '24.54', '16.36', 14, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1467, '202210281481', '', 'MYCOLEX 3 CREAM 30G', '27.27', '18.18', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1468, '202210281482', '', 'Mycolex Powder 30g', '28.87', '22.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1469, '202210281483', '', 'Mycolex Powder 50g', '37.22', '26.59', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1470, '202210281484', '', 'Mycovin (Griseofulvin) 500mg 10sECL 25/pck', '12.96', '10.00', 58, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1471, '202210281485', '', 'NAKLOFEN DUO CAPS 75MG 2/PCK 10S', '41.81', '26.40', 24, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1472, '202210281486', '', 'Naklofen Inj. 75mg 3ml 1s', '8.24', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1473, '202210281487', '', 'Nan 1/2/3', '43.59', '33.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1474, '202210281488', '', 'NanaPa Garlic Caps', '14.73', '11.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1475, '202210281489', '', 'Naprosyn EC 500mg 1s UK', '9.42', '7.27', 320, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1476, '202210281490', '', 'Naprox EC 500mg 10s (ECL)', '8.24', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1477, '202210281491', '', 'Nasonex (Mometasone) Nasal Spray', '136.94', '117.40', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1478, '202210281492', '', 'NAT B CAPS', '109.54', '41.73', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1479, '202210281493', '', 'NAT C 1000mg Tab.', '52.49', '45.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1480, '202210281494', '', 'Native Shea-Butter', '16.49', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1481, '202210281495', '', 'NATRILIX SR (INDAPAMIDE)1.5MG 1S 30/PCK', '4.55', '2.80', 368, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1482, '202210281496', '', 'Natrixam 1.5mg/10mg 5s 6/pck', '31.22', '24.09', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1483, '202210281497', '', 'Natrixam 1.5mg/5mg 5s 6/pck', '28.27', '21.82', 60, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1484, '202210281498', '', 'NCP Antiseptic Solution 200ml', '34.75', '26.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1485, '202210281499', '', 'Neo-Cort een Drops 10ml (Korlyns)', '43.59', '33.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1486, '202210281500', '', 'NEO CORT EEN DROP 10ML', '36.68', '24.45', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1487, '202210281501', '', 'Neo Hycolex Eye/Ear Drops 10ml', '36.52', '28.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1488, '202210281502', '', 'NEO HYCOLEX EYE/EAR DROPS 5ML', '34.09', '22.73', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1489, '202210281503', '', 'Neo Medrol lotion 25ml ( Pfizer)', '237.49', '183.25', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1490, '202210281504', '', 'Neo Mercazole tab 5mg 1s', '2.95', '2.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1491, '202210281505', '', 'Neoferon Syr. 200ml', '18.86', '14.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1492, '202210281506', '', 'NEOVITA CAPS', '99.40', '81.81', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1493, '202210281507', '', 'Nerve & Bone Liniment', '29.45', '22.73', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1494, '202210281508', '', 'Nesben Susp', '7.07', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1495, '202210281509', '', 'Nesterix Forte Syp', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1496, '202210281510', '', 'Nestinor Post Pill (1&2)', '7.66', '5.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1497, '202210281511', '', 'Nestrim  240 susp 100ml', '8.24', '6.36', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1498, '202210281512', '', 'Nestrim 480mgTab', '2.35', '1.82', 86, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1499, '202210281513', '', 'Neuro- Min Plus(Entrance)', '24.75', '19.09', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1500, '202210281515', '', 'Neuromind plus', '161.27', '138.26', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1501, '202210281516', '', 'Neuropat Plus Caps. 30s', '98.61', '84.54', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1502, '202210281517', '', 'Neurozan Caps 30s', '157.78', '127.62', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1503, '202210281518', '', 'Nexcofer Caps', '11.78', '9.09', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1504, '202210281519', '', 'Nexcofer Syp 200ml', '20.03', '15.45', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1505, '202210281520', '', 'Nexium  40mg Tab 1S 14/pck', '17.68', '13.64', 301, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1506, '202210281521', '', 'Nexium (Emeprazole) 40mg powder for injection infusion 1s', '132.53', '113.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1507, '202210281522', '', 'NEXIUM (OMEPRAZOLE) 10MG SATCHET 1S 28/PCK', '18.41', '14.32', 210, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1508, '202210281523', '', 'Nexium 20mg 14/pk Tab 1S', '11.78', '9.09', 215, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1509, '202210281524', '', 'NIFECARD XL 30MG 10\'S 3/PCK', '22.40', '15.91', 30, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(1510, '202210281525', '', 'Nifecard XL 60mg 10s', '18.86', '14.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1511, '202210281526', '', 'Nifedi Denk 10mg 10S', '10.59', '8.18', 75, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1512, '202210281527', '', 'Nifedi Denk retard  20mg 10s 10/pck', '13.57', '8.18', 110, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1513, '202210281528', '', 'NIGHT NURSE CAPS GSK', '79.54', '41.81', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1514, '202210281529', '', 'Night Nurse Syrup 160ml', '115.56', '99.08', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1515, '202210281530', '', 'Night Time Cold&Flu Syr. 355ml', '38.87', '30.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1516, '202210281531', '', 'Nilol 20/50mg 30s', '20.61', '15.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1517, '202210281532', '', 'Nivea bath/Shower Gel (All) ', '62.84', '34.36', 56, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1518, '202210281533', '', 'Nivea Cream 400ml (Tin)', '63.16', '33.63', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1519, '202210281534', '', 'Nivea Deo Spray 150ml(all)', '40.08', '24.54', 74, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1520, '202210281535', '', 'Nivea Perfect & Radiant (Natural Fairness) 400ml', '62.17', '26.36', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1521, '202210281536', '', 'Nivea Roll On (Glass) Men & women', '21.21', '16.36', 282, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1522, '202210281537', '', 'NIZORAL (KETACONAZOLE)SHAMPOO 60ML', '49.06', '32.70', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1523, '202210281538', '', 'Nizoral Topical (Ketaconazole) Cream 15g', '50.66', '39.09', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1524, '202210281539', '', 'NO 10 Liver Salt 50/pck', '1.18', '0.91', 1504, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1525, '202210281540', '', 'No Spa 40mg Tab. 10s 10/pck', '15.55', '10.00', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1526, '202210281541', '', 'No Spa inj 40mg 1s 25/pck', '8.24', '6.36', 107, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1527, '202210281542', '', 'Nolicin (Norfloxacin) 400mg 10S', '33.58', '25.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1528, '202210281543', '', 'Noni Caps. (Lamps)', '48.77', '37.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1529, '202210281544', '', 'Noni Juice 1ltr (Lamps)', '71.86', '55.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1530, '202210281545', '', 'Noni Juice 500ml (Lamps)', '36.52', '28.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1531, '202210281546', '', 'NORMAL SALINE NASAL DROPS (IMPRTD) ALL', '9.54', '6.36', 37, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1532, '202210281547', '', 'NORMAL SALINE NASAL DROPS (SANA /LOCAL) ALL', '5.45', '3.00', 96, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1533, '202210281548', '', 'Normo Tears Eye Drops', '31.22', '24.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1534, '202210281549', '', 'Norvasc (Amlodipine) 10mg 1s 30/pck', '21.21', '16.36', 275, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1535, '202210281550', '', 'Norvasc 5mg 1s 30/pck', '12.96', '10.00', 150, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1536, '202210281551', '', 'Nostamine Eye/Nasal Drops', '31.22', '24.09', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1537, '202210281552', '', 'NOVAGYL (METRONIDAZOLE) 125MG5ML SUSP.PHARMANOVA', '7.07', '5.45', 15, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(1538, '202210281553', '', 'NS (Normal Saline) Infusion 500ml', '7.66', '5.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1539, '202210281554', '', 'NS (Sodium Chloride Infusion) ', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1540, '202210281555', '', 'Nucleo CMP Forte 15s', '44.53', '34.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1541, '202210281556', '', 'Nugel Antacid Susp 200ml.', '60.20', '33.18', 38, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1542, '202210281557', '', 'Nugel O Susp. 200ml', '44.77', '34.54', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1543, '202210281558', '', 'NURIFER CAPS', '42.72', '33.63', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1544, '202210281559', '', 'Nurifer Junior syp 100ml', '15.91', '12.27', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1545, '202210281560', '', 'Nurofen 200mg 12s', '27.10', '20.91', 2, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1546, '202210281561', '', 'Nurofen Child. Syr./strawberry 100ml', '67.86', '52.36', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1547, '202210281562', '', 'Nurofen Cold & Flu 8s', '64.79', '50.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1548, '202210281563', '', 'Nursing Pad', '20.03', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1549, '202210281564', '', 'Nystatin Oral Susp.', '43.59', '33.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1550, '202210281565', '', 'O yes feminine wash B/S', '29.45', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1551, '202210281566', '', 'Obibini Sanitizer', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1552, '202210281567', '', 'Odyssey Tab. 2s', '17.68', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1553, '202210281568', '', 'Oilatum Emoilant Bath 250ml', '47.13', '36.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1554, '202210281569', '', 'Oilatum Junior Cream 350g(Adult and child)', '76.58', '59.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1555, '202210281570', '', 'Oilatum Soap (Bar) 100g', '55.37', '42.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1556, '202210281571', '', 'Olanzanpine 5mg 10s (Exeter)', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1557, '202210281572', '', 'Olanzanpine 5mg 14s', '19.43', '15.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1558, '202210281573', '', 'Olanzapine 10mg( Accord) 7s', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1559, '202210281574', '', 'Olanzapine 10mg( Teva) 7s 4/PCK', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1560, '202210281575', '', 'Olay Bar Soap', '12.37', '9.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1561, '202210281576', '', 'OLBAS OIL 10/12ML CHILDREN', '48.18', '43.63', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1562, '202210281577', '', 'OLBAS OIL 10ML /ADULT', '57.81', '31.82', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1563, '202210281578', '', 'Old Spice Bath', '48.65', '31.82', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1564, '202210281579', '', 'Old Spice Deo Stick', '44.86', '30.91', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1565, '202210281580', '', 'Olfen 75-SR Depotab 10s', '27.10', '20.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1566, '202210281581', '', 'Olfen Gel 20mg', '24.75', '19.09', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1567, '202210281582', '', 'Olfen Gel 50g', '43.59', '33.63', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1568, '202210281583', '', 'Olive oil ear Drop (All)', '15.32', '11.82', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1569, '202210281584', '', 'Omega  H3 (Health Aid) 30s', '125.35', '69.08', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1570, '202210281585', '', 'Omega H3 BioTonic Caps 30S', '124.88', '96.35', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1571, '202210281586', '', 'Omega H3 Liquid 200ml', '97.30', '53.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1572, '202210281587', '', 'Omega Oil 50ml', '14.14', '10.91', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1573, '202210281588', '', 'Omeprazole (Lavicid/Swiss) Injection 40mg', '15.32', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1574, '202210281589', '', 'Omeprazole (Limzer) Caps. 10s 3/pck Mega', '44.18', '27.27', 60, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1575, '202210281590', '', 'Omeprazole (Mylan) 40mg 7s', '3.54', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1576, '202210281591', '', 'Omeprazole (Omzol) 10s', '4.13', '3.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1577, '202210281592', '', 'Omeprazole (Omzol) INJECTION 40mg', '16.49', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1578, '202210281593', '', 'Omeprazole (Sandoz) 20mg 7s', '4.71', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1579, '202210281594', '', 'Omeprazole (teva) 40mg 7s 3/pck', '10.59', '8.18', 62, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1580, '202210281595', '', 'Omeprazole 20mg (milpharm) Caps. 7s', '4.01', '3.09', 45, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1581, '202210281596', '', 'Omeprazole 20mg (Omizec-Sanofi) 7s 4/pck', '7.66', '5.91', 29, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1582, '202210281597', '', 'Omeprazole 20mg (teva) 7s*4', '8.24', '6.36', 59, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1583, '202210281598', '', 'Omeprazole(omesk) 20mg 10s', '3.54', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE');
INSERT INTO `products_master` (`id`, `pid`, `barcode`, `pname`, `sprice`, `cprice`, `qty`, `cat`, `pimg`, `status`) VALUES
(1584, '202210281599', '', 'Omezole 20mg (ECL) 10s', '2.35', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1585, '202210281600', '', 'Omron M2 Arm Bood Presure', '412.32', '318.15', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1586, '202210281601', '', 'Omron M7 BP Monitor', '632.62', '488.13', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1587, '202210281602', '', 'On-call Stripsn 50s', '129.58', '99.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1588, '202210281603', '', 'One Touch Lancet (Ultra)', '82.47', '63.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1589, '202210281604', '', 'One Touch Lancets (Delica)', '82.47', '63.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1590, '202210281605', '', 'One Touch Select Plus Flex Meter', '619.67', '478.13', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1591, '202210281606', '', 'ONE TOUCH SELECT PLUS STRIPS 50S', '332.21', '256.34', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1592, '202210281607', '', 'One Touch Select STRIPS', '262.71', '202.71', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1593, '202210281608', '', 'One Touch Ultra Test Strips 50s', '303.94', '234.52', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1594, '202210281609', '', 'Optilub Jelly 82g', '29.45', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1595, '202210281610', '', 'Optilube Jelly 113g', '44.77', '34.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1596, '202210281611', '', 'Optilube Jelly 42g', '20.03', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1597, '202210281612', '', 'Optimol Eye Drop(Ashford)', '35.34', '27.27', 2, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1598, '202210281613', '', 'Optrex Bloodshot Eye Drop', '80.11', '61.81', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1599, '202210281614', '', 'Optrex Itchy Eye Drops', '56.55', '43.63', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1600, '202210281615', '', 'Optrex Multi Action Eye Wash 100ml', '81.04', '68.72', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1601, '202210281616', '', 'Optrex Refreshing Eye 10ml', '42.41', '32.72', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1602, '202210281617', '', 'Optrex Sore Eye Drops', '53.01', '40.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1603, '202210281618', '', 'Oral B Brush (Extra Clean)', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1604, '202210281619', '', 'Oral B Brush 123 (Classic)', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1605, '202210281620', '', 'Oral B mouth Wash ( lasting Freshness)', '21.21', '16.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1606, '202210281621', '', 'Oral B Paste FamilySize 140g', '18.86', '14.54', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1607, '202210281622', '', 'Oral B ToothPaste (Pro-Health)93g', '30.63', '23.63', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1608, '202210281623', '', 'Oral B. Paste 158g (Multi-Pro) Family Size', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1609, '202210281624', '', 'Orelox Susp 50ml', '95.42', '73.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1610, '202210281625', '', 'Orelox Susp. 100ml', '191.91', '148.08', 18, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1611, '202210281626', '', 'Orelox Tab 100mg 1s', '15.32', '11.82', 100, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1612, '202210281627', '', 'Orelox Tab 200mg 1s', '21.80', '16.82', 100, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1613, '202210281628', '', 'ORS Original 1s 25/pck ALL', '1.84', '0.91', 385, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1614, '202210281629', '', 'Osons Garlic Peals', '10.59', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1615, '202210281630', '', 'Osons Gripe Water', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1616, '202210281631', '', 'Osteocare Chewable 30S', '113.39', '69.99', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1617, '202210281632', '', 'Osteocare Liquid -india', '22.21', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1618, '202210281633', '', 'Osteocare Liquid UK', '84.13', '56.45', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1619, '202210281634', '', 'Osteocare Original Cap UK 30s', '89.54', '69.08', 3, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1620, '202210281635', '', 'OSTEOCARE PLUS OMEGA 3C', '248.16', '181.80', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1621, '202210281637', '', 'Otrivine Infant/Child Drops 0.5 percent ', '67.15', '34.54', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1622, '202210281638', '', 'OTRIVINE NASAL DROPS (ADULT) 0.1 PERCENT', '66.27', '32.72', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1623, '202210281639', '', 'Ovacare Tab.', '40.05', '30.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1624, '202210281640', '', 'Ovatine 1.2kg', '153.15', '118.17', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1625, '202210281641', '', 'Oxafen (Piroxicam) Caps', '4.71', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1626, '202210281642', '', 'Pabiovite Injection 5ml 1s', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1627, '202210281643', '', 'Painoff Tab 25/pk 4s', '1.18', '0.91', 383, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1628, '202210281644', '', 'Palaxin Susp.', '15.91', '12.27', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1629, '202210281645', '', 'Palaxin Tab 9s', '19.43', '15.00', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1630, '202210281646', '', 'Palmolive Shower Gel 250ml', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1631, '202210281647', '', 'Panacin Tabs 10s 10/pck', '2.35', '1.82', 165, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1632, '202210281648', '', 'Panadol Actifast 14s', '27.10', '20.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1633, '202210281649', '', 'Panadol Advance plain (Booklet blue) 16s uk gsk', '35.38', '30.00', 27, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1634, '202210281650', '', 'Panadol Extra 10s ', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1635, '202210281651', '', 'Panadol Extra 12s (UK)', '18.26', '14.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1636, '202210281652', '', 'Panadol Extra Adv.(Booklet Red)14s', '38.59', '32.72', 119, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1637, '202210281653', '', 'Panadol soluble (sachet)', '2.35', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1638, '202210281654', '', 'Panadol Tab. 10s', '4.13', '3.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1639, '202210281655', '', 'Panto Denk 20mg (Pantoprazole) 14S', '20.61', '15.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1640, '202210281656', '', 'Para 500mg Supp. (Exeter) 1s', '2.35', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1641, '202210281657', '', 'Para Denk Suppo 125mg 1S', '4.71', '3.64', 250, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1642, '202210281658', '', 'Para Denk Suppo 250mg 1s', '4.71', '3.64', 279, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1643, '202210281659', '', 'Para Infusion 1000mg', '24.75', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1644, '202210281660', '', 'Paracetamol 500mg (Local) 10s', '1.77', '1.36', 276, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1645, '202210281661', '', 'Paracetamol 500mg 16s (Crescent-Pharma)', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1646, '202210281662', '', 'PARACETAMOL 500MG 16S(GALPHARM)', '10.91', '7.22', 76, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1647, '202210281663', '', 'Paracetamol 500mg 32s UK', '15.32', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1648, '202210281664', '', 'Paracetamol 500mg UK (Crescent/Exeter/ Zentiva /A&M) 10s', '3.54', '2.73', 71, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1649, '202210281665', '', 'Paracetamol Extra tab (exeter)10s', '2.35', '1.82', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1650, '202210281666', '', 'Paracetamol Infusion (Tamin-Bieffe) Italy', '32.99', '25.45', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1651, '202210281667', '', 'Paracetamol Infusion (Troge)1000mg', '30.63', '23.63', 31, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1652, '202210281668', '', 'Paracetamol Infusion 1000mg ( Entramol)', '17.68', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1653, '202210281669', '', 'PARACETAMOL SYR. 100ML (AYRTON)', '10.59', '8.18', 36, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1654, '202210281670', '', 'Paracetamol Syr.(3mnth-12ys) ABC/Aryton/pharmanova', '8.24', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1655, '202210281671', '', 'Paracetamol Syr.120mg5ml UK 100ml (Fennings)', '40.64', '31.36', 35, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1656, '202210281672', '', 'Paramol supp 1000mg', '2.35', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1657, '202210281673', '', 'PARIET TAB 10MG 1S', '8.24', '6.36', 56, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1658, '202210281674', '', 'PARIET TAB 20MG 1\'S|(14/PCK)', '10.00', '6.55', 112, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1659, '202210281675', '', 'Parlodel (TUK) 2.5mg 10s', '28.87', '22.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1660, '202210281676', '', 'Patanol Eye Drop 0.1 percent', '62.72', '53.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1661, '202210281677', '', 'Pears Soap 125g', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1662, '202210281678', '', 'Pectol Lozenges', '1.18', '0.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1663, '202210281679', '', 'Penicillin 250mg (Phenoxymethyl P enicillin) 28s', '19.43', '15.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1664, '202210281680', '', 'Penicillin G 1MEGA 1S', '1.18', '0.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1665, '202210281681', '', 'Penicillin Ointment', '9.42', '7.27', 41, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1666, '202210281682', '', 'Pepsodent All', '15.32', '11.82', 108, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1667, '202210281683', '', 'Pepsodent Brush', '4.71', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1668, '202210281684', '', 'Pepto Bismol Susp. 118ml', '82.47', '63.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1669, '202210281685', '', 'Pepto Bismol Susp. 120ml', '41.23', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1670, '202210281686', '', 'Pepto Bismol Susp. 240ml', '64.79', '50.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1671, '202210281687', '', 'Pepto Bismol Susp. Ultra 54ml240ml', '129.58', '99.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1672, '202210281688', '', 'Perfect Adult Diapers', '44.77', '34.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1673, '202210281689', '', 'Perfectil Max Caps 84S', '203.69', '172.71', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1674, '202210281690', '', 'PERFECTIL PLATINUM CAPS(RADIANCE SKIN TIME DEFY) 60S', '431.80', '318.24', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1675, '202210281691', '', 'PERFECTIL PLUS CAPS. (HAIR)', '345.81', '253.27', 14, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1676, '202210281692', '', 'Perfectil Plus Skin', '334.60', '236.43', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1677, '202210281693', '', 'Perfectil skin/ hair/nail Original 30S', '82.47', '63.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1678, '202210281694', '', 'PERFECTIL TRIPLE ACTION SKIN.HAIR. NAIL', '158.62', '105.52', 18, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1679, '202210281695', '', 'Permanet Circular Queen size', '50.07', '38.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1680, '202210281696', '', 'Permanet Student Single Retangular', '28.27', '21.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1681, '202210281697', '', 'PERMOXYL (AMOXICILLIN) 100ML SUSP.', '10.02', '7.73', 10, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(1682, '202210281698', '', 'PERMOXYL 500MG  TAB. 10S', '7.07', '5.45', 64, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(1683, '202210281699', '', 'Pethidine Inj 100mg/2ml', '100.13', '77.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1684, '202210281700', '', 'Pevison Cream 15g', '70.09', '54.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1685, '202210281701', '', 'Pharmaderm crem', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1686, '202210281702', '', 'Pharmaderm Soap', '8.24', '6.36', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1687, '202210281703', '', 'Philips Nebuliser Compressor (Innospire Deluxe 230V 50HZ', '948.34', '731.75', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1688, '202210281704', '', 'Phlebodia Cap 1S 15caps', '8.24', '6.36', 235, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1689, '202210281705', '', 'Phytokon (Vitamin K1) inj. 1s', '4.71', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1690, '202210281706', '', 'Pikovit Syp', '35.34', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1691, '202210281707', '', 'Pilex Ointment 30mg', '41.23', '31.82', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1692, '202210281708', '', 'PineGinger', '7.07', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1693, '202210281709', '', 'Pinoplex 200ml', '15.91', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1694, '202210281710', '', 'PIRITON SYP 150ML GSK UK', '102.72', '68.25', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1695, '202210281711', '', 'Piriton Tab UK 15S 2/pck', '37.63', '24.54', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1696, '202210281712', '', 'Piroxicam 20mg (Entrance) 10s', '1.77', '1.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1697, '202210281714', '', 'Plaster Strip 4s(25)', '1.18', '0.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1698, '202210281715', '', 'Plavix (Clopidogrel) 75mg Tab 1s 28/pck', '12.37', '9.54', 215, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1699, '202210281716', '', 'Play Boy Condoms 3s', '8.24', '6.36', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1700, '202210281717', '', 'Plendil (Felodipine) 10mg Tab 30S', '215.29', '172.22', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1701, '202210281718', '', 'Plendil (Felodipine) 5mg Tab 30S', '112.89', '95.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1702, '202210281719', '', 'PMF Vaseline 200g', '14.73', '11.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1703, '202210281720', '', 'Polar Ice Gel 227g (Unirob)', '36.52', '28.18', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1704, '202210281721', '', 'Polyfer Caps', '11.19', '8.64', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1705, '202210281722', '', 'POLYFER FORTE SYRUP 150ML', '19.09', '11.82', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1706, '202210281723', '', 'Polyfer Forte Syrup 200ml', '21.21', '16.36', 9, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1707, '202210281724', '', 'Polyfer Syrup 50ml', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1708, '202210281725', '', 'Polygynax Pess 6s 2/pck', '77.52', '42.72', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1709, '202210281726', '', 'Ponstan (Mefenamic Acid) Caps 250mg 10s 5/pck', '19.43', '15.00', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1710, '202210281727', '', 'Postinor 2 Orig.', '50.07', '38.63', 27, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1711, '202210281728', '', 'Potex 1/2', '15.32', '11.82', 32, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1712, '202210281729', '', 'Praziquantel 600mg 10S', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1713, '202210281730', '', 'Pred Forte 1 percent Eye Drop 5ml', '65.40', '55.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1714, '202210281731', '', 'Prednislone 1mg (Teva) 14s', '4.13', '3.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1715, '202210281732', '', 'Prednisolone 5mg (Local M&G) 10s 50/pck', '1.77', '1.36', 230, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1716, '202210281733', '', 'Prednisolone 5mg (uk/strides pharma) ', '34.16', '26.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1717, '202210281734', '', 'Preg. Test Kit (1st Aid)', '20.61', '15.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1718, '202210281735', '', 'Preg. Test Kit (EASY CHECK)', '22.38', '17.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1719, '202210281736', '', 'Pregabalin Caps (Pregatas 75mg) 10s 3/pck (Intas)', '27.10', '20.91', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1720, '202210281737', '', 'Pregasafe (Pregabalin) 75mg 10s(MSN)', '30.05', '23.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1721, '202210281738', '', 'Pregna Premium caps', '90.71', '69.99', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1722, '202210281739', '', 'PREGNACARE BREASTFEEDING 84S', '229.89', '153.80', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1723, '202210281740', '', 'Pregnacare Conception (Him&Her) 60s', '166.46', '128.44', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1724, '202210281742', '', 'PREGNACARE CONCEPTION 30S HER', '129.46', '89.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1725, '202210281743', '', 'Pregnacare Gummies UK (17Vits&minerals)', '148.44', '114.53', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1726, '202210281744', '', 'Pregnacare Max Caps', '292.67', '248.16', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1727, '202210281745', '', 'Pregnacare New Mom', '141.37', '109.08', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1728, '202210281746', '', 'Pregnacare Original VIT &Minerals 19s', '143.61', '96.35', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1729, '202210281747', '', 'Pregnacare Plus Omega3 UK', '233.94', '161.17', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1730, '202210281748', '', 'Pregnancy Test Kit ( 1st Aid) uk', '20.03', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1731, '202210281749', '', 'Pregnancy text kit ( Clear Preg)', '2.95', '2.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1732, '202210281750', '', 'Pregnavit Max caps', '163.28', '125.99', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1733, '202210281751', '', 'PREMECO CAP 10S 3/PCK', '23.63', '15.45', 42, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(1734, '202210281752', '', 'Premiere Luxe 75ml', '94.24', '72.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1735, '202210281753', '', 'Pretty Panty Liner 30s', '8.24', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1736, '202210281754', '', 'Prime Nut (Almond) 20g', '7.07', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1737, '202210281755', '', 'Prime Nut (Cashew) 20g', '5.30', '4.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1738, '202210281756', '', 'Prime Nut (Mixed) 20g', '4.71', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1739, '202210281757', '', 'Primolut N 5mg 15s 2/pck UK', '29.64', '32.27', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1740, '202210281758', '', 'Procaine Penicillin Inj. 4g', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1741, '202210281759', '', 'Procold Tab 4S 50/pck', '7.07', '5.45', 265, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1742, '202210281760', '', 'Procomil  Spray', '89.05', '68.72', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1743, '202210281761', '', 'Procomil Tab 5mg 10S 3/pck', '20.14', '15.54', 35, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1744, '202210281762', '', 'Procranx Supplement (life Essentials)', '89.05', '68.72', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1745, '202210281763', '', 'Progynova 2ml', '70.09', '54.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1746, '202210281764', '', 'Proman 50+ Caps.', '54.20', '41.81', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1747, '202210281765', '', 'Proman Caps 30s', '55.37', '42.72', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1748, '202210281766', '', 'Promethazine Inj. 50mg/2ml', '2.35', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1749, '202210281767', '', 'Promethazine Syrup (ECL)', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1750, '202210281768', '', 'Promethazine Tab (ECL) 25mg', '1.18', '0.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1751, '202210281769', '', 'Propranolol 40mg 14s  (Teva)', '15.32', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1752, '202210281770', '', 'Prosta Joy Caps', '49.48', '38.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1753, '202210281771', '', 'Prostacare Caps. (Mega)', '169.64', '81.81', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1754, '202210281772', '', 'Prostacure Herb. Tea 24s 80g', '36.52', '28.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1755, '202210281773', '', 'Prostan 2.5ml Eye Drops -Fridge', '132.19', '112.08', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1756, '202210281774', '', 'Prostat 60 10S', '37.69', '29.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1757, '202210281775', '', 'Prostat 60 30S', '131.47', '101.44', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1758, '202210281776', '', 'Prosteez Tab', '69.50', '53.63', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1759, '202210281777', '', 'Provasc 150mg/5mg 1s', '6.48', '5.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1760, '202210281778', '', 'PROVERA TAB 10MG 1\'S', '7.89', '6.09', 136, '4', 'assets/data/products/noimage.png', 'ACTIVE'),
(1761, '202210281779', '', 'Provera Tab 5mg', '155.85', '120.26', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1762, '202210281780', '', 'Proviron Tab 10s', '32.40', '25.00', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1763, '202210281781', '', 'PROWOMAN 50+', '72.27', '48.00', 24, '5', 'assets/data/products/noimage.png', 'ACTIVE'),
(1764, '202210281782', '', 'Prowoman Caps 30S', '65.74', '50.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1765, '202210281783', '', 'Proxeed Plus 1S 30/pck', '24.15', '18.63', 150, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1766, '202210281784', '', 'Proxeed Woman 1S', '20.03', '15.45', 150, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1767, '202210281785', '', 'Proximexa (Cefuroxime)  10tabs 500mg 1s', '13.54', '10.45', 34, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1768, '202210281786', '', 'Proximexa 250mg Tab. 1s', '4.96', '5.45', 150, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1769, '202210281787', '', 'Proximexa Susp 125m(50ml)', '96.49', '81.81', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1770, '202210281788', '', 'PROXIMEXA SUSP 250GM(50ML)', '149.99', '100.03', 17, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(1771, '202210281789', '', 'Prozac (Fluoxetine) 20mg 10s', '11.19', '8.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1772, '202210281790', '', 'Punch & Judy Tooth Paste', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1773, '202210281791', '', 'Pure 3in1 Make-up Wipes', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1774, '202210281792', '', 'Pure Cod Liver Oil 150ml(Ayrtons)', '73.64', '42.72', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1775, '202210281793', '', 'Pure Klenz Hand Sanitizer 100ml', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1776, '202210281794', '', 'Pure Klenz Hand Sanitizer 250ml', '22.38', '17.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1777, '202210281795', '', 'Pure Klenz Hand Sanitizer 50ml', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1778, '202210281796', '', 'Pure Klenz Hand Sanitizer 600ml', '35.34', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1779, '202210281797', '', 'Pylin Capsules', '78.34', '60.45', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1780, '202210281798', '', 'Pylin Ointment', '63.61', '49.09', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1781, '202210281799', '', 'Queen Elizbeth Cocoa Cream  Butter B/S 500ml', '30.63', '23.63', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1782, '202210281800', '', 'Queen Elizbeth Cocoa Cream Butter m/s 250ml', '18.86', '14.54', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1783, '202210281801', '', 'Queen Elizbeth Cocoa Cream Butter S/S 125ml ml', '10.59', '8.18', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1784, '202210281802', '', 'Queen Elizbeth lottion B/S 800ml', '30.63', '23.63', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1785, '202210281803', '', 'Queen Elizbeth lottion m/S 400ml', '18.86', '14.54', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1786, '202210281804', '', 'Quine sulphate 200mg (Teva)10S', '18.86', '14.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1787, '202210281805', '', 'Quinine Tabs 200mg 14s', '19.43', '15.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1788, '202210281806', '', 'Ramipril 10mg 28s Teva', '24.15', '18.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1789, '202210281807', '', 'Ramipril 5mg (Bristol & Crescent) 14s 2/pck', '18.26', '14.09', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1790, '202210281808', '', 'Ramipril 5mg (Teva) 7s 4/pck', '5.89', '4.55', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1791, '202210281809', '', 'Ranitidine 150mg 10s', '3.54', '2.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1792, '202210281810', '', 'Ranitidine( Medreich & ennogen)300mg 10s', '10.02', '7.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1793, '202210281811', '', 'Rapinol Tab 4S 25/pck', '1.18', '0.91', 281, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1794, '202210281812', '', 'Redbull Can Drink', '15.32', '11.82', 33, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1795, '202210281813', '', 'Redin plus Caps 30S', '30.63', '23.63', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1796, '202210281814', '', 'Redin PN Syr. ', '25.92', '20.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1797, '202210281815', '', 'RedSun Jelly 1s 4/pk', '3.54', '2.73', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1798, '202210281816', '', 'Refresh Liquigel Drop 15ml(Allergan)', '89.24', '75.68', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1799, '202210281817', '', 'Refresh Tears Eye Drops ', '120.07', '101.81', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1800, '202210281818', '', 'Relcer Gel', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1801, '202210281819', '', 'Relestat Eye Drop 5ml(Allergan)', '157.58', '133.62', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1802, '202210281820', '', 'Renerve Plus', '220.55', '166.97', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1803, '202210281821', '', 'Replenish+ Caps.', '173.67', '147.26', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1804, '202210281822', '', 'Rescofer Syrup 200ml', '34.75', '26.82', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1805, '202210281823', '', 'Rexona Duo Spray 200ml', '30.63', '23.63', 107, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1806, '202210281824', '', 'Rexona Roll on', '16.49', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1807, '202210281825', '', 'RHINATHIOL EXPECTORANT 2 PERCENT (INFANT)', '61.36', '40.91', 49, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1808, '202210281826', '', 'Rhinathiol Expectorant Adult 5 percent 125ml', '57.72', '44.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1809, '202210281827', '', 'Rhizin (Ozin) Entrance 10s', '1.18', '0.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1810, '202210281828', '', 'Rhizine Syp 30ml', '5.89', '4.55', 70, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1811, '202210281829', '', 'RHIZINE TAB 10S(KINAPHARMA)', '1.18', '0.91', 186, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1812, '202210281830', '', 'Rima Cream 1 percent', '4.13', '3.18', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1813, '202210281831', '', 'Rima plus Cream', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1814, '202210281832', '', 'Risperidone 2mg 14s 2/PCK', '22.97', '17.73', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1815, '202210281833', '', 'RL (Ringers) Infusion 500ml', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1816, '202210281834', '', 'RL(Sodium Lactate Infusion)', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1817, '202210281835', '', 'ROBAXIN TAB 750MG 1S', '3.18', '2.73', 400, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1818, '202210281836', '', 'ROBB INHALER', '3.54', '2.73', 59, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1819, '202210281837', '', 'Robb Ointment b/s 23ml', '7.07', '5.45', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1820, '202210281838', '', 'ROBB OINTMENT S/S', '1.77', '0.82', 168, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1821, '202210281839', '', 'ROBERTS GLYCERINE 30ML', '9.42', '7.27', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1822, '202210281840', '', 'Roberts Glycerine 90ml', '18.26', '14.09', 3, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1823, '202210281841', '', 'Robitussin Chesty Cough (UK)', '70.68', '54.54', 3, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1824, '202210281842', '', 'Robitussin Cough Syr. 100ml (dry)', '41.35', '31.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1825, '202210281843', '', 'Robitussin Cough Syr. 100ml (wet)', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1826, '202210281844', '', 'Robitussin Syr. 250ml', '73.15', '56.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1827, '202210281845', '', 'ROCEPHIN (CEFTRIAXONE) IV 2G', '151.96', '117.26', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1828, '202210281846', '', 'Rocephin(Ceftriaxone) inj 1g', '96.60', '74.54', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1829, '202210281847', '', 'Ronfit cold forte syrp 100ml', '4.71', '3.64', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1830, '202210281848', '', 'ROOTER LIFE MIXTURE', '51.86', '34.54', 44, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1831, '202210281849', '', 'ROOTER MIXTURE L/S', '21.64', '8.50', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1832, '202210281850', '', 'Rooter Tytonic', '30.45', '21.36', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1833, '202210281851', '', 'ROPHELINE 100ML', '31.80', '24.54', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1834, '202210281852', '', 'ROUGH RIDER CONDOM', '12.73', '7.27', 156, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1835, '202210281853', '', 'Rox', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1836, '202210281854', '', 'Rubbing  (isopropyl) 450ml', '25.92', '20.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1837, '202210281855', '', 'Rubbing Alcohol ( Royal Charisma)', '29.45', '22.73', 35, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1838, '202210281856', '', 'Rubbing Alcohol (Trustcare) 500ml', '23.56', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1839, '202210281857', '', 'Rubbing Alcohol 1L (Trustcare)', '44.77', '34.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1840, '202210281858', '', 'Sabroso oil 100ml', '16.49', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1841, '202210281859', '', 'Sabroso oil 250ml', '38.87', '30.00', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1842, '202210281860', '', 'Salamol (kmsol) Inhaler', '43.00', '33.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1843, '202210281861', '', 'SALAMOL INHALER (VENTOMAC/IVAX)', '49.09', '32.72', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1844, '202210281862', '', 'SALBUTAMOL SYRUP 200ML', '13.64', '8.18', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1845, '202210281863', '', 'Salbutamol Tab 4mg (letap)', '1.18', '0.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1846, '202210281864', '', 'Salo fulvin Susp. ', '12.37', '9.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1847, '202210281865', '', 'Samalin  Adult drowsy cough syrup125ml', '14.14', '10.91', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1848, '202210281866', '', 'Samalin Adult (Non Drowsy)', '14.14', '10.91', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1849, '202210281867', '', 'SAMALIN ADULT LOZENGES', '5.30', '4.09', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1850, '202210281868', '', 'Samalin Junior (Drowsy)', '15.91', '12.27', 76, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1851, '202210281869', '', 'Samalin Junior (Non Drowsy)', '13.54', '10.45', 46, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1852, '202210281870', '', 'Samocid Skin and Nail', '51.95', '40.09', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1853, '202210281871', '', 'Sanex Bath', '47.13', '36.36', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1854, '202210281872', '', 'Sanitizer (Kasapreko) 750ml', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1855, '202210281873', '', 'Sanitizer 60ml (Hand Gel)', '23.56', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1856, '202210281874', '', 'Sanitizer kinel (S/S)', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1857, '202210281875', '', 'Savlon Anticeptic 125ML', '17.08', '13.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1858, '202210281876', '', 'Savlon Anticeptic 250ml', '29.45', '22.73', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1859, '202210281877', '', 'Savlon Anticeptic 2Lt', '171.23', '132.13', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1860, '202210281878', '', 'Savlon Anticeptic 75ML', '11.19', '8.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1861, '202210281879', '', 'Savlon Antiseptic 500ml', '41.23', '31.82', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1862, '202210281880', '', 'Savlon Antiseptic 750ml', '90.71', '69.99', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1863, '202210281881', '', 'Savlon Cream 30g', '20.61', '15.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1864, '202210281882', '', 'Savlon Cream 60g', '32.40', '25.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1865, '202210281883', '', 'Savlon Soap 175mg', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1866, '202210281884', '', 'Scheripoct Supp 1s', '2.83', '2.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1867, '202210281885', '', 'Scheriproct Ointment 30g', '79.52', '61.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1868, '202210281886', '', 'SEFLOX EYE/EAR DROPS', '8.18', '5.45', 12, '4', 'assets/data/products/noimage.png', 'ACTIVE'),
(1869, '202210281887', '', 'SebaMed  Buble Bath 500m', '79.52', '61.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1870, '202210281888', '', 'SebaMed Anti-Stretch Mark CR 200ml', '63.61', '49.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1871, '202210281889', '', 'SebaMed Antibacterial cleansing foam 150ml', '58.32', '45.00', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1872, '202210281890', '', 'SebaMed Baby milk 200ml', '70.68', '54.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1873, '202210281891', '', 'SebaMed Body Lotion 100ml', '37.69', '29.09', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1874, '202210281892', '', 'SebaMed Body Lotion 200ml', '63.61', '49.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1875, '202210281893', '', 'SebaMed Buble Bath 1000ml', '151.96', '117.26', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1876, '202210281894', '', 'SebaMed Buble Bath 200m', '40.05', '30.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1877, '202210281895', '', 'SebaMed Clear Face Care Gel 50ml', '68.92', '53.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1878, '202210281896', '', 'SebaMed Clear Face Caremattifying cream 50ml', '68.92', '53.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1879, '202210281897', '', 'SebaMed Clear Face cleansing bar 100g', '34.16', '26.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1880, '202210281898', '', 'SebaMed Clear Face facial toner 150ml', '42.41', '32.72', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1881, '202210281899', '', 'SebaMed Clear Face gentle scrub 150ml', '68.92', '53.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1882, '202210281900', '', 'SebaMed Clear Face pimples 10ml', '36.52', '28.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1883, '202210281901', '', 'SebaMed Repair Foot Cream100ml', '41.35', '31.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1884, '202210281902', '', 'SECLEAR EYE DROP', '18.18', '10.91', 36, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1885, '202210281903', '', 'Secnidazole Seczol DS 1g', '7.07', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1886, '202210281904', '', 'SECURE CONTRACEPTIVE', '5.89', '4.55', 44, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1887, '202210281905', '', 'Sedalyn Adult Cough', '7.07', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1888, '202210281906', '', 'Sedalyn Paed 125mls', '6.48', '5.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1889, '202210281907', '', 'Selevite P Tabs', '48.69', '13.64', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1890, '202210281908', '', 'SELEVITE TAB 30S', '54.05', '24.54', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1891, '202210281909', '', 'Selsun Shampoo 2 percent 100ml', '41.23', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1892, '202210281910', '', 'SENAFEN (ACCECLOFENAC) TAB 100MG 10S 10/PCK', '20.00', '13.64', 60, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1893, '202210281911', '', 'Sensodyne Paste 75mg All', '33.64', '25.96', 215, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1894, '202210281912', '', 'Sensodyne 75g fresh Mint', '14.14', '10.91', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1895, '202210281913', '', 'Sensodyne (Freshmint & Cool Gel) 100mg', '25.92', '20.00', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1896, '202210281914', '', 'Septilin Syr(Himalaya) 100ml', '40.05', '30.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1897, '202210281915', '', 'Septilin Tab 100s', '35.34', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1898, '202210281916', '', 'Septol Sanitizer 500ml', '47.13', '36.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1899, '202210281917', '', 'Seretide Accu. inhaler 50/250mg', '187.67', '144.80', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1900, '202210281918', '', 'Seretide Accuhaler 50/100mcg', '166.92', '141.53', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1901, '202210281919', '', 'Sertraline 100mg 1s 28/pck (milpharm)', '2.35', '1.82', 210, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1902, '202210281920', '', 'Sertraline 50mg (teva) 28s', '22.38', '17.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1903, '202210281921', '', 'Seven Sea Codliver oil caps 120s', '131.32', '111.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1904, '202210281922', '', 'Seven Sea Codliver oil orange flavour(Children)', '47.13', '36.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1905, '202210281923', '', 'Seven Seas Cod liver Oil syrup -(Orange flavor/Max strength) 150ml UKs', '70.68', '54.54', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1906, '202210281924', '', 'Seven Seas Codliver  plus omega 3 fish oil. 100mg', '67.86', '52.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1907, '202210281925', '', 'Seven Seas Codliver 125ml( ECL)', '43.59', '33.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1908, '202210281926', '', 'Seven Seas Codliver oil cap 1s', '0.95', '0.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1909, '202210281927', '', 'Seven Seas Codliver oil cap 30s', '67.14', '51.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1910, '202210281928', '', 'Seven Seas Codliver oil cap 60s  liver Gelatin150ml', '97.19', '74.99', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1911, '202210281929', '', 'Seven Seas Codliver Syrup children 100ml', '62.44', '48.18', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1912, '202210281930', '', 'Seven Seas Joint care Active tab', '156.31', '132.53', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1913, '202210281931', '', 'Seven Seas Joint care max tab', '288.00', '244.21', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1914, '202210281932', '', 'Seven Seas Joint care Supplex tab', '123.00', '94.90', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1915, '202210281933', '', 'Shavette 2', '4.71', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1916, '202210281934', '', 'Shavette Tripple Bades for Women', '17.68', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1917, '202210281935', '', 'Shavette Twin Blades For Women (Chromium)', '15.32', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1918, '202210281936', '', 'Sibi Men Caps', '21.80', '16.82', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1919, '202210281937', '', 'Sibi soap', '21.21', '16.36', 2, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1920, '202210281938', '', 'Sibi Women Caps', '22.38', '17.27', 13, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1921, '202210281939', '', 'SILDENAFIL 100MG (MACLEODS)', '19.09', '12.73', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1922, '202210281940', '', 'Sildenafil 100mg (Exeter)', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1923, '202210281941', '', 'Sildenafil 100mg (Teva/accord)', '31.80', '24.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1924, '202210281942', '', 'Sildenafil 100mg uk ( Dr. Reddy)', '15.32', '11.82', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1925, '202210281943', '', 'Sildenafil 50mg (Teva/accord)', '20.03', '15.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1926, '202210281944', '', 'Sildenafil 50mg Tab. 1s', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1927, '202210281945', '', 'Silver Bird Oil', '32.40', '25.00', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1928, '202210281946', '', 'Silverderma Cream 50g (imres)', '24.75', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1929, '202210281947', '', 'Silverderma Cream 50g(Aldo)', '46.10', '39.09', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1930, '202210281948', '', 'Silverzine Cream', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1931, '202210281949', '', 'Simvastatin 10mg 28s UK', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1932, '202210281950', '', 'Simvastatin 20mg 28s (crescent)', '17.68', '13.64', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1933, '202210281951', '', 'Simvastatin 40mg 28s ', '21.80', '16.82', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1934, '202210281952', '', 'Sinopid Tab 10s', '6.48', '5.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1935, '202210281953', '', 'Sinutab Non-Drowsy Tab.', '61.11', '51.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1936, '202210281954', '', 'Sirdalud (Tizanidine) 4mg 10s', '50.66', '39.09', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1937, '202210281955', '', 'Sirdalud 2mg tab 10s 3/pck', '25.92', '20.00', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1938, '202210281956', '', 'Sivoderm Cream 80mg', '12.96', '10.00', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1939, '202210281957', '', 'Sivoderm Powder 70g', '10.02', '7.73', 2, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1940, '202210281958', '', 'Slim Smart Cap.', '135.48', '104.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1941, '202210281959', '', 'SMA', '57.72', '44.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1942, '202210281960', '', 'Soluble Asprin 75mg 26s 8/pck', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1943, '202210281961', '', 'Soluble Vit C+Zinc+Selenium(Harveys)', '29.45', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1944, '202210281962', '', 'Somazina 1000mg.', '224.78', '173.44', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1945, '202210281963', '', 'Soothing Foot Powder 170g', '19.43', '15.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1946, '202210281964', '', 'Spanish Fly', '94.24', '72.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1947, '202210281965', '', 'Spironolactone 100mg 14s ( Bristol)UK', '15.91', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1948, '202210281966', '', 'Spironolactone 25mg tab(Gen) 28s', '25.32', '19.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1949, '202210281967', '', 'Sporanox (Itraconazole) Cap 100mg 1s 15/pck', '13.54', '10.45', 174, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1950, '202210281968', '', 'Stagyl (Secnidazole) 1g', '4.71', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1951, '202210281969', '', 'STAMLO 10MG  ', '68.65', '54.99', 64, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1952, '202210281970', '', 'Stamlo 5mg 10s 2/pck', '24.75', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1953, '202210281971', '', 'Stericon Vit C 15mg zinc', '29.45', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1954, '202210281972', '', 'Stomacaine susp 200ml', '24.75', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1955, '202210281973', '', 'Stomocaine 200ml', '23.56', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1956, '202210281974', '', 'Stopkof Cold & Catarrh  Syr.', '14.14', '10.91', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1957, '202210281975', '', 'Stopkof Cold & Catarrh Tab.', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1958, '202210281977', '', 'StopKof Lozenges 4s', '1.77', '1.36', 395, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1959, '202210281978', '', 'Stopkoff  child Formula', '16.49', '12.73', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1960, '202210281979', '', 'STOPKOFF  EXPECTRANT CHILDREN 100ML', '15.00', '9.82', 13, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1961, '202210281980', '', 'Stopkoff Adult formula / Expectrant 100ml', '14.14', '10.91', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1962, '202210281981', '', 'Strepsil Extra triple action 8s 3/pck', '35.34', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1963, '202210281982', '', 'Strepsil Honey & Lemon 12s 2/pck', '40.05', '30.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1964, '202210281983', '', 'STREPSIL HONEY & LEMON 8S 2/PCK', '22.05', '21.82', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1965, '202210281984', '', 'Strepsil loz Orange & Vit C 36s 3/pck', '27.10', '20.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1966, '202210281985', '', 'Strepsil lozenges strawberry 12s', '24.75', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1967, '202210281986', '', 'Strepsil Menthol/lozenges 8s 2/pck', '28.27', '21.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1968, '202210281987', '', 'Strepsil Orange vit C 24s 2/pck', '28.27', '21.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1969, '202210281988', '', 'Strepsil Original 8s', '29.45', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1970, '202210281989', '', 'Strepsil Sore Throat 12s', '25.92', '20.00', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1971, '202210281990', '', 'Streptol Loz', '7.07', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1972, '202210281991', '', 'Stugeron Tab 25mg 10S 4/pck', '12.96', '10.00', 60, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1973, '202210281992', '', 'Sucrafil O Gel 100ml', '31.80', '24.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE');
INSERT INTO `products_master` (`id`, `pid`, `barcode`, `pname`, `sprice`, `cprice`, `qty`, `cat`, `pimg`, `status`) VALUES
(1974, '202210281993', '', 'SUDAFED DECONGESTANT 12S', '52.27', '34.73', 14, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1975, '202210281994', '', 'Sudafed Maxstrength Congestion & Headache Cap 16s', '71.57', '55.23', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1976, '202210281995', '', 'sudafed mucus relief tab 16s', '62.55', '48.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1977, '202210281996', '', 'Sudafed Sinus Max Strength 16', '70.76', '59.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1978, '202210281997', '', 'Sudafed Sinus Pressure & Pain Cap. 12s (PE)', '40.05', '30.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1979, '202210281998', '', 'Sudo cream 125gm', '48.77', '37.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1980, '202210282000', '', 'Sudo cream Cream 400gm', '128.40', '99.08', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1981, '202210282001', '', 'SUDO CREAM CREAM 60GM', '40.91', '32.72', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1982, '202210282002', '', 'Sulphur Ointment', '13.54', '10.45', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1983, '202210282003', '', 'Sulphur Soap', '24.75', '19.09', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1984, '202210282004', '', 'Sumatriptan 100mg 6s (Teva)', '30.63', '23.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1985, '202210282005', '', 'SUPER APETI PLUS SYP', '17.27', '11.50', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1986, '202210282006', '', 'Super Apeti Plus Tab.', '2.35', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1987, '202210282007', '', 'SUPIROCIN OINT. 15G', '39.09', '25.96', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1988, '202210282008', '', 'Supofen Supp. (Para) 500mg 1s', '2.35', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1989, '202210282009', '', 'Sure Deo Spray (Men/Women)', '30.63', '23.63', 315, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1990, '202210282010', '', 'Sure Roll on', '8.24', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1991, '202210282011', '', 'SURFAZ SN  CREAM15G', '17.73', '11.59', 31, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1992, '202210282012', '', 'Swedish Bitters', '32.99', '25.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1993, '202210282013', '', 'Sweetex 700s', '23.56', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1994, '202210282014', '', 'SYMBICORT 160/4.5UG 120DOSES', '182.26', '121.51', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1995, '202210282015', '', 'Symbicort 160/4.5ug 60Doses', '86.84', '73.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1996, '202210282016', '', 'SYMBICORT INHALER 80/4.5UG 60DOSES', '219.68', '58.67', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1997, '202210282017', '', 'Syringe & needle 10ml', '1.18', '0.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1998, '202210282018', '', 'Syringe & needle 2ml', '0.60', '0.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(1999, '202210282019', '', 'Syringe & Needle 5cc', '0.60', '0.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2000, '202210282020', '', 'Systane Eye Drop 10ml', '129.58', '99.99', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2001, '202210282021', '', 'Taabea Caps.', '20.03', '15.45', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2002, '202210282022', '', 'Taabea Mixture', '28.27', '18.18', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2003, '202210282023', '', 'TADOL 100MG 10S 3/PCK', '63.63', '38.81', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2004, '202210282024', '', 'Tadol Cap 50mg 10s', '51.25', '39.54', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2005, '202210282025', '', 'Tadol inj 100mg 1S', '15.32', '11.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2006, '202210282026', '', 'Tadol(Tramadol) Inj (verve) 50mg', '10.59', '8.18', 80, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2007, '202210282027', '', 'TAGERA FORTE TAB(SECNIDAZOLE)', '14.73', '11.36', 32, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(2008, '202210282028', '', 'Talgentis (Taladafil) 5mg 10s 3/pck', '16.49', '12.73', 35, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2009, '202210282029', '', 'Talgentis 20mg 4/pk 1s', '4.71', '3.64', 60, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2010, '202210282030', '', 'Tampax compak Super 18s', '30.63', '23.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2011, '202210282031', '', 'Tamsulosin Hyd. MR 400mcg (Zentiva)15s', '17.68', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2012, '202210282032', '', 'Tamsulosin MR 400mcg 10s (Teva)', '10.59', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2013, '202210282033', '', 'TAVANIC 500MG 1S 5/PCK', '48.18', '32.12', 60, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(2014, '202210282034', '', 'TCP 100ml uk', '68.33', '52.72', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2015, '202210282035', '', 'TCP 200ml', '89.05', '68.72', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2016, '202210282036', '', 'TCP Liquid 50ml', '44.77', '34.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2017, '202210282037', '', 'Tears Natural Eye Drops(alcon)', '41.23', '31.82', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2018, '202210282038', '', 'TEEDAR SYR.', '15.32', '11.82', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2019, '202210282039', '', 'Tegretol (Carbamazepine) CR 200mg 10s', '22.61', '17.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2020, '202210282040', '', 'Tegretol (Carbamazepine) Syr 2 percent', '43.59', '33.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2021, '202210282041', '', 'Tegretol CR 400mg 10s', '44.00', '33.96', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2022, '202210282042', '', 'Tegretol Plane 200mg 10s 5/pck', '22.43', '17.31', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2023, '202210282043', '', 'Tena Lady normal pad 12s', '37.69', '29.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2024, '202210282044', '', 'Tena Lady normal pad 6s', '40.05', '30.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2025, '202210282045', '', 'Tentex Royal', '131.95', '101.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2026, '202210282046', '', 'Terbinafine Hyd. 1 percent Cream 30g', '40.82', '31.50', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2027, '202210282047', '', 'Tetanus Inj. 1s', '12.96', '10.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2028, '202210282048', '', 'TETRACYCLINE CAP 250MG 10S', '2.95', '2.27', 39, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(2029, '202210282049', '', 'Tetracycline Eye Oint', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2030, '202210282050', '', 'Thermometer ( Digital)', '23.56', '18.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2031, '202210282051', '', 'Thermometer ( Infrared)', '636.16', '490.86', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2032, '202210282052', '', 'Tic Tac loz.', '4.13', '3.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2033, '202210282053', '', 'Tiger Caps. 2s', '26.50', '20.45', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2034, '202210282054', '', 'Tiger Delay Spray', '32.99', '25.45', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2035, '202210282055', '', 'Time Herbal Mixture', '26.50', '20.45', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2036, '202210282056', '', 'Timolol (Timol) eye drop 0.5 percent 10ml', '16.49', '12.73', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2037, '202210282057', '', 'Timolol( Exetomol) eye drop 0.5 percent', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2038, '202210282058', '', 'Tinatett B4B4', '34.16', '26.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2039, '202210282059', '', 'TINATETT MALAKARE', '24.54', '15.45', 17, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2040, '202210282060', '', 'TINATETT VENECARE', '36.36', '25.45', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2041, '202210282061', '', 'Tiny Vite Drops', '47.17', '40.00', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2042, '202210282062', '', 'Tixylix Baby Syr.(3mth+)', '41.23', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2043, '202210282063', '', 'Tixylix Black current', '54.20', '41.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2044, '202210282064', '', 'Tixylix Syr. (Toddler)', '41.23', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2045, '202210282065', '', 'Tobradex Eye Drop(novartis)', '21.21', '16.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2046, '202210282066', '', 'Tobrex Eye Drop 0.3 percent', '47.13', '36.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2047, '202210282067', '', 'TOBREX OINT 3.5G', '58.90', '45.45', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2048, '202210282068', '', 'Today Lady Caps.', '22.38', '17.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2049, '202210282069', '', 'Today Man Caps', '23.56', '18.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2050, '202210282070', '', 'Topamax (Topiramato) 50mg 1s', '7.07', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2051, '202210282071', '', 'Tothema 1s(20)', '7.13', '5.00', 169, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2052, '202210282072', '', 'TOUCH AND GO ', '30.00', '20.00', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2053, '202210282073', '', 'Tranexamic Acid Tab 500mg 1s(Exeter/Rivopharm)', '3.54', '2.73', 405, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2054, '202210282074', '', 'Travatan eye drop 2.5ml(Alcon)', '105.92', '81.73', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2055, '202210282075', '', 'Travocort Cream 15g', '37.11', '28.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2056, '202210282076', '', 'Travogen Cream 20g', '45.94', '35.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2057, '202210282077', '', 'TRES ORIX FORTE 100ML S/S', '17.27', '11.28', 68, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2058, '202210282078', '', 'Tres Orix Forte 250ml b/s', '40.05', '30.91', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2059, '202210282079', '', 'Trexamol (Tramadol+Para.)', '18.86', '14.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2060, '202210282080', '', 'Triam-Denk (Triamcinolone ) 40mg Inj. 1s', '20.61', '15.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2061, '202210282081', '', 'Tricillicate (  Aluminium Hydro) Tab 10s', '1.18', '0.91', 196, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2062, '202210282082', '', 'Trident Gum All', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2063, '202210282083', '', 'Tums (Mint) 150s', '79.52', '61.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2064, '202210282084', '', 'Tums ext strengh (Assorted Fruits) 80s', '63.61', '49.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2065, '202210282085', '', 'Tushies Baby Wipes', '16.49', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2066, '202210282086', '', 'Tylenol Cold Max. 12s', '40.05', '30.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2067, '202210282087', '', 'Tylenol Extra 24s', '65.97', '50.90', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2068, '202210282088', '', 'Tylenol Extra 2s(50)', '5.89', '4.55', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2069, '202210282089', '', 'Tylenol PM 24s', '113.10', '87.26', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2070, '202210282090', '', 'Tylenol PM 2s', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2071, '202210282091', '', 'Tylenol Rapid 24s', '60.08', '46.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2072, '202210282092', '', 'Typhoid Whole Blood Test Kit', '10.59', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2073, '202210282093', '', 'Ulcerplex Herbal', '8.84', '6.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2074, '202210282094', '', 'Ultra Compact Wet Wipes', '35.34', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2075, '202210282095', '', 'Ultra S3 ', '58.90', '45.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2076, '202210282096', '', 'Unidus love-long Delay Condoms 3s', '14.14', '10.91', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2077, '202210282097', '', 'UNIROB HAND SANITIZER 500ML', '57.72', '44.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2078, '202210282098', '', 'Urografin 76 percent 1s', '34.16', '26.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2079, '202210282099', '', 'V-Firm Cream', '28.27', '21.82', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2080, '202210282100', '', 'Vagi-Cure cream', '19.43', '15.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2081, '202210282101', '', 'Vagin 1s', '58.90', '45.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2082, '202210282102', '', 'Vaginax Cream', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2083, '202210282103', '', 'Vaginax Tab/pess 6s', '6.48', '5.00', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2084, '202210282104', '', 'Valupak Calcium+D 400mg', '16.49', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2085, '202210282105', '', 'Valupak Garlic caps.', '15.91', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2086, '202210282106', '', 'Valupak Multivitamins ', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2087, '202210282107', '', 'Valupak Vit B Complex 30s', '24.75', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2088, '202210282108', '', 'Valupak Vit D', '18.26', '14.09', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2089, '202210282109', '', 'Valupak Vit D3 1000IU/60', '27.10', '20.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2090, '202210282110', '', 'Valupak Vit E 100UI 30S', '24.75', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2091, '202210282111', '', 'Valupak Vit E 200iu (Haid) ', '1.18', '0.91', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2092, '202210282112', '', 'VALUPAK VIT E 400IU ', '64.79', '50.00', 35, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2093, '202210282113', '', 'Valupak vita Zinc 10mg 60tabs', '27.10', '20.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2094, '202210282114', '', 'Vapour Rub', '11.19', '8.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2095, '202210282115', '', 'Vaseline Blue Seal 100g', '16.49', '12.73', 26, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2096, '202210282116', '', 'Vaseline Blue Seal 250g', '30.05', '23.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2097, '202210282117', '', 'Vastarel MR 35mg 10s', '21.21', '16.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2098, '202210282118', '', 'Veet Hair Removal 200ml', '41.23', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2099, '202210282119', '', 'vegan Biotin 800mcg', '45.94', '35.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2100, '202210282120', '', 'Vegan Vit D 500iu 60s (HealthAid)', '56.55', '43.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2101, '202210282121', '', 'Vegan Vitamin B6 (HAid) 100s', '57.72', '44.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2102, '202210282122', '', 'Venos Cough (All)', '37.69', '29.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2103, '202210282123', '', 'VENTOLIN INHALER 100 GSK', '85.45', '56.78', 19, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2104, '202210282124', '', 'Ventolin Nebules 2.5mg 5s', '22.90', '17.68', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2105, '202210282125', '', 'Ventolin Nebules 5mg 5s', '28.84', '22.25', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2106, '202210282126', '', 'Ventolin Syr 150ml', '38.87', '30.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2107, '202210282127', '', 'VERMOX (MEBANDAZOLE)TAB 500MG', '21.00', '14.09', 78, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2108, '202210282128', '', 'VERMOX (MEBENDAZOLE) SUSP.30MLS', '40.58', '24.09', 28, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2109, '202210282130', '', 'Viagra (Sildenafil) 50mg 4Tabs 1s', '99.38', '84.26', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2110, '202210282131', '', 'Viagra (Sildenafil)100mg Tab 1s', '104.20', '98.17', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2111, '202210282132', '', 'Viatamin D3 (Delthapharma)', '25.92', '20.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2112, '202210282133', '', 'vicks sinex soother nasal spray', '65.97', '50.90', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2113, '202210282134', '', 'Victorias Secret Lotion( Kiss me in the ocean) topic rain', '76.34', '65.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2114, '202210282135', '', 'Victorias Secrete Splash', '0.00', '0.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2115, '202210282136', '', 'Vioplex T Spray', '53.01', '40.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2116, '202210282137', '', 'Virest 5 percent Cream 5g', '15.91', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2117, '202210282138', '', 'Virol Tonic 200MLS', '15.32', '11.82', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2118, '202210282139', '', 'VISCOF D SYRUP 100ML', '40.41', '22.27', 23, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2119, '202210282140', '', 'Viscof S Syrup', '22.44', '21.36', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2120, '202210282141', '', 'VISCOF SYRUP PLAIN 100ML', '37.63', '13.91', 52, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2121, '202210282142', '', 'Visine Advance 15ml', '53.60', '45.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2122, '202210282143', '', 'Visine Original 15ml', '63.08', '48.68', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2123, '202210282144', '', 'Visionace Caps 30s', '76.22', '64.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2124, '202210282145', '', 'VIT B  DENK TAB 10S 10/PCK', '36.36', '24.09', 110, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2125, '202210282146', '', 'Vit C 500mg (Healthlife) Tin', '44.77', '34.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2126, '202210282147', '', 'Vit E1000iu 30s Tin (Health Aids', '137.83', '106.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2127, '202210282148', '', 'Vit E400iu 30s (Health Aids', '78.93', '60.90', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2128, '202210282149', '', 'Vita Globin Syrup 200ml', '41.23', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2129, '202210282150', '', 'Vita Joint', '70.68', '54.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2130, '202210282151', '', 'Vitacee 500mg cap. 15s', '21.80', '16.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2131, '202210282152', '', 'Vitafol Tabs 30s', '18.86', '14.54', 30, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2132, '202210282153', '', 'Vitaforce Syr.', '22.38', '17.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2133, '202210282154', '', 'Vitaglobin 200ml', '41.23', '31.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2134, '202210282155', '', 'VitaJoint Tabs 30S', '70.68', '54.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2135, '202210282156', '', 'Vitamin A 5000IU ( HealthAids)', '61.26', '47.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2136, '202210282157', '', 'Vitamin B Co Strong film Coarted (Exeter) 10s', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2137, '202210282158', '', 'Vitamin B Compound 28s', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2138, '202210282159', '', 'VITAMIN ', '29.00', '13.50', 40, '4', 'assets/data/products/noimage.png', 'INACTIVE'),
(2139, '202210282160', '', 'Vitamin B1 100MG (HealthAid) 90S', '70.68', '54.54', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2140, '202210282161', '', 'Vitamin B12 1000IU (HealthAid) 50S', '57.14', '44.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2141, '202210282162', '', 'Vitamin B12 50s (Health Aid)', '57.49', '44.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2142, '202210282163', '', 'Vitamin B6 ( HealthAids)', '58.90', '45.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2143, '202210282164', '', 'Vitamin B6 50mg (HealthAid) 100S', '45.36', '35.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2144, '202210282165', '', 'Vitamin B6 60s (Basic Nutri.)', '16.49', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2145, '202210282166', '', 'Vitamin C (Chewable)-Exeter 30s', '28.27', '21.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2146, '202210282167', '', 'Vitamin C (M&G) 10s', '1.18', '0.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2147, '202210282168', '', 'Vitamin C + Zinc(VitaCare)', '35.34', '27.27', 33, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2148, '202210282169', '', 'Vitamin C +Zinc (Tobcee forte) tobinco', '29.45', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2149, '202210282170', '', 'Vitamin c +Zinc (Vitlife Immune Care)Rakmor', '35.34', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2150, '202210282171', '', 'Vitamin C Effervicent (Mivolis & Altapharma)', '24.75', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2151, '202210282172', '', 'Vitamin C. Chewable (Valupak)', '29.45', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2152, '202210282173', '', 'Vitamin D ( Sunshine 1000iu', '95.42', '73.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2153, '202210282174', '', 'Vitamin E 1000IU (HealthAid)', '127.23', '98.17', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2154, '202210282175', '', 'Vitamin E 2000iu (Health Aid) 60s', '88.35', '68.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2155, '202210282176', '', 'Vitamin E 200IU 60S ( HealthAids)', '94.24', '72.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2156, '202210282177', '', 'Vitamin E 400iu (Health Aid) 30s', '93.06', '71.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2157, '202210282178', '', 'Vitamine B1 100mg (Haid) 100s', '50.66', '39.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2158, '202210282179', '', 'Vitane Oral Drop', '53.01', '40.91', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2159, '202210282180', '', 'VITANE SYR. 200ML', '105.56', '81.45', 10, '1', 'assets/data/products/noimage.png', 'INACTIVE'),
(2160, '202210282181', '', 'Vitarenew 500mg 30s', '31.80', '24.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2161, '202210282182', '', 'Vivadona 20s', '62.44', '48.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2162, '202210282183', '', 'Volpar (Exeter) 10S', '4.71', '3.64', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2163, '202210282184', '', 'Vitamin C +Zinc (Tobcee forte) tobinco', '29.45', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2164, '202210282185', '', 'Vitamin c +Zinc (Vitlife Immune Care)Rakmor', '35.34', '27.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2165, '202210282186', '', 'Vitamin C Effervicent (Mivolis & Altapharma)', '24.75', '19.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2166, '202210282187', '', 'Vitamin C. Chewable (Valupak)', '29.45', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2167, '202210282188', '', 'Vitamin D ( Sunshine 1000iu', '95.42', '73.63', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2168, '202210282189', '', 'Vitamin E 1000IU (HealthAid)', '127.23', '98.17', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2169, '202210282190', '', 'Vitamin E 2000iu (Health Aid) 60s', '88.35', '68.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2170, '202210282191', '', 'Vitamin E 200IU 60S ( HealthAids)', '94.24', '72.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2171, '202210282192', '', 'Vitamin E 400iu (Health Aid) 30s', '93.06', '71.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2172, '202210282193', '', 'Vitamine B1 100mg (Haid) 100s', '50.66', '39.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2173, '202210282194', '', 'Vitane Oral Drop', '53.01', '40.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2174, '202210282195', '', 'Vitane Syr. 200ml', '95.95', '74.04', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2175, '202210282196', '', 'Vitarenew 500mg 30s', '31.80', '24.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2176, '202210282197', '', 'Vivadona 20s', '62.44', '48.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2177, '202210282198', '', 'Volpar (Exeter) 10S', '4.71', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2178, '202210282199', '', 'Voltaren Emulgel 1 percent 20g', '29.45', '22.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2179, '202210282200', '', 'VOLTAREN EMULGEL 1 PERCENT 50G', '74.22', '63.63', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2180, '202210282201', '', 'Voltaren Retard 100mg 10s', '33.58', '25.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2181, '202210282202', '', 'Voltfast 50mg 1s sobres', '4.71', '3.64', 480, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2182, '202210282203', '', 'Warfarin 3mg Tab 28s', '12.96', '10.00', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2183, '202210282204', '', 'Warfarin 5mg 28s', '15.32', '11.82', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2184, '202210282205', '', 'Water -Active', '2.35', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2185, '202210282206', '', 'Water For Injection 10ml 1s (B.Braun)', '2.35', '1.82', 140, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2186, '202210282207', '', 'Wellbaby multi vit Drops(1-12mnths)', '145.14', '101.81', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2187, '202210282208', '', 'Wellkid smart chewable 30s', '159.03', '68.18', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2188, '202210282209', '', 'Wellbaby Syrup 150ml', '176.71', '109.08', 14, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2189, '202210282211', '', 'Wellkid Immune Chewable 4-12yrs', '86.00', '66.36', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2190, '202210282212', '', 'WELLKID MULTIVITAMIN SMART CHEWABLE(4-12YS)', '116.62', '89.99', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2191, '202210282213', '', 'WELLKID MULTIVITAMIN SYRUP 4-12YRS', '154.10', '109.08', 24, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2192, '202210282214', '', 'Wellkid soft Jelly 30s', '169.11', '89.99', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2193, '202210282215', '', 'Wellman 50+ Caps. 30s', '146.91', '78.17', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2194, '202210282216', '', 'Wellman 70+ Caps. 30s', '139.86', '96.35', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2195, '202210282217', '', 'Wellman Anti-fatigue Under Eye Serum 15ml', '160.22', '123.62', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2196, '202210282218', '', 'Wellman Body Wash 250ml', '58.90', '45.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2197, '202210282219', '', 'WELLMAN CONCEPTION 30S', '184.98', '123.12', 4, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2198, '202210282220', '', 'Wellman Drink', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2199, '202210282221', '', 'Wellman Face Scrub 75ml', '79.52', '61.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2200, '202210282222', '', 'Wellman Max Caps', '292.64', '196.34', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2201, '202210282223', '', 'Wellman Original Caps 30S', '163.99', '87.26', 7, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2202, '202210282224', '', 'WELLMAN PLUS OMEGA 3', '145.44', '8.18', 36, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2203, '202210282225', '', 'Wellman Shampoo 250ml', '71.28', '54.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2204, '202210282226', '', 'Wellman Sport Caps.', '91.30', '70.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2205, '202210282227', '', 'Wellteen Caps (Her) 30s', '95.72', '59.09', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2206, '202210282228', '', 'Wellteen Caps (Him) 30s', '98.22', '65.90', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2207, '202210282229', '', 'Wellwoman 50+ Caps.', '159.63', '123.17', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2208, '202210282230', '', 'wellwoman 70+', '128.12', '79.08', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2209, '202210282231', '', 'Wellwoman Can Drink ', '11.78', '9.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2210, '202210282232', '', 'Wellwoman HairFollic Cap. 60s', '261.53', '201.80', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2211, '202210282233', '', 'Wellwoman Max UK', '306.29', '236.34', 3, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2212, '202210282234', '', 'Wellwoman Original Caps. 30s', '171.70', '120.44', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2213, '202210282236', '', 'Wellwoman Sport Caps.', '91.30', '70.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2214, '202210282237', '', 'Whitfield Ointment', '8.24', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2215, '202210282238', '', 'Wibe-Blue unity', '40.05', '30.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2216, '202210282239', '', 'Wibe-Pro clean', '188.49', '145.44', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2217, '202210282240', '', 'Wibe ( B.F)', '21.21', '16.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2218, '202210282241', '', 'Wisdim Kids Paste 0-3yrs', '10.02', '7.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2219, '202210282242', '', 'Wisdom Brush (Great Clean)', '8.84', '6.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2220, '202210282243', '', 'Wisdom Brush (Regular Fresh)', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2221, '202210282244', '', 'Wisdom Brush 2packs', '8.84', '6.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2222, '202210282245', '', 'Wisdom Brush Start 3+ (Twins)', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2223, '202210282246', '', 'Wisdom Kids Brush 0-2yrs', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2224, '202210282247', '', 'Wisdom Kids Brush 3-5yrs', '12.96', '10.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2225, '202210282248', '', 'Wisdom Kids Brush 6yr+', '12.96', '10.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2226, '202210282249', '', 'Wisdom Kids Paste 0-3yrs', '10.59', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2227, '202210282250', '', 'Wisdom Kids Paste 4yrs+', '11.19', '8.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2228, '202210282251', '', 'Wisdom Mouth Wash 500ml', '19.43', '15.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2229, '202210282252', '', 'Wisdom Smokers Brush', '8.24', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2230, '202210282253', '', 'Wokadine Ointment', '9.42', '7.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2231, '202210282254', '', 'WORMBAT SUSP 10ML', '7.07', '5.45', 32, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2232, '202210282255', '', 'Wormee tab', '2.35', '1.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2233, '202210282256', '', 'Wormplex 400 Susp', '15.32', '11.82', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2234, '202210282257', '', 'Wormplex 400 Tab 25/pck', '12.37', '9.54', 73, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2235, '202210282258', '', 'Wright Soap', '21.80', '16.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2236, '202210282259', '', 'Xalacom Eye Drops 2.5ml', '291.57', '224.98', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2237, '202210282260', '', 'Xalatan Eye Drop -Fridge', '207.82', '160.35', 2, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2238, '202210282261', '', 'Xarelto 10mg Tabs 10S', '264.12', '268.16', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2239, '202210282262', '', 'Xarelto 15mg ', '398.38', '374.51', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2240, '202210282263', '', 'Xarelto 20mg ', '366.82', '438.14', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2241, '202210282264', '', 'XATRAL (ALFUZOSIN) LP 10MG 1S 30/PCK', '16.36', '11.82', 240, '3', 'assets/data/products/noimage.png', 'ACTIVE'),
(2242, '202210282265', '', 'XBC Charcoal Soap 100g', '8.84', '6.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2243, '202210282266', '', 'Xenical (Orlistat) Caps 120mg 1S', '12.96', '10.00', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2244, '202210282267', '', 'XIN A (CIPRO) SUSP. 250MG', '50.72', '55.45', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2245, '202210282268', '', 'XOC Charcoal Paste', '16.49', '12.73', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2246, '202210282269', '', 'Xolfovel (Levofloxacin) 500mg', '85.88', '66.27', 2, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2247, '202210282270', '', 'Xolfovel 250mg tabs', '85.88', '66.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2248, '202210282271', '', 'Xylo Acino 0.05 percent (Child)', '87.77', '67.72', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2249, '202210282272', '', 'Xylo Acino 0.1 percent (Adult)', '90.71', '69.99', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2250, '202210282273', '', 'Yafo Tonic', '13.54', '10.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2251, '202210282274', '', 'Yasmin Contraceptive tab', '189.67', '146.35', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2252, '202210282275', '', 'Yoga Fresh(wheat mix yoghurt)', '8.24', '6.36', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2253, '202210282276', '', 'Zedex Syp 100ml', '16.49', '12.73', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2254, '202210282277', '', 'Zeeghurt wheat', '5.89', '4.55', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2255, '202210282278', '', 'Zeman Caps 30S', '143.49', '79.08', 10, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2256, '202210282279', '', 'Zentel (Albendazole) Susp.', '24.75', '19.09', 83, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2257, '202210282280', '', 'Zentel (Albendazole) Tab 48/pck', '20.03', '15.45', 122, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2258, '202210282281', '', 'Zestril (Lisinopril) 20mg Tab 1s 28/pck', '7.66', '5.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2259, '202210282282', '', 'Zestril (Lisinopril) 5mg Tab 1s 28/pck', '5.89', '4.55', 190, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2260, '202210282283', '', 'Zestril (Lisinopril) Tab 10mg 1s 28/pck', '8.84', '6.82', 360, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2261, '202210282284', '', 'Zetapro', '14.14', '10.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2262, '202210282285', '', 'Zin PR 10mg 10s', '1.18', '0.91', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2263, '202210282286', '', 'Zinacef (Cefuroxime) inj 750mg', '38.29', '29.54', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2264, '202210282287', '', 'Zinc 30mg (Naturemade)', '63.61', '49.09', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2265, '202210282288', '', 'Zinc Oxide Ointment', '8.84', '6.82', 3, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2266, '202210282289', '', 'PLASTER ROLL 4\'\'INCHES', '25.91', '17.27', 88, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2267, '202210282290', '', 'PLASTER ROLL 6 15CM*5CM', '23.56', '18.18', 1, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2268, '202210282291', '', 'Zinc Oxide Plaster Roll 1*5cm(EasyCare)', '7.07', '5.45', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2269, '202210282292', '', 'PLASTER ROLL 2INCHES\'\' (5CM*5M)', '12.73', '8.40', 140, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2270, '202210282293', '', 'Zinc Oxide Plaster Roll 3*5cm', '17.68', '13.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2271, '202210282294', '', 'ROLL 6', '28.51', '22.00', 4, '4', 'assets/data/products/noimage.png', 'INACTIVE'),
(2272, '202210282295', '', 'ZINCOFER CAPS 30S', '54.05', '24.54', 27, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2273, '202210282296', '', 'ZINCOFER SYP. 200ML', '43.65', '18.54', 12, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2274, '202210282297', '', 'ZINCOVIT DROPS 15ML', '23.86', '11.70', 26, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2275, '202210282298', '', 'Zincovit Syp. 200ml', '32.05', '30.91', 15, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2276, '202210282299', '', 'Zincovit Tab 30S (APEX)', '39.58', '38.18', 24, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2277, '202210282300', '', 'ZINNAT (CEFUROXIME) 250MG 1S', '15.32', '11.82', 125, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2278, '202210282301', '', 'Zinnat (Cefuroxime) Susp 125mg 100ml', '265.13', '168.37', 6, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2279, '202210282302', '', 'Zinnat (Cefuroxime)125mg Susp. 50ml', '154.27', '132.27', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2280, '202210282303', '', 'ZINNAT TAB 500MG 1S 10/PCK', '22.38', '17.27', 212, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2281, '202210282304', '', 'Zintab 10mg 10s', '2.35', '1.82', 291, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2282, '202210282305', '', 'Zintab 20mg 10s', '3.54', '2.73', 530, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2283, '202210282306', '', 'Zipferon Forte Syr. 200ml', '21.80', '16.82', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2284, '202210282307', '', 'Zirtek Allergy Solution 150ml', '103.91', '89.08', 11, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2285, '202210282308', '', 'ZIRTEK TAB. 1\'S', '6.00', '3.50', 1189, '4', 'assets/data/products/noimage.png', 'INACTIVE'),
(2286, '202210282309', '', 'ZITHROMAX 250MG CAPS', '333.35', '167.26', 24, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2287, '202210282310', '', 'Zithromax Suspension 200MG/15ml', '204.14', '167.26', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2288, '202210282311', '', 'Zoflora Disinfectant', '10.59', '8.18', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2289, '202210282312', '', 'Zoxon (Ceftriaxone) 1g Injection', '15.91', '12.27', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2290, '202210282313', '', 'Zubes Children syp 100ml', '18.26', '14.09', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2291, '202210282314', '', 'ZUBES EXPECTORANT ADULT', '18.18', '11.70', 36, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2292, '202210282315', '', 'ZUBES EXTRA STRONG COUGH 125ML', '25.45', '16.95', 16, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2293, '202210282316', '', 'Zubes Lozenges 4S(Extra Strong)', '1.18', '0.91', 157, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2294, '202210282317', '', 'Zudrex Syr. 100ml', '10.59', '8.18', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2295, '202210282318', '', 'Zudrex tab.', '4.71', '3.64', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2296, '202210282319', '', 'ZULU 100MG (ACCLOFENAC) TAB.', '6.36', '5.00', 20, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2297, '202210282320', '', 'Zurion Tab. 100s', '215.58', '166.35', 0, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2298, '202210282321', '', 'ZURION TABS 30S', '136.35', '90.90', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2299, '202210282322', '', 'Zyloric (Allopurinol)100ml 1s', '2.35', '1.82', 850, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2300, '202210282323', '', 'Zyloric (Allopurinol)300mg 1s 28tabs', '3.54', '2.73', 280, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2301, '202210282324', '', 'Zymax 500mg (Azithromycin) 6s', '22.38', '17.27', 21, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2302, '202210282325', '', 'Zymax Susp (Azithromycin) 250mg', '17.68', '13.64', 40, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2303, '20221102213614', '', 'CHARCOAL GENTLE CLEAN ', '19.00', '11.82', 12, '2', 'assets/data/products/noimage.png', 'Active'),
(2304, '20221102214236', '', 'COLGATE SENSITIVE', '27.55', '17.27', 18, '1', 'assets/data/products/noimage.png', 'Active'),
(2305, '20221102214441', '', 'COLGATE WHITEENING', '24.69', '14.54', 18, '2', 'assets/data/products/noimage.png', 'Active'),
(2306, '20221102215946', '', 'COLGATE EXTRA CLEAN BRUSH', '6.66', '3.64', 144, '2', 'assets/data/products/noimage.png', 'Active'),
(2307, '20221103102226', '', 'GLYCERINE PURE 30ML ROBERT', '8.00', '5.30', 16, '1', 'assets/data/products/noimage.png', 'INACTIVE'),
(2308, '20221103113228', '', 'BARBASOL', '33.25', '18.18', 7, '2', 'assets/data/products/noimage.png', 'Active'),
(2309, '20221103154056', '', 'RHINATHIOL EXPECT 300ML', '102.26', '68.18', 52, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2310, '20221103222614', '', 'LEXSPORIN OINT', '48.48', '30.30', 8, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2311, '20221103232127', '', 'WELLWOMAN PLUS', '215.43', '143.62', 14, '1', 'assets/data/products/noimage.png', 'Active'),
(2312, '20221104124648', '', 'VHEGA (LIFE ESSENTIALS)', '53.63', '38.18', 8, '1', 'assets/data/products/noimage.png', 'Active'),
(2313, '20221104143644', '', ' ACYCLOVIR - DENK 5% CREAM 7G', '65.55', '39.63', 15, '4', 'assets/data/products/noimage.png', 'ACTIVE'),
(2314, '20221105223828', '', 'GUAZE 3\'\'', '15.15', '0.00', 144, '1', 'assets/data/products/noimage.png', 'Active'),
(2315, '20221106095648', '', 'MY BABY SIMPLE LINCTUS COUGH 100ML (MGP)', '15.45', '11.91', 25, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2316, '20221107122119', '', 'B-CO TAB ECL 10\'S 50/PCK', '0.96', '0.00', 72, '1', 'assets/data/products/noimage.png', 'Active'),
(2317, '20221107132000', '', 'NEUROBION TABS 10\'S 2/PCK', '30.91', '20.36', 20, '1', 'assets/data/products/noimage.png', 'Active'),
(2318, '20221107153339', '', 'MY BABY SIMPLE LINCTUS COUGH (ECL)', '14.54', '9.54', 16, '1', 'assets/data/products/noimage.png', 'Active'),
(2319, '20221107195206', '', 'COLGATE CHARCOAL GENTLE CLEAN PASTE.', '15.20', '0.00', 40, '2', 'assets/data/products/noimage.png', 'Active'),
(2320, '20221108162921', '', 'ZIRTEK 21/PCK 1S', '5.45', '3.64', 180, '1', 'assets/data/products/noimage.png', 'Active'),
(2321, '20221109180743', '', 'LUFART TAB 24\'S', '10.91', '7.20', 5, '1', 'assets/data/products/noimage.png', 'ACTIVE'),
(2322, '20221110193843', '', 'DICLO DENK (RECTAL) SUPP 100MG 1\'S 10/PCK', '7.12', '0.05', 160, '1', 'assets/data/products/noimage.png', 'Active'),
(2323, '20221112145428', '', 'NURIFER JR SYP', '15.91', '12.12', 16, '1', 'assets/data/products/noimage.png', 'Active'),
(2324, '20221112150304', '', 'PLASTER ROLL 4\' NEW', '27.27', '0.00', 16, '1', 'assets/data/products/noimage.png', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `products_master_history`
--

CREATE TABLE `products_master_history` (
  `id` int(11) NOT NULL,
  `pid` varchar(30) NOT NULL DEFAULT '',
  `pname` varchar(100) NOT NULL DEFAULT '',
  `sprice` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cprice` decimal(10,2) NOT NULL DEFAULT 0.00,
  `qty` int(4) NOT NULL DEFAULT 0,
  `cat` varchar(10) NOT NULL DEFAULT '',
  `pimg` varchar(100) NOT NULL DEFAULT '',
  `status` varchar(10) NOT NULL DEFAULT '',
  `changedate` timestamp NOT NULL DEFAULT current_timestamp(),
  `pnameo` varchar(100) NOT NULL DEFAULT '',
  `spriceo` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cpriceo` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cato` varchar(10) NOT NULL DEFAULT '',
  `qtyo` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `quotation_details`
--

CREATE TABLE `quotation_details` (
  `id` int(11) NOT NULL,
  `invoiceid` varchar(30) NOT NULL DEFAULT '',
  `pid` varchar(30) NOT NULL DEFAULT '',
  `qty` int(5) NOT NULL DEFAULT 0,
  `sprice` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sales_summary`
--

CREATE TABLE `sales_summary` (
  `id` int(11) NOT NULL,
  `userid` varchar(50) NOT NULL DEFAULT '',
  `sid` varchar(50) NOT NULL,
  `tot_sales` decimal(10,2) NOT NULL DEFAULT 0.00,
  `tot_tax` decimal(10,2) NOT NULL DEFAULT 0.00,
  `tot_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `profit` decimal(10,2) NOT NULL DEFAULT 0.00,
  `transdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `shop` varchar(50) NOT NULL DEFAULT '',
  `cid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shopping_cart`
--

CREATE TABLE `shopping_cart` (
  `id` int(11) NOT NULL,
  `userid` varchar(30) NOT NULL DEFAULT '',
  `pid` varchar(30) NOT NULL DEFAULT '',
  `qty` int(3) NOT NULL DEFAULT 0,
  `status` varchar(20) NOT NULL DEFAULT '',
  `ordernum` varchar(50) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shop_to_shop`
--

CREATE TABLE `shop_to_shop` (
  `id` int(11) NOT NULL,
  `pid` varchar(50) NOT NULL DEFAULT '',
  `prev` int(10) NOT NULL DEFAULT 0,
  `cur` int(10) NOT NULL DEFAULT 0,
  `from_shop` varchar(50) NOT NULL DEFAULT '',
  `to_shop` varchar(50) NOT NULL DEFAULT '',
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `transid` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shop_transfer_details`
--

CREATE TABLE `shop_transfer_details` (
  `id` int(11) NOT NULL,
  `transid` varchar(50) NOT NULL,
  `transdate` date DEFAULT NULL,
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `shop` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `taxconfig`
--

CREATE TABLE `taxconfig` (
  `id` int(11) NOT NULL,
  `taxid` varchar(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `val` decimal(10,2) NOT NULL,
  `optin` varchar(10) NOT NULL DEFAULT 'No',
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` int(11) NOT NULL,
  `pid` varchar(50) NOT NULL DEFAULT '',
  `transid` varchar(100) NOT NULL DEFAULT '',
  `prev` int(10) NOT NULL DEFAULT 0,
  `cur` int(10) NOT NULL DEFAULT 0,
  `shop` varchar(50) NOT NULL DEFAULT '',
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `whqty` tinyint(4) NOT NULL DEFAULT 0,
  `whbal` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `transfer_details`
--

CREATE TABLE `transfer_details` (
  `id` int(11) NOT NULL,
  `transid` varchar(50) NOT NULL,
  `transdate` date DEFAULT NULL,
  `tstamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `shop` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `userid` varchar(20) NOT NULL,
  `fname` varchar(100) NOT NULL DEFAULT '',
  `lname` varchar(100) NOT NULL DEFAULT '',
  `img` varchar(100) NOT NULL DEFAULT '',
  `pword` varchar(200) NOT NULL DEFAULT '',
  `status` varchar(20) NOT NULL DEFAULT '',
  `access` varchar(50) NOT NULL DEFAULT '',
  `gender` varchar(20) NOT NULL DEFAULT '',
  `contact` varchar(50) NOT NULL DEFAULT '',
  `address` varchar(100) NOT NULL DEFAULT '',
  `last_login` datetime DEFAULT NULL,
  `last_page` varchar(500) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `userid`, `fname`, `lname`, `img`, `pword`, `status`, `access`, `gender`, `contact`, `address`, `last_login`, `last_page`) VALUES
(21, 'SP2022001', 'FELIX', 'NIAMAH', 'assets/data/users/avatar.png', '$argon2i$v=19$m=65536,t=4,p=1$QmlqLjhlUncvVGYwMTZrRg$QQyhF1Fx2TIcAj+i7aYUz+3b2E5zb9YG4Hj3/iMtFlY', 'ACTIVE', 'ADMINISTRATOR', 'FEMALE', '0268640343', 'DANSOMAN SHIABU', '2022-12-07 01:07:43', 'http://localhost/pos/dashboard.php?backups'),
(24, 'SP2022002', 'ABRAHAM', 'SARCOH', 'assets/data/users/avatar.png', '$argon2i$v=19$m=65536,t=4,p=1$YTh5N1N0WmlIT01JOHhSSg$IRwbTFzayy+Jp5B7RNQ8QBnOiGuOj31uBkQSeALuPdw', 'ACTIVE', 'USER', 'MALE', '0554923322', '', '2022-12-06 09:22:40', 'http://localhost/pos/dashboard.php?branch=1'),
(30, 'SP2022003', 'OPHELIA ', 'OPARE', 'assets/data/users/avatar.png', '$argon2i$v=19$m=65536,t=4,p=1$R0x4ek1NTFJTL25Fc2ZuWA$dIOiIFu8e0ecCtlHx0pTWNJ1P68lSxLXDIYRENn3EPU', 'ACTIVE', 'USER', 'FEMALE', '0551529694', 'KWABENYA', '2022-11-12 22:05:24', 'http://192.168.100.5/dashboard.php?branch=1&pos'),
(31, 'SP2022004', 'COMFORT', 'AKRAMAH', 'assets/data/users/avatar.png', '$argon2i$v=19$m=65536,t=4,p=1$MzR2QWc4UUkuREdEYlNKZw$7q3RE6OchCbKi/HJ1JF31g1aZmd2p2HZmrTDsQLAZD8', 'ACTIVE', 'USER', 'FEMALE', '0279318066', 'ASHONGMAN ESTATE', '2022-11-16 22:56:12', 'http://localhost/pos_mednet/dashboard.php?viewinvoice=INV/2022/1115181958'),
(32, 'SP2022005', 'THADDEAUS', 'MOR-SARCOH', 'assets/data/users/avatar.png', '$argon2i$v=19$m=65536,t=4,p=1$d2o4ckcwUGM4N3RmUEhsdg$gdbqTLNryc+TetiWrvJmsccL1m874Kj5y0wuXpu2sTY', 'INACTIVE', 'ADMINISTRATOR', 'MALE', '0557351688', 'ASHONGMAN ESTATE', '2022-11-03 15:11:14', 'https://nasoopz.com/mednet/dashboard.php?branch=1&items_master'),
(33, 'SP2022006', 'JOHN', 'MENSAH', 'assets/data/users/avatar.png', '$argon2i$v=19$m=65536,t=4,p=1$amlvTVZRZmhZLmtFbVFFcA$tNxb3FTVP61THthC+lvfHL2/5XwZevKHrhZxjduUp64', 'ACTIVE', 'USER', 'FEMALE', '0209586311', 'KWABENYA', '2022-11-24 01:03:07', 'http://localhost/pos/dashboard.php?branch=1'),
(34, 'SP2022007', 'FORGIVE', 'AKPETORGBOR', 'assets/data/users/avatar.png', '$argon2i$v=19$m=65536,t=4,p=1$OFFzT2dGOUFlSXdHdDdDWQ$1tk0ZLtVzpE/WmRrSHseLPXOHonYfezZAnvldYTBvEI', 'ACTIVE', 'USER', 'FEMALE', '0209586311', 'KWABENYA', '2022-11-13 14:14:54', 'http://192.168.100.5/dashboard.php?branch=1&pos'),
(35, 'SP2022008', 'THADDEAUS', 'MORSARCOH', 'assets/data/users/avatar.png', '$argon2i$v=19$m=65536,t=4,p=1$V2I3V21qdkI4VXJkYnNxUA$anRApPXeTv2v70DJ1rJ8FDkG/PBonR5GB9is1obB2hQ', 'ACTIVE', 'ADMINISTRATOR', 'MALE', '0557351688', 'ASHONGMAN ESTATE', '2022-11-11 16:12:16', 'http://192.168.100.5/dashboard.php?branch=1&items_master');

-- --------------------------------------------------------

--
-- Table structure for table `usr_branch`
--

CREATE TABLE `usr_branch` (
  `id` int(2) NOT NULL,
  `userid` varchar(50) NOT NULL DEFAULT '',
  `branch` varchar(50) NOT NULL DEFAULT '',
  `status` varchar(10) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `backup`
--
ALTER TABLE `backup`
  ADD PRIMARY KEY (`fname`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bname` (`bname`);

--
-- Indexes for table `cart_temp`
--
ALTER TABLE `cart_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`cname`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`cid`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `customer_invoice`
--
ALTER TABLE `customer_invoice`
  ADD PRIMARY KEY (`invoiceid`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `customer_quotation`
--
ALTER TABLE `customer_quotation`
  ADD PRIMARY KEY (`invoiceid`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `cust_login`
--
ALTER TABLE `cust_login`
  ADD PRIMARY KEY (`email`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `invoice_details`
--
ALTER TABLE `invoice_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_payment`
--
ALTER TABLE `invoice_payment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_tax`
--
ALTER TABLE `invoice_tax`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inv_temp`
--
ALTER TABLE `inv_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `memo`
--
ALTER TABLE `memo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ordernum`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `pos_payment`
--
ALTER TABLE `pos_payment`
  ADD PRIMARY KEY (`sid`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `pos_sales`
--
ALTER TABLE `pos_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pos_tax`
--
ALTER TABLE `pos_tax`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pos_temp`
--
ALTER TABLE `pos_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products_master`
--
ALTER TABLE `products_master`
  ADD PRIMARY KEY (`pid`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `products_master_history`
--
ALTER TABLE `products_master_history`
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `quotation_details`
--
ALTER TABLE `quotation_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales_summary`
--
ALTER TABLE `sales_summary`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sid` (`sid`);

--
-- Indexes for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shop_to_shop`
--
ALTER TABLE `shop_to_shop`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shop_transfer_details`
--
ALTER TABLE `shop_transfer_details`
  ADD PRIMARY KEY (`transid`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `taxconfig`
--
ALTER TABLE `taxconfig`
  ADD PRIMARY KEY (`taxid`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfer_details`
--
ALTER TABLE `transfer_details`
  ADD PRIMARY KEY (`transid`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userid`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `usr_branch`
--
ALTER TABLE `usr_branch`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `backup`
--
ALTER TABLE `backup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_temp`
--
ALTER TABLE `cart_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_invoice`
--
ALTER TABLE `customer_invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_quotation`
--
ALTER TABLE `customer_quotation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cust_login`
--
ALTER TABLE `cust_login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_details`
--
ALTER TABLE `invoice_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_payment`
--
ALTER TABLE `invoice_payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_tax`
--
ALTER TABLE `invoice_tax`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inv_temp`
--
ALTER TABLE `inv_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `memo`
--
ALTER TABLE `memo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pos_payment`
--
ALTER TABLE `pos_payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pos_sales`
--
ALTER TABLE `pos_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pos_tax`
--
ALTER TABLE `pos_tax`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pos_temp`
--
ALTER TABLE `pos_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_master`
--
ALTER TABLE `products_master`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2325;

--
-- AUTO_INCREMENT for table `products_master_history`
--
ALTER TABLE `products_master_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotation_details`
--
ALTER TABLE `quotation_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales_summary`
--
ALTER TABLE `sales_summary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop_to_shop`
--
ALTER TABLE `shop_to_shop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shop_transfer_details`
--
ALTER TABLE `shop_transfer_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxconfig`
--
ALTER TABLE `taxconfig`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transfer_details`
--
ALTER TABLE `transfer_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `usr_branch`
--
ALTER TABLE `usr_branch`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
