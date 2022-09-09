SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

CREATE TABLE city (
  id_city INT NOT NULL AUTO_INCREMENT UNIQUE,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_city)
) ENGINE = InnoDB;

INSERT INTO city VALUES
(1, 'Mataro'),
(2, 'Argentona'),
(3, 'Dosrrius'),
(4, 'Premiá'),
(5, 'Cabrera'),
(6, 'Blanes');

CREATE TABLE client (
    id_client INT NOT NULL AUTO_INCREMENT UNIQUE,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL,
    postal_code INT NOT NULL,
    id_city INT NOT NULL,
    province VARCHAR(50) NOT NULL DEFAULT 'Barcelona',
    phone_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_client),
    CONSTRAINT fk_client_city FOREIGN KEY (id_city)
        REFERENCES city (id_city)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

INSERT INTO client VALUES
(1, 'Maria', 'Callas', 'C/Casta Diva 1', 11111, 1 , '', '11 1111111'),
(2, 'Abraham', 'Lincoln', 'C/del President 12 2º2ª', 22222, 2, '', '11 2222222'),
(3, 'Paul', 'Cezanne', 'C/de la Pintura 10', 33333, 3, '', '11 3333333'),
(4, 'Stephen', 'King', 'C/del Resplandor 13 1º', 44444, 4, '', '11 4444444'),
(5, 'Claude', 'Monet', 'C/Impresionisme 50', 55555, 5, '', '11 5555555'),
(6, 'Greta', 'Garbo', 'C/Gustafsson', 66666, 6, 'Girona', '22 6666666'),
(7, 'Francisco', 'de Quevedo', 'C/del Buscón 14', 11111, 1, '', '11 7777777'),
(8, 'Georgia', 'OKeeffe', 'C/Modernisme 87 3º3ª', 11111, 1, '', '11 8888888'),
(9, 'Marilyn', 'Monroe', 'C/Norma Jean 75 At. 1ª', 66666, 6, 'Girona', '22 9999999'),
(10, 'Leonardo', 'DaVinci', 'C/Inventor 10', 33333, 3, '', '11 1234567'),
(11, 'Esther', 'Pintado', 'C/Maresme 33', 11111, 1, '', '11 9876543'),
(12, 'Anna', 'Ramon', 'C/del Mig 25', 44444, 4 , '', '11 1001010'),
(13, 'Susanna', 'Gelabert', 'C/de la Muntanya', 22222, 2, '', '11 3004050'),
(14, 'Helena', 'Roure', 'C/Estacio 80', 55555, 5 , '', '11 1357924'),
(15, 'Joan', 'Mir', 'C/Gran 8', 22222, 2 , '', '+11 2468008');

CREATE TABLE pizzashop (
  id_pizzashop INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  address VARCHAR(50) NOT NULL,
  postalCode INT NOT NULL,
  city_idCity INT NOT NULL,
  province VARCHAR(50) NOT NULL DEFAULT 'Barcelona',
  phone_number VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_pizzashop),
  CONSTRAINT fk_pizzashop_city1 FOREIGN KEY (city_idCity)
    REFERENCES city (id_city)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO pizzashop VALUES
(1, 'Pizzeria Vella', 'C/de la Muralla 16', 11111, 1, '', '11 7689452'),
(2, 'Pizzeria Nova', 'C/del Centre 47', 22222, 2, '', '11 3927643');

CREATE TABLE employee (
    id_employee INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    nif VARCHAR(15) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    pizzashop_id_pizzashop INT NOT NULL,
    PRIMARY KEY (id_employee),
    CONSTRAINT fk_employee_pizzashop FOREIGN KEY (pizzashop_id_pizzashop)
        REFERENCES pizzashop (id_pizzashop)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

INSERT INTO employee VALUES
(1, 'Joan', 'Lopez', '35679845H', '11 6358359', 1),
(2, 'Josep', 'Garcia', '87878787X', '11 4538624', 1),
(3, 'Antoni', 'Martinez', '91919191B', '11 3678294', 1),
(4, 'Montse', 'Bosch', '75393620G', '11 5479234', 2),
(5, 'Imma', 'Cantero', '45362874J', '11 9345267', 2),
(6, 'Marçal', 'Benitez', '65835472L', '11 2342534', 2);

CREATE TABLE category (
    id_category INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_category)
)  ENGINE=INNODB;

