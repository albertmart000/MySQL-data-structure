USE pizzeria;

# Begudes venudes a una determinada localitat (en aquest cas, Argentona).
SELECT product.name AS 'Beguda', COUNT(product.id_product) AS 'Unitats', city.name AS 'Població'
FROM product INNER JOIN order_items
ON product.id_product=order_items.id_product
INNER JOIN orders
ON order_items.id_order=orders.id_order
INNER JOIN client
ON orders.id_client=client.id_client
INNER JOIN city
ON client.id_city=city.id_city
INNER JOIN category
ON product.id_category=category.id_category
WHERE city.name= 'Argentona' AND category.name= 'Begudes'
GROUP BY product.name 
ORDER BY COUNT(product.id_product) DESC, product.name;

# Comandes efectuades per un empleat/da determinat (en aquest cas Antoni Martinez).
SELECT employee.name AS 'Nom empleat', employee.surname AS 'Cognom empleat', COUNT(orders.id_order) AS 'Nombre de comandes'
FROM employee JOIN orders
ON employee.id_employee=orders.id_employee
WHERE employee.name='Antoni' GROUP BY employee.name, employee.surname;
