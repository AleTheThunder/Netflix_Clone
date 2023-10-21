-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 13. Okt 2023 um 22:27
-- Server-Version: 10.4.24-MariaDB
-- PHP-Version: 8.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `streamy`
--

DELIMITER $$
--
-- Prozeduren
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CalculateContentRating` (IN `v_content_id` INT(11))   SELECT AVG(rating), COUNT(*) FROM content_rating WHERE content_rating.content_id = v_content_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetContentByType` (IN `v_type` VARCHAR(64), IN `v_limit` INT)   BEGIN
SELECT * FROM content  WHERE type = v_type  ORDER BY release_date DESC LIMIT v_limit;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TopContentInCountry` (IN `v_country_code` VARCHAR(12), IN `v_type` VARCHAR(64), IN `v_limit` INT(11))   SELECT c.title, COUNT(vh.id) as views
  FROM view_history vh
  JOIN content c ON vh.content_id = c.id
  JOIN user u ON vh.user_id = u.id
  WHERE u.country = v_country_code
  AND DATE(vh.timestamp) BETWEEN DATE_SUB(NOW(), INTERVAL 7 DAY) AND NOW()
  AND c.type = v_type
GROUP BY c.title
ORDER BY views DESC
LIMIT v_limit$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TopMoviesInCountry` (IN `v_country_code` VARCHAR(12), IN `v_type` VARCHAR(64), IN `v_limit` INT(11))   SELECT c.title, COUNT(vh.id) as views
  FROM view_history vh
  JOIN content c ON vh.content_id = c.id
  JOIN user u ON vh.user_id = u.id
  WHERE u.country = v_country_code
  AND DATE(vh.timestamp) BETWEEN DATE_SUB(NOW(), INTERVAL 7 DAY) AND NOW()
  AND c.type = v_type
GROUP BY c.title
ORDER BY views DESC
LIMIT v_limit$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `content`
--

