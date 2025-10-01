
-- PAÍS
INSERT INTO paises (countryName, countryCode) 
VALUES ('Costa Rica', 'CR');

-- PROVINCIAS
INSERT INTO estados (idPais, stateName, stateCode) VALUES
(1, 'San José', 'SJ'),
(1, 'Alajuela', 'AL');

-- CANTONES
INSERT INTO ciudades (idEstados, cityName) VALUES
(1, 'San José Centro'),
(1, 'Escazú'),
(2, 'Alajuela Centro');

-- DIRECCIONES
INSERT INTO direcciones (idCiudad, addressLine1, adressLine2, zipCode, geoPosition) VALUES
-- Primer edificio
(1, 'Avenida Central, Calle 2', 'Frente al Parque Central', '10101', POINT(-83.5262366, 8.9578495)),
-- Segundo edificio  
(2, 'Centro Comercial Multiplaza Escazú', 'Local 15, Primer Nivel', '10201', POINT(-84.091, 9.933));

-- EDIFICIOS
INSERT INTO edificios (idDireccion, nombre, uso) VALUES
(1, 'Edificio Plaza Central', 'Comercial'),
(2, 'Multiplaza Escazú', 'Comercial');

-- LOCALES
INSERT INTO locales (idEdificio, codigoPiso, nombre, descripcion, estado, tipo) VALUES
-- Primer edificio: 1 local
(1, 'PB', 'Local Principal', 'Local con vitrina a la avenida principal', 'Disponible', 'Gastronomico'),
-- Segundo edificio: 2 locales
(2, 'P1', 'Local Food Court', 'Ubicado en zona de comidas', 'Disponible', 'Gastronomico'),
(2, 'P2', 'Local Moda', 'Zona de tiendas de ropa', 'Disponible', 'Rental');

-- KIOSKOS
INSERT INTO kioskos (idLocal, codigo, sizem2, estado, costeRemodelacion) VALUES
-- Local 1: 5 kioskos
(1, 'K001', 12.50, 'Ocupado', 180000.00),
(1, 'K002', 15.25, 'Ocupado', 220000.00),
(1, 'K003', 10.75, 'Ocupado', 150000.00),
(1, 'K004', 14.00, 'Ocupado', 190000.00),
(1, 'K005', 11.80, 'Ocupado', 160000.00),

-- Local 2: 6 kioskos
(2, 'K006', 8.25, 'Ocupado', 120000.00),
(2, 'K007', 9.50, 'Ocupado', 135000.00),
(2, 'K008', 7.80, 'Ocupado', 110000.00),
(2, 'K009', 10.20, 'Ocupado', 145000.00),
(2, 'K010', 8.75, 'Ocupado', 125000.00),
(2, 'K011', 9.25, 'Ocupado', 130000.00),

-- Local 3: 4 kioskos
(3, 'K012', 16.50, 'Ocupado', 240000.00),
(3, 'K013', 14.25, 'Ocupado', 210000.00),
(3, 'K014', 13.75, 'Ocupado', 200000.00),
(3, 'K015', 15.80, 'Ocupado', 230000.00);

