CREATE TABLE trademarks (
    id_trademark SERIAL PRIMARY KEY,
    trademark varchar(15)
);

CREATE TABLE flavors (
    id_flavor SERIAL PRIMARY KEY,
    flavor VARCHAR (15)
);

CREATE TABLE presentations (
    id_presentation SERIAL PRIMARY KEY,
    presentation varchar(15)
);

CREATE TABLE products (
    id_product SERIAL PRIMARY KEY,
    id_presentation INT NOT NULL,
    id_flavor INT NOT NULL,
    id_trademark INT NOT NULL,
    price INT,
    size_product varchar (15),
    FOREIGN KEY (id_presentation) REFERENCES presentations (id_presentation),
    FOREIGN KEY (id_flavor) REFERENCES flavors (id_flavor),
    FOREIGN KEY (id_trademark) REFERENCES trademarks (id_trademark)
);

CREATE TABLE storage (
    id_storage SERIAL PRIMARY KEY,
    id_product INT NOT NULL,
    input_date DATE,
    quantity INT,
    FOREIGN KEY (id_product) REFERENCES products (id_product)
);

CREATE TABLE sales (
    id_venta SERIAL PRIMARY KEY,
    id_product INT NOT NULL,
    output_date DATE,
    quantity INT,
    total_sale INT,
    individual_price INT,
    FOREIGN KEY (id_product) REFERENCES products (id_product)
);



INSERT INTO trademarks (trademark) VALUES
('boing'),
('adez'),
('del valle'),
('jumex');


INSERT INTO presentations (presentation) VALUES
('tetrapak'),
('pet'),
('vidrio');

INSERT INTO flavors (flavor) VALUES
('mango'),
('manzana'),
('uva'),
('naranja'),
('guayaba');


-- delete from presentations;

-- ALTER SEQUENCE sales_id_venta_seq RESTART WITH 1;



INSERT INTO products (id_presentation, id_flavor, id_trademark, price, size_product) VALUES
-- boing (id_trademark = 1)
(1, 1, 1, 7, '125'),   -- tetrapak, mango, boing, 125 ml
(1, 1, 1, 13, '355'),  -- tetrapak, mango, boing, 355 ml
(1, 1, 1, 25, '1000'), -- tetrapak, mango, boing, 1000 ml
(1, 1, 1, 30, '1500'), -- tetrapak, mango, boing, 1500 ml
(1, 1, 1, 43, '2000'), -- tetrapak, mango, boing, 2000 ml
(1, 2, 1, 7, '125'),   -- tetrapak, manzana, boing, 125 ml
(1, 2, 1, 13, '355'),  -- tetrapak, manzana, boing, 355 ml
(1, 2, 1, 25, '1000'), -- tetrapak, manzana, boing, 1000 ml
(1, 2, 1, 30, '1500'), -- tetrapak, manzana, boing, 1500 ml
(1, 2, 1, 43, '2000'), -- tetrapak, manzana, boing, 2000 ml
-- repetir para cada sabor
(1, 3, 1, 7, '125'),   -- tetrapak, uva, boing, 125 ml
(1, 3, 1, 13, '355'),
(1, 3, 1, 25, '1000'),
(1, 3, 1, 30, '1500'),
(1, 3, 1, 43, '2000'),
-- Adez (id_trademark = 2)
(2, 1, 2, 7, '125'),   -- pet, mango, adez, 125 ml
(2, 1, 2, 13, '355'),
(2, 1, 2, 25, '1000'),
(2, 1, 2, 30, '1500'),
(2, 1, 2, 43, '2000'),
(2, 2, 2, 7, '125'),   -- pet, manzana, adez, 125 ml
(2, 2, 2, 13, '355'),
(2, 2, 2, 25, '1000'),
(2, 2, 2, 30, '1500'),
(2, 2, 2, 43, '2000'),
-- repetir para cada sabor
(2, 3, 2, 7, '125'),   -- pet, uva, adez, 125 ml
(2, 3, 2, 13, '355'),
(2, 3, 2, 25, '1000'),
(2, 3, 2, 30, '1500'),
(2, 3, 2, 43, '2000'),
-- del valle (id_trademark = 3)
(3, 1, 3, 7, '125'),   -- vidrio, mango, del valle, 125 ml
(3, 1, 3, 13, '355'),
(3, 1, 3, 25, '1000'),
(3, 1, 3, 30, '1500'),
(3, 1, 3, 43, '2000'),
(3, 2, 3, 7, '125'),   -- vidrio, manzana, del valle, 125 ml
(3, 2, 3, 13, '355'),
(3, 2, 3, 25, '1000'),
(3, 2, 3, 30, '1500'),
(3, 2, 3, 43, '2000'),
-- repetir para cada sabor
(3, 3, 3, 7, '125'),   -- vidrio, uva, del valle, 125 ml
(3, 3, 3, 13, '355'),
(3, 3, 3, 25, '1000'),
(3, 3, 3, 30, '1500'),
(3, 3, 3, 43, '2000'),
-- jumex (id_trademark = 4)
(1, 1, 4, 7, '125'),   -- tetrapak, mango, jumex, 125 ml
(1, 1, 4, 13, '355'),
(1, 1, 4, 25, '1000'),
(1, 1, 4, 30, '1500'),
(1, 1, 4, 43, '2000'),
(1, 2, 4, 7, '125'),   -- tetrapak, manzana, jumex, 125 ml
(1, 2, 4, 13, '355'),
(1, 2, 4, 25, '1000'),
(1, 2, 4, 30, '1500'),
(1, 2, 4, 43, '2000'),
-- repetir para cada sabor
(1, 3, 4, 7, '125'),   -- tetrapak, uva, jumex, 125 ml
(1, 3, 4, 13, '355'),
(1, 3, 4, 25, '1000'),
(1, 3, 4, 30, '1500'),
(1, 3, 4, 43, '2000');



