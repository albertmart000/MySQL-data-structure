USE optics;

# Factures d'un client determinat en un periode de temps.
SELECT CONCAT(client.name, ' ', client.surname) AS 'Nom',
id_invoice AS 'Codi factura', sale_date AS 'Data Factura', total_invoice AS 'Total factura'
FROM client INNER JOIN invoice ON client.id_client=invoice.id_client
where CONCAT(client.name, ' ', client.surname)='Stephen King' and sale_date BETWEEN '22-01-01' AND '22-07-01';

# Models d'ulleres venudes per un empleat determinat durant un any.
SELECT CONCAT(seller.name, ' ', seller.surname) AS 'Nom venedor', model.name AS 'Model', invoice.sale_date as 'Data'
FROM seller INNER JOIN invoice ON seller.id_seller=invoice.id_seller
INNER JOIN invoice_detail ON invoice.id_invoice=invoice_detail.id_invoice
INNER JOIN glasses ON invoice_detail.id_glasses=glasses.id_glasses
INNER JOIN model ON glasses.id_model=model.id_model
WHERE CONCAT(seller.name, ' ', seller.surname)='Antoni Martinez'
AND invoice.sale_date BETWEEN 2020-10-10 AND '2021-10-10'
ORDER BY invoice.sale_date;

# Proveïdors que han subministrat ulleres venudes per l'òptica.
SELECT supplier.name AS 'Proveidor', model.name AS 'Model', COUNT(glasses.id_glasses)
FROM invoice_detail INNER JOIN glasses on invoice_detail.id_glasses=glasses.id_glasses
INNER JOIN model ON glasses.id_model=model.id_model
INNER JOIN brand ON model.id_brand=brand.id_brand
INNER JOIN supplier ON brand.id_supplier=supplier.id_supplier
GROUP BY supplier.name, model.name
ORDER BY COUNT(glasses.id_glasses) DESC, supplier.name,  model.name;