-- USUARIOS
INSERT INTO usuarios (nombre, cedula, email, telefono, `password`, fechaInicio) VALUES
-- Admin
('Tony Solano Carranza', '119160345', 'tonysolano08@gmail.com', '6027-3086', UNHEX(MD5('123456')), '2025-09-22 08:00:00'),
-- Dueños para Local 1 (K001-K005)
('Roberto Castro Salas', '109870321', 'roberto.castro@sodacr.com', '8987-6543', UNHEX(MD5('123456')), '2025-09-23 09:00:00'),
('Laura Méndez Rojas', '208760432', 'laura.mendez@boutiquecr.com', '8876-5432', UNHEX(MD5('123456')), '2025-09-23 09:00:00'),
('Javier Solís Pérez', '307650543', 'javier.solis@cafecr.com', '8765-4321', UNHEX(MD5('123456')), '2025-09-23 09:00:00'),
('Sofia Ramírez Chaves', '406540654', 'sofia.ramirez@techcr.com', '8654-3210', UNHEX(MD5('123456')), '2025-09-23 09:00:00'),
('Diego González Herrera', '505430765', 'diego.gonzalez@libroscr.com', '8543-2109', UNHEX(MD5('123456')), '2025-09-23 09:00:00'),
-- Dueños para Local 2 (K006-K011)
('Gabriela Morales Castro', '604320876', 'gabriela.morales@deportecr.com', '8432-1098', UNHEX(MD5('123456')), '2025-09-24 09:00:00'),
('Andrés Navarro Segura', '703210987', 'andres.navarro@joyascr.com', '8321-0987', UNHEX(MD5('123456')), '2025-09-24 09:00:00'),
('María Rodríguez Vega', '802101098', 'maria.rodriguez@artecr.com', '8210-9876', UNHEX(MD5('123456')), '2025-09-24 09:00:00'),
('Carlos Vargas Mora', '901090109', 'carlos.vargas@musica.cr.com', '8109-8765', UNHEX(MD5('123456')), '2025-09-24 09:00:00'),
('Ana Fernández Jiménez', '100980210', 'ana.fernandez@belleza.cr.com', '8098-7654', UNHEX(MD5('123456')), '2025-09-24 09:00:00'),
('Pablo Chacón Ríos', '110870321', 'pablo.chacon@electronica.cr.com', '7987-6543', UNHEX(MD5('123456')), '2025-09-24 09:00:00'),
-- Dueños para Local 3 (K012-K015)
('Elena Soto Díaz', '120760432', 'elena.soto@decoracion.cr.com', '7876-5432', UNHEX(MD5('123456')), '2025-09-25 09:00:00'),
('Miguel Ángel Blanco', '130650543', 'miguel.blanco@jugueteria.cr.com', '7765-4321', UNHEX(MD5('123456')), '2025-09-25 09:00:00'),
('Carmen Núñez López', '140540654', 'carmen.nunez@zapateria.cr.com', '7654-3210', UNHEX(MD5('123456')), '2025-09-25 09:00:00'),
('Ricardo Mora Castro', '150430765', 'ricardo.mora@deportes.cr.com', '7543-2109', UNHEX(MD5('123456')), '2025-09-25 09:00:00');

-- CONTRATOS
INSERT INTO contratos (idKiosko, idUsuarioA, idUsuarioC, fechaInicial, fechaFinal, tarifaVentas, estadoContrato) VALUES
-- local 1
(1, 1, 2, '2025-09-23 00:00:00', '2025-12-31 23:59:59', 12.50, 'Activo'),  -- K001 - Roberto
(2, 1, 3, '2025-09-23 00:00:00', '2025-12-31 23:59:59', 15.00, 'Activo'),  -- K002 - Laura
(3, 1, 4, '2025-09-23 00:00:00', '2025-12-31 23:59:59', 10.00, 'Activo'),  -- K003 - Javier
(4, 1, 5, '2025-09-23 00:00:00', '2025-12-31 23:59:59', 14.00, 'Activo'),  -- K004 - Sofia
(5, 1, 6, '2025-09-23 00:00:00', '2025-12-31 23:59:59', 11.50, 'Activo'), -- K005 - Diego
-- local 2
(6, 1, 7, '2025-09-24 00:00:00', '2025-12-31 23:59:59', 9.50, 'Activo'),   -- K006 - Gabriela
(7, 1, 8, '2025-09-24 00:00:00', '2025-12-31 23:59:59', 8.75, 'Activo'),   -- K007 - Andrés
(8, 1, 9, '2025-09-24 00:00:00', '2025-12-31 23:59:59', 11.25, 'Activo'), -- K008 - María
(9, 1, 10, '2025-09-24 00:00:00', '2025-12-31 23:59:59', 10.00, 'Activo'), -- K009 - Carlos
(10, 1, 11, '2025-09-24 00:00:00', '2025-12-31 23:59:59', 9.00, 'Activo'), -- K010 - Ana
(11, 1, 12, '2025-09-24 00:00:00', '2025-12-31 23:59:59', 12.00, 'Activo'),-- K011 - Pablo
-- local 3
(12, 1, 13, '2025-09-25 00:00:00', '2025-12-31 23:59:59', 16.50, 'Activo'), -- K012 - Elena
(13, 1, 14, '2025-09-25 00:00:00', '2025-12-31 23:59:59', 14.75, 'Activo'), -- K013 - Miguel
(14, 1, 15, '2025-09-25 00:00:00', '2025-12-31 23:59:59', 13.25, 'Activo'), -- K014 - Carmen
(15, 1, 16, '2025-09-25 00:00:00', '2025-12-31 23:59:59', 15.00, 'Activo'); -- K015 - Ricardo

-- KIOSKOS X CONTRATOS
INSERT INTO kioskosxcontratos (idKiosko, idContrato) VALUES
-- Local 1
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
-- Local 2
(6, 6), (7, 7), (8, 8), (9, 9), (10, 10), (11, 11),
-- Local 3
(12, 12), (13, 13), (14, 14), (15, 15);

