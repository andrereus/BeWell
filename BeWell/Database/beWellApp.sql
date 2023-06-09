-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 09. Jun 2023 um 12:31
-- Server-Version: 10.4.28-MariaDB
-- PHP-Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `beWellApp`
--
CREATE DATABASE IF NOT EXISTS `beWellApp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `beWellApp`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `categories`
--

CREATE TABLE `categories` (
  `id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `categories`
--

INSERT INTO `categories` (`id`, `name`, `timestamp`) VALUES
(1, 'Nature', '2023-05-31 14:06:02'),
(2, 'Art', '2023-05-31 14:13:22'),
(3, 'Mindfulness', '2023-06-08 13:55:45'),
(4, 'Wellbeing', '2023-06-08 13:55:58');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `likes`
--

CREATE TABLE `likes` (
  `uid` int(10) NOT NULL,
  `postId` int(10) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `likes`
--

INSERT INTO `likes` (`uid`, `postId`, `timestamp`) VALUES
(1, 2, '2023-05-31 14:14:35'),
(2, 1, '2023-05-31 14:15:15');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `posts`
--

CREATE TABLE `posts` (
  `id` int(10) NOT NULL,
  `type` varchar(50) NOT NULL,
  `image` varchar(100) NOT NULL,
  `quote` text NOT NULL,
  `quoteAuthor` varchar(100) NOT NULL,
  `uid` int(10) NOT NULL,
  `category` int(10) NOT NULL,
  `reported` tinyint(1) NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `posts`
--

INSERT INTO `posts` (`id`, `type`, `image`, `quote`, `quoteAuthor`, `uid`, `category`, `reported`, `timestamp`) VALUES
(1, 'quote', '', 'Nature does not hurry, yet everything is accomplished.', 'Lao Tzu', 1, 1, 0, '2023-05-31 14:07:00'),
(2, 'quote', '', 'This world is but a canvas to our imagination.', 'Henry David Thoreau', 2, 2, 0, '2023-05-31 14:14:08'),
(5, 'quote', '', 'Besuche meine tolle Seite jens.de', 'Jens', 3, 1, 1, '2023-05-31 14:30:30'),
(16, 'image', '93F588CF-0082-4B48-9BF5-EF87E729B235.png', '', '', 1, 1, 0, '2023-06-08 15:58:06'),
(17, 'image', '6B4FE13D-1401-4156-9CF3-69E94B42971A.png', '', '', 1, 3, 0, '2023-06-08 16:02:35'),
(18, 'quote', '', 'Vision is the art of seeing what is invisible to others.', 'Jonathan Swift', 11, 2, 0, '2023-06-09 08:15:48'),
(20, 'image', '4FEA7BB6-7F2D-4D28-AD82-468BB6498D3E.png', '', '', 12, 1, 0, '2023-06-09 08:25:14');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
  `id` int(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `registered` tinyint(1) NOT NULL DEFAULT 0,
  `reported` tinyint(1) NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `username`, `registered`, `reported`, `timestamp`) VALUES
(1, 'jürgen@web.de', 'jürgen123', 'jürgen', 1, 0, '2023-05-31 14:02:56'),
(2, 'heinrich@web.de', 'heinrich123', 'heinrich', 1, 0, '2023-05-31 14:08:27'),
(3, 'jens@web.de', 'jens123', 'jens', 1, 1, '2023-05-31 14:28:22'),
(4, 'susi@web.de', 'susi123', 'susi', 0, 0, '2023-05-31 14:32:22'),
(11, 'samuel@web.de', 'samuel123', 'samuel', 1, 0, '2023-06-09 08:03:47'),
(12, 'susanne@web.de', 'susanne123', 'susanne', 1, 0, '2023-06-09 08:23:25'),
(13, 'regina@web.de', 'regina123', 'regina', 0, 0, '2023-06-09 08:46:11');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `likes`
--
ALTER TABLE `likes`
  ADD KEY `uid` (`uid`),
  ADD KEY `postId` (`postId`);

--
-- Indizes für die Tabelle `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `category` (`category`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT für Tabelle `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`);

--
-- Constraints der Tabelle `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`category`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