-- Generar registros de productos en la tabla storage con fechas en agosto y septiembre de 2024
INSERT INTO storage (id_product, input_date, quantity) VALUES
-- boing (trademark_id = 1)
(1, '2024-08-15', 100),  -- tetrapak, mango, boing, 125 ml
(2, '2024-08-20', 200),  -- tetrapak, mango, boing, 355 ml
(3, '2024-08-25', 150),  -- tetrapak, mango, boing, 1000 ml
(4, '2024-09-01', 250),  -- tetrapak, mango, boing, 1500 ml
(5, '2024-09-05', 300),  -- tetrapak, mango, boing, 2000 ml
(6, '2024-08-18', 180),  -- tetrapak, manzana, boing, 125 ml
(7, '2024-08-22', 220),  -- tetrapak, manzana, boing, 355 ml
(8, '2024-08-28', 160),  -- tetrapak, manzana, boing, 1000 ml
(9, '2024-09-03', 240),  -- tetrapak, manzana, boing, 1500 ml
(10, '2024-09-10', 320), -- tetrapak, manzana, boing, 2000 ml
-- Adez (trademark_id = 2)
(11, '2024-08-16', 90),  -- pet, mango, adez, 125 ml
(12, '2024-08-21', 210), -- pet, mango, adez, 355 ml
(13, '2024-08-26', 130), -- pet, mango, adez, 1000 ml
(14, '2024-09-02', 230), -- pet, mango, adez, 1500 ml
(15, '2024-09-07', 280), -- pet, mango, adez, 2000 ml
(16, '2024-08-19', 170), -- pet, manzana, adez, 125 ml
(17, '2024-08-24', 190), -- pet, manzana, adez, 355 ml
(18, '2024-08-30', 140), -- pet, manzana, adez, 1000 ml
(19, '2024-09-06', 220), -- pet, manzana, adez, 1500 ml
(20, '2024-09-12', 310), -- pet, manzana, adez, 2000 ml
-- del valle (trademark_id = 3)
(21, '2024-08-17', 110), -- vidrio, mango, del valle, 125 ml
(22, '2024-08-25', 205), -- vidrio, mango, del valle, 355 ml
(23, '2024-08-28', 125), -- vidrio, mango, del valle, 1000 ml
(24, '2024-09-04', 225), -- vidrio, mango, del valle, 1500 ml
(25, '2024-09-09', 275), -- vidrio, mango, del valle, 2000 ml
(26, '2024-08-22', 185), -- vidrio, manzana, del valle, 125 ml
(27, '2024-08-29', 195), -- vidrio, manzana, del valle, 355 ml
(28, '2024-09-01', 135); -- vidrio, manzana, del valle, 1000 ml

