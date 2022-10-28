-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 28, 2022 at 04:44 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hikaya`
--

-- --------------------------------------------------------

--
-- Table structure for table `age_range`
--

CREATE TABLE `age_range` (
  `id` int(11) NOT NULL,
  `min` int(3) DEFAULT NULL,
  `max` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `parent_id` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `title`, `parent_id`) VALUES
(10, 'الإسلامية', 0),
(11, 'المعنوية', 0),
(12, 'التاريخ', 0),
(13, 'قصة خرافية', 0),
(14, 'سبحان محمد ﷺ', 10),
(15, 'قصص اسلامية', 10),
(16, 'رسول اکرم کا اخلاق', 11),
(17, 'الخيال', 0),
(20, 'الخيال العلمي', 0),
(25, 'الكرتون', 0),
(26, 'قصص کارتون', 25),
(27, 'الرسوم المتحركة للأطفال', 25),
(28, 'طويلة-كورتون', 25),
(36, 'Muhammad Younis', 0);

-- --------------------------------------------------------

--
-- Table structure for table `child_activity`
--

CREATE TABLE `child_activity` (
  `id` int(11) NOT NULL,
  `child_id` int(11) DEFAULT NULL,
  `story_id` int(11) DEFAULT NULL,
  `view_date` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cstory_schedule`
--

CREATE TABLE `cstory_schedule` (
  `id` int(11) NOT NULL,
  `story_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `for_child_id` int(11) DEFAULT NULL,
  `datetime_send` int(100) DEFAULT NULL,
  `datetime_created` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `gender_profiles`
--

CREATE TABLE `gender_profiles` (
  `id` int(11) NOT NULL,
  `title` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `id` int(11) NOT NULL,
  `title` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`id`, `title`) VALUES
(5, 'جَذّاب');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `datetime` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `playlists`
--

CREATE TABLE `playlists` (
  `user_id` int(3) DEFAULT NULL,
  `title` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `playlist_stories`
--

CREATE TABLE `playlist_stories` (
  `id` int(11) NOT NULL,
  `playlist_id` int(11) DEFAULT NULL,
  `story_id` int(11) DEFAULT NULL,
  `date_added` int(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `stories`
--

CREATE TABLE `stories` (
  `id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `video_url` varchar(255) NOT NULL,
  `image_name` varchar(255) NOT NULL,
  `length` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `created_date` varchar(255) NOT NULL,
  `modified_date` varchar(255) NOT NULL,
  `genre` varchar(255) NOT NULL,
  `topic` text DEFAULT NULL,
  `upvotes` text DEFAULT NULL,
  `downvotes` text DEFAULT NULL,
  `is_paid` int(1) DEFAULT NULL,
  `display_order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stories`
--

INSERT INTO `stories` (`id`, `video_id`, `title`, `description`, `video_url`, `image_name`, `length`, `owner_id`, `created_date`, `modified_date`, `genre`, `topic`, `upvotes`, `downvotes`, `is_paid`, `display_order`) VALUES
(2, 124797573, ' فيديو كارتون مخصص للأطفال', 'هو فيديو رسوم متحركة خاص للأطفال الذين تتراوح أعمارهم بين 2-10 سنوات تم إنشاؤه بواسطة', 'https://player.vimeo.com/video/124797573?h=2fdc42156b&app_id=122963', 'stories_1692237641.jpg', 53, 1, '1666354077', '', '5', '5', NULL, NULL, 1, 3),
(3, 162184892, 'الإمارات العربية المتحدة سلامة الطفل كارتون برنامج بلدية دبي الرسوم المتحركة مع الأطفال', 'الإمارات العربية المتحدة سلامة الطفل كارتون برنامج بلدية دبي الرسوم المتحركة مع الأطفال', 'https://player.vimeo.com/video/162184892?h=8c81f4a09e&app_id=122963', '1_16a084530a0.2042797_3713423700_16a084530a0_medium_215496693.jpg', 205, 1, '1666341218', '', '5', '5', NULL, NULL, 1, 4),
(4, 148106141, 'بكرة مشروع الرسوم المتحركة للموسم الثاني من المنصور (2015)', 'كارتون المنصور من أوائل الإنتاجات العربية التي طبقت تقنيات الرسوم المتحركة العالمية عالية الجودة وتم إطلاقها في أبو ظبي. يعتبر The Cartoon من أوائل الأفلام التي تم إنتاجها محليًا ويمزج الموضوعات العربية التقليدية مع معايير الإنتاج من الدرجة الأولى التي يستخدمها عمالقة الرسوم المتحركة مثل Disney و Nickelodeon. تم بث الموسم الثاني من كارتون المنصور عام 2015 على قناة ماجد الإماراتية وشبكة كرتون نتورك العربية.', 'https://player.vimeo.com/video/148106141?h=08abe10077&app_id=122963', 'HUWAEKTEP2IGVNN3IJD7ZT33NE_86049771.jpg', 77, 2, '1666364792', '', '5', '5', NULL, NULL, 1, 1),
(5, 166110937, 'قصة الأشجار الثلاثة', 'هذا المشروع عبارة عن نادي رسوم متحركة غير ربحي للأطفال (جزء من مهمتنا في تايلاند).\r\nمقاطع الفيديو هذه مجانية للاستخدام الشخصي والتعليمي.', 'https://player.vimeo.com/video/166110937?h=a3c18e751e&app_id=122963', 'childs_1930249585.webp', 353, 1, '1666353835', '', '5', '5', NULL, NULL, 1, 5),
(6, 629005903, 'سلسلة ترفيه السلحفاة الأرجواني | قصص قصيرة للاطفال', 'تقدم سلسلة Purple Turtle التعليمية الترفيهية العديد من القصص القصيرة للأطفال ، مما يثير الاهتمام بجودتها المرئية والصوتية العالية. في القصة ، A Light in the Night ، وجد Tedlee GlowBug في الغابة ليلعب بها ولكن Glowbug لم يكن سعيدًا ، للعثور على الخطأ ، والاستماع إلى القصة ومعرفة كيف يساعد الأصدقاء بعضهم البعض.', 'https://player.vimeo.com/video/629005903?h=5bfcf22e3d&app_id=122963', 'emirates-kids-postcard-meet-the-expo-2020-mascots-w768x480_1436008463.webp', 45, 1, '1666354264', '', '5', '5', NULL, NULL, 1, 0),
(7, 166110937, 'قصة الأشجار الثلاثة', 'Open Sea Morning بواسطة Puddle of Infinity - مكتبة الصوت على Youtube.\r\nليلة صامتة من جوقة كلية سانت جون ، كامبريدج.\r\n\r\nتحرير القصة بواسطة هانا تشي.\r\nرواه سامانثا أوي.\r\nالرسوم المتحركة والتصميم Seth Phatik.\r\n\r\nهذا المشروع عبارة عن نادي رسوم متحركة غير ربحي للأطفال (جزء من مهمتنا في تايلاند).\r\nمقاطع الفيديو هذه مجانية للاستخدام الشخصي والتعليمي.', 'https://player.vimeo.com/video/166110937?h=a3c18e751e&app_id=122963', 'MainKV_mascot_cmyk_16236278.jpg', 353, 1, '1666356105', '', '5', '5', NULL, NULL, 0, 2),
(8, 758919268, 'Squarespace — Icons: Björk', 'Director & VP, Creative\r\nSquarespace, 2022\r\n\r\nDirector — Ben Hughes\r\nProduction Company — Hero\r\nDirector of Photography — Tómas Örn Tómasson ÍKS, My Management\r\nLine Producer — Kitty Von-Sometime\r\nEditor — Ted Guard, Rock Paper Scissors\r\nMusic Video Director — Vidar Logi\r\n3D Design — M/M Paris\r\n3D Animation — Andréa Philippon\r\n2D Design & Animation — Alex Scott, Elastic\r\nColorist — Ayumi Ashley, Rare Medium\r\nMusic — Björk, One Little Independent\r\nSound Designer & Mixer — Matt Miller, Lime Studios', 'https://player.vimeo.com/video/758919268?h=4078c7ecbd&app_id=122963', 'childs_950958956.webp', 132, 2, '1666617373', '', '5', '5', NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `story_cats`
--

CREATE TABLE `story_cats` (
  `category_id` int(11) DEFAULT NULL,
  `story_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `story_cats`
--

INSERT INTO `story_cats` (`category_id`, `story_id`) VALUES
(10, 1),
(12, 1),
(21, 1),
(23, 1),
(14, 1),
(15, 1),
(22, 1),
(24, 1),
(25, 3),
(26, 3),
(27, 3),
(25, 5),
(26, 5),
(27, 5),
(25, 2),
(27, 2),
(25, 6),
(27, 6),
(25, 7),
(26, 7),
(27, 7),
(28, 7),
(25, 4),
(26, 4),
(27, 4),
(28, 4),
(10, 8),
(14, 8),
(15, 8);

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `type_duration` varchar(255) DEFAULT NULL,
  `start_date` int(100) DEFAULT NULL,
  `end_date` int(100) DEFAULT NULL,
  `price` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `topic`
--

CREATE TABLE `topic` (
  `id` int(11) NOT NULL,
  `title` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `topic`
--

INSERT INTO `topic` (`id`, `title`) VALUES
(5, 'قصص تشايلدز'),
(6, 'حياة سن المراهقة');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `age` varchar(33) DEFAULT NULL,
  `is_child` int(1) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `parental_password` text DEFAULT NULL,
  `child_code` varchar(200) DEFAULT NULL,
  `modified_at` int(11) NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `name`, `age`, `is_child`, `parent_id`, `parental_password`, `child_code`, `modified_at`, `created_at`) VALUES
(2, 'admin@microrage.com', 'مائکرور ایج سلوشن', '2656', 0, NULL, '202cb962ac59075b964b07152d234b70', NULL, 1666365860, 0),
(26, 'admin2@microrage.com', '  muhammad Younis', '12/3/1980', NULL, NULL, '202cb962ac59075b964b07152d234b70', NULL, 0, 1666793636);

-- --------------------------------------------------------

--
-- Table structure for table `users_role`
--

CREATE TABLE `users_role` (
  `user_id` int(11) NOT NULL,
  `role` varchar(22) NOT NULL,
  `user_role_key` varchar(22) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users_role`
--

INSERT INTO `users_role` (`user_id`, `role`, `user_role_key`) VALUES
(1, 'admin', 'admin'),
(2, 'admin', 'admin'),
(13, 'manager', 'manager'),
(14, 'manager', 'manager'),
(15, 'manager', 'manager'),
(0, '', ''),
(0, '', ''),
(0, '', ''),
(19, 'manager', 'manager'),
(21, 'manager', 'manager'),
(22, 'manager', 'manager'),
(22, 'manager', 'manager'),
(23, 'manager', 'manager'),
(24, 'manager', 'manager'),
(25, 'manager', 'manager'),
(26, 'manager', 'manager');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `age_range`
--
ALTER TABLE `age_range`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `child_activity`
--
ALTER TABLE `child_activity`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cstory_schedule`
--
ALTER TABLE `cstory_schedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gender_profiles`
--
ALTER TABLE `gender_profiles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `playlist_stories`
--
ALTER TABLE `playlist_stories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stories`
--
ALTER TABLE `stories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `topic`
--
ALTER TABLE `topic`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `age_range`
--
ALTER TABLE `age_range`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `child_activity`
--
ALTER TABLE `child_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cstory_schedule`
--
ALTER TABLE `cstory_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gender_profiles`
--
ALTER TABLE `gender_profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genre`
--
ALTER TABLE `genre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `playlist_stories`
--
ALTER TABLE `playlist_stories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stories`
--
ALTER TABLE `stories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `topic`
--
ALTER TABLE `topic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