-- PRODUCTOS
INSERT INTO productos (idKiosko, nombre, barCode, descripcion, precioUnitario, stockActual, lastRestock) VALUES
-- K001
(1, 'Casado de Carne', '7501234567890', 'Plato típico con carne, arroz, frijoles, plátano y ensalada', 4500.00, 50, '2025-09-28 06:00:00'),
(1, 'Gallo Pinto', '7501234567891', 'Arroz con frijoles tradicional costarricense', 1800.00, 75, '2025-09-28 06:00:00'),
(1, 'Olla de Carne', '7501234567892', 'Sopa tradicional con carne y verduras', 3200.00, 40, '2025-09-28 06:00:00'),
(1, 'Refresco de Cas', '7501234567893', 'Bebida natural de cas costarricense', 1200.00, 100, '2025-09-28 06:00:00'),
(1, 'Tres Leches', '7501234567894', 'Postre tradicional costarricense', 1500.00, 30, '2025-09-28 06:00:00'),
-- K006
(6, 'Café Britt Premium', '7502345678901', 'Café gourmet costarricense 250g', 8500.00, 25, '2025-09-27 07:00:00'),
(6, 'Cappuccino Mediano', '7502345678902', 'Bebida de café con espuma de leche', 2200.00, 150, '2025-09-29 07:00:00'),
(6, 'Latte Vainilla', '7502345678903', 'Café latte con sabor a vainilla', 2500.00, 120, '2025-09-29 07:00:00'),
(6, 'Bagel con Queso', '7502345678904', 'Bagel tostado con queso crema', 1800.00, 40, '2025-09-28 07:00:00'),
(6, 'Brownie de Chocolate', '7502345678905', 'Brownie artesanal de chocolate', 1600.00, 35, '2025-09-28 07:00:00'),
-- K012
(12, 'Camiseta Algodón CR', '7503456789012', 'Camiseta 100% algodón con diseño CR', 12500.00, 60, '2025-09-25 09:00:00'),
(12, 'Sombrero Pinta', '7503456789013', 'Sombrero tradicional costarricense', 8500.00, 30, '2025-09-25 09:00:00'),
(12, 'Chaqueta Ligera', '7503456789014', 'Chaqueta para clima tropical', 35000.00, 20, '2025-09-25 09:00:00'),
(12, 'Bolso Típico', '7503456789015', 'Bolso artesanal con diseños CR', 18000.00, 25, '2025-09-25 09:00:00'),
(12, 'Pulsera Artesanal', '7503456789016', 'Pulsera hecha a mano con semillas', 6500.00, 50, '2025-09-25 09:00:00');

-- ROLES
INSERT INTO roles (tipo, descripcion) VALUES
('Administrador', 'Gestionar contratos, inversiones, gastos, cuentas por cobrar y reportes globales'),
('Inquilino', 'Gestionar inventario, ventas y reportes relacionados con su propio negocio');

-- PERMISOS
INSERT INTO permisos (nombre, codigo) VALUES
-- PERMISOS ADMIN
('Gestionar Contratos', 'CTR_MGT'),
('Gestionar Inversiones', 'INV_MGT'),
('Gestionar Gastos Globales', 'EXP_MGT'),
('Gestionar Cuentas por Cobrar', 'REC_MGT'),
('Ver Reportes Globales', 'REP_GLOBAL'),
('Gestionar Usuarios', 'USR_MGT'),
('Gestionar Kioskos', 'KIO_MGT'),
('Gestionar Locales', 'LCL_MGT'),
('Gestionar Alquileres', 'RENT_MGT'),
('Gestionar Tarifas de Venta', 'FEE_MGT'),
-- PERMISOS INQUILINO
('Gestionar Inventario Propio', 'INV_OWN'),
('Registrar Ventas Propias', 'SAL_OWN'), 
('Ver Reportes Propios', 'REP_OWN'),
('Gestionar Productos Propios', 'PROD_OWN'),
('Ver Pagos de Alquiler', 'RENT_VIEW'),
('Realizar Pagos de Alquiler', 'RENT_PAY'),
('Ver Tarifas de Venta', 'FEE_VIEW'),
('Pagar Tarifas de Venta', 'FEE_PAY');

-- PERMISOS X ROLES
INSERT INTO permisosxrol (idRol, idPermiso) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
(2, 11), (2, 12), (2, 13), (2, 14), (2, 15), (2, 16), (2, 17), (2, 18);

