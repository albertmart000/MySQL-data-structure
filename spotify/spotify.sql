DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARACTER SET utf8mb4;
USE spotify ;

CREATE TABLE `country` (
  `id_country` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_country`),
  UNIQUE INDEX `id_country_UNIQUE` (`id_country` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;
INSERT INTO `country` (`id_country`,`name`) VALUES
(1,'England'),
(2,'Japan'),
(3,'France');

CREATE TABLE `artist` (
  `id_artist` INT NOT NULL,
  `artist_name` VARCHAR(45) NOT NULL,
  `image` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_artist`),
  UNIQUE INDEX `id_artist_UNIQUE` (`id_artist` ASC) VISIBLE,
  UNIQUE INDEX `artist_name_UNIQUE` (`artist_name` ASC) VISIBLE)
ENGINE = InnoDB;
INSERT INTO `artist` (`id_artist`,`artist_name`,`image`) VALUES 
(1,'Artist1','/imageSpotify/artist1.jpeg'),
(2,'Artist2','/imageSpotify/artist2.jpeg'),
(3,'Artist3','/imageSpotify/artist3.jpeg');

CREATE TABLE `album` (
  `id_album` INT NOT NULL AUTO_INCREMENT,
  `album_title` VARCHAR(45) NOT NULL,
  `image` VARCHAR(45) NOT NULL,
  `year_publication` INT NOT NULL,
  `id_artist` INT NOT NULL,
  PRIMARY KEY (`id_album`),
  UNIQUE INDEX `id_album_UNIQUE` (`id_album` ASC) VISIBLE,
  INDEX `fk_album_artist1_idx` (`id_artist` ASC) VISIBLE,
  UNIQUE INDEX `album_title_UNIQUE` (`album_title` ASC) VISIBLE,
  CONSTRAINT `fk_album_artist1`
    FOREIGN KEY (`id_artist`)
    REFERENCES `spotify`.`artist` (`id_artist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `album` (`id_album`,`album_title`,`image`,`year_publication`,`id_artist`) VALUES
(1,'Album1Artist1','/imageSpotify/album1.jpeg',2000,1),
(2,'Album2Artist1','/imageSpotify/album2.jpeg',2003,1),
(3,'Album3Artist2','/imageSpotify/album3.jpeg',2005,2),
(4,'Album4Artist2','/imageSpotify/album4.jpeg',2007,2),
(5,'Album5Artist3','/imageSpotify/album6.jpeg',1995,3),
(6,'Album6Artist3','/imageSpotify/album6.jpeg',1998,3);

CREATE TABLE `song` (
  `id_song` INT NOT NULL,
  `song_title` VARCHAR(45) NOT NULL,
  `lenght` VARCHAR(45) NOT NULL,
  `reproductions` INT NOT NULL,
  `id_album` INT NOT NULL,
  PRIMARY KEY (`id_song`),
  UNIQUE INDEX `id_song_UNIQUE` (`id_song` ASC) VISIBLE,
  UNIQUE INDEX `song_title_UNIQUE` (`song_title` ASC) VISIBLE,
  INDEX `fk_song_album1_idx` (`id_album` ASC) VISIBLE,
  CONSTRAINT `fk_song_album1`
    FOREIGN KEY (`id_album`)
    REFERENCES `spotify`.`album` (`id_album`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `song` (`id_song`,`song_title`,`lenght`,`reproductions`,`id_album`) VALUES 
(1,'Song1Album1','04:55',243,1),
(2,'Song2Album1','06:14',150,1),
(3,'Song3Album1','08:37',115,1),
(4,'Song4Album2','10:05',315,2),
(5,'Song5Album2','07:25',412,2),
(6,'Song6Album2','02:38',99,2),
(7,'Song7Album3','05:10',243,3),
(8,'Song8Album3','06:14',150,3),
(9,'Song9Album3','08:37',115,3),
(10,'Song10Album4','12:20',95,4),
(11,'Song11Album4','04:21',125,4),
(12,'Song12Album4','07:14',185,4),
(13,'Song13Album5','04:55',303,5),
(14,'Song14Album5','03:49',214,5),
(15,'Song15Album5','12:59',85,5),
(16,'Song16Album6','12:00',199,6),
(17,'Song17Album6','06:29',540,6),
(18,'Song18Album6','04:11',222,6);

CREATE TABLE `user` (
  `id_user` INT NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `date_of_birth` VARCHAR(45) NOT NULL,
  `gender` ENUM('no binari', 'dona', 'home') NOT NULL,
  `postal_code` INT NOT NULL,
  `account_type` ENUM('premium', 'free') NOT NULL,
  `id_country` INT NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  INDEX `fk_user_country1_idx` (`id_country` ASC) VISIBLE,
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_user_country1`
    FOREIGN KEY (`id_country`)
    REFERENCES `spotify`.`country` (`id_country`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `user` (`id_user`,`user_name`,`email`,`password`,`date_of_birth`,`gender`,`postal_code`,`account_type`,`id_country`) VALUES
(1,'John Allred','johnallred@email.com','johnpassword','1962-06-24','1',11111,'1',1),
(2,'Diana Krall','diana@email.com','dianapassword','1964-11-16','2',22222,'1',2), 
(3,'Frank Wess','frank@email.com','frankpassword','1922-01-04','3',33333,'2',3);

CREATE TABLE `playlist` (
  `id_playlist` INT NOT NULL,
  `playlist_title` VARCHAR(45) NOT NULL,
  `date_creation` DATE NOT NULL,
  `active_or_removal` ENUM('active', 'removal') NOT NULL,
  `date_removal` DATE NULL,
  `howManySongs` INT NOT NULL,
  `id_user` INT NOT NULL,
  PRIMARY KEY (`id_playlist`),
  UNIQUE INDEX `id_playlist_UNIQUE` (`id_playlist` ASC) VISIBLE,
  INDEX `fk_playlist_user1_idx` (`id_user` ASC) VISIBLE,
  UNIQUE INDEX `playlist_title_UNIQUE` (`playlist_title` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_user1`
    FOREIGN KEY (`id_user`)
    REFERENCES `spotify`.`user` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `playlist` (`id_playlist`,`playlist_title`,`date_creation`,`active_or_removal`,`date_removal`,`howManySongs`,`id_user`) VALUES
(1,'Playlist1User1','2021-06-01','1',NULL,2,1),
(2,'Playlist2User1','2020-06-01','1',NULL,2,1),
(3,'Playlist3User2','2021-10-10','1',NULL,3,2),
(4,'Playlist4User2','2020-08-21','2','2121-11-21',2,2),
(5,'Playlist5User3','2021-04-21','1',NULL,2,3),
(6,'Playlist6User3','2021-04-20','1',NULL,2,3);

CREATE TABLE `relations_between_artists` (
  `id_relation_between_artist` INT NOT NULL,
  `id_artist` INT NOT NULL,
  `id_artist_related` INT NOT NULL,
  PRIMARY KEY (`id_relation_between_artist`, `id_artist`, `id_artist_related`),
  UNIQUE INDEX `id_related_artists_UNIQUE` (`id_relation_between_artist` ASC) VISIBLE,
  INDEX `fk_relations_between_artists_artist1_idx` (`id_artist` ASC) VISIBLE,
  INDEX `fk_relations_between_artists_artist2_idx` (`id_artist_related` ASC) VISIBLE,
  CONSTRAINT `fk_relations_between_artists_artist1`
    FOREIGN KEY (`id_artist`)
    REFERENCES `spotify`.`artist` (`id_artist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_relations_between_artists_artist2`
    FOREIGN KEY (`id_artist_related`)
    REFERENCES `spotify`.`artist` (`id_artist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `relations_between_artists` (`id_relation_between_artist`,`id_artist`,`id_artist_related`) VALUES
(1,1,2),
(2,1,3),
(3,2,1),
(4,2,3),
(5,3,1), 
(6,3,2);

CREATE TABLE `playlist_songs` (
  `id_playlist_songs` INT NOT NULL,
  `id_playlist` INT NOT NULL,
  `id_song` INT NOT NULL,
  `id_user` INT NOT NULL,
  `date_added` DATE NOT NULL,
  PRIMARY KEY (`id_playlist_songs`, `id_playlist`, `id_song`),
  INDEX `fk_playlist_songs_song1_idx` (`id_song` ASC) VISIBLE,
  INDEX `fk_playlist_songs_playlist1_idx` (`id_playlist` ASC) VISIBLE,
  UNIQUE INDEX `id_playlist_songs_UNIQUE` (`id_playlist_songs` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_songs_song1`
    FOREIGN KEY (`id_song`)
    REFERENCES `spotify`.`song` (`id_song`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_songs_playlist1`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `spotify`.`playlist` (`id_playlist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `playlist_songs` (`id_playlist_songs`,`id_playlist`,`id_song`,`id_user`,`date_added`) VALUE
(1,1,5,1,'2020-10-10'),
(2,1,13,2,'2020-06-01'),
(3,2,6,1,'2020-07-21'),
(4,2,3,3,'2020-12-25'),
(5,3,9,2,'2021-11-01'),
(6,3,14,1,'2022-01-01'),
(7,3,6,2,'2022-02-27'),
(8,4,7,2,'2021-03-24'),
(9,4,9,3,'2020-11-12'),
(10,5,5,3,'2021-05-13'),
(11,5,3,1,'2020-09-12'),
(12,6,1,3,'2021-07-17'),
(13,6,12,3,'2020-06-01');

CREATE TABLE `favorites_songs` (
  `id_favorites_songs` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `id_song` INT NOT NULL,
  PRIMARY KEY (`id_favorites_songs`, `id_song`),
  INDEX `fk_favorites_songs_song1_idx` (`id_song` ASC) VISIBLE,
  UNIQUE INDEX `id_favorites_songs_UNIQUE` (`id_favorites_songs` ASC) VISIBLE,
  CONSTRAINT `fk_favorites_songs_song1`
    FOREIGN KEY (`id_song`)
    REFERENCES `spotify`.`song` (`id_song`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `favorites_songs` (`id_favorites_songs`,`id_user`,`id_song`) VALUES
(1,1,2),
(2,1,11),
(3,2,10),
(4,2,15),
(5,3,10),
(6,3,17);

CREATE TABLE `favorites_albums` (
  `id_favorites_albums` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `id_album` INT NOT NULL,
  PRIMARY KEY (`id_favorites_albums`, `id_album`),
  UNIQUE INDEX `id_favorites_albums_UNIQUE` (`id_favorites_albums` ASC) VISIBLE,
  INDEX `fk_favorites_albums_album1_idx` (`id_album` ASC) VISIBLE,
  CONSTRAINT `fk_favorites_albums_album1`
    FOREIGN KEY (`id_album`)
    REFERENCES `spotify`.`album` (`id_album`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `favorites_albums` (`id_favorites_albums`,`id_user`,`id_album`) VALUES
(1,1,1),
(2,1,4),
(3,2,6),
(4,2,4),
(5,3,6),
(6,3,2);

CREATE TABLE `suscriptions` (
  `id_suscription` INT NOT NULL,
  `dateStart` DATE NOT NULL,
  `dateRenewal` DATE NOT NULL,
  `credit_card_or_paypal` ENUM('credit card', 'PayPal') NOT NULL,
  `id_user` INT NOT NULL,
  PRIMARY KEY (`id_suscription`),
  INDEX `fk_suscriptions_user1_idx` (`id_user` ASC) VISIBLE,
  UNIQUE INDEX `id_suscription_UNIQUE` (`id_suscription` ASC) VISIBLE,
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_suscriptions_user1`
    FOREIGN KEY (`id_user`)
    REFERENCES `spotify`.`user` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `suscriptions` (`id_suscription`,`dateStart`,`dateRenewal`,`credit_card_or_paypal`,`id_user`) VALUES 
(1,'2020-01-01','2022-01-01','1',1),
(2,'2020-06-01','2022-06-01','2',2);

CREATE TABLE `credit_card` (
  `id_credit_card` INT NOT NULL,
  `number` INT NOT NULL,
  `caducity` VARCHAR(45) NOT NULL,
  `security_code` INT NOT NULL,
  `id_suscription` INT NOT NULL,
  PRIMARY KEY (`id_credit_card`),
  UNIQUE INDEX `id_credit_card_UNIQUE` (`id_credit_card` ASC) VISIBLE,
  INDEX `fk_credit_card_suscriptions1_idx` (`id_suscription` ASC) VISIBLE,
  UNIQUE INDEX `id_suscription_UNIQUE` (`id_suscription` ASC) VISIBLE,
  UNIQUE INDEX `number_UNIQUE` (`number` ASC) VISIBLE,
  CONSTRAINT `fk_credit_card_suscriptions1`
    FOREIGN KEY (`id_suscription`)
    REFERENCES `spotify`.`suscriptions` (`id_suscription`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `credit_card` (`id_credit_card`,`number`,`caducity`,`security_code`,`id_suscription`) VALUES 
(1,1111111111,'10/24',123,1);

CREATE TABLE `payments` (
  `id_payment` INT NOT NULL,
  `date_payment` DATE NOT NULL,
  `total` INT NOT NULL,
  `id_suscription` INT NOT NULL,
  PRIMARY KEY (`id_payment`),
  UNIQUE INDEX `id_payments_UNIQUE` (`id_payment` ASC) VISIBLE,
  INDEX `fk_payments_suscriptions1_idx` (`id_suscription` ASC) VISIBLE,
  CONSTRAINT `fk_payments_suscriptions1`
    FOREIGN KEY (`id_suscription`)
    REFERENCES `spotify`.`suscriptions` (`id_suscription`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `payments` (`id_payment`,`date_payment`,`total`,`id_suscription`) VALUES
(1,'2020-01-01',45,1),
(2,'2021-01-01',50,1),
(3,'2020-06-01',45,2),
(4,'2021-06-01',50,2),
(5,'2022-01-01',55,1),
(6,'2020-01-01',55,2);

CREATE TABLE `paypal` (
  `id_paypal` INT NOT NULL,
  `user_paypal` VARCHAR(45) NOT NULL,
  `id_suscription` INT NOT NULL,
  PRIMARY KEY (`id_paypal`),
  INDEX `fk_paypal_suscriptions1_idx` (`id_suscription` ASC) VISIBLE,
  UNIQUE INDEX `id_paypal_UNIQUE` (`id_paypal` ASC) VISIBLE,
  CONSTRAINT `fk_paypal_suscriptions1`
    FOREIGN KEY (`id_suscription`)
    REFERENCES `spotify`.`suscriptions` (`id_suscription`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `paypal` (`id_paypal`,`user_paypal`,`id_suscription`) VALUES
(1,'diana@email.com',2);