CREATE TABLE `content` (
  `id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `type` enum('movie','series') NOT NULL,
  `duration` int(11) NOT NULL,
  `release_date` datetime NOT NULL,
  `language` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `content`
--

INSERT INTO `content` (`id`, `title`, `description`, `type`, `duration`, `release_date`, `language`) VALUES
(1, 'Iron Man', 'Test', 'movie', 200, '2023-10-11 19:52:17', 'AT'),
(2, 'Iron Man 2', 'Test', 'movie', 200, '2023-10-11 19:52:17', 'AT'),
(3, 'Film 1', 'Beschreibung für Film 1', 'movie', 120, '2023-10-10 12:00:00', 'Deutsch'),
(4, 'Serie 1', 'Beschreibung für Serie 1', 'series', 30, '2023-09-15 10:30:00', 'Englisch'),
(5, 'Film 2', 'Beschreibung für Film 2', 'movie', 90, '2023-08-20 15:45:00', 'Spanisch'),
(6, 'Film 1', 'Beschreibung für Film 1', 'movie', 120, '2023-10-10 12:00:00', 'Deutsch'),
(7, 'Serie 1', 'Beschreibung für Serie 1', 'series', 30, '2023-09-15 10:30:00', 'Englisch'),
(8, 'Film 2', 'Beschreibung für Film 2', 'movie', 90, '2023-08-20 15:45:00', 'Spanisch');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `content_contributor`
--

CREATE TABLE `content_contributor` (
  `id` int(11) NOT NULL,
  `contributor_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `content_contributor`
--

INSERT INTO `content_contributor` (`id`, `contributor_id`, `content_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 1, 1),
(5, 2, 1),
(6, 3, 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `content_genre`
--

CREATE TABLE `content_genre` (
  `id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `content_genre`
--

INSERT INTO `content_genre` (`id`, `content_id`, `genre_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 2),
(4, 3, 3),
(5, 1, 1),
(6, 1, 2),
(7, 2, 2),
(8, 3, 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `content_language`
--

CREATE TABLE `content_language` (
  `id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `content_language`
--

INSERT INTO `content_language` (`id`, `language_id`, `content_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 2, 2),
(4, 3, 3),
(5, 1, 1),
(6, 2, 1),
(7, 2, 2),
(8, 3, 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `content_rating`
--

CREATE TABLE `content_rating` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL,
  `comment` text NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `content_rating`
--

INSERT INTO `content_rating` (`id`, `user_id`, `content_id`, `rating`, `comment`, `timestamp`) VALUES
(1, 1, 1, 4, 'Guter Film!', '2023-10-10 13:00:00'),
(2, 2, 1, 5, 'Sehr spannend!', '2023-10-10 14:00:00'),
(3, 1, 2, 4, 'Interessante Serie', '2023-10-11 10:00:00');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `content_studio`
--

CREATE TABLE `content_studio` (
  `id` int(11) NOT NULL,
  `studio_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `content_studio`
--

INSERT INTO `content_studio` (`id`, `studio_id`, `content_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 2, 2),
(4, 3, 3),
(5, 1, 1),
(6, 2, 1),
(7, 2, 2),
(8, 3, 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `contributor`
--

CREATE TABLE `contributor` (
  `id` int(11) NOT NULL,
  `first_name` varchar(128) NOT NULL,
  `last_name` varchar(128) NOT NULL,
  `country` varchar(12) NOT NULL,
  `description` text NOT NULL,
  `role` enum('director','actor','producer','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `contributor`
--

INSERT INTO `contributor` (`id`, `first_name`, `last_name`, `country`, `description`, `role`) VALUES
(1, 'Max', 'Mustermann', 'Österreich', 'Beschreibung für Max Mustermann', 'director'),
(2, 'Anna', 'Musterfrau', 'Deutschland', 'Beschreibung für Anna Musterfrau', 'actor'),
(3, 'Peter', 'Meier', 'Österreich', 'Beschreibung für Peter Meier', 'producer'),
(4, 'Max', 'Mustermann', 'Österreich', 'Beschreibung für Max Mustermann', 'director'),
(5, 'Anna', 'Musterfrau', 'Deutschland', 'Beschreibung für Anna Musterfrau', 'actor'),
(6, 'Peter', 'Meier', 'Österreich', 'Beschreibung für Peter Meier', 'producer');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `genre`
--

CREATE TABLE `genre` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `genre`
--

INSERT INTO `genre` (`id`, `name`) VALUES
(1, 'Action'),
(2, 'Drama'),
(3, 'Komödie'),
(4, 'Action'),
(5, 'Drama'),
(6, 'Komödie');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `language`
--

CREATE TABLE `language` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `code` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `language`
--

INSERT INTO `language` (`id`, `name`, `code`) VALUES
(1, 'Deutsch', 1),
(2, 'Englisch', 2),
(3, 'Spanisch', 3),
(4, 'Deutsch', 1),
(5, 'Englisch', 2),
(6, 'Spanisch', 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `permission`
--

CREATE TABLE `permission` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `proc_log`
--

CREATE TABLE `proc_log` (
  `id` int(11) NOT NULL,
  `msg` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `proc_log`
--

INSERT INTO `proc_log` (`id`, `msg`) VALUES
(1, '5'),
(2, 'movie:5'),
(3, ':type:0'),
(4, ':type:5'),
(5, ':v_type:5'),
(6, ':v_type:5'),
(7, ':content_type:5'),
(8, 'movie:5'),
(9, 'movie:5'),
(10, 'movie:5');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'Regisseur'),
(2, 'Schauspieler'),
(3, 'Produzent');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `role_permission`
--

CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `studio`
--

CREATE TABLE `studio` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `studio`
--

INSERT INTO `studio` (`id`, `name`) VALUES
(1, 'Studio A'),
(2, 'Studio B'),
(3, 'Studio C'),
(4, 'Studio A'),
(5, 'Studio B'),
(6, 'Studio C');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `salt` varchar(128) NOT NULL,
  `birth_date` datetime NOT NULL,
  `country` varchar(12) NOT NULL COMMENT 'Using Country-Code',
  `subscription_status` tinyint(1) NOT NULL,
  `payment_info` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `password`, `salt`, `birth_date`, `country`, `subscription_status`, `payment_info`) VALUES
(1, 'Nico', 'Thuniot', 'test@gmail.com', 'test', 'test', '2023-10-11 19:37:44', 'AT', 1, 'test'),
(2, 'Hans', 'Müller', 'hans.mueller@example.com', 'hashedpassword1', 'salt1', '1990-05-15 08:00:00', 'Österreich', 1, '1234-5678-9012-3456'),
(3, 'Maria', 'Schmidt', 'maria.schmidt@example.com', 'hashedpassword2', 'salt2', '1985-09-22 14:30:00', 'Deutschland', 1, '5678-1234-9012-3456'),
(4, 'Hans', 'Müller', 'hans.mueller@example.com', 'hashedpassword1', 'salt1', '1990-05-15 08:00:00', 'Österreich', 1, '1234-5678-9012-3456'),
(5, 'Maria', 'Schmidt', 'maria.schmidt@example.com', 'hashedpassword2', 'salt2', '1985-09-22 14:30:00', 'Deutschland', 1, '5678-1234-9012-3456');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user_interest`
--

CREATE TABLE `user_interest` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `user_interest`
--

INSERT INTO `user_interest` (`id`, `user_id`, `content_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 1, 1),
(5, 1, 2),
(6, 2, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user_list`
--

CREATE TABLE `user_list` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `user_list`
--

INSERT INTO `user_list` (`id`, `user_id`, `content_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 1, 1),
(5, 1, 2),
(6, 2, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user_recommendation`
--

CREATE TABLE `user_recommendation` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL,
  `reason` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `user_recommendation`
--

INSERT INTO `user_recommendation` (`id`, `user_id`, `content_id`, `reason`) VALUES
(1, 1, 2, 'Ähnliche Inhalte mögen'),
(2, 2, 1, 'Hohe Bewertungen erhalten'),
(3, 1, 2, 'Ähnliche Inhalte mögen'),
(4, 2, 1, 'Hohe Bewertungen erhalten');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user_role`
--

CREATE TABLE `user_role` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `user_role`
--

INSERT INTO `user_role` (`id`, `role_id`, `user_id`) VALUES
(4, 1, 1),
(5, 2, 1),
(6, 2, 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `view_history`
--

CREATE TABLE `view_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL,
  `timestamp` datetime NOT NULL,
  `progress` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `view_history`
--

INSERT INTO `view_history` (`id`, `user_id`, `content_id`, `timestamp`, `progress`) VALUES
(1, 1, 1, '2023-10-11 19:52:55', 200),
(2, 1, 2, '2023-10-11 19:52:55', 300),
(3, 1, 2, '2023-10-11 19:53:51', 300),
(4, 1, 1, '2023-10-10 14:00:00', 60),
(5, 1, 2, '2023-10-11 11:00:00', 20),
(6, 2, 1, '2023-10-11 12:00:00', 80);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `content`
--
ALTER TABLE `content`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `content_contributor`
--
ALTER TABLE `content_contributor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_content_contr_contributor_id` (`contributor_id`),
  ADD KEY `fk_content_contr_content_id` (`content_id`);

--
-- Indizes für die Tabelle `content_genre`
--
ALTER TABLE `content_genre`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_content_genre_content_id` (`content_id`),
  ADD KEY `fk_content_genre_genre_id` (`genre_id`);

--
-- Indizes für die Tabelle `content_language`
--
ALTER TABLE `content_language`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_content_lang_language_id` (`language_id`),
  ADD KEY `fk_content_lang_content_id` (`content_id`);

--
-- Indizes für die Tabelle `content_rating`
--
ALTER TABLE `content_rating`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_content_rating_user_id` (`user_id`),
  ADD KEY `fk_content_rating_content_id` (`content_id`);

--
-- Indizes für die Tabelle `content_studio`
--
ALTER TABLE `content_studio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_content_studio_studio_id` (`studio_id`),
  ADD KEY `fk_content_studio_content_id` (`content_id`);

--
-- Indizes für die Tabelle `contributor`
--
ALTER TABLE `contributor`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `proc_log`
--
ALTER TABLE `proc_log`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `role_permission`
--
ALTER TABLE `role_permission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_role_perm_role_id` (`role_id`),
  ADD KEY `fk_role_perm_permission_id` (`permission_id`);

--
-- Indizes für die Tabelle `studio`
--
ALTER TABLE `studio`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `user_interest`
--
ALTER TABLE `user_interest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_interest_user_id` (`user_id`),
  ADD KEY `fk_user_interest_content_id` (`content_id`);

--
-- Indizes für die Tabelle `user_list`
--
ALTER TABLE `user_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_list_user_id` (`user_id`),
  ADD KEY `fk_user_list_content_id` (`content_id`);

--
-- Indizes für die Tabelle `user_recommendation`
--
ALTER TABLE `user_recommendation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_rec_user_id` (`user_id`),
  ADD KEY `fk_user_rec_content_id` (`content_id`);

--
-- Indizes für die Tabelle `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_role_user_id` (`user_id`),
  ADD KEY `fk_user_role_role_id` (`role_id`);

--
-- Indizes für die Tabelle `view_history`
--
ALTER TABLE `view_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_view_history_user_id` (`user_id`),
  ADD KEY `fk_view_history_content_id` (`content_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `content`
--
ALTER TABLE `content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT für Tabelle `content_contributor`
--
ALTER TABLE `content_contributor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `content_genre`
--
ALTER TABLE `content_genre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT für Tabelle `content_language`
--
ALTER TABLE `content_language`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT für Tabelle `content_rating`
--
ALTER TABLE `content_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `content_studio`
--
ALTER TABLE `content_studio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT für Tabelle `contributor`
--
ALTER TABLE `contributor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `genre`
--
ALTER TABLE `genre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `language`
--
ALTER TABLE `language`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `permission`
--
ALTER TABLE `permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `proc_log`
--
ALTER TABLE `proc_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `role_permission`
--
ALTER TABLE `role_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `studio`
--
ALTER TABLE `studio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `user_interest`
--
ALTER TABLE `user_interest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `user_list`
--
ALTER TABLE `user_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `user_recommendation`
--
ALTER TABLE `user_recommendation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `user_role`
--
ALTER TABLE `user_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `view_history`
--
ALTER TABLE `view_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `content_contributor`
--
ALTER TABLE `content_contributor`
  ADD CONSTRAINT `fk_content_contr_content_id` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`),
  ADD CONSTRAINT `fk_content_contr_contributor_id` FOREIGN KEY (`contributor_id`) REFERENCES `contributor` (`id`);

--
-- Constraints der Tabelle `content_genre`
--
ALTER TABLE `content_genre`
  ADD CONSTRAINT `fk_content_genre_content_id` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`),
  ADD CONSTRAINT `fk_content_genre_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`);

--
-- Constraints der Tabelle `content_language`
--
ALTER TABLE `content_language`
  ADD CONSTRAINT `fk_content_lang_content_id` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`),
  ADD CONSTRAINT `fk_content_lang_language_id` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`);

--
-- Constraints der Tabelle `content_rating`
--
ALTER TABLE `content_rating`
  ADD CONSTRAINT `fk_content_rating_content_id` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`),
  ADD CONSTRAINT `fk_content_rating_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints der Tabelle `content_studio`
--
ALTER TABLE `content_studio`
  ADD CONSTRAINT `fk_content_studio_content_id` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`),
  ADD CONSTRAINT `fk_content_studio_studio_id` FOREIGN KEY (`studio_id`) REFERENCES `studio` (`id`);

--
-- Constraints der Tabelle `role_permission`
--
ALTER TABLE `role_permission`
  ADD CONSTRAINT `fk_role_perm_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`),
  ADD CONSTRAINT `fk_role_perm_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);

--
-- Constraints der Tabelle `user_interest`
--
ALTER TABLE `user_interest`
  ADD CONSTRAINT `fk_user_interest_content_id` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`),
  ADD CONSTRAINT `fk_user_interest_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints der Tabelle `user_list`
--
ALTER TABLE `user_list`
  ADD CONSTRAINT `fk_user_list_content_id` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`),
  ADD CONSTRAINT `fk_user_list_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints der Tabelle `user_recommendation`
--
ALTER TABLE `user_recommendation`
  ADD CONSTRAINT `fk_user_rec_content_id` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`),
  ADD CONSTRAINT `fk_user_rec_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints der Tabelle `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `fk_user_role_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  ADD CONSTRAINT `fk_user_role_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints der Tabelle `view_history`
--
ALTER TABLE `view_history`
  ADD CONSTRAINT `fk_view_history_content_id` FOREIGN KEY (`content_id`) REFERENCES `content` (`id`),
  ADD CONSTRAINT `fk_view_history_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
