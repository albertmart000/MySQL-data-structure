DROP DATABASE IF EXISTS YouTube;
CREATE DATABASE YouTube CHARACTER SET utf8mb4;
USE YouTube;

CREATE TABLE `country` (
  `id_country` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_country`),
  UNIQUE INDEX `id_country_UNIQUE` (`id_country` ASC) VISIBLE)
ENGINE = InnoDB;
INSERT INTO country VALUES
(1, 'England'),
(2, 'Japan'),
(3, 'France');

CREATE TABLE `user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `gender` ENUM('no binari', 'dona', 'home') NOT NULL,
  `postal_code` INT NOT NULL,
  `country_id_country` INT NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  INDEX `fk_client_country_idx` (`country_id_country` ASC) VISIBLE,
  CONSTRAINT `fk_user_country`
    FOREIGN KEY (`country_id_country`)
    REFERENCES `YouTube`.`country` (`id_country`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `user` (`id_user`,`name`,`email`,`password`,`date_of_birth`,`gender`,`postal_code`,`country_id_country`) VALUES 
(1,'John Allred','john@email','johnpassword','2001-01-01','1',11111,1),
(2,'Diana Krall','diana@email','dianapasswod','2002-02-02','2',22222,2),
(3,'Frank Wess','frank@email','frankpassword','2003-03-03','3',33333,3);

CREATE TABLE `video` (
  `id_video` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `size` DOUBLE NOT NULL,
  `length` TIME NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `thumbnail` TINYBLOB NOT NULL,
  `datetime_of_publication` DATETIME NOT NULL,
  `visibility` ENUM('public', 'privat', 'ocult') NOT NULL,
  `reproductions` INT NULL,
  `likes` INT NULL COMMENT '	',
  `dislikes` INT NULL,
  `user_id_user` INT NOT NULL,
  PRIMARY KEY (`id_video`),
  UNIQUE INDEX `id_video_UNIQUE` (`id_video` ASC) VISIBLE,
  INDEX `fk_video_user_idx` (`user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_video_user`
    FOREIGN KEY (`user_id_user`)
    REFERENCES `YouTube`.`user` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `video` (`id_video`,`title`,`size`,`length`,`description`,`thumbnail`,`datetime_of_publication`,`visibility`,`reproductions`,`likes`,`dislikes`,`user_id_user`) VALUES
(1,'Trombone1',75.5,'340','Video Trombone1','/thumbnailYouTube/trombone1.jpeg','2001-01-15 21:00:00','public',1000,100,2,1),
(2,'Trombone2',100.8,'538','Video Trombone2','/thumbnailYouTube/trombone2.jpg','2001-03-05 12:00:00','privat',150,34,NULL,1),
(3,'Trombone3',92.3,'245','Video Trombone3','/thumbnailYouTube/trombone3.jpeg','2001-05-28 17:30:00','public',2000,249,4,1),
(4,'Piano1',68.7,'1015','Video Piano1','/thumbnailYouTube/piano1.jpeg','2002-04-09 22:00:00','public',1800,415,NULL,2),
(5,'Piano2',83.5,'414','Video Piano2','/thumbnailYouTube/piano2.jpeg','2002-06-18 11:45:00','public',2000,188,3,2),
(6,'Piano3',104.25,'1111','Video Piano3','/thumbnailYouTube/piano3.jpeg','2002-08-29 14:00:00','ocult',NULL,NULL,NULL,2),
(7,'Flute1',112.4,'656','Video Flute1','/thumbnailYouTube/flute1.jpeg','2003-09-16 23:30:00','public',1250,400,2,3),
(8,'Flute2',79.6,'658','Video Flute2','/thumbnailYouTube/flute2.jpeg','2003-09-30 15:10:00','privat',175,19,NULL,3),
(9,'Flute3',88.2,'400','Video Flute3','/thumbnailYouTube/flute3.jpeg','2003-10-02 10:20:00','ocult',NULL,NULL,NULL,3),
(10,'Flute4',99,'1515','Video Flute4','/thumbnailYouTube/flute4.jpeg','2003-11-07 18:00:00','public',2100,300,2,3);

CREATE TABLE `tags` (
  `id_tags` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tags`),
  UNIQUE INDEX `id_tags_UNIQUE` (`id_tags` ASC) VISIBLE)
ENGINE = InnoDB;
INSERT INTO `tags`(`id_tags`,`name`) VALUES
(1, 'Trombone'),
(2, 'Piano'),
(3, 'Flute'),
(4, 'Music'),
(5, 'Jazz');

CREATE TABLE `channel` (
  `id_channel` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `date_of_creation` DATE NOT NULL,
  `user_id_user` INT NOT NULL,
  PRIMARY KEY (`id_channel`),
  UNIQUE INDEX `id_canal_UNIQUE` (`id_channel` ASC) VISIBLE,
  INDEX `fk_canal_user_idx` (`user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_channel_user`
    FOREIGN KEY (`user_id_user`)
    REFERENCES `YouTube`.`user` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `channel` (`id_channel`,`name`, `description`,`date_of_creation`,`user_id_user`) VALUES
(1,'Channel Trombone','Videos trombone','2021-01-01',1),
(2,'Channel Piano','Videos piano','2021-02-02',2),
(3,'Channel Flute','Videos flute','2021-03-03',3);

CREATE TABLE `like_dislike_video` (
  `id_like_dislike_video` INT NOT NULL,
  `like_or_dislike` ENUM('like', 'dislike') NOT NULL,
  `datetime` DATETIME NOT NULL,
  `user_id_user` INT NOT NULL,
  `video_id_video` INT NOT NULL,
  PRIMARY KEY (`id_like_dislike_video`),
  UNIQUE INDEX `id_like_dislike_UNIQUE` (`id_like_dislike_video` ASC) VISIBLE,
  INDEX `fk_like_dislike_video_id_video_idx` (`video_id_video` ASC) VISIBLE,
  INDEX `fk_like_dislike_video_id_user_idx` (`user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_like_dislike_video_id_video`
    FOREIGN KEY (`video_id_video`)
    REFERENCES `YouTube`.`video` (`id_video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_like_dislike_video_id_user`
    FOREIGN KEY (`user_id_user`)
    REFERENCES `YouTube`.`user` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `like_dislike_video` (`id_like_dislike_video`,`like_or_dislike`,`datetime`,`user_id_user`,`video_id_video`) VALUES
(1,'like', 20040315093000, 1, 4),
(2,'dislike', 20040315103000, 1, 5),
(3,'like', 20040328093000, 1, 7),
(4,'like', 20040509190000, 1, 8),
(5,'dislike', 20040715093000, 2, 1),
(6,'like', 20040915094500, 2, 2),
(7,'like', 20041111182000, 2, 3),
(8,'like', 20041205233000, 2, 7),
(9,'like', 20041225101500, 2, 8),
(10,'dislike', 20040614093000, 3, 1),
(11,'like', 20040415215000, 3, 2),
(12,'like', 20041011143000, 3, 3),
(13,'like', 20041022162500, 3, 4),
(14,'like', 20041101200000, 3, 5);

CREATE TABLE `playlists` (
  `id_playlists` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `date_of_creation` DATE NOT NULL,
  `visibility` ENUM('publica', 'privada') NOT NULL,
  `user_id_user` INT NOT NULL,
  PRIMARY KEY (`id_playlists`),
  UNIQUE INDEX `id_playlists_UNIQUE` (`id_playlists` ASC) VISIBLE,
  INDEX `fk_playlists_user_idx` (`user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_user`
    FOREIGN KEY (`user_id_user`)
    REFERENCES `YouTube`.`user` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `playlists` (`id_playlists`,`name`,`date_of_creation`,`visibility`,`user_id_user`) VALUES 
(1,'Playlist Trombone','2020-01-01','publica',1),
(2,'Playlist Piano','2020-02-02','privada',2),
(3,'Playlist Flute','2020-03-03','publica',3);

CREATE TABLE `comment` (
  `id_comment` INT NOT NULL,
  `text` VARCHAR(100) NOT NULL,
  `datetime_of_publication` DATETIME NOT NULL,
  `user_id_user` INT NOT NULL,
  PRIMARY KEY (`id_comment`),
  UNIQUE INDEX `id_comment_UNIQUE` (`id_comment` ASC) VISIBLE,
  INDEX `fk_comment_user_idx` (`user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_comment_user`
    FOREIGN KEY (`user_id_user`)
    REFERENCES `YouTube`.`user` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `comment` (`id_comment`,`text`,`datetime_of_publication`,`user_id_user`) VALUES
(1,"Es un video genial", 20040315093000, 1),
(2,"Es pot millorar", 20040315103000, 1),
(3,'Gràcies per pujar aquest video', 20040328093000, 1),
(4,'Molt bo', 20040509190000, 1),
(5,"No m'agrada", 20040715093000, 2),
(6,'Que bo!', 20040915094500, 2),
(7,"M'agrada molt", 20041111182000, 2),
(8,'Gran video', 20041205233000, 2),
(9,'Molt bé', 20041225101500, 2),
(10, "No m'agrada el video", 20040614093000, 3),
(11,'Gracies.', 20040415215000, 3),
(12,'Perfecte!', 20041011143000, 3),
(13,'Yeahhh', 20041022162500, 3),
(14,'Impresionant', 20041101200000, 3);

CREATE TABLE `like_dislike_comment` (
  `id_like_dislike_comment` INT NOT NULL,
  `like_or_dislike` ENUM('like', 'dislike') NOT NULL,
  `datetime` DATETIME NOT NULL,
  `user_id_user` INT NOT NULL,
  `comment_id_comment` INT NOT NULL,
  PRIMARY KEY (`id_like_dislike_comment`),
  UNIQUE INDEX `id_like_dislike_UNIQUE` (`id_like_dislike_comment` ASC) VISIBLE,
  INDEX `fk_like_dislike_comment_comment_idx` (`comment_id_comment` ASC) VISIBLE,
  INDEX `fk_like_dislike_comment_user_idx` (`user_id_user` ASC) VISIBLE,
  CONSTRAINT `fk_like_dislike_comment_comment`
    FOREIGN KEY (`comment_id_comment`)
    REFERENCES `YouTube`.`comment` (`id_comment`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_like_dislike_comment_user`
    FOREIGN KEY (`user_id_user`)
    REFERENCES `YouTube`.`user` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `like_dislike_comment` (`id_like_dislike_comment`,`like_or_dislike`,`datetime`,`user_id_user`,`comment_id_comment`) VALUES
(1,'like', 20040315093000, 1, 4),
(2,'dislike', 20040315103000, 1, 5),
(3,'like', 20040328093000, 1, 7),
(4,'like', 20040509190000, 1, 8),
(5,'like', 20040715093000, 2, 1),
(6,'like', 20040915094500, 2, 2),
(7,'like', 20041111182000, 2, 3),
(8,'like', 20041205233000, 2, 7),
(9,'like', 20041225101500, 2, 8),
(10,'dislike', 20040614093000, 3, 1),
(11,'like', 20040415215000, 3, 2),
(12,'like', 20041011143000, 3, 3),
(13,'like', 20041022162500, 3, 4),
(14,'like', 20041101200000, 3, 5);

CREATE TABLE `playlist_video` (
  `id_playlist_video` INT NOT NULL,
  `id_playlists` INT NOT NULL,
  `id_video` INT NOT NULL,
  PRIMARY KEY (`id_playlist_video`),
  UNIQUE INDEX `id_playlist_video_UNIQUE` (`id_playlist_video` ASC) VISIBLE,
  INDEX `fk_playlist_video_playlist_idx` (`id_playlists` ASC) VISIBLE,
  INDEX `fk_playlist_video_video_idx` (`id_video` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_video_playlist`
    FOREIGN KEY (`id_playlists`)
    REFERENCES `YouTube`.`playlists` (`id_playlists`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_video_video`
    FOREIGN KEY (`id_video`)
    REFERENCES `YouTube`.`video` (`id_video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `playlist_video` (`id_playlist_video`, `id_playlists`, `id_video`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 5),
(4, 2, 6),
(5, 2, 8),
(6, 2, 9),
(7, 3, 2),
(8, 3, 7),
(9, 3, 7),
(10, 3, 4);

CREATE TABLE `tags_video` (
  `id_tags_video` INT NOT NULL,
  `id_tags` INT NOT NULL,
  `id_video` INT NOT NULL,
  PRIMARY KEY (`id_tags_video`),
  UNIQUE INDEX `id_playlist_video_UNIQUE` (`id_tags_video` ASC) VISIBLE,
  INDEX `fk_playlist_video_video_idx` (`id_video` ASC) VISIBLE,
  INDEX `fk_tags_video_tags_idx` (`id_tags` ASC) VISIBLE,
  CONSTRAINT `fk_tags_video_tags`
    FOREIGN KEY (`id_tags`)
    REFERENCES `YouTube`.`tags` (`id_tags`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tags_video_video`
    FOREIGN KEY (`id_video`)
    REFERENCES `YouTube`.`video` (`id_video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `tags_video` (`id_tags_video`, `id_tags`, `id_video`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 5),
(4, 2, 6),
(5, 3, 8),
(6, 3, 9),
(7, 4, 2),
(8, 4, 7),
(9, 5, 7),
(10, 5, 4);

CREATE TABLE `suscriber_channel` (
  `id_suscriber_channel` INT NOT NULL,
  `id_user` INT NOT NULL,
  `id_channel` INT NOT NULL,
  PRIMARY KEY (`id_suscriber_channel`),
  UNIQUE INDEX `id_suscriber_channel_UNIQUE` (`id_suscriber_channel` ASC) VISIBLE,
  INDEX `fk_suscriber_channel_user_idx` (`id_user` ASC) VISIBLE,
  INDEX `fk_suscriber_channel_channel_idx` (`id_channel` ASC) VISIBLE,
  CONSTRAINT `fk_suscriber_channel_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `YouTube`.`user` (`id_user`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_suscriber_channel_channel`
    FOREIGN KEY (`id_channel`)
    REFERENCES `YouTube`.`channel` (`id_channel`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `suscriber_channel` (`id_suscriber_channel`, `id_user`, `id_channel`) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 1);

CREATE TABLE `comment_video` (
  `id_comment_video` INT NOT NULL,
  `id_comment` INT NOT NULL,
  `id_video` INT NOT NULL,
  PRIMARY KEY (`id_comment_video`),
  UNIQUE INDEX `id_playlist_video_UNIQUE` (`id_comment_video` ASC) VISIBLE,
  INDEX `fk_playlist_video_video_idx` (`id_video` ASC) VISIBLE,
  INDEX `fk_comment_video_comment_idx` (`id_comment` ASC) VISIBLE,
  CONSTRAINT `fk_comment_video_comment`
    FOREIGN KEY (`id_comment`)
    REFERENCES `YouTube`.`comment` (`id_comment`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comment_video_video`
    FOREIGN KEY (`id_video`)
    REFERENCES `YouTube`.`video` (`id_video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
INSERT INTO `comment_video` (`id_comment_video`, `id_comment`, `id_video`) VALUES
(1, 1, 8),
(2, 2, 10),
(3, 3, 2),
(4, 4, 5),
(5, 5, 5),
(6, 6, 8),
(7, 7, 2),
(8, 8, 7),
(9, 9, 4),
(10, 10, 10),
(11, 11, 3),
(12, 12, 2),
(13, 13, 5),
(14, 14, 1);