INSERT INTO storage (id_product, input_date, quantity) VALUES
-- Continuación de los datos para completar hasta 60
(29, '2024-09-02', 250),  -- vidrio, manzana, del valle, 1500 ml
(30, '2024-09-10', 300),  -- vidrio, manzana, del valle, 2000 ml
(31, '2024-09-15', 210),  -- tetrapak, uva, boing, 125 ml
(32, '2024-09-18', 180),  -- tetrapak, uva, boing, 355 ml
(33, '2024-09-20', 160),  -- tetrapak, uva, boing, 1000 ml
(34, '2024-09-25', 280),  -- tetrapak, uva, boing, 1500 ml
(35, '2024-09-30', 300),  -- tetrapak, uva, boing, 2000 ml
(36, '2024-09-05', 170),  -- pet, uva, adez, 125 ml
(37, '2024-09-07', 150),  -- pet, uva, adez, 355 ml
(38, '2024-09-12', 200),  -- pet, uva, adez, 1000 ml
(39, '2024-09-14', 220),  -- pet, uva, adez, 1500 ml
(40, '2024-09-18', 270),  -- pet, uva, adez, 2000 ml
(41, '2024-09-01', 190),  -- vidrio, uva, del valle, 125 ml
(42, '2024-09-03', 210),  -- vidrio, uva, del valle, 355 ml
(43, '2024-09-08', 240),  -- vidrio, uva, del valle, 1000 ml
(44, '2024-09-12', 230),  -- vidrio, uva, del valle, 1500 ml
(45, '2024-09-16', 250),  -- vidrio, uva, del valle, 2000 ml
(46, '2024-09-02', 300),  -- tetrapak, guayaba, boing, 125 ml
(47, '2024-09-06', 200),  -- tetrapak, guayaba, boing, 355 ml
(48, '2024-09-11', 160),  -- tetrapak, guayaba, boing, 1000 ml
(49, '2024-09-16', 190),  -- tetrapak, guayaba, boing, 1500 ml
(50, '2024-09-20', 220),  -- tetrapak, guayaba, boing, 2000 ml
(51, '2024-09-02', 150),  -- pet, guayaba, adez, 125 ml
(52, '2024-09-05', 170),  -- pet, guayaba, adez, 355 ml
(53, '2024-09-10', 140),  -- pet, guayaba, adez, 1000 ml
(54, '2024-09-15', 180),  -- pet, guayaba, adez, 1500 ml
(55, '2024-09-20', 210),  -- pet, guayaba, adez, 2000 ml
(56, '2024-09-01', 125),  -- vidrio, guayaba, del valle, 125 ml
(57, '2024-09-06', 135),  -- vidrio, guayaba, del valle, 355 ml
(58, '2024-09-11', 145),  -- vidrio, guayaba, del valle, 1000 ml
(59, '2024-09-15', 155),  -- vidrio, guayaba, del valle, 1500 ml
(60, '2024-09-20', 165);  -- vidrio, guayaba, del valle, 2000 ml


CREATE OR REPLACE FUNCTION generar_ventas_aleatorias()
RETURNS void AS $$
DECLARE
    id_producto INT;
    fecha_venta DATE;
    cantidad_venta INT;
    precio_individual INT;
    total_venta INT;
BEGIN
    FOR i IN 1..10000 LOOP
        -- Seleccionar aleatoriamente un id_product de la tabla products
        SELECT id_product, price
        INTO id_producto, precio_individual
        FROM products
        ORDER BY random()
        LIMIT 1;

        -- Generar una fecha de venta aleatoria dentro de un año (ejemplo 2023)
        fecha_venta := DATE '2023-01-01' + (random() * 365)::int;

        -- Generar una cantidad aleatoria (entre 1 y 100)
        cantidad_venta := FLOOR(random() * 100) + 1;

        -- Calcular el total de la venta (cantidad * precio individual)
        total_venta := cantidad_venta * precio_individual;

        -- Insertar la venta en la tabla sales
        INSERT INTO sales (id_product, output_date, quantity, total_sale, individual_price)
        VALUES (id_producto, fecha_venta, cantidad_venta, total_venta, precio_individual);
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- delete from sales;

SELECT generar_ventas_aleatorias();


SELECT envase, sabor, marca, precio, tamaño, cantidad_vendida, fecha_venta, fecha_ingreso
    FROM ventas;



SELECT
	a.id_venta,
    c.presentation as envase,
    d.flavor as sabor,
    e.trademark as marca,
    a.individual_price as precio,
    b.size_product,
    a.quantity as cantidad_vendida,
    a.output_date as fecha_venta,
    f.input_date as fecha_ingreso
FROM
    sales as a
    INNER JOIN products as b ON b.id_product = a.id_product
    INNER JOIN presentations as c ON c.id_presentation = b.id_presentation
    INNER JOIN flavors AS d ON d.id_flavor = b.id_flavor
    INNER JOIN trademarks AS e ON e.id_trademark = b.id_trademark
    INNER JOIN storage AS f ON f.id_product = a.id_product
ORDER BY 
	a.id_venta;



CREATE VIEW view_sales AS SELECT
	a.id_venta,
    c.presentation as envase,
    d.flavor as sabor,
    e.trademark as marca,
    a.individual_price as precio,
    b.size_product,
    a.quantity as cantidad_vendida,
    a.output_date as fecha_venta,
    f.input_date as fecha_ingreso
FROM
    sales as a
    INNER JOIN products as b ON b.id_product = a.id_product
    INNER JOIN presentations as c ON c.id_presentation = b.id_presentation
    INNER JOIN flavors AS d ON d.id_flavor = b.id_flavor
    INNER JOIN trademarks AS e ON e.id_trademark = b.id_trademark
    INNER JOIN storage AS f ON f.id_product = a.id_product
ORDER BY 
	a.id_venta;













