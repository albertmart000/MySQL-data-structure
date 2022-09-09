DROP DATABASE IF EXISTS optics;
CREATE DATABASE optics CHARACTER SET utf8mb4;
USE optics;

CREATE TABLE city (
  id_city INT NOT NULL AUTO_INCREMENT UNIQUE,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_city)
) ENGINE = InnoDB;

INSERT INTO city VALUES
(1, 'Nova York'),
(2, 'Paris'),
(3, 'Los Angeles'),
(4, 'Estocolmo'),
(5, 'Madrid'),
(6, 'Roma'),
(7, 'Barcelona');

CREATE TABLE country (
  id_country INT NOT NULL AUTO_INCREMENT UNIQUE,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_country)
) ENGINE = InnoDB;

INSERT INTO country VALUES
(1, 'EEUU'),
(2, 'España'),
(3, 'France'),
(4, 'Sweden'),
(5, 'Italia');

CREATE TABLE client (
    id_client INT NOT NULL AUTO_INCREMENT UNIQUE,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    address VARCHAR(50) NOT NULL,
	postal_code INT NOT NULL,
    id_city INT NOT NULL,
    id_country INT NOT NULL,
    id_recommender INT DEFAULT NULL,
    PRIMARY KEY (id_client),
    CONSTRAINT fk_client_city FOREIGN KEY (id_city)
        REFERENCES city (id_city)
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_client_country FOREIGN KEY (id_country)
        REFERENCES country (id_country)
        ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_recommender FOREIGN KEY (id_recommender)
        REFERENCES client (id_client)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

INSERT INTO client VALUES
(1, 'Maria', 'Callas', '+11 11 111 11 11', 'maria@email.com', '2015-01-09', 'C/Casta Diva 1', '11111', 1, 1, null),
(2, 'Abraham', 'Lincoln', '+44 22 222 22 22', 'abraham@email.com', '2016-02-12', 'C/del President 12 2º2ª', '44444', 3, 1, null),
(3, 'Paul', 'Cezanne', '+33 33 333 33 33', 'paul@email.com', '2017-03-15', 'C/de la Pintura 10', '33333', 2, 3, 2),
(4, 'Stephen', 'King', '+11 44 444 44 44', 'stephen@email.com', '2018-04-24','C/del Resplandor 13 1º', '11111', 1, 1, 1),
(5, 'Claude', 'Monet', '+33 55 555 55 55', 'claude@email.com', '2021-07-30', 'C/Impresionisme 50', '33333', 2, 3, null),
(6, 'Greta', 'Garbo', '+66 66 666 66 66', 'greta@email.com', '2020-10-14', 'C/Gustafsson', '66666', 4, 4, 5),
(7, 'Francisco', 'de Quevedo', '+77 77 777 77 77', 'francisco@email.com', '2019-08-22', 'C/del Buscón 14', '77777', 5, 2, null),
(8, 'Georgia', 'OKeeffe', '+11 88 888 88 88', 'georgia@email.com', '2022-11-28', 'C/Modernisme 87 3º3ª','11111', 1, 1, 5),
(9, 'Marilyn', 'Monroe', '+44 99 999 99 99', 'marilyn@email.com', '2020-10-21', 'C/Norma Jean 75 At. 1ª', '44444', 3, 1, 6),
(10, 'Leonardo', 'DaVinci', '+55 34 567 89 01', 'leonardo@email.com', '2017-05-18', 'C/Inventor 10', '55555', 6, 5, 9);

CREATE TABLE seller (
    id_seller INT NOT NULL AUTO_INCREMENT UNIQUE,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_seller)
)  ENGINE=INNODB;
INSERT INTO seller VALUES
(1, 'Joan', 'Lopez'),
(2, 'Josep', 'Garcia'),
(3, 'Antoni', 'Martinez');

CREATE TABLE invoice (
    id_invoice INT NOT NULL AUTO_INCREMENT UNIQUE,
    id_client INT NOT NULL,
    sale_date DATE NOT NULL,
    id_seller INT NOT NULL,
    total_invoice DOUBLE NOT NULL,
    PRIMARY KEY (id_invoice),
    CONSTRAINT fk_invoice_client FOREIGN KEY (id_client)
        REFERENCES client (id_client)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_invoice_seller FOREIGN KEY (id_seller)
        REFERENCES seller (id_seller)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

INSERT INTO invoice VALUES
(1, 1, '2015-01-09', 1, 1750),
(2, 2, '2016-02-12', 1, 900),
(3, 3, '2017-03-15', 1, 1200),
(4, 4, '2022-04-24', 2, 2000),
(5, 5, '2021-07-30', 3, 600),
(6, 6, '2020-10-14', 3, 500),
(7, 7, '2019-08-22', 2, 3850),
(8, 8, '2021-11-28', 3, 900),
(9, 9, '2020-10-21', 3, 650),
(10, 10, '2020-05-18', 3, 500);

CREATE TABLE lenses (
    id_lenses INT NOT NULL AUTO_INCREMENT UNIQUE,
    graduation DOUBLE NOT NULL,
    color ENUM('transparent', 'marro', 'gris') NOT NULL,
    PRIMARY KEY (id_lenses)
)  ENGINE=INNODB;

INSERT INTO lenses VALUES
(1, '0.5', 1),
(2, '0.5', 2),
(3, '0.5', 3),
(4, '1', 1),
(5, '1', 2),
(6, '1', 3),
(7, '2', 1),
(8, '2', 2),
(9, '2', 3),
(10, '5', 1),
(11, '5', 2),
(12, '5', 3);

CREATE TABLE supplier (
    id_supplier INT NOT NULL AUTO_INCREMENT UNIQUE,
    name VARCHAR(50) NOT NULL,
    nif VARCHAR(50) NOT NULL,
    phone_number VARCHAR(50) NOT NULL,
    fax_number VARCHAR(50) DEFAULT NULL,
    address VARCHAR(50) NOT NULL,
    postal_code INT NOT NULL,
    id_city INT NOT NULL,
    id_country INT NOT NULL,
    PRIMARY KEY (id_supplier),
	CONSTRAINT fk_supplier_city FOREIGN KEY (id_city)
        REFERENCES city (id_city)
        ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_supplier_country FOREIGN KEY (id_country)
        REFERENCES country (id_country)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

INSERT INTO supplier VALUES
(1, 'Alain Afflelou', '12345678A' , '+33 22 333 44 55 66', '+33 22 333 44 55 77', 'C/Rue 13','33333', 2, 3),
(2, 'Optica Universitaria', '98765432Z' , '+77 99 888 77 66', null, 'C/Barcelona 1', '22222', 7, 2),
(3, 'Opticalia Argent', '10203040M', '+77 15 791 11 13', '+77 15 791 11 15', 'C/Bellavista 50', '22222', 7, 2);

CREATE TABLE brand (
    id_brand INT NOT NULL AUTO_INCREMENT UNIQUE,
    name VARCHAR(50) NOT NULL,
    id_supplier INT NOT NULL,
    PRIMARY KEY (id_brand),
    CONSTRAINT fk_brand_supplier FOREIGN KEY (id_supplier)
        REFERENCES supplier (id_supplier)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

INSERT INTO brand VALUES
(1, 'Ray Band', 1),
(2, 'Lacoste', 1),
(3, 'Polaroid', 2),
(4, 'Oakley', 3),
(5, 'TitanFlex', 3);

CREATE TABLE model (
    id_model INT NOT NULL AUTO_INCREMENT UNIQUE,
    name VARCHAR(50) NOT NULL,
    id_brand INT NOT NULL,
    frame_type ENUM('flotant', 'pasta', 'metal.lica') NOT NULL,
    PRIMARY KEY (id_model),
    CONSTRAINT fk_model_brand FOREIGN KEY (id_brand)
        REFERENCES brand (id_brand)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

INSERT INTO model VALUES
(1, 'Ray Band Pasta', 1, 2),
(2, 'Ray Band Metal', 1, 3),
(3, 'Lacoste Pasta', 2, 2),
(4, 'Lacoste Metal', 2, 3),
(5, 'Polaroid Air', 3, 1),
(6, 'Polaroid Pasta', 3, 2),
(7, 'Polaroid Air', 3, 3),
(8, 'Oakley Air', 4, 1),
(9, 'Oakley Pasta', 4, 2),
(10, 'Oakley Metal', 4, 3),
(11, 'TitanFlex Air', 5, 1);

CREATE TABLE glasses (
    id_glasses INT NOT NULL AUTO_INCREMENT UNIQUE,
    id_model INT NOT NULL,
    frame_color ENUM('argent', 'daurada', 'negra', 'blava', 'vermella') NOT NULL,
    id_leftLens_id_lens INT NOT NULL,
    id_rightLens_id_lens INT NOT NULL,
    price DOUBLE NOT NULL,
    PRIMARY KEY (id_glasses),
    CONSTRAINT fk_glasses_lensLeft FOREIGN KEY (id_leftLens_id_lens)
        REFERENCES lenses (id_lenses)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_glasses_lensRight FOREIGN KEY (id_rightLens_id_lens)
        REFERENCES lenses (id_lenses)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_glasses_model FOREIGN KEY (id_model)
        REFERENCES model (id_model)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

INSERT INTO glasses VALUES
(1, 11, 1, 3, 3, 1000),
(2, 7, 3, 2, 5, 750),
(3, 4, 4, 7, 4, 900),
(4, 3, 3, 2, 5, 500),
(5, 9, 5, 3, 1, 700),
(6, 1, 1, 8, 11, 1500),
(7, 4, 2, 3, 1, 500),
(8, 6, 1, 7, 4, 600),
(9, 10, 4, 2, 2, 500),
(10, 8, 1, 5, 2, 850),
(11, 3, 5, 11, 11, 1500),
(12, 2, 3, 9, 12, 1500),
(13, 5, 1, 6, 6, 900),
(14, 5, 2, 5, 8, 650),
(15, 11, 1, 2, 2, 500);

CREATE TABLE invoice_detail (
    id_inovice_detail INT NOT NULL AUTO_INCREMENT UNIQUE,
    id_invoice INT NOT NULL,
    id_glasses INT NOT NULL,
    PRIMARY KEY (id_invoice , id_glasses),
    CONSTRAINT fk_invoice_etail_invoice1 FOREIGN KEY (id_invoice)
        REFERENCES invoice (id_invoice)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_invoice_detail_glasses1 FOREIGN KEY (id_glasses)
        REFERENCES glasses (id_glasses)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

INSERT INTO invoice_detail VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 3, 4),
(5, 3, 5),
(6, 4, 6),
(7, 4, 7),
(8, 5, 8),
(9, 6, 9),
(10, 7, 10),
(11, 7, 11),
(12, 7, 12),
(13, 8, 13),
(14, 9, 14),
(15, 10, 15);