INSERT INTO category VALUES
(1, 'Pizzas'),
(2, 'Hamburguesas'),
(3, 'Begudes');

CREATE TABLE subcategory (
    id_subcategory INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    category_id_category INT NULL,
    PRIMARY KEY (id_subcategory),
    CONSTRAINT fk_subcategory_category FOREIGN KEY (category_id_category)
        REFERENCES category(id_category)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

INSERT INTO subcategory VALUES
(1, 'Pizzes Clasiques', 1),
(2, 'Pizzes Vegetals', 1),
(3, 'Pizzes Especials', 1);

CREATE TABLE product (
    id_product INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description TEXT(100) NOT NULL,
    image TINYBLOB NOT NULL,
    price DOUBLE NOT NULL,
    id_category INT NOT NULL,
    id_subcategory INT NULL,
    PRIMARY KEY (id_product),
    CONSTRAINT fk_product_category FOREIGN KEY (id_category)
        REFERENCES category (id_category)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_product_subcategory FOREIGN KEY (id_subcategory)
        REFERENCES subcategory (id_subcategory)
        ON DELETE CASCADE ON UPDATE CASCADE
)  ENGINE=INNODB;

INSERT INTO product VALUES
(1, 'Cinc Formatges', 'Pizza Cinc Formatges', '/imagesPizzeria/formatges.jpeg', 10, 1, 1),
(2, 'Pepperoni', 'Pizza Pepperoni', '/imagesPizzeria/pepperoni.jpg', 10, 1, 1),
(3, 'Vegetal 1', 'Pizza Vegetal 1', '/imagesPizzeria/vegetal1.jpeg', 12.5, 1, 2),
(4, 'Vegetal 2', 'Pizza Vegetal 2', '/imagesPizzeria/vegetal2.jpeg', 12.5, 1, 2),
(5, 'Vegetal 3', 'Pizza Vegetal 3', '/imagesPizzeria/vegetal3.jpg', 12.5, 1, 2),
(6, 'Especial 1', 'Pizza Especial 1','/imagesPizzeria/especial1.jpeg', 15, 1, 3),
(7, 'Especial 2', 'Pizza Especial 2', '/imagesPizzeria/especial2.jpeg', 15, 1, 3),
(8, 'Maxi', 'Hamburguesa Maxi', '/imagesPizzeria/burguerMaxi.jpeg', 12.5, 2, 0),
(9, 'Vegetal', 'Hamburguesa Vegetal', '/imagesPizzeria/burguerVegetal.jpeg', 12.5, 2, 0),
(10, 'Picant', 'Hamburguesa Picant', '/imagesPizzeria/burguerPicant.jpeg', 10, 2, 0),
(11, 'Aigua', 'Ampolla Aigua ', '/imagesPizzeria/aigua.jpg', 2, 3, 0),
(12, 'Cola', 'Llauna Cola', '/imagesPizzeria/cola.jpg', 3, 3, 0),
(13, 'Taronja', 'Llauna Taronja', '/imagesPizzeria/taronja.jpg', 3, 3, 0),
(14, 'Llimona', 'Llauna Llimona', '/imagesPizzeria/llimona.jpeg', 3, 3, 0),
(15, 'Cervesa', 'Llauna Cervesa', '/imagesPizzeria/cervesa.jpeg', 5, 3, 5);

CREATE TABLE orders (
  id_order INT NOT NULL AUTO_INCREMENT,
  data_time_order DATETIME NOT NULL,
  delivery_or_shop ENUM('domicili', 'restaurant') NOT NULL,
  id_employee INT NOT NULL,
  date_time_delivery DATETIME NULL,
  number_items_cat1 INT DEFAULT NULL,
  number_items_cat2 INT DEFAULT NULL,
  number_items_cat3 INT DEFAULT NULL,
  total_order INT NOT NULL,
  id_pizzashop INT NOT NULL,
  id_client INT NOT NULL,
  PRIMARY KEY (id_order),
  CONSTRAINT fk_orders_pizzashop
    FOREIGN KEY (id_pizzashop)
    REFERENCES pizzashop (id_pizzashop)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_orders_employee
    FOREIGN KEY (id_employee)
    REFERENCES employee (id_employee)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_orders_client
    FOREIGN KEY (id_client)
    REFERENCES client (id_client)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO orders VALUES
(1, '2022-01-09 20:15:00', 2, 3, null, 3, 2, 5, 77, 1, 7),
(2, '2022-01-15 20:30:00', 1, 1, '2022-01-15 21:00:00', 1, 1, 2, 30, 1, 6),
(3, '2022-02-05 20:00:00', 1, 1, '2022-02-05 20:30:00', 4, null, null, 45, 1, 9),
(4, '2022-02-18 20:50:00', 2, 3, null, 1, 3, 4, 75, 1, 1),
(5, '2022-02-24 21:20:00', 1, 2, '2022-02-24 21:50:00', null, 4, 8, 72, 1, 7),
(6, '2022-03-08 22:00:00', 2, 3, null, 3, null, 3, 46, 1, 8),
(7, '2022-03-14 21:45:00', 1, 2, '2022-03-14 22:50:00', 1, null, 1, 13, 1, 11),
(8, '2022-04-14 20:30:00', 1, 1, '2022-04-14 21:00:00', 2, 2, 3, 55.5, 1, 9),
(9, '2022-04-21 20:45:00', 1, 2, '2022-04-21 21:15:00', 2, null, 2, 29, 1, 7),
(10, '2022-04-30 21:00:00', 2, 3, null, null, 3, 3, 43, 1, 8),
(11, '2022-05-01 22:15:00', 1, 1, '2022-05-01 22:45:00', 1, 1, 2, 33.5, 1, 7),
(12, '2022-01-12 20:30:00', 1, 6, '2022-01-12 21:00:00', 3, null, 3, 49, 2, 2),
(13, '2022-01-25 21:10:00', 1, 4, '2022-01-25 21:40:00', null, 1, 1, 15, 2, 3),
(14, '2022-02-05 22:30:00', 2, 5, null, null, 1, 1, 48.5, 2, 4),
(15, '2022-02-21 22:30:00', 1, 6, '2022-02-20 22:30:00', 1, 1, 2, 33, 2, 5),
(16, '2022-03-20 20:00:00', 1, 4, '2022-03-28 20:30:00', null, 1, 1, 15, 2, 10),
(17, '2022-03-28 20:30:00', 2, 5, null, null, 3, 3, 43, 2, 12),
(18, '2022-03-30 22:00:00', 2, 5, null, 1, 1, 2, 30, 2, 13),
(19, '2022-04-01 21:15:00', 1, 4, '2022-04-01 21:45:00', 3, null, 3, 49, 2, 13),
(20, '2022-04-15 22:30:00', 1, 6, '2022-04-15 23:00:00', 1, 1, 2, 33.5, 2, 3),
(21, '2022-05-13 20:30:00', 1, 6, '2022-05-15 21:00:00', 4, null, null, 45, 2, 14),
(22, '2022-05-15 21:30:00', 1, 4, '2022-05-15 22:00:00', null, 4, 8, 72, 2, 15),
(23, '2022-05-24 22:30:00', 2, 5, null, 1, null, 1, 13, 2, 3),
(24, '2022-05-25 20:30:00', 2, 5, null, 2, null, 2, 29, 1, 8),
(25, '2022-05-27 20:20:00', 1, 2, '2022-05-27 20:50:00', 3, 2, 5, 77, 1, 11);

CREATE TABLE order_items(
  id_order_items INT NOT NULL AUTO_INCREMENT,
  id_order INT NOT NULL,
  id_product INT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (id_order_items, id_product, id_order),
  CONSTRAINT fk_order_items_product
    FOREIGN KEY (id_product)
    REFERENCES product (id_product)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_order_items_orders
    FOREIGN KEY (id_order)
    REFERENCES orders (id_order)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO order_items VALUES
(1, 1, 1, 1),
(2, 1, 3, 1),
(3, 1, 5, 1),
(4, 1, 8, 1),
(5, 1, 9, 1),
(6, 1, 11, 2),
(7, 1, 14, 1),
(8, 1, 15, 2),
(9, 2, 2, 1),
(10, 2, 10, 1),
(11, 2, 15, 2),
(12, 3, 1, 1),
(13, 3, 2, 1),
(14, 3, 3, 1),
(15, 3, 4, 1),
(16, 4, 7, 1),
(17, 4, 8, 1),
(18, 4, 9, 1),
(19, 4, 10, 1),
(20, 4, 11, 2),
(21, 4, 12, 1),
(22, 4, 13, 1),
(23, 4, 15, 3),
(24, 5, 8, 1),
(25, 5, 9, 1),
(26, 5, 10, 1),
(27, 5, 11, 4), 
(28, 5, 15, 4),
(29, 6, 1, 1),
(30, 6, 6, 1),
(31, 6, 7, 1),
(32, 6, 11, 3),
(33, 7, 1, 1), 
(34, 7, 12, 1),
(35, 8, 1, 1),
(36, 8, 3, 1),
(37, 8, 8, 1), 
(38, 8, 9, 1),
(39, 8, 12, 1), 
(40, 8, 14, 2),
(41, 9, 4, 1),
(42, 9, 5, 1),
(43, 9, 11, 2),
(44, 10, 8, 1),
(45, 10, 9, 1),
(46, 10, 10, 1),
(47, 10, 12, 3),
(48, 11, 7, 1),
(49, 11, 9, 1),
(50, 11, 13, 1),
(51, 11, 14, 1),
(52, 12, 4, 1),
(53, 12, 5, 1),
(54, 12, 6, 1),
(55, 12, 12, 1),
(56, 12, 13, 1),
(57, 12, 14, 1),
(58, 13, 10, 1),
(59, 13, 15, 1),
(60, 14, 3, 1),
(61, 14, 4, 1),
(62, 14, 9, 1),
(63, 14, 13, 1),
(64, 14, 14, 1),
(65, 14, 15, 1),
(66, 15, 5, 1),
(67, 15, 8, 1),
(68, 15, 12, 1),
(69, 15, 15, 1),
(70, 16, 10, 1),
(71, 16, 15, 1),
(72, 17, 8, 1),
(73, 17, 9, 1),
(74, 17, 10, 1),
(75, 17, 12, 3),
(76, 18, 2, 1),
(77, 18, 10, 1),
(78, 18, 15, 2),
(79, 19, 4, 1),
(80, 19, 5, 1),
(81, 19, 6, 1),
(82, 19, 12, 1),
(83, 19, 13, 1),
(84, 19, 14, 1),
(85, 20, 7, 1),
(86, 20, 9, 1),
(87, 20, 13, 1),
(88, 20, 14, 1),
(89, 21, 1, 1),
(90, 21, 2, 1),
(91, 21, 3, 1),
(92, 21, 4, 1),
(93, 22, 8, 1),
(94, 22, 9, 1),
(95, 22, 10, 2),
(96, 22, 11, 4), 
(97, 22, 15, 4),
(98, 23, 1, 1),
(99, 23, 12, 1),
(100, 24, 4, 1),
(101, 24, 5, 1),
(102, 24, 11, 2),
(103, 25, 1, 1),
(104, 25, 3, 1),
(105, 25, 5, 1),
(106, 25, 8, 1),
(107, 25, 9, 1),
(108, 25, 11, 2),
(109, 25, 14, 1),
(110, 25, 15, 2);

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