-- PERMISOS X USUARIOS
INSERT INTO permisosxusuarios (idUsuario, idPermiso) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
(2, 11), (2, 12), (2, 13), (2, 14), (2, 15), (2, 16), (2, 17), (2, 18),
(3, 11), (3, 12), (3, 13), (3, 14), (3, 15), (3, 16), (3, 17), (3, 18),
(4, 11), (4, 12), (4, 13), (4, 14), (4, 15), (4, 16), (4, 17), (4, 18),
(5, 11), (5, 12), (5, 13), (5, 14), (5, 15), (5, 16), (5, 17), (5, 18),
(6, 11), (6, 12), (6, 13), (6, 14), (6, 15), (6, 16), (6, 17), (6, 18),
(7, 11), (7, 12), (7, 13), (7, 14), (7, 15), (7, 16), (7, 17), (7, 18),
(8, 11), (8, 12), (8, 13), (8, 14), (8, 15), (8, 16), (8, 17), (8, 18),
(9, 11), (9, 12), (9, 13), (9, 14), (9, 15), (9, 16), (9, 17), (9, 18),
(10, 11), (10, 12), (10, 13), (10, 14), (10, 15), (10, 16), (10, 17), (10, 18),
(11, 11), (11, 12), (11, 13), (11, 14), (11, 15), (11, 16), (11, 17), (11, 18),
(12, 11), (12, 12), (12, 13), (12, 14), (12, 15), (12, 16), (12, 17), (12, 18),
(13, 11), (13, 12), (13, 13), (13, 14), (13, 15), (13, 16), (13, 17), (13, 18),
(14, 11), (14, 12), (14, 13), (14, 14), (14, 15), (14, 16), (14, 17), (14, 18),
(15, 11), (15, 12), (15, 13), (15, 14), (15, 15), (15, 16), (15, 17), (15, 18),
(16, 11), (16, 12), (16, 13), (16, 14), (16, 15), (16, 16), (16, 17), (16, 18);

-- ROLES X USUARIOS
INSERT INTO rolesxusuarios (idUsuario, idRol) VALUES
(1, 1),  -- Admin
(2, 2), (3, 2), (4, 2), (5, 2), (6, 2),   -- Dueños Local 1
(7, 2), (8, 2), (9, 2), (10, 2), (11, 2), (12, 2),  -- Dueños Local 2  
(13, 2), (14, 2), (15, 2), (16, 2);  -- Dueños Local 3

-- USUARIOS X KIOSKOS
INSERT INTO usuariosxkioskos (idKiosko, idUsuario) VALUES
-- Local 1
(1, 2), (2, 3), (3, 4), (4, 5), (5, 6),
-- Local 2  
(6, 7), (7, 8), (8, 9), (9, 10), (10, 11), (11, 12),
-- Local 3
(12, 13), (13, 14), (14, 15), (15, 16);

-- ALQUILERES MENSUALES
INSERT INTO Alquileres (idContrato, fechaInicio, fechaFinal, montoAlquiler, montoPagado, estadoPago) VALUES
-- Local 1
(1, '2025-09-23 00:00:00', '2025-10-23 23:59:59', 150000.00, 150000.00, 'Pagado'),
(2, '2025-09-23 00:00:00', '2025-10-23 23:59:59', 180000.00, 90000.00, 'Sin pagar'),
(3, '2025-09-23 00:00:00', '2025-10-23 23:59:59', 120000.00, 0.00, 'Sin pagar'),
(4, '2025-09-23 00:00:00', '2025-10-23 23:59:59', 160000.00, 160000.00, 'Pagado'),
(5, '2025-09-23 00:00:00', '2025-10-23 23:59:59', 140000.00, 70000.00, 'Sin pagar'),
-- Local 2
(6, '2025-09-24 00:00:00', '2025-10-24 23:59:59', 80000.00, 80000.00, 'Pagado'),
(7, '2025-09-24 00:00:00', '2025-10-24 23:59:59', 90000.00, 0.00, 'Sin pagar'),
(8, '2025-09-24 00:00:00', '2025-10-24 23:59:59', 75000.00, 75000.00, 'Pagado'),
(9, '2025-09-24 00:00:00', '2025-10-24 23:59:59', 95000.00, 47500.00, 'Sin pagar'),
(10, '2025-09-24 00:00:00', '2025-10-24 23:59:59', 85000.00, 85000.00, 'Pagado'),
(11, '2025-09-24 00:00:00', '2025-10-24 23:59:59', 88000.00, 0.00, 'Sin pagar'),
-- Local 3
(12, '2025-09-25 00:00:00', '2025-10-25 23:59:59', 200000.00, 100000.00, 'Sin pagar'),
(13, '2025-09-25 00:00:00', '2025-10-25 23:59:59', 190000.00, 190000.00, 'Pagado'),
(14, '2025-09-25 00:00:00', '2025-10-25 23:59:59', 170000.00, 170000.00, 'Pagado'),
(15, '2025-09-25 00:00:00', '2025-10-25 23:59:59', 210000.00, 0.00, 'Sin pagar');

