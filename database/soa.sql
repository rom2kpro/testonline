-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 21, 2021 at 03:56 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `soa`
--

-- --------------------------------------------------------

--
-- Table structure for table `accept`
--

CREATE TABLE `accept` (
  `id_user` int(11) NOT NULL,
  `id_test` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `accept`
--

INSERT INTO `accept` (`id_user`, `id_test`) VALUES
(1, 3),
(1, 2),
(2, 3),
(3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `answer`
--

CREATE TABLE `answer` (
  `id` int(11) NOT NULL,
  `id_ques` int(11) NOT NULL,
  `content` text NOT NULL,
  `answer_true` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `answer`
--

INSERT INTO `answer` (`id`, `id_ques`, `content`, `answer_true`) VALUES
(1, 10, 'anh', 0),
(2, 10, 'yeu', 1),
(3, 10, 'em', 0),
(4, 18, 'trung', 1),
(5, 18, 'trungok', 0),
(6, 18, 'trungoccho', 0),
(7, 19, '1', 0),
(8, 19, '2', 1),
(9, 19, '3', 0),
(10, 19, '4', 0),
(11, 20, 'ok', 0),
(12, 20, 'not ok', 1),
(13, 21, 'Đưa ra quy trình đánh giá tính an toàn cho sản phẩm phần mềm.', 0),
(14, 21, 'Đưa ra quy trình đánh giá hiệu quả của phần mềm', 0),
(15, 21, 'Đưa ra quy trình đánh giá chất lượng cho sản phẩm phần mềm.', 1),
(16, 21, 'Đưa ra quy trình đánh giá tính khả dụng cho sản phẩm phần mềm.', 0),
(17, 22, 'Con người. ', 1),
(18, 22, 'Quy trình.', 0),
(19, 22, 'Sản phẩm.', 0),
(20, 22, 'Thời gian', 0),
(21, 23, 'Extreme programing.', 0),
(22, 23, 'Evolutionary prototyping.', 0),
(23, 23, 'Component architecture', 1),
(24, 23, 'Open-source development', 0),
(25, 24, 'Software requirement specification.', 1),
(26, 24, 'Software design.', 0),
(27, 24, 'Testing.', 0),
(28, 24, 'Coding.', 0),
(29, 25, 'Kiến thức về phân tích thiết kế hệ thống.', 0),
(30, 25, 'Kiến thức về cơ sở dữ liệu.', 0),
(31, 25, 'Lập trình thành thạo bằng một ngôn ngữ lập trình.', 1),
(32, 25, 'Kinh nghiệm quản lý dự án phần mềm.', 0),
(33, 26, 'Nghiệp vụ và tiếp thị.', 0),
(34, 26, 'Phạm vi, ràng buộc và thị trường.', 0),
(35, 26, 'Công nghệ, tiền bạc, thời gian và tài nguyên.', 1),
(36, 26, 'Kỹ năng và năng lực của nhà phát triển.', 0),
(37, 27, 'Phần mềm hệ thống (System software)', 0),
(38, 27, 'Phần mềm trí tuệ nhân tạo (Artificial Intelligence Software)', 0),
(39, 27, 'Phần mềm thời gian thực (Real time software)', 1),
(40, 27, 'Phần mềm nghiệp vụ (Business software)', 0),
(41, 28, 'Phần mềm hệ thống (System software)', 0),
(42, 28, 'Phần mềm trí tuệ nhân tạo (Artificial Intelligence Software)', 0),
(43, 28, 'Phần mềm thời gian thực (Real time software)', 0),
(44, 28, 'Phần mềm nghiệp vụ (Business software)', 1),
(45, 29, 'Phần mềm nghiệp vụ (Business software) ', 1),
(46, 29, 'Phần mềm hệ thống (System software)', 0),
(47, 29, 'Phần mềm trí tuệ nhân tạo (Artificial Intelligence Software)', 0),
(48, 29, 'Phần mềm thời gian thực (Real time software)', 0);

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `id` int(11) NOT NULL,
  `id_test` int(11) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`id`, `id_test`, `content`) VALUES
(10, 2, 'alo123'),
(18, 2, 'ai la trung'),
(19, 2, '1 + 1 = ?'),
(20, 2, 'ok chua?'),
(21, 3, 'Tiêu chuẩn ISO-14598 đưa ra:'),
(22, 3, 'Trong phát triển phần mềm, yếu tố nào quan trọng nhất?'),
(23, 3, 'Kỹ thuật nào sau đây là xây dựng phần mềm từ các thành phần đã được thiết kế trong lĩnh vực công nghệ khác nhau?'),
(24, 3, 'IEEE 830-1993 là một khuyến nghị tiêu chuẩn cho'),
(25, 3, 'Kỹ sư phần mềm không cần'),
(26, 3, 'Tính khả thi của phần mềm dựa vào các yếu tố sau'),
(27, 3, 'Phần mềm dự báo thời tiết thu thập các số liệu về nhiệt độ, độ ẩm, … xử lý tính toán để cho ra các dự báo thời tiết là 1 ví dụ của loại phần mềm'),
(28, 3, 'Phần mềm quản lý sinh viên của 1 trường là'),
(29, 3, 'Phần mềm quản lý tài chính của một công ty là:');

-- --------------------------------------------------------

--
-- Table structure for table `result`
--

CREATE TABLE `result` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_test` int(11) NOT NULL,
  `score` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `result`
--

INSERT INTO `result` (`id`, `id_user`, `id_test`, `score`) VALUES
(1, 1, 2, 5),
(2, 1, 3, 8.88888888888889);

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`id`, `name`) VALUES
(1, 'subject'),
(2, 'SOA'),
(3, 'CNPM');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `id_sub` int(11) NOT NULL,
  `name` text NOT NULL,
  `time` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id`, `id_sub`, `name`, `time`) VALUES
(2, 2, 'kiem tra lan 1', '0:30:0'),
(3, 3, 'Kiểm tra giữa kì 1', '0:30:0');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`) VALUES
(1, 'trung', 'trung123'),
(2, 'alo', '123'),
(3, '123', '123');

-- --------------------------------------------------------

--
-- Table structure for table `user_answer`
--

CREATE TABLE `user_answer` (
  `id_user` int(11) NOT NULL,
  `id_answer` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_answer`
--

INSERT INTO `user_answer` (`id_user`, `id_answer`) VALUES
(1, 3),
(1, 4),
(1, 8),
(1, 11),
(1, 3),
(1, 4),
(1, 8),
(1, 11),
(1, 3),
(1, 4),
(1, 8),
(1, 11),
(1, 2),
(1, 4),
(1, 8),
(1, 11),
(1, 3),
(1, 4),
(1, 8),
(1, 11),
(1, 13),
(1, 17),
(1, 23),
(1, 25),
(1, 31),
(1, 35),
(1, 39),
(1, 44),
(1, 45);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accept`
--
ALTER TABLE `accept`
  ADD KEY `FK_TEST_AC` (`id_test`),
  ADD KEY `FK_USER_AC` (`id_user`);

--
-- Indexes for table `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_AN_QUES` (`id_ques`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_TEST_QUES` (`id_test`);

--
-- Indexes for table `result`
--
ALTER TABLE `result`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_TEST_SUB` (`id_sub`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_answer`
--
ALTER TABLE `user_answer`
  ADD KEY `FK_USER_UA` (`id_user`),
  ADD KEY `FK_AN_UA` (`id_answer`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answer`
--
ALTER TABLE `answer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `result`
--
ALTER TABLE `result`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accept`
--
ALTER TABLE `accept`
  ADD CONSTRAINT `FK_TEST_AC` FOREIGN KEY (`id_test`) REFERENCES `test` (`id`),
  ADD CONSTRAINT `FK_USER_AC` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Constraints for table `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `FK_AN_QUES` FOREIGN KEY (`id_ques`) REFERENCES `question` (`id`);

--
-- Constraints for table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `FK_TEST_QUES` FOREIGN KEY (`id_test`) REFERENCES `test` (`id`);

--
-- Constraints for table `test`
--
ALTER TABLE `test`
  ADD CONSTRAINT `FK_TEST_SUB` FOREIGN KEY (`id_sub`) REFERENCES `subject` (`id`);

--
-- Constraints for table `user_answer`
--
ALTER TABLE `user_answer`
  ADD CONSTRAINT `FK_AN_UA` FOREIGN KEY (`id_answer`) REFERENCES `answer` (`id`),
  ADD CONSTRAINT `FK_USER_UA` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
