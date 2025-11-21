-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 21, 2025 at 03:45 PM
-- Server version: 8.0.17
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `save_energy_go`
--

-- --------------------------------------------------------

--
-- Table structure for table `completed_missions`
--

CREATE TABLE `completed_missions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mission_id` int(11) NOT NULL,
  `completed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `id` int(11) NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`id`, `title`, `content`, `order_number`) VALUES
(1, 'พลังงานคือชีวิต', 'พลังงานเป็นสิ่งจำเป็นในชีวิตประจำวัน แต่การใช้พลังงานอย่างสิ้นเปลืองส่งผลต่อสิ่งแวดล้อมและค่าใช้จ่าย การประหยัดพลังงานช่วยลดค่าไฟฟ้า ลดการปล่อยก๊าซเรือนกระจก และอนุรักษ์ทรัพยากรธรรมชาติ', 1),
(2, 'หลอดไฟ LED ประหยัดจริงหรือ?', 'หลอด LED ใช้พลังงานน้อยกว่าหลอดไส้ถึง 80% และมีอายุการใช้งานนานกว่า 25 เท่า แม้จะมีราคาสูงกว่า แต่ประหยัดค่าไฟในระยะยาว 1 หลอด LED 10W ให้แสงเท่ากับหลอดไส้ 60W', 2),
(3, 'เครื่องปรับอากาศ ตัวการค่าไฟแพง', 'แอร์ใช้พลังงานสูงสุดในบ้าน คิดเป็น 40-60% ของค่าไฟทั้งหมด การตั้งอุณหภูมิที่ 25-26°C ทำความสะอาดแผงกรองทุกเดือน และเลือกแอร์เบอร์ 5 ช่วยประหยัดได้มาก', 3),
(4, 'ปิดเครื่องใช้ไฟฟ้าเมื่อไม่ใช้', 'อุปกรณ์ที่อยู่ในโหมด Standby ยังใช้พลังงาน 5-10% ของการทำงานปกติ ทีวี คอมพิวเตอร์ เครื่องชาร์จ ควรถอดปลั๊กหรือใช้สวิตช์ปิดเมื่อไม่ใช้งาน', 4),
(5, 'พลังงานหมุนเวียน ทางเลือกใหม่', 'พลังงานแสงอาทิตย์ ลม น้ำ เป็นพลังงานสะอาดไม่มีวันหมด การติดตั้งโซลาร์เซลล์บนหลังคาบ้านช่วยลดค่าไฟและเป็นมิตรกับสิ่งแวดล้อม', 5);

-- --------------------------------------------------------

--
-- Table structure for table `missions`
--

CREATE TABLE `missions` (
  `id` int(11) NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `points` int(11) NOT NULL,
  `order_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `missions`
--

INSERT INTO `missions` (`id`, `title`, `description`, `points`, `order_number`) VALUES
(1, 'เปลี่ยนหลอดไฟเป็น LED', 'เปลี่ยนหลอดไฟในบ้านอย่างน้อย 1 หลอดเป็น LED', 10, 1),
(2, 'ปิดไฟเมื่อออกจากห้อง', 'ปิดไฟทุกครั้งเมื่อออกจากห้อง 5 วันติดต่อกัน', 15, 2),
(3, 'ถอดปลั๊กเครื่องชาร์จ', 'ถอดปลั๊กเครื่องชาร์จทุกครั้งหลังชาร์จเสร็จ', 10, 3),
(4, 'ทำความสะอาดแผงกรองแอร์', 'ทำความสะอาดแผงกรองเครื่องปรับอากาศ', 20, 4),
(5, 'ตั้งอุณหภูมิแอร์ 25°C', 'ตั้งอุณหภูมิแอร์ที่ 25-26°C เป็นเวลา 7 วัน', 15, 5),
(6, 'ใช้พัดลมแทนแอร์', 'ใช้พัดลมแทนแอร์ในวันที่อากาศไม่ร้อนมาก', 20, 6),
(7, 'ปิดคอมพิวเตอร์เมื่อไม่ใช้', 'ปิดคอมพิวเตอร์ทุกครั้งเมื่อไม่ใช้งานเกิน 1 ชั่วโมง', 10, 7),
(8, 'ตากผ้าแทนเครื่องอบผ้า', 'ตากผ้าให้แห้งด้วยแสงแดดแทนการใช้เครื่องอบ', 15, 8),
(9, 'ใช้น้ำอย่างประหยัด', 'ปิดน้ำขณะแปรงฟัน ลดเวลาอาบน้ำให้สั้นลง', 15, 9);

