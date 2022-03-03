CREATE TABLE IF NOT EXISTS `user_kills` (
  `identifier` varchar(50) NOT NULL,
  `deaths` int(11) DEFAULT NULL,
  `kills` int(11) DEFAULT NULL,
  `headshots` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