-- PAGOS ALQUILERES MENSUALES
INSERT INTO PagosAlquiler (idUsuario, idAlquiler, descripcion, monto, pagoAntes, pagoDespues, postTime) VALUES
-- K001 - Pagado completo en 2 pagos
(2, 1, 'Abono inicial alquiler K001', 75000.00, 150000.00, 75000.00, '2025-09-23 10:00:00'),
(2, 1, 'Liquidación alquiler K001', 75000.00, 75000.00, 0.00, '2025-09-28 14:30:00'),
-- K002 - Abono parcial (sin pagar)
(3, 2, 'Abono parcial alquiler K002', 90000.00, 180000.00, 90000.00, '2025-09-25 11:20:00'),
-- K004 - Pagado completo en 1 pago
(5, 4, 'Pago completo alquiler K004', 160000.00, 160000.00, 0.00, '2025-09-24 09:45:00'),
-- K005 - Abono parcial (sin pagar)
(6, 5, 'Primer abono alquiler K005', 70000.00, 140000.00, 70000.00, '2025-09-26 16:15:00'),
-- K006 - Pagado completo en 2 pagos
(7, 6, 'Primer pago alquiler K006', 40000.00, 80000.00, 40000.00, '2025-09-24 09:00:00'),
(7, 6, 'Segundo pago alquiler K006', 40000.00, 40000.00, 0.00, '2025-09-29 10:30:00'),
-- K008 - Pagado completo en 1 pago
(9, 8, 'Pago total alquiler K008', 75000.00, 75000.00, 0.00, '2025-09-25 08:45:00'),
-- K009 - Abono parcial (sin pagar)
(10, 9, 'Abono inicial alquiler K009', 47500.00, 95000.00, 47500.00, '2025-09-27 15:20:00'),
-- K010 - Pagado completo en 3 pagos
(11, 10, 'Primer abono alquiler K010', 30000.00, 85000.00, 55000.00, '2025-09-24 10:00:00'),
(11, 10, 'Segundo abono alquiler K010', 25000.00, 55000.00, 30000.00, '2025-09-27 11:15:00'),
(11, 10, 'Tercer abono alquiler K010', 30000.00, 30000.00, 0.00, '2025-09-30 14:00:00'),
-- K012 - Abono parcial (sin pagar)
(13, 12, 'Primer abono alquiler K012', 100000.00, 200000.00, 100000.00, '2025-09-28 12:30:00'),
-- K013 - Pagado completo en 2 pagos
(14, 13, 'Primer pago alquiler K013', 95000.00, 190000.00, 95000.00, '2025-09-25 11:15:00'),
(14, 13, 'Segundo pago alquiler K013', 95000.00, 95000.00, 0.00, '2025-09-29 09:45:00'),
-- K014 - Pagado completo en 1 pago
(15, 14, 'Pago completo alquiler K014', 170000.00, 170000.00, 0.00, '2025-09-26 10:20:00');

-- GASTOS
INSERT INTO Gastos (idUsuario, idKiosko, nombre, descripcion, monto, fechaGasto) VALUES
-- K001
(2, 1, 'Electricidad K001', 'Consumo eléctrico refrigeración', 45000.00, '2025-09-08 14:30:00'),
-- K006
(7, 6, 'Electricidad K006', 'Consumo máquinas café y refrigeración', 38000.00, '2025-09-07 11:20:00'),
-- K001
(2, 1, 'Mantenimiento Refrigerador', 'Reparación equipo refrigeración', 85000.00, '2025-09-15 08:00:00'),
-- K006
(7, 6, 'Calibración Máquinas', 'Mantenimiento máquinas de café', 45000.00, '2025-09-18 10:30:00'),
-- K001
(2, 1, 'Insumos Cocina', 'Aceite, especias, condimentos', 28000.00, '2025-09-21 15:30:00'),
-- K012
(13, 12, 'Material Empaque', 'Bolsas, cajas, etiquetas', 18000.00, '2025-09-13 14:20:00'),
-- K012
(13, 12, 'Publicidad Instagram', 'Anuncios Instagram moda local', 22000.00, '2025-09-23 15:15:00');

-- DESCUENTOS
INSERT INTO Descuentos (nombre, codigo, descuento) VALUES
('Cliente Frecuente', 'CLFR', 15.00),
('Cupón Merkadit', 'CMRK', 20.00);