-- --------------------------------------------------------

--
-- Table structure for table `quiz_questions`
--

CREATE TABLE `quiz_questions` (
  `id` int(11) NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `option1` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option2` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option3` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option4` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correct_answer` int(11) NOT NULL,
  `order_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_questions`
--

INSERT INTO `quiz_questions` (`id`, `question`, `option1`, `option2`, `option3`, `option4`, `correct_answer`, `order_number`) VALUES
(1, 'หลอด LED ใช้พลังงานน้อยกว่าหลอดไส้กี่เปอร์เซ็นต์?', '50%', '60%', '70%', '80%', 4, 1),
(2, 'ควรตั้งอุณหภูมิเครื่องปรับอากาศที่เท่าไร?', '20-22°C', '23-24°C', '25-26°C', '27-28°C', 3, 2),
(3, 'เครื่องปรับอากาศใช้พลังงานคิดเป็นกี่เปอร์เซ็นต์ของค่าไฟในบ้าน?', '20-30%', '30-40%', '40-60%', '60-80%', 3, 3),
(4, 'อุปกรณ์ในโหมด Standby ใช้พลังงานเท่าไร?', '0%', '5-10%', '15-20%', '25-30%', 2, 4),
(5, 'ข้อใดไม่ใช่พลังงานหมุนเวียน?', 'แสงอาทิตย์', 'ลม', 'น้ำมัน', 'น้ำ', 3, 5),
(6, 'ควรทำความสะอาดแผงกรองแอร์ทุกกี่เดือน?', 'ทุกสัปดาห์', 'ทุกเดือน', 'ทุก 3 เดือน', 'ทุก 6 เดือน', 2, 6),
(7, 'หลอด LED มีอายุการใช้งานนานกว่าหลอดไส้กี่เท่า?', '10 เท่า', '15 เท่า', '20 เท่า', '25 เท่า', 4, 7),
(8, 'เครื่องใช้ไฟฟ้าเบอร์ 5 หมายถึงอะไร?', 'ใช้ไฟน้อยที่สุด', 'ใช้ไฟปานกลาง', 'ใช้ไฟมาก', 'ใช้ไฟมากที่สุด', 1, 8),
(9, 'การประหยัดพลังงานช่วยลดอะไร?', 'ค่าไฟฟ้า', 'ก๊าซเรือนกระจก', 'การใช้ทรัพยากร', 'ถูกทุกข้อ', 4, 9),
(10, 'หลอด LED 10W ให้แสงเท่ากับหลอดไส้กี่วัตต์?', '40W', '50W', '60W', '75W', 3, 10);

-- --------------------------------------------------------

--
-- Table structure for table `quiz_results`
--

CREATE TABLE `quiz_results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `total_questions` int(11) NOT NULL,
  `taken_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_results`
--

INSERT INTO `quiz_results` (`id`, `user_id`, `score`, `total_questions`, `taken_at`) VALUES
(1, 3, 4, 10, '2025-11-16 15:58:47');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `created_at`) VALUES
(3, 'demo', '$2y$10$mSDmbmQwqCZlnlQTBjsctur.JtUpujlf2RzBdumI42V/xUIDjevFC', 'ผู้ใช้ทดสอบ', '2025-11-16 11:05:21'),
(4, 'meaw', '$2y$10$SWMFkapKm85w/O48hl2mvebMukqLkbWOKVkXQg2q.KmA3KkUE2t1S', 'พีรญา', '2025-11-16 11:19:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `completed_missions`
--
ALTER TABLE `completed_missions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_mission` (`user_id`,`mission_id`),
  ADD KEY `mission_id` (`mission_id`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `missions`
--
ALTER TABLE `missions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `completed_missions`
--
ALTER TABLE `completed_missions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `missions`
--
ALTER TABLE `missions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `quiz_results`
--
ALTER TABLE `quiz_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `completed_missions`
--
ALTER TABLE `completed_missions`
  ADD CONSTRAINT `completed_missions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `completed_missions_ibfk_2` FOREIGN KEY (`mission_id`) REFERENCES `missions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD CONSTRAINT `quiz_results_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
