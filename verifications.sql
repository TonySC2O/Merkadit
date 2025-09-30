-- =============================================
-- 13. VERIFICACIÓN SISTEMA DE ROLES
-- =============================================

SELECT '=== SISTEMA DE ROLES Y PERMISOS ===' AS '';

SELECT 'ROLES CREADOS:' AS '';
SELECT idRol, tipo, descripcion FROM roles;

SELECT 'PERMISOS POR ROL:' AS '';
SELECT 
    r.tipo AS 'Rol',
    GROUP_CONCAT(p.nombre ORDER BY p.nombre) AS 'Permisos'
FROM roles r
JOIN permisosxrol pr ON r.idRol = pr.idRol
JOIN permisos p ON pr.idPermiso = p.idPermiso
GROUP BY r.idRol;

SELECT 'USUARIOS Y SUS ROLES:' AS '';
SELECT 
    u.nombre AS 'Usuario',
    u.email,
    r.tipo AS 'Rol'
FROM usuarios u
JOIN rolesxusuarios ru ON u.idUsuario = ru.idUsuario
JOIN roles r ON ru.idRol = r.idRol
ORDER BY r.tipo, u.nombre;

SELECT 'ACCESO USUARIOS A KIOSKOS:' AS '';
SELECT 
    u.nombre AS 'Usuario',
    k.codigo AS 'Kiosko',
    l.nombre AS 'Local',
    e.nombre AS 'Edificio'
FROM usuariosxkioskos uk
JOIN usuarios u ON uk.idUsuario = u.idUsuario
JOIN kioskos k ON uk.idKiosko = k.idKiosko
JOIN locales l ON k.idLocal = l.idLocal
JOIN edificios e ON l.idEdificio = e.idEdificio
ORDER BY e.nombre, l.nombre, k.codigo;

-- =============================================
-- 15. VERIFICACIÓN COMPLETA DEL SISTEMA DE PAGOS
-- =============================================

SELECT '=== VERIFICACIÓN COMPLETA SISTEMA DE ALQUILERES ===' AS '';

SELECT 'RESUMEN GENERAL DE PAGOS:' AS '';
SELECT 
    COUNT(*) AS 'Total Alquileres',
    SUM(CASE WHEN estadoPago = 'Pagado' THEN 1 ELSE 0 END) AS 'Alquileres Pagados',
    SUM(CASE WHEN estadoPago = 'Sin pagar' AND montoPagado > 0 THEN 1 ELSE 0 END) AS 'Alquileres con Pagos Parciales',
    SUM(CASE WHEN estadoPago = 'Sin pagar' AND montoPagado = 0 THEN 1 ELSE 0 END) AS 'Alquileres Sin Pagos'
FROM Alquileres;

SELECT 'DETALLE DE TRANSACCIONES POR KIOSKO:' AS '';
SELECT 
    k.codigo AS 'Kiosko',
    u.nombre AS 'Inquilino',
    CONCAT('₡', FORMAT(a.montoAlquiler, 2)) AS 'Alquiler Total',
    CONCAT('₡', FORMAT(a.montoPagado, 2)) AS 'Total Pagado',
    CONCAT('₡', FORMAT(a.montoAlquiler - a.montoPagado, 2)) AS 'Saldo Pendiente',
    a.estadoPago AS 'Estado',
    COUNT(pa.idPagoAlquiler) AS 'Transacciones',
    GROUP_CONCAT(CONCAT('₡', FORMAT(pa.monto, 2)) ORDER BY pa.postTime) AS 'Montos de Pagos'
FROM Alquileres a
JOIN contratos c ON a.idContrato = c.idContrato
JOIN kioskos k ON c.idKiosko = k.idKiosko
JOIN usuarios u ON c.idUsuarioC = u.idUsuario
LEFT JOIN PagosAlquiler pa ON a.idAlquiler = pa.idAlquiler
GROUP BY a.idAlquiler
ORDER BY k.codigo;

SELECT 'HISTORIAL DE PAGOS RECIENTES:' AS '';
SELECT 
    k.codigo AS 'Kiosko',
    u.nombre AS 'Inquilino',
    CONCAT('₡', FORMAT(pa.monto, 2)) AS 'Monto',
    pa.descripcion,
    DATE_FORMAT(pa.postTime, '%d/%m/%Y %H:%i') AS 'Fecha Pago',
    CONCAT('₡', FORMAT(pa.pagoAntes, 2)) AS 'Saldo Anterior',
    CONCAT('₡', FORMAT(pa.pagoDespues, 2)) AS 'Nuevo Saldo'
FROM PagosAlquiler pa
JOIN Alquileres a ON pa.idAlquiler = a.idAlquiler
JOIN contratos c ON a.idContrato = c.idContrato
JOIN kioskos k ON c.idKiosko = k.idKiosko
JOIN usuarios u ON pa.idUsuario = u.idUsuario
ORDER BY pa.postTime DESC
LIMIT 10;

-- =============================================
-- 19. VERIFICACIÓN RELACIÓN KIOSKOS-CONTRATOS
-- =============================================

SELECT '=== RELACIÓN KIOSKOS X CONTRATOS ===' AS '';

SELECT 'VERIFICACIÓN DE RELACIONES:' AS '';
SELECT 
    k.codigo AS 'Kiosko',
    c.idContrato AS 'Contrato',
    u_admin.nombre AS 'Administrador',
    u_tenant.nombre AS 'Inquilino',
    c.fechaInicial AS 'Inicio Contrato',
    c.fechaFinal AS 'Fin Contrato'
FROM kioskosxcontratos kc
JOIN kioskos k ON kc.idKiosko = k.idKiosko
JOIN contratos c ON kc.idContrato = c.idContrato
JOIN usuarios u_admin ON c.idUsuarioA = u_admin.idUsuario
JOIN usuarios u_tenant ON c.idUsuarioC = u_tenant.idUsuario
ORDER BY k.codigo;

SELECT 'RESUMEN DE RELACIONES:' AS '';
SELECT 
    COUNT(*) AS 'Total Relaciones',
    (SELECT COUNT(*) FROM kioskos) AS 'Total Kioskos',
    (SELECT COUNT(*) FROM contratos) AS 'Total Contratos',
    CASE 
        WHEN COUNT(*) = (SELECT COUNT(*) FROM kioskos) AND COUNT(*) = (SELECT COUNT(*) FROM contratos) 
        THEN 'Todas las relaciones están completas'
        ELSE 'Faltan relaciones por establecer'
    END AS 'Estado'
FROM kioskosxcontratos;

SELECT 'KIOSKOS SIN RELACIÓN (VERIFICACIÓN):' AS '';
SELECT k.codigo AS 'Kiosko Sin Relación'
FROM kioskos k
LEFT JOIN kioskosxcontratos kc ON k.idKiosko = kc.idKiosko
WHERE kc.idKiosko IS NULL;

SELECT 'CONTRATOS SIN RELACIÓN (VERIFICACIÓN):' AS '';
SELECT c.idContrato AS 'Contrato Sin Relación'
FROM contratos c
LEFT JOIN kioskosxcontratos kc ON c.idContrato = kc.idContrato
WHERE kc.idContrato IS NULL;