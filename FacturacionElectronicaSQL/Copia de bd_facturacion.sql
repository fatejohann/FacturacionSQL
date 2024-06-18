-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 16-06-2024 a las 21:21:08
-- Versión del servidor: 8.0.31
-- Versión de PHP: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_facturacion`
--
CREATE DATABASE IF NOT EXISTS `bd_facturacion` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `bd_facturacion`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_anulacion`
--

DROP TABLE IF EXISTS `t_anulacion`;
CREATE TABLE IF NOT EXISTS `t_anulacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idDocumento` int NOT NULL,
  `idTipoAnulacion` int NOT NULL,
  `codigoGeneracion` varchar(50) NOT NULL,
  `fechaAnulacion` date NOT NULL,
  `horaAnulacion` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_DocumentoFacturacion_2` (`idDocumento`),
  KEY `FK_TipoAnulacion_1` (`idTipoAnulacion`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_archivos`
--

DROP TABLE IF EXISTS `t_archivos`;
CREATE TABLE IF NOT EXISTS `t_archivos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int DEFAULT NULL,
  `idTipoArchivo` int DEFAULT NULL,
  `key` text,
  `rutaArchivo` text,
  `salt` text,
  PRIMARY KEY (`id`),
  KEY `FK_Archivos_1` (`idTipoArchivo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_autorizacion`
--

DROP TABLE IF EXISTS `t_autorizacion`;
CREATE TABLE IF NOT EXISTS `t_autorizacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idDocumentoFacturacion` int NOT NULL,
  `idTipoAutorizacion` int DEFAULT NULL,
  `estadoAutorizacion` int DEFAULT NULL,
  `key` text,
  `salt` text,
  `tipoAutorizacion` text,
  `idUsuarioAprobador` int DEFAULT NULL,
  `idUsuarioSolicitante` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_identificacion` (`idDocumentoFacturacion`),
  KEY `FK_Autorizacion_2` (`estadoAutorizacion`),
  KEY `FK_Usuario_8` (`idUsuarioAprobador`),
  KEY `FK_Usuario_9` (`idUsuarioSolicitante`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_bodega_sucursal`
--

DROP TABLE IF EXISTS `t_bodega_sucursal`;
CREATE TABLE IF NOT EXISTS `t_bodega_sucursal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` text,
  `idPersona` int NOT NULL,
  `latitud` double DEFAULT NULL,
  `longitud` double DEFAULT NULL,
  `direccion` text,
  `idMunicipio` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Persona_1` (`idPersona`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_cliente`
--

DROP TABLE IF EXISTS `t_cliente`;
CREATE TABLE IF NOT EXISTS `t_cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombreCliente` varchar(255) NOT NULL,
  `nombreComercial` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `nitDui` varchar(20) NOT NULL,
  `nrc` varchar(20) NOT NULL,
  `exentoIVA` int NOT NULL,
  `correoElectronico` varchar(255) NOT NULL,
  `idMunicipio` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Municipio_1` (`idMunicipio`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_cliente_giro_comercial`
--

DROP TABLE IF EXISTS `t_cliente_giro_comercial`;
CREATE TABLE IF NOT EXISTS `t_cliente_giro_comercial` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idCliente` int NOT NULL,
  `idGiroComercial` int NOT NULL,
  `principal` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Cliente_2` (`idCliente`),
  KEY `FK_GiroComercial_1` (`idGiroComercial`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_contabilidad`
--

DROP TABLE IF EXISTS `t_contabilidad`;
CREATE TABLE IF NOT EXISTS `t_contabilidad` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idPersona` int NOT NULL,
  `idUsuario` int NOT NULL,
  `estado` int DEFAULT NULL,
  `nombreContabilidad` text NOT NULL,
  `idTipoAproximacion` int NOT NULL,
  `idTipoMoneda` int NOT NULL,
  `cifrasSignificativas` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `estado` (`estado`),
  KEY `id_emisor` (`idPersona`),
  KEY `id_usuario` (`idUsuario`),
  KEY `FK_Contabilidad_4` (`idTipoAproximacion`),
  KEY `FK_Contabilidad_5` (`idTipoMoneda`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_contingencia`
--

DROP TABLE IF EXISTS `t_contingencia`;
CREATE TABLE IF NOT EXISTS `t_contingencia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idTipoContingencia` int NOT NULL,
  `observacionContingencia` varchar(500) NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFin` date NOT NULL,
  `horaInicio` time NOT NULL,
  `horaFin` time NOT NULL,
  `codigoGeneracion` varchar(50) DEFAULT NULL,
  `fechaTransmision` date DEFAULT NULL,
  `horaTransmision` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_TipoContingencia1` (`idTipoContingencia`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_correlativos_documentos`
--

DROP TABLE IF EXISTS `t_correlativos_documentos`;
CREATE TABLE IF NOT EXISTS `t_correlativos_documentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idTipoDocumento` int NOT NULL,
  `correlativo` int NOT NULL,
  `idPersona` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Persona_3` (`idPersona`),
  KEY `FK_TipoDocumentoFacturacion_1` (`idTipoDocumento`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_departamento`
--

DROP TABLE IF EXISTS `t_departamento`;
CREATE TABLE IF NOT EXISTS `t_departamento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigoDepartamento` varchar(20) NOT NULL,
  `nombreDepartamento` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_departamento`
--

INSERT INTO `t_departamento` (`id`, `codigoDepartamento`, `nombreDepartamento`) VALUES
(1, '01', 'Ahuachapán'),
(2, '02', 'Santa Ana'),
(3, '03', 'Sonsonate'),
(4, '04', 'Chalatenango'),
(5, '05', 'La Libertad'),
(6, '06', 'San Salvador'),
(7, '07', 'Cuscatlán'),
(8, '08', 'La Paz'),
(9, '09', 'Cabañas'),
(10, '10', 'San Vicente'),
(11, '11', 'Usulután'),
(12, '12', 'San Miguel'),
(13, '13', 'Morazán'),
(14, '14', 'La Unión');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_detalle_documento_facturacion`
--

DROP TABLE IF EXISTS `t_detalle_documento_facturacion`;
CREATE TABLE IF NOT EXISTS `t_detalle_documento_facturacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idDocumentoFacturacion` int NOT NULL,
  `noLinea` int NOT NULL,
  `cantidad` decimal(8,4) NOT NULL,
  `idProductoServicio` int NOT NULL,
  `precioSinIVA` decimal(14,4) NOT NULL,
  `porcentajeDescuento` decimal(4,2) NOT NULL,
  `valorDescuento` decimal(14,4) NOT NULL,
  `subTotalExentas` decimal(14,4) NOT NULL,
  `subTotalNoSujetas` decimal(14,4) NOT NULL,
  `subTotalGravadas` decimal(14,4) NOT NULL,
  `ivaDetalle` decimal(14,4) NOT NULL,
  `totalDetalle` decimal(14,4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_DocumentoFacturacion_1` (`idDocumentoFacturacion`),
  KEY `FK_ProductoServicio_1` (`idProductoServicio`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_documento_facturacion`
--

DROP TABLE IF EXISTS `t_documento_facturacion`;
CREATE TABLE IF NOT EXISTS `t_documento_facturacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `noDocumento` varchar(50) NOT NULL,
  `fechaDocumento` date NOT NULL,
  `horaDocumento` time NOT NULL,
  `idEstadoDocumento` int NOT NULL,
  `idCliente` int NOT NULL,
  `totalVentasExentas` decimal(14,4) NOT NULL,
  `totalVentasNoSujetas` decimal(14,4) NOT NULL,
  `totalVentasGravadas` decimal(14,4) NOT NULL,
  `ivaDocumento` decimal(14,4) NOT NULL,
  `retencionIVA` decimal(14,4) NOT NULL,
  `totalDocumento` decimal(14,4) NOT NULL,
  `numeroControl` varchar(50) DEFAULT NULL,
  `codigoGeneracion` varchar(50) DEFAULT NULL,
  `clasificacionMsg` varchar(100) DEFAULT NULL,
  `codigoMsg` varchar(100) DEFAULT NULL,
  `descripcionMsg` varchar(1000) DEFAULT NULL,
  `idArchivoJson` int DEFAULT NULL,
  `idArchivoPDF` int DEFAULT NULL,
  `idTipoPago` int NOT NULL,
  `idPlazoPago` int NOT NULL,
  `idLote` int DEFAULT NULL,
  `idBodegaSucursal` int NOT NULL,
  `idUsuario` int NOT NULL,
  `subTotalVentas` decimal(14,4) DEFAULT NULL,
  `descuentoNoSujetas` decimal(14,4) DEFAULT NULL,
  `descuentoExentas` decimal(14,0) DEFAULT NULL,
  `descuentoGravadas` decimal(14,4) DEFAULT NULL,
  `porcentajeDescuento` decimal(14,0) DEFAULT NULL,
  `totalDescuentos` decimal(14,4) DEFAULT NULL,
  `subTotal` decimal(14,4) DEFAULT NULL,
  `ivaPercibido` decimal(14,4) DEFAULT NULL,
  `retencionRenta` decimal(14,4) DEFAULT NULL,
  `montoTotalOperacion` decimal(14,4) DEFAULT NULL,
  `totalNoGravado` decimal(14,4) DEFAULT NULL,
  `totalPagar` decimal(14,4) DEFAULT NULL,
  `totalLetras` varchar(500) DEFAULT NULL,
  `totalIva` decimal(14,4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_BodegaSucursal_1` (`idBodegaSucursal`),
  KEY `FK_Cliente_1` (`idCliente`),
  KEY `FK_EstadoDocumento_1` (`idEstadoDocumento`),
  KEY `FK_Lote1` (`idLote`),
  KEY `FK_PlazoPagos_1` (`idPlazoPago`),
  KEY `FK_TipoPago_1` (`idTipoPago`),
  KEY `FK_Usuario_7` (`idUsuario`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_errores`
--

DROP TABLE IF EXISTS `t_errores`;
CREATE TABLE IF NOT EXISTS `t_errores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ambiente` varchar(25) DEFAULT NULL,
  `descripcion` text,
  `nombreError` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_estado_autorizacion`
--

DROP TABLE IF EXISTS `t_estado_autorizacion`;
CREATE TABLE IF NOT EXISTS `t_estado_autorizacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  `tipoAutorizacion` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_estado_autorizacion`
--

INSERT INTO `t_estado_autorizacion` (`id`, `descripcion`, `tipoAutorizacion`) VALUES
(1, 'Estado solicitado', 'Solicitado'),
(2, 'Estado Autorizado', 'Autorizado'),
(3, 'Estado Rechazado', 'Rechazado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_estado_documento`
--

DROP TABLE IF EXISTS `t_estado_documento`;
CREATE TABLE IF NOT EXISTS `t_estado_documento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_estado_documento`
--

INSERT INTO `t_estado_documento` (`id`, `nombre`) VALUES
(1, 'Ingresado'),
(2, 'Procesado'),
(3, 'Anulado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_estado_usuario`
--

DROP TABLE IF EXISTS `t_estado_usuario`;
CREATE TABLE IF NOT EXISTS `t_estado_usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  `estadoUsuario` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_estado_usuario`
--

INSERT INTO `t_estado_usuario` (`id`, `descripcion`, `estadoUsuario`) VALUES
(1, 'Usuarios activos', 'Activo'),
(2, 'Usuarios inactivos', 'Inactivo'),
(3, 'Usuarios en Proceso', 'Proceso'),
(4, 'Usuarios Suspendidos', 'Suspendido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_giro_comercial`
--

DROP TABLE IF EXISTS `t_giro_comercial`;
CREATE TABLE IF NOT EXISTS `t_giro_comercial` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigoGiro` varchar(10) NOT NULL,
  `nombreGiro` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=772 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_giro_comercial`
--

INSERT INTO `t_giro_comercial` (`id`, `codigoGiro`, `nombreGiro`) VALUES
(1, '01111', 'Cultivo de cereales excepto arroz y para forrajes'),
(2, '01112', 'Cultivo de legumbres'),
(3, '01113', 'Cultivo de semillas oleaginosas'),
(4, '01114', 'Cultivo de plantas para la preparación de semillas'),
(5, '01119', 'Cultivo de otros cereales excepto arroz y forrajeros n.c.p.'),
(6, '01120', 'Cultivo de arroz'),
(7, '01131', 'Cultivo de raíces y tubérculos'),
(8, '01132', 'Cultivo de brotes, bulbos, vegetales tubérculos y cultivos similares'),
(9, '01133', 'Cultivo hortícola de fruto'),
(10, '01134', 'Cultivo de hortalizas de hoja y otras hortalizas ncp'),
(11, '01140', 'Cultivo de caña de azúcar'),
(12, '01150', 'Cultivo de tabaco'),
(13, '01161', 'Cultivo de algodón'),
(14, '01162', 'Cultivo de fibras vegetales excepto algodón'),
(15, '01191', 'Cultivo de plantas no perennes para la producción de semillas y flores'),
(16, '01192', 'Cultivo de cereales y pastos para la alimentación animal'),
(17, '01199', 'Producción de cultivos no estacionales ncp'),
(18, '01220', 'Cultivo de frutas tropicales'),
(19, '01230', 'Cultivo de cítricos'),
(20, '01240', 'Cultivo de frutas de pepita y hueso'),
(21, '01251', 'Cultivo de frutas ncp'),
(22, '01252', 'Cultivo de otros frutos y nueces de árboles y arbustos'),
(23, '01260', 'Cultivo de frutos oleaginosos'),
(24, '01271', 'Cultivo de café'),
(25, '01272', 'Cultivo de plantas para la elaboración de bebidas excepto café'),
(26, '01281', 'Cultivo de especias y aromáticas'),
(27, '01282', 'Cultivo de plantas para la obtención de productos medicinales y farmacéuticos'),
(28, '01291', 'Cultivo de árboles de hule (caucho) para la obtención de látex'),
(29, '01292', 'Cultivo de plantas para la obtención de productos químicos y colorantes'),
(30, '01299', 'Producción de cultivos perennes ncp'),
(31, '01300', 'Propagación de plantas'),
(32, '01301', 'Cultivo de plantas y flores ornamentales'),
(33, '01410', 'Cría y engorde de ganado bovino'),
(34, '01420', 'Cría de caballos y otros equinos'),
(35, '01440', 'Cría de ovejas y cabras'),
(36, '01450', 'Cría de cerdos'),
(37, '01460', 'Cría de aves de corral y producción de huevos'),
(38, '01491', 'Cría de abejas apicultura para la obtención de miel y otros'),
(39, '01492', 'Cría de conejos'),
(40, '01493', 'Cría de iguanas y garrobos'),
(41, '01494', 'Cría de mariposas y otros insectos'),
(42, '01499', 'Cría y obtención de productos animales n.c.p.'),
(43, '01500', 'Cultivo de productos agrícolas en combinación con la cría de'),
(44, '01611', 'Servicios de maquinaria agrícola'),
(45, '01612', 'Control de plagas'),
(46, '01613', 'Servicios de riego'),
(47, '01614', 'Servicios de contratación de mano de obra para la agricultura'),
(48, '01619', 'Servicios agrícolas ncp'),
(49, '01621', 'Actividades para mejorar la reproducción, el crecimiento y el'),
(50, '01622', 'Servicios de mano de obra pecuaria'),
(51, '01629', 'Servicios pecuarios ncp'),
(52, '01631', 'Labores post cosecha de preparación de los productos agrícolas'),
(53, '01632', 'Servicio de beneficio de café'),
(54, '01633', 'Servicio de beneficiado de plantas textiles (incluye el beneficiado cuando este es realizado en la misma explotación agropecuaria)'),
(55, '01640', 'Tratamiento de semillas para la propagación'),
(56, '01700', 'Caza ordinaria y mediante trampas, repoblación de animales de caza y servicios conexos'),
(57, '02100', 'Silvicultura y otras actividades forestales'),
(58, '02200', 'Extracción de madera'),
(59, '02300', 'Recolección de productos diferentes a la madera'),
(60, '02400', 'Servicios de apoyo a la silvicultura'),
(61, '03110', 'Pesca marítima de altura y costera'),
(62, '03120', 'Pesca de agua dulce'),
(63, '03210', 'Acuicultura marítima'),
(64, '03220', 'Acuicultura de agua dulce'),
(65, '03300', 'Servicios de apoyo a la pesca y acuicultura'),
(66, '05100', 'Extracción de hulla'),
(67, '05200', 'Extracción y aglomeración de lignito'),
(68, '06100', 'Extracción de petróleo crudo'),
(69, '06200', 'Extracción de gas natural'),
(70, '07100', 'Extracción de minerales de hierro'),
(71, '07210', 'Extracción de minerales de uranio y torio'),
(72, '07290', 'Extracción de minerales metalíferos no ferrosos'),
(73, '08100', 'Extracción de piedra, arena y arcilla'),
(74, '08910', 'Extracción de minerales para la fabricación de abonos y productos químicos'),
(75, '08920', 'Extracción y aglomeración de turba'),
(76, '08930', 'Extracción de sal'),
(77, '08990', 'Explotación de otras minas y canteras ncp'),
(78, '09100', 'Actividades de apoyo a la extracción de petróleo y gas natural'),
(79, '09900', 'Actividades de apoyo a la explotación de minas y canteras'),
(80, '10101', 'Servicio de rastros y mataderos de bovinos y porcinos'),
(81, '10102', 'Matanza y procesamiento de bovinos y porcinos'),
(82, '10103', 'Matanza y procesamientos de aves de corral'),
(83, '10104', 'Elaboración y conservación de embutidos y tripas naturales'),
(84, '10105', 'Servicios de conservación y empaque de carnes'),
(85, '10106', 'Elaboración y conservación de grasas y aceites animales'),
(86, '10107', 'Servicios de molienda de carne'),
(87, '10108', 'Elaboración de productos de carne ncp'),
(88, '10201', 'Procesamiento y conservación de pescado, crustáceos y moluscos'),
(89, '10209', 'Fabricación de productos de pescado ncp'),
(90, '10301', 'Elaboración de jugos de frutas y hortalizasv'),
(91, '10302', 'Elaboración y envase de jaleas, mermeladas y frutas deshidratadas'),
(92, '10309', 'Elaboración de productos de frutas y hortalizas n.c.p.'),
(93, '10401', 'Fabricación de aceites y grasas vegetales y animales comestibles'),
(94, '10402', 'Fabricación de aceites y grasas vegetales y animales no comestibles'),
(95, '10409', 'Servicio de maquilado de aceites'),
(96, '10501', 'Fabricación de productos lácteos excepto sorbetes y quesos sustitutos'),
(97, '10502', 'Fabricación de sorbetes y helados'),
(98, '10503', 'Fabricación de quesos'),
(99, '10611', 'Molienda de cereales'),
(100, '10612', 'Elaboración de cereales para el desayuno y similares'),
(101, '10613', 'Servicios de beneficiado de productos agrícolas ncp (excluye Beneficio de azúcar rama 1072 y beneficio de café rama 0163)'),
(102, '10621', 'Fabricación de almidón'),
(103, '10628', 'Servicio de molienda de maíz húmedo molino para nixtamal'),
(104, '10711', 'Elaboración de tortillas'),
(105, '10712', 'Fabricación de pan, galletas y barquillos'),
(106, '10713', 'Fabricación de repostería'),
(107, '10721', 'Ingenios azucareros'),
(108, '10722', 'Molienda de caña de azúcar para la elaboración de dulces'),
(109, '10723', 'Elaboración de jarabes de azúcar y otros similares'),
(110, '10724', 'Maquilado de azúcar de caña'),
(111, '10730', 'Fabricación de cacao, chocolates y productos de confitería'),
(112, '10740', 'Elaboración de macarrones, fideos, y productos farináceos similares'),
(113, '10750', 'Elaboración de comidas y platos preparados para la reventa en locales y/o para exportación'),
(114, '10791', 'Elaboración de productos de café'),
(115, '10792', 'Elaboración de especies, sazonadores y condimentos'),
(116, '10793', 'Elaboración de sopas, cremas y consomé'),
(117, '10794', 'Fabricación de bocadillos tostados y/o fritos'),
(118, '10799', 'Elaboración de productos alimenticios ncp'),
(119, '10800', 'Elaboración de alimentos preparados para animales'),
(120, '11012', 'Fabricación de aguardiente y licores'),
(121, '11020', 'Elaboración de vinos'),
(122, '11030', 'Fabricación de cerveza'),
(123, '11041', 'Fabricación de aguas gaseosas'),
(124, '11042', 'Fabricación y envasado de agua'),
(125, '11043', 'Elaboración de refrescos'),
(126, '11048', 'Maquilado de aguas gaseosas'),
(127, '11049', 'Elaboración de bebidas no alcohólicas'),
(128, '12000', 'Elaboración de productos de tabaco'),
(129, '13111', 'Preparación de fibras textiles'),
(130, '13112', 'Fabricación de hilados'),
(131, '13120', 'Fabricación de telas'),
(132, '13130', 'Acabado de productos textiles'),
(133, '13910', 'Fabricación de tejidos de punto y ganchillo'),
(134, '13921', 'Fabricación de productos textiles para el hogar'),
(135, '13922', 'Sacos, bolsas y otros artículos textiles'),
(136, '13929', 'Fabricación de artículos confeccionados con materiales textiles, excepto prendas de vestir ncp'),
(137, '13930', 'Fabricación de tapices y alfombras'),
(138, '13941', 'Fabricación de cuerdas de henequén y otras fibras naturales (lazos, pitas)'),
(139, '13942', 'Fabricación de redes de diversos materiales'),
(140, '13948', 'Maquilado de productos trenzables de cualquier material (petates, sillas, etc.)'),
(141, '13991', 'Fabricación de adornos, etiquetas y otros artículos para prendas de vestir'),
(142, '13992', 'Servicio de bordados en artículos y prendas de tela'),
(143, '13999', 'Fabricación de productos textiles ncp'),
(144, '14101', 'Fabricación de ropa interior, para dormir y similares'),
(145, '14102', 'Fabricación de ropa para niños'),
(146, '14103', 'Fabricación de prendas de vestir para ambos sexos'),
(147, '14104', 'Confección de prendas a medida'),
(148, '14105', 'Fabricación de prendas de vestir para deportes'),
(149, '14106', 'Elaboración de artesanías de uso personal confeccionadas especialmente de materiales textiles'),
(150, '14108', 'Maquilado de prendas de vestir, accesorios y otros'),
(151, '14109', 'Fabricación de prendas y accesorios de vestir n.c.p.'),
(152, '14200', 'Fabricación de artículos de piel'),
(153, '14301', 'Fabricación de calcetines, calcetas, medias (panty house) y otros similares'),
(154, '14302', 'Fabricación de ropa interior de tejido de punto'),
(155, '14309', 'Fabricación de prendas de vestir de tejido de punto ncp'),
(156, '15110', 'Curtido y adobo de cueros; adobo y teñido de pieles'),
(157, '15121', 'Fabricación de maletas, bolsos de mano y otros artículos de marroquinería'),
(158, '15122', 'Fabricación de monturas, accesorios y vainas talabartería'),
(159, '15123', 'Fabricación de artesanías principalmente de cuero natural y sintético'),
(160, '15128', 'Maquilado de artículos de cuero natural, sintético y de otros materiales'),
(161, '15201', 'Fabricación de calzado'),
(162, '15202', 'Fabricación de partes y accesorios de calzado'),
(163, '15208', 'Maquilado de partes y accesorios de calzado'),
(164, '16100', 'Aserradero y acepilladura de madera'),
(165, '16210', 'Fabricación de madera laminada, terciada, enchapada y contrachapada, paneles para la construcción'),
(166, '16220', 'Fabricación de partes y piezas de carpintería para edificios y construcciones'),
(167, '16230', 'Fabricación de envases y recipientes de madera'),
(168, '16292', 'Fabricación de artesanías de madera, semillas, materiales trenzables'),
(169, '16299', 'Fabricación de productos de madera, corcho, paja y materiales trenzables ncp'),
(170, '17010', 'Fabricación de pasta de madera, papel y cartón'),
(171, '17020', 'Fabricación de papel y cartón ondulado y envases de papel y cartón'),
(172, '17091', 'Fabricación de artículos de papel y cartón de uso personal y doméstico'),
(173, '17092', 'Fabricación de productos de papel ncp'),
(174, '18110', 'Impresión'),
(175, '18120', 'Servicios relacionados con la impresión'),
(176, '18200', 'Reproducción de grabaciones'),
(177, '19100', 'Fabricación de productos de hornos de coque'),
(178, '19201', 'Fabricación de combustible'),
(179, '19202', 'Fabricación de aceites y lubricantes'),
(180, '20111', 'Fabricación de materias primas para la fabricación de colorantes'),
(181, '20112', 'Fabricación de materiales curtientes'),
(182, '20113', 'Fabricación de gases industriales'),
(183, '20114', 'Fabricación de alcohol etílico'),
(184, '20119', 'Fabricación de sustancias químicas básicas'),
(185, '20120', 'Fabricación de abonos y fertilizantes'),
(186, '20130', 'Fabricación de plástico y caucho en formas primarias'),
(187, '20210', 'Fabricación de plaguicidas y otros productos químicos de uso agropecuario'),
(188, '20220', 'Fabricación de pinturas, barnices y productos de revestimiento similares; tintas de imprenta y masillas'),
(189, '20231', 'Fabricación de jabones, detergentes y similares para limpieza'),
(190, '20232', 'Fabricación de perfumes, cosméticos y productos de higiene y cuidado personal, incluyendo tintes, champú, etc.'),
(191, '20291', 'Fabricación de tintas y colores para escribir y pintar; fabricación de cintas para impresoras'),
(192, '20292', 'Fabricación de productos pirotécnicos, explosivos y municiones'),
(193, '20299', 'Fabricación de productos químicos n.c.p.'),
(194, '20300', 'Fabricación de fibras artificiales'),
(195, '21001', 'Manufactura de productos farmacéuticos, sustancias químicas y productos botánicos'),
(196, '21008', 'Maquilado de medicamentos'),
(197, '22110', 'Fabricación de cubiertas y cámaras; renovación y recauchutado de cubiertas'),
(198, '22190', 'Fabricación de otros productos de caucho'),
(199, '22201', 'Fabricación de envases plásticos'),
(200, '22202', 'Fabricación de productos plásticos para uso personal o doméstico'),
(201, '22208', 'Maquila de plásticos'),
(202, '22209', 'Fabricación de productos plásticos n.c.p.'),
(203, '23101', 'Fabricación de vidrio'),
(204, '23102', 'Fabricación de recipientes y envases de vidrio'),
(205, '23108', 'Servicio de maquilado'),
(206, '23109', 'Fabricación de productos de vidrio ncp'),
(207, '23910', 'Fabricación de productos refractarios'),
(208, '23920', 'Fabricación de productos de arcilla para la construcción'),
(209, '23931', 'Fabricación de productos de cerámica y porcelana no refractaria'),
(210, '23932', 'Fabricación de productos de cerámica y porcelana ncp'),
(211, '23940', 'Fabricación de cemento, cal y yeso'),
(212, '23950', 'Fabricación de artículos de hormigón, cemento y yeso'),
(213, '23960', 'Corte, tallado y acabado de la piedra'),
(214, '23990', 'Fabricación de productos minerales no metálicos ncp'),
(215, '24100', 'Industrias básicas de hierro y acero'),
(216, '24200', 'Fabricación de productos primarios de metales preciosos y metales no ferrosos'),
(217, '24310', 'Fundición de hierro y acero'),
(218, '24320', 'Fundición de metales no ferrosos'),
(219, '25111', 'Fabricación de productos metálicos para uso estructural'),
(220, '25118', 'Servicio de maquila para la fabricación de estructuras metálicas'),
(221, '25120', 'Fabricación de tanques, depósitos y recipientes de metal'),
(222, '25130', 'Fabricación de generadores de vapor, excepto calderas de agua caliente para calefacción central'),
(223, '25200', 'Fabricación de armas y municiones'),
(224, '25910', 'Forjado, prensado, estampado y laminado de metales; pulvimetalurgia'),
(225, '25920', 'Tratamiento y revestimiento de metales'),
(226, '25930', 'Fabricación de artículos de cuchillería, herramientas de mano y artículos de ferretería'),
(227, '25991', 'Fabricación de envases y artículos conexos de metal'),
(228, '25992', 'Fabricación de artículos metálicos de uso personal y/o doméstico'),
(229, '25999', 'Fabricación de productos elaborados de metal ncp'),
(230, '26100', 'Fabricación de componentes electrónicos'),
(231, '26200', 'Fabricación de computadoras y equipo conexo'),
(232, '26300', 'Fabricación de equipo de comunicaciones'),
(233, '26400', 'Fabricación de aparatos electrónicos de consumo para audio, video radio y televisión'),
(234, '26510', 'Fabricación de instrumentos y aparatos para medir, verificar, ensayar, navegar y de control de procesos industriales'),
(235, '26520', 'Fabricación de relojes y piezas de relojes'),
(236, '26600', 'Fabricación de equipo médico de irradiación y equipo electrónico de uso médico y terapéutico'),
(237, '26700', 'Fabricación de instrumentos de óptica y equipo fotográfico'),
(238, '26800', 'Fabricación de medios magnéticos y ópticos'),
(239, '27100', 'Fabricación de motores, generadores, transformadores eléctricos, aparatos de distribución y control de electricidad'),
(240, '27200', 'Fabricación de pilas, baterías y acumuladores'),
(241, '27310', 'Fabricación de cables de fibra óptica'),
(242, '27320', 'Fabricación de otros hilos y cables eléctricos'),
(243, '27330', 'Fabricación de dispositivos de cableados'),
(244, '27400', 'Fabricación de equipo eléctrico de iluminación'),
(245, '27500', 'Fabricación de aparatos de uso doméstico'),
(246, '27900', 'Fabricación de otros tipos de equipo eléctrico'),
(247, '28110', 'Fabricación de motores y turbinas, excepto motores para aeronaves, vehículos automotores y motocicletas'),
(248, '28120', 'Fabricación de equipo hidráulico'),
(249, '28130', 'Fabricación de otras bombas, compresores, grifos y válvulas'),
(250, '28140', 'Fabricación de cojinetes, engranajes, trenes de engranajes y piezas de transmisión'),
(251, '28150', 'Fabricación de hornos y quemadores'),
(252, '28160', 'Fabricación de equipo de elevación y manipulación'),
(253, '28170', 'Fabricación de maquinaria y equipo de oficina'),
(254, '28180', 'Fabricación de herramientas manuales'),
(255, '28190', 'Fabricación de otros tipos de maquinaria de uso general'),
(256, '28210', 'Fabricación de maquinaria agropecuaria y forestal'),
(257, '28220', 'Fabricación de máquinas para conformar metales y maquinaria herramienta'),
(258, '28230', 'Fabricación de maquinaria metalúrgica'),
(259, '28240', 'Fabricación de maquinaria para la explotación de minas y canteras y para obras de construcción'),
(260, '28250', 'Fabricación de maquinaria para la elaboración de alimentos, bebidas y tabaco'),
(261, '28260', 'Fabricación de maquinaria para la elaboración de productos textiles, prendas de vestir y cueros'),
(262, '28291', 'Fabricación de máquinas para imprenta'),
(263, '28299', 'Fabricación de maquinaria de uso especial ncp'),
(264, '29100', 'Fabricación vehículos automotores'),
(265, '29200', 'Fabricación de carrocerías para vehículos automotores; fabricación de remolques y semiremolques'),
(266, '29300', 'Fabricación de partes, piezas y accesorios para vehículos automotores'),
(267, '30110', 'Fabricación de buques'),
(268, '30120', 'Construcción y reparación de embarcaciones de recreo'),
(269, '30200', 'Fabricación de locomotoras y de material rodante'),
(270, '30300', 'Fabricación de aeronaves y naves espaciales'),
(271, '30400', 'Fabricación de vehículos militares de combate'),
(272, '30910', 'Fabricación de motocicletas'),
(273, '30920', 'Fabricación de bicicletas y sillones de ruedas para inválidos'),
(274, '30990', 'Fabricación de equipo de transporte ncp'),
(275, '31001', 'Fabricación de colchones y somier'),
(276, '31002', 'Fabricación de muebles y otros productos de madera a medida'),
(277, '31008', 'Servicios de maquilado de muebles'),
(278, '31009', 'Fabricación de muebles ncp'),
(279, '32110', 'Fabricación de joyas platerías y joyerías'),
(280, '32120', 'Fabricación de joyas de imitación (fantasía) y artículos conexos'),
(281, '32200', 'Fabricación de instrumentos musicales'),
(282, '32301', 'Fabricación de artículos de deporte'),
(283, '32308', 'Servicio de maquila de productos deportivos'),
(284, '32401', 'Fabricación de juegos de mesa y de salón'),
(285, '32402', 'Servicio de maquilado de juguetes y juegos'),
(286, '32409', 'Fabricación de juegos y juguetes n.c.p.'),
(287, '32500', 'Fabricación de instrumentos y materiales médicos y odontológicos'),
(288, '32901', 'Fabricación de lápices, bolígrafos, sellos y artículos de librería en general'),
(289, '32902', 'Fabricación de escobas, cepillos, pinceles y similares'),
(290, '32903', 'Fabricación de artesanías de materiales diversos'),
(291, '32904', 'Fabricación de artículos de uso personal y domésticos n.c.p.'),
(292, '32905', 'Fabricación de accesorios para las confecciones y la marroquinería n.c.p.'),
(293, '32908', 'Servicios de maquila ncp'),
(294, '32909', 'Fabricación de productos manufacturados n.c.p.'),
(295, '33110', 'Reparación y mantenimiento de productos elaborados de metal'),
(296, '33120', 'Reparación y mantenimiento de maquinaria'),
(297, '33130', 'Reparación y mantenimiento de equipo electrónico y óptico'),
(298, '33140', 'Reparación y mantenimiento de equipo eléctrico'),
(299, '33150', 'Reparación y mantenimiento de equipo de transporte, excepto vehículos automotores'),
(300, '33190', 'Reparación y mantenimiento de equipos n.c.p.'),
(301, '33200', 'Instalación de maquinaria y equipo industrial'),
(302, '35101', 'Generación de energía eléctrica'),
(303, '35102', 'Transmisión de energía eléctrica'),
(304, '35103', 'Distribución de energía eléctrica'),
(305, '35200', 'Fabricación de gas, distribución de combustibles gaseosos por tuberías'),
(306, '35300', 'Suministro de vapor y agua caliente'),
(307, '36000', 'Captación, tratamiento y suministro de agua'),
(308, '37000', 'Evacuación de aguas residuales (alcantarillado)'),
(309, '38110', 'Recolección y transporte de desechos sólidos proveniente de hogares y sector urbano'),
(310, '38120', 'Recolección de desechos peligrosos'),
(311, '38210', 'Tratamiento y eliminación de desechos inicuos'),
(312, '38220', 'Tratamiento y eliminación de desechos peligrosos'),
(313, '38301', 'Reciclaje de desperdicios y desechos textiles'),
(314, '38302', 'Reciclaje de desperdicios y desechos de plástico y caucho'),
(315, '38303', 'Reciclaje de desperdicios y desechos de vidrio'),
(316, '38304', 'Reciclaje de desperdicios y desechos de papel y cartón'),
(317, '38305', 'Reciclaje de desperdicios y desechos metálicos'),
(318, '38309', 'Reciclaje de desperdicios y desechos no metálicos n.c.p.'),
(319, '39000', 'Actividades de Saneamiento y otros Servicios de Gestión de Desechos'),
(320, '41001', 'Construcción de edificios residenciales'),
(321, '41002', 'Construcción de edificios no residenciales'),
(322, '42100', 'Construcción de carreteras, calles y caminos'),
(323, '42200', 'Construcción de proyectos de servicio público'),
(324, '42900', 'Construcción de obras de ingeniería civil n.c.p.'),
(325, '43110', 'Demolición'),
(326, '43120', 'Preparación de terreno'),
(327, '43210', 'Instalaciones eléctricas'),
(328, '43220', 'Instalación de fontanería, calefacción y aire acondicionado'),
(329, '43290', 'Otras instalaciones para obras de construcción'),
(330, '43300', 'Terminación y acabado de edificios'),
(331, '43900', 'Otras actividades especializadas de construcción'),
(332, '43901', 'Fabricación de techos y materiales diversos'),
(333, '45100', 'Venta de vehículos automotores'),
(334, '45201', 'Reparación mecánica de vehículos automotores'),
(335, '45202', 'Reparaciones eléctricas del automotor y recarga de baterías'),
(336, '45203', 'Enderezado y pintura de vehículos automotores'),
(337, '45204', 'Reparaciones de radiadores, escapes y silenciadores'),
(338, '45205', 'Reparación y reconstrucción de vías, stop y otros artículos de fibra de vidrio'),
(339, '45206', 'Reparación de llantas de vehículos automotores'),
(340, '45207', 'Polarizado de vehículos (mediante la adhesión de papel especial a los vidrios)'),
(341, '45208', 'Lavado y pasteado de vehículos (carwash)'),
(342, '45209', 'Reparaciones de vehículos n.c.p.'),
(343, '45211', 'Remolque de vehículos automotores'),
(344, '45301', 'Venta de partes, piezas y accesorios nuevos para vehículos automotores'),
(345, '45302', 'Venta de partes, piezas y accesorios usados para vehículos automotores'),
(346, '45401', 'Venta de motocicletas'),
(347, '45402', 'Venta de repuestos, piezas y accesorios de motocicletas'),
(348, '45403', 'Mantenimiento y reparación de motocicletas'),
(349, '46100', 'Venta al por mayor a cambio de retribución o por contrata'),
(350, '46201', 'Venta al por mayor de materias primas agrícolas'),
(351, '46202', 'Venta al por mayor de productos de la silvicultura'),
(352, '46203', 'Venta al por mayor de productos pecuarios y de granja'),
(353, '46211', 'Venta de productos para uso agropecuario'),
(354, '46291', 'Venta al por mayor de granos básicos (cereales, leguminosas)'),
(355, '46292', 'Venta al por mayor de semillas mejoradas para cultivo'),
(356, '46293', 'Venta al por mayor de café oro y uva'),
(357, '46294', 'Venta al por mayor de caña de azúcar'),
(358, '46295', 'Venta al por mayor de flores, plantas y otros productos naturales'),
(359, '46296', 'Venta al por mayor de productos agrícolas'),
(360, '46297', 'Venta al por mayor de ganado bovino (vivo)'),
(361, '46298', 'Venta al por mayor de animales porcinos, ovinos, caprino, canículas, apícolas, avícolas vivos'),
(362, '46299', 'Venta de otras especies vivas del reino animal'),
(363, '46301', 'Venta al por mayor de alimentos'),
(364, '46302', 'Venta al por mayor de bebidas'),
(365, '46303', 'Venta al por mayor de tabaco'),
(366, '46371', 'Venta al por mayor de frutas, hortalizas (verduras), legumbres y tubérculos'),
(367, '46372', 'Venta al por mayor de pollos, gallinas destazadas, pavos y otras aves'),
(368, '46373', 'Venta al por mayor de carne bovina y porcina, productos de carne y embutidos'),
(369, '46374', 'Venta al por mayor de huevos'),
(370, '46375', 'Venta al por mayor de productos lácteos'),
(371, '46376', 'Venta al por mayor de productos farináceos de panadería (pan dulce, cakes, repostería, etc.)'),
(372, '46377', 'Venta al por mayor de pastas alimenticias, aceites y grasas comestibles vegetal y animal'),
(373, '46378', 'Venta al por mayor de sal comestible'),
(374, '46379', 'Venta al por mayor de azúcar'),
(375, '46391', 'Venta al por mayor de abarrotes (vinos, licores, productos alimenticios envasados, etc.)'),
(376, '46392', 'Venta al por mayor de aguas gaseosas'),
(377, '46393', 'Venta al por mayor de agua purificada'),
(378, '46394', 'Venta al por mayor de refrescos y otras bebidas, líquidas o en polvo'),
(379, '46395', 'Venta al por mayor de cerveza y licores'),
(380, '46396', 'Venta al por mayor de hielo'),
(381, '46411', 'Venta al por mayor de hilados, tejidos y productos textiles de mercería'),
(382, '46412', 'Venta al por mayor de artículos textiles excepto confecciones para el hogar'),
(383, '46413', 'Venta al por mayor de confecciones textiles para el hogar'),
(384, '46414', 'Venta al por mayor de prendas de vestir y accesorios de vestir'),
(385, '46415', 'Venta al por mayor de ropa usada'),
(386, '46416', 'Venta al por mayor de calzado'),
(387, '46417', 'Venta al por mayor de artículos de marroquinería y talabartería'),
(388, '46418', 'Venta al por mayor de artículos de peletería'),
(389, '46419', 'Venta al por mayor de otros artículos textiles n.c.p.'),
(390, '46471', 'Venta al por mayor de instrumentos musicales'),
(391, '46472', 'Venta al por mayor de colchones, almohadas, cojines, etc.'),
(392, '46473', 'Venta al por mayor de artículos de aluminio para el hogar y para otros usos'),
(393, '46474', 'Venta al por mayor de depósitos y otros artículos plásticos para el hogar y otros usos, incluyendo los desechables de durapax y no desechables'),
(394, '46475', 'Venta al por mayor de cámaras fotográficas, accesorios y materiales'),
(395, '46482', 'Venta al por mayor de medicamentos, artículos y otros productos de uso veterinario'),
(396, '46483', 'Venta al por mayor de productos y artículos de belleza y de uso personal'),
(397, '46484', 'Venta de productos farmacéuticos y medicinales'),
(398, '46491', 'Venta al por mayor de productos medicinales, cosméticos, perfumería y productos de limpieza'),
(399, '46492', 'Venta al por mayor de relojes y artículos de joyería'),
(400, '46493', 'Venta al por mayor de electrodomésticos y artículos del hogar excepto bazar; artículos de iluminación'),
(401, '46494', 'Venta al por mayor de artículos de bazar y similares'),
(402, '46495', 'Venta al por mayor de artículos de óptica'),
(403, '46496', 'Venta al por mayor de revistas, periódicos, libros, artículos de librería y artículos de papel y cartón en general'),
(404, '46497', 'Venta de artículos deportivos, juguetes y rodados'),
(405, '46498', 'Venta al por mayor de productos usados para el hogar o el uso personal'),
(406, '46499', 'Venta al por mayor de enseres domésticos y de uso personal n.c.p.'),
(407, '46500', 'Venta al por mayor de bicicletas, partes, accesorios y otros'),
(408, '46510', 'Venta al por mayor de computadoras, equipo periférico y programas informáticos'),
(409, '46520', 'Venta al por mayor de equipos de comunicación'),
(410, '46530', 'Venta al por mayor de maquinaria y equipo agropecuario, accesorios, partes y suministros'),
(411, '46590', 'Venta de equipos e instrumentos de uso profesional y científico y aparatos de medida y control'),
(412, '46591', 'Venta al por mayor de maquinaria equipo, accesorios y materiales para la industria de la madera y sus productos'),
(413, '46592', 'Venta al por mayor de maquinaria, equipo, accesorios y materiales para la industria gráfica y del papel, cartón y productos de papel y cartón'),
(414, '46593', 'Venta al por mayor de maquinaria, equipo, accesorios y materiales para la industria de productos químicos, plástico y caucho'),
(415, '46594', 'Venta al por mayor de maquinaria, equipo, accesorios y materiales para la industria metálica y de sus productos'),
(416, '46595', 'Venta al por mayor de equipamiento para uso médico, odontológico, veterinario y servicios conexos'),
(417, '46596', 'Venta al por mayor de maquinaria, equipo, accesorios y partes para la industria de la alimentación'),
(418, '46597', 'Venta al por mayor de maquinaria, equipo, accesorios y partes para la industria textil, confecciones y cuero'),
(419, '46598', 'Venta al por mayor de maquinaria, equipo y accesorios para la construcción y explotación de minas y canteras'),
(420, '46599', 'Venta al por mayor de otro tipo de maquinaria y equipo con sus accesorios y partes'),
(421, '46610', 'Venta al por mayor de otros combustibles sólidos, líquidos, gaseosos y de productos conexos'),
(422, '46612', 'Venta al por mayor de combustibles para automotores, aviones, barcos, maquinaria y otros'),
(423, '46613', 'Venta al por mayor de lubricantes, grasas y otros aceites para automotores, maquinaria industrial, etc.'),
(424, '46614', 'Venta al por mayor de gas propano'),
(425, '46615', 'Venta al por mayor de leña y carbón'),
(426, '46620', 'Venta al por mayor de metales y minerales metalíferos'),
(427, '46631', 'Venta al por mayor de puertas, ventanas, vitrinas y similares'),
(428, '46632', 'Venta al por mayor de artículos de ferretería y pinturerías'),
(429, '46633', 'Vidrierías'),
(430, '46634', 'Venta al por mayor de maderas'),
(431, '46639', 'Venta al por mayor de materiales para la construcción n.c.p.'),
(432, '46691', 'Venta al por mayor de sal industrial sin yodar'),
(433, '46692', 'Venta al por mayor de productos intermedios y desechos de origen textil'),
(434, '46693', 'Venta al por mayor de productos intermedios y desechos de origen metálico'),
(435, '46694', 'Venta al por mayor de productos intermedios y desechos de papel y cartón'),
(436, '46695', 'Venta al por mayor fertilizantes, abonos, agroquímicos y productos similares'),
(437, '46696', 'Venta al por mayor de productos intermedios y desechos de origen plástico'),
(438, '46697', 'Venta al por mayor de tintas para imprenta, productos curtientes y materias y productos colorantes'),
(439, '46698', 'Venta de productos intermedios y desechos de origen químico y de caucho'),
(440, '46699', 'Venta al por mayor de productos intermedios y desechos ncp'),
(441, '46701', 'Venta de algodón en oro'),
(442, '46900', 'Venta al por mayor de otros productos'),
(443, '46901', 'Venta al por mayor de cohetes y otros productos pirotécnicos'),
(444, '46902', 'Venta al por mayor de artículos diversos para consumo humano'),
(445, '46903', 'Venta al por mayor de armas de fuego, municiones y accesorios'),
(446, '46904', 'Venta al por mayor de toldos y tiendas de campaña de cualquier material'),
(447, '46905', 'Venta al por mayor de exhibidores publicitarios y rótulos'),
(448, '46906', 'Venta al por mayor de artículos promocionales diversos'),
(449, '47111', 'Venta en supermercados'),
(450, '47112', 'Venta en tiendas de artículos de primera necesidad'),
(451, '47119', 'Almacenes (venta de diversos artículos)'),
(452, '47190', 'Venta al por menor de otros productos en comercios no especializados'),
(453, '47199', 'Venta de establecimientos no especializados con surtido compuesto principalmente de alimentos, bebidas y tabaco'),
(454, '47211', 'Venta al por menor de frutas y hortalizas'),
(455, '47212', 'Venta al por menor de carnes, embutidos y productos de granja'),
(456, '47213', 'Venta al por menor de pescado y mariscos'),
(457, '47214', 'Venta al por menor de productos lácteos'),
(458, '47215', 'Venta al por menor de productos de panadería, repostería y galletas'),
(459, '47216', 'Venta al por menor de huevos'),
(460, '47217', 'Venta al por menor de carnes y productos cárnicos'),
(461, '47218', 'Venta al por menor de granos básicos y otros'),
(462, '47219', 'Venta al por menor de alimentos n.c.p.'),
(463, '47221', 'Venta al por menor de hielo'),
(464, '47223', 'Venta de bebidas no alcohólicas, para su consumo fuera del establecimiento'),
(465, '47224', 'Venta de bebidas alcohólicas, para su consumo fuera del establecimiento'),
(466, '47225', 'Venta de bebidas alcohólicas para su consumo dentro del establecimiento'),
(467, '47230', 'Venta al por menor de tabaco'),
(468, '47300', 'Venta de combustibles, lubricantes y otros (gasolineras)'),
(469, '47411', 'Venta al por menor de computadoras y equipo periférico'),
(470, '47412', 'Venta de equipo y accesorios de telecomunicación'),
(471, '47420', 'Venta al por menor de equipo de audio y video'),
(472, '47510', 'Venta al por menor de hilados, tejidos y productos textiles de mercería; confecciones para el hogar y textiles n.c.p.'),
(473, '47521', 'Venta al por menor de productos de madera'),
(474, '47522', 'Venta al por menor de artículos de ferretería'),
(475, '47523', 'Venta al por menor de productos de pinturerías'),
(476, '47524', 'Venta al por menor en vidrierías'),
(477, '47529', 'Venta al por menor de materiales de construcción y artículos conexos'),
(478, '47530', 'Venta al por menor de tapices, alfombras y revestimientos de paredes y pisos en comercios especializados'),
(479, '47591', 'Venta al por menor de muebles'),
(480, '47592', 'Venta al por menor de artículos de bazar'),
(481, '47593', 'Venta al por menor de aparatos electrodomésticos, repuestos y accesorios'),
(482, '47594', 'Venta al por menor de artículos eléctricos y de iluminación'),
(483, '47598', 'Venta al por menor de instrumentos musicales'),
(484, '47610', 'Venta al por menor de libros, periódicos y artículos de papelería en comercios especializados'),
(485, '47620', 'Venta al por menor de discos láser, cassettes, cintas de video y otros'),
(486, '47630', 'Venta al por menor de productos y equipos de deporte'),
(487, '47631', 'Venta al por menor de bicicletas, accesorios y repuestos'),
(488, '47640', 'Venta al por menor de juegos y juguetes en comercios especializados'),
(489, '47711', 'Venta al por menor de prendas de vestir y accesorios de vestir'),
(490, '47712', 'Venta al por menor de calzado'),
(491, '47713', 'Venta al por menor de artículos de peletería, marroquinería y talabartería'),
(492, '47721', 'Venta al por menor de medicamentos farmacéuticos y otros materiales y artículos de uso médico, odontológico y veterinario'),
(493, '47722', 'Venta al por menor de productos cosméticos y de tocador'),
(494, '47731', 'Venta al por menor de productos de joyería, bisutería, óptica, relojería'),
(495, '47732', 'Venta al por menor de plantas, semillas, animales y artículos conexos'),
(496, '47733', 'Venta al por menor de combustibles de uso doméstico (gas propano y gas licuado)'),
(497, '47734', 'Venta al por menor de artesanías, artículos cerámicos y recuerdos en general'),
(498, '47735', 'Venta al por menor de ataúdes, lápidas y cruces, trofeos, artículos religiosos en general'),
(499, '47736', 'Venta al por menor de armas de fuego, municiones y accesorios'),
(500, '47737', 'Venta al por menor de artículos de cohetería y pirotécnicos'),
(501, '47738', 'Venta al por menor de artículos desechables de uso personal y doméstico (servilletas, papel higiénico, pañales, toallas sanitarias, etc.)'),
(502, '47739', 'Venta al por menor de otros productos n.c.p.'),
(503, '47741', 'Venta al por menor de artículos usados'),
(504, '47742', 'Venta al por menor de textiles y confecciones usados'),
(505, '47743', 'Venta al por menor de libros, revistas, papel y cartón usados'),
(506, '47749', 'Venta al por menor de productos usados n.c.p.'),
(507, '47811', 'Venta al por menor de frutas, verduras y hortalizas'),
(508, '47814', 'Venta al por menor de productos lácteos'),
(509, '47815', 'Venta al por menor de productos de panadería, galletas y similares'),
(510, '47816', 'Venta al por menor de bebidas'),
(511, '47818', 'Venta al por menor en tiendas de mercado y puestos'),
(512, '47821', 'Venta al por menor de hilados, tejidos y productos textiles de mercería en puestos de mercados y ferias'),
(513, '47822', 'Venta al por menor de artículos textiles excepto confecciones para el hogar en puestos de mercados y ferias'),
(514, '47823', 'Venta al por menor de confecciones textiles para el hogar en puestos de mercados y ferias'),
(515, '47824', 'Venta al por menor de prendas de vestir, accesorios de vestir y similares en puestos de mercados y ferias'),
(516, '47825', 'Venta al por menor de ropa usada'),
(517, '47826', 'Venta al por menor de calzado, artículos de marroquinería y talabartería en puestos de mercados y ferias'),
(518, '47827', 'Venta al por menor de artículos de marroquinería y talabartería en puestos de mercados y ferias'),
(519, '47829', 'Venta al por menor de artículos textiles ncp en puestos de mercados y ferias'),
(520, '47891', 'Venta al por menor de animales, flores y productos conexos en puestos de feria y mercados'),
(521, '47892', 'Venta al por menor de productos medicinales, cosméticos, de tocador y de limpieza en puestos de ferias y mercados'),
(522, '47893', 'Venta al por menor de artículos de bazar en puestos de ferias y mercados'),
(523, '47894', 'Venta al por menor de artículos de papel, envases, libros, revistas y conexos en puestos de feria y mercados'),
(524, '47895', 'Venta al por menor de materiales de construcción, electrodomésticos, accesorios para autos y similares en puestos de feria y mercados'),
(525, '47896', 'Venta al por menor de equipos accesorios para las comunicaciones en puestos de feria y mercados'),
(526, '47899', 'Venta al por menor en puestos de ferias y mercados n.c.p.'),
(527, '47910', 'Venta al por menor por correo o Internet'),
(528, '47990', 'Otros tipos de venta al por menor no realizada, en almacenes, puestos de venta o mercado'),
(529, '49110', 'Transporte interurbano de pasajeros por ferrocarril'),
(530, '49120', 'Transporte de carga por ferrocarril'),
(531, '49211', 'Transporte de pasajeros urbanos e interurbano mediante buses'),
(532, '49212', 'Transporte de pasajeros interdepartamental mediante microbuses'),
(533, '49213', 'Transporte de pasajeros urbanos e interurbano mediante microbuses'),
(534, '49214', 'Transporte de pasajeros interdepartamental mediante buses'),
(535, '49221', 'Transporte internacional de pasajeros'),
(536, '49222', 'Transporte de pasajeros mediante taxis y autos con chofer'),
(537, '49223', 'Transporte escolar'),
(538, '49225', 'Transporte de pasajeros para excursiones'),
(539, '49226', 'Servicios de transporte de personal'),
(540, '49229', 'Transporte de pasajeros por vía terrestre ncp'),
(541, '49231', 'Transporte de carga urbano'),
(542, '49232', 'Transporte nacional de carga'),
(543, '49233', 'Transporte de carga internacional'),
(544, '49234', 'Servicios de mudanza'),
(545, '49235', 'Alquiler de vehículos de carga con conductor'),
(546, '49300', 'Transporte por oleoducto o gasoducto'),
(547, '50110', 'Transporte de pasajeros marítimo y de cabotaje'),
(548, '50120', 'Transporte de carga marítimo y de cabotaje'),
(549, '50211', 'Transporte de pasajeros por vías de navegación interiores'),
(550, '50212', 'Alquiler de equipo de transporte de pasajeros por vías de navegación interior con conductor'),
(551, '50220', 'Transporte de carga por vías de navegación interiores'),
(552, '51100', 'Transporte aéreo de pasajeros'),
(553, '51201', 'Transporte de carga por vía aérea'),
(554, '51202', 'Alquiler de equipo de aerotransporte con operadores para el propósito de transportar carga'),
(555, '52101', 'Alquiler de instalaciones de almacenamiento en zonas francas'),
(556, '52102', 'Alquiler de silos para conservación y almacenamiento de granos'),
(557, '52103', 'Alquiler de instalaciones con refrigeración para almacenamiento y conservación de alimentos y otros productos'),
(558, '52109', 'Alquiler de bodegas para almacenamiento y depósito n.c.p.'),
(559, '52211', 'Servicio de garaje y estacionamiento'),
(560, '52212', 'Servicios de terminales para el transporte por vía terrestre'),
(561, '52219', 'Servicios para el transporte por vía terrestre n.c.p.'),
(562, '52220', 'Servicios para el transporte acuático'),
(563, '52230', 'Servicios para el transporte aéreo'),
(564, '52240', 'Manipulación de carga'),
(565, '52290', 'Servicios para el transporte ncp'),
(566, '52291', 'Agencias de tramitaciones aduanales'),
(567, '53100', 'Servicios de correo nacional'),
(568, '53200', 'Actividades de correo distintas a las actividades postales nacionales'),
(569, '55101', 'Actividades de alojamiento para estancias cortas'),
(570, '55102', 'Hoteles'),
(571, '55200', 'Actividades de campamentos, parques de vehículos de recreo y parques de caravanas'),
(572, '55900', 'Alojamiento n.c.p.'),
(573, '56101', 'Restaurantes'),
(574, '56106', 'Pupusería'),
(575, '56107', 'Actividades varias de restaurantes'),
(576, '56108', 'Comedores'),
(577, '56109', 'Merenderos ambulantes'),
(578, '56210', 'Preparación de comida para eventos especiales'),
(579, '56291', 'Servicios de provisión de comidas por contrato'),
(580, '56292', 'Servicios de concesión de cafetines y chalet en empresas e instituciones'),
(581, '56299', 'Servicios de preparación de comidas ncp'),
(582, '56301', 'Servicio de expendio de bebidas en salones y bares'),
(583, '56302', 'Servicio de expendio de bebidas en puestos callejeros, mercados y ferias'),
(584, '58110', 'Edición de libros, folletos, partituras y otras ediciones distintas a estas'),
(585, '58120', 'Edición de directorios y listas de correos'),
(586, '58130', 'Edición de periódicos, revistas y otras publicaciones periódicas'),
(587, '58190', 'Otras actividades de edición'),
(588, '58200', 'Edición de programas informáticos (software)'),
(589, '59110', 'Actividades de producción cinematográfica'),
(590, '59120', 'Actividades de post producción de películas, videos y programas de televisión'),
(591, '59130', 'Actividades de distribución de películas cinematográficas, videos y programas de televisión'),
(592, '59140', 'Actividades de exhibición de películas cinematográficas y cintas de vídeo'),
(593, '59200', 'Actividades de edición y grabación de música'),
(594, '60100', 'Servicios de difusiones de radio'),
(595, '60201', 'Actividades de programación y difusión de televisión abierta'),
(596, '60202', 'Actividades de suscripción y difusión de televisión por cable y/o suscripción'),
(597, '60299', 'Servicios de televisión, incluye televisión por cable'),
(598, '60900', 'Programación y transmisión de radio y televisión'),
(599, '61101', 'Servicio de telefonía'),
(600, '61102', 'Servicio de Internet'),
(601, '61103', 'Servicio de telefonía fija'),
(602, '61109', 'Servicio de Internet n.c.p.'),
(603, '61201', 'Servicios de telefonía celular'),
(604, '61202', 'Servicios de Internet inalámbrico'),
(605, '61209', 'Servicios de telecomunicaciones inalámbrico n.c.p.'),
(606, '61301', 'Telecomunicaciones satelitales'),
(607, '61309', 'Comunicación vía satélite n.c.p.'),
(608, '61900', 'Actividades de telecomunicación n.c.p.'),
(609, '62010', 'Programación informática'),
(610, '62020', 'Consultorías y gestión de servicios informáticos'),
(611, '62090', 'Otras actividades de tecnología de información y servicios de computadora'),
(612, '63110', 'Procesamiento de datos y actividades relacionadas'),
(613, '63120', 'Portales WEB'),
(614, '63910', 'Servicios de Agencias de Noticias'),
(615, '63990', 'Otros servicios de información n.c.p.'),
(616, '64110', 'Servicios provistos por el Banco Central de El salvador'),
(617, '64190', 'Bancos'),
(618, '64192', 'Entidades dedicadas al envío de remesas'),
(619, '64199', 'Otras entidades financieras'),
(620, '64200', 'Actividades de sociedades de cartera'),
(621, '64300', 'Fideicomisos, fondos y otras fuentes de financiamiento'),
(622, '64910', 'Arrendamientos financieros'),
(623, '64920', 'Asociaciones cooperativas de ahorro y crédito dedicadas a la intermediación financiera'),
(624, '64921', 'Instituciones emisoras de tarjetas de crédito y otros'),
(625, '64922', 'Tipos de crédito ncp'),
(626, '64928', 'Prestamistas y casas de empeño'),
(627, '64990', 'Actividades de servicios financieros, excepto la financiación de planes de seguros y de pensiones n.c.p.'),
(628, '65110', 'Planes de seguros de vida'),
(629, '65120', 'Planes de seguro excepto de vida'),
(630, '65199', 'Seguros generales de todo tipo'),
(631, '65200', 'Planes se seguro'),
(632, '65300', 'Planes de pensiones'),
(633, '66110', 'Administración de mercados financieros (Bolsa de Valores)'),
(634, '66120', 'Actividades bursátiles (Corredores de Bolsa)'),
(635, '66190', 'Actividades auxiliares de la intermediación financiera ncp'),
(636, '66210', 'Evaluación de riesgos y daños'),
(637, '66220', 'Actividades de agentes y corredores de seguros'),
(638, '66290', 'Otras actividades auxiliares de seguros y fondos de pensiones'),
(639, '66300', 'Actividades de administración de fondos'),
(640, '68101', 'Servicio de alquiler y venta de lotes en cementerios'),
(641, '68109', 'Actividades inmobiliarias realizadas con bienes propios o arrendados n.c.p.'),
(642, '68200', 'Actividades Inmobiliarias Realizadas a Cambio de una Retribución o por Contrata'),
(643, '69100', 'Actividades jurídicas'),
(644, '69200', 'Actividades de contabilidad, teneduría de libros y auditoría; asesoramiento en materia de impuestos'),
(645, '70100', 'Actividades de oficinas centrales de sociedades de cartera'),
(646, '70200', 'Actividades de consultoría en gestión empresarial'),
(647, '71101', 'Servicios de arquitectura y planificación urbana y servicios conexos'),
(648, '71102', 'Servicios de ingeniería'),
(649, '71103', 'Servicios de agrimensura, topografía, cartografía, prospección y geofísica y servicios conexos'),
(650, '71200', 'Ensayos y análisis técnicos'),
(651, '72100', 'Investigaciones y desarrollo experimental en el campo de las ciencias naturales y la ingeniería'),
(652, '72199', 'Investigaciones científicas'),
(653, '72200', 'Investigaciones y desarrollo experimental en el campo de las ciencias sociales y las humanidades científica y desarrollo'),
(654, '73100', 'Publicidad'),
(655, '73200', 'Investigación de mercados y realización de encuestas de opinión pública'),
(656, '74100', 'Actividades de diseño especializado'),
(657, '74200', 'Actividades de fotografía'),
(658, '74900', 'Servicios profesionales y científicos ncp'),
(659, '75000', 'Actividades veterinarias'),
(660, '77101', 'Alquiler de equipo de transporte terrestre'),
(661, '77102', 'Alquiler de equipo de transporte acuático'),
(662, '77103', 'Alquiler de equipo de transporte por vía aérea'),
(663, '77210', 'Alquiler y arrendamiento de equipo de recreo y deportivo'),
(664, '77220', 'Alquiler de cintas de video y discos'),
(665, '77290', 'Alquiler de otros efectos personales y enseres domésticos'),
(666, '77300', 'Alquiler de maquinaria y equipo'),
(667, '77400', 'Arrendamiento de productos de propiedad intelectual'),
(668, '78100', 'Obtención y dotación de personal'),
(669, '78200', 'Actividades de las agencias de trabajo temporal'),
(670, '78300', 'Dotación de recursos humanos y gestión; gestión de las funciones de recursos humanos'),
(671, '79110', 'Actividades de agencias de viajes y organizadores de viajes; actividades de asistencia a turistas'),
(672, '79120', 'Actividades de los operadores turísticos'),
(673, '79900', 'Otros servicios de reservas y actividades relacionadas'),
(674, '80100', 'Servicios de seguridad privados'),
(675, '80201', 'Actividades de servicios de sistemas de seguridad'),
(676, '80202', 'Actividades para la prestación de sistemas de seguridad'),
(677, '80300', 'Actividades de investigación'),
(678, '81100', 'Actividades combinadas de mantenimiento de edificios e instalaciones'),
(679, '81210', 'Limpieza general de edificios'),
(680, '81290', 'Otras actividades combinadas de mantenimiento de edificios e instalaciones ncp'),
(681, '81300', 'Servicio de jardinería'),
(682, '82110', 'Servicios administrativos de oficinas'),
(683, '82190', 'Servicio de fotocopiado y similares, excepto en imprentas'),
(684, '82200', 'Actividades de las centrales de llamadas (call center)'),
(685, '82300', 'Organización de convenciones y ferias de negocios'),
(686, '82910', 'Actividades de agencias de cobro y oficinas de crédito'),
(687, '82921', 'Servicios de envase y empaque de productos alimenticios'),
(688, '82922', 'Servicios de envase y empaque de productos medicinales'),
(689, '82929', 'Servicio de envase y empaque ncp'),
(690, '82990', 'Actividades de apoyo empresariales ncp'),
(691, '84110', 'Actividades de la Administración Pública en general'),
(692, '84111', 'Alcaldías municipales'),
(693, '84120', 'Regulación de las actividades de prestación de servicios sanitarios, educativos, culturales y otros servicios sociales, excepto seguridad social'),
(694, '84130', 'Regulación y facilitación de la actividad económica'),
(695, '84210', 'Actividades de administración y funcionamiento del Ministerio de Relaciones Exteriores'),
(696, '84220', 'Actividades de defensa'),
(697, '84230', 'Actividades de mantenimiento del orden público y de seguridad'),
(698, '84300', 'Actividades de planes de seguridad social de afiliación obligatoria'),
(699, '85101', 'Guardería educativa'),
(700, '85102', 'Enseñanza preescolar o parvularia'),
(701, '85103', 'Enseñanza primaria'),
(702, '85104', 'Servicio de educación preescolar y primaria integrada'),
(703, '85211', 'Enseñanza secundaria tercer ciclo (7°, 8° y 9°)'),
(704, '85212', 'Enseñanza secundaria de formación general bachillerato'),
(705, '85221', 'Enseñanza secundaria de formación técnica y profesional'),
(706, '85222', 'Enseñanza secundaria de formación técnica y profesional integrada con enseñanza primaria'),
(707, '85301', 'Enseñanza superior universitaria'),
(708, '85302', 'Enseñanza superior no universitaria'),
(709, '85303', 'Enseñanza superior integrada a educación secundaria y/o primaria'),
(710, '85410', 'Educación deportiva y recreativa'),
(711, '85420', 'Educación cultural'),
(712, '85490', 'Otros tipos de enseñanza n.c.p.'),
(713, '85499', 'Enseñanza formal'),
(714, '85500', 'Servicios de apoyo a la enseñanza'),
(715, '86100', 'Actividades de hospitales'),
(716, '86201', 'Clínicas médicas'),
(717, '86202', 'Servicios de Odontología'),
(718, '86203', 'Servicios médicos'),
(719, '86901', 'Servicios de análisis y estudios de diagnóstico'),
(720, '86902', 'Actividades de atención de la salud humana'),
(721, '86909', 'Otros Servicio relacionados con la salud ncp'),
(722, '87100', 'Residencias de ancianos con atención de enfermería'),
(723, '87200', 'Instituciones dedicadas al tratamiento del retraso mental, problemas de salud mental y el uso indebido de sustancias nocivas'),
(724, '87300', 'Instituciones dedicadas al cuidado de ancianos y discapacitados');
INSERT INTO `t_giro_comercial` (`id`, `codigoGiro`, `nombreGiro`) VALUES
(725, '87900', 'Actividades de asistencia a niños y jóvenes'),
(726, '87901', 'Otras actividades de atención en instituciones'),
(727, '88100', 'Actividades de asistencia sociales sin alojamiento para ancianos y discapacitados'),
(728, '88900', 'Servicios sociales sin alojamiento ncp'),
(729, '90000', 'Actividades creativas artísticas y de esparcimiento'),
(730, '91010', 'Actividades de bibliotecas y archivos'),
(731, '91020', 'Actividades de museos y preservación de lugares y edificios históricos'),
(732, '91030', 'Actividades de jardines botánicos, zoológicos y de reservas naturales'),
(733, '92000', 'Actividades de juegos y apuestas'),
(734, '93110', 'Gestión de instalaciones deportivas'),
(735, '93120', 'Actividades de clubes deportivos'),
(736, '93190', 'Otras actividades deportivas'),
(737, '93210', 'Actividades de parques de atracciones y parques temáticos'),
(738, '93291', 'Discotecas y salas de baile'),
(739, '93298', 'Centros vacacionales'),
(740, '93299', 'Actividades de esparcimiento ncp'),
(741, '94110', 'Actividades de organizaciones empresariales y de empleadores'),
(742, '94120', 'Actividades de organizaciones profesionales'),
(743, '94200', 'Actividades de sindicatos'),
(744, '94910', 'Actividades de organizaciones religiosas'),
(745, '94920', 'Actividades de organizaciones políticas'),
(746, '94990', 'Actividades de asociaciones n.c.p.'),
(747, '95110', 'Reparación de computadoras y equipo periférico'),
(748, '95120', 'Reparación de equipo de comunicación'),
(749, '95210', 'Reparación de aparatos electrónicos de consumo'),
(750, '95220', 'Reparación de aparatos doméstico y equipo de hogar y jardín'),
(751, '95230', 'Reparación de calzado y artículos de cuero'),
(752, '95240', 'Reparación de muebles y accesorios para el hogar'),
(753, '95291', 'Reparación de Instrumentos musicales'),
(754, '95292', 'Servicios de cerrajería y copiado de llaves'),
(755, '95293', 'Reparación de joyas y relojes'),
(756, '95294', 'Reparación de bicicletas, sillas de ruedas y rodados n.c.p.'),
(757, '95299', 'Reparaciones de enseres personales n.c.p.'),
(758, '96010', 'Lavado y limpieza de prendas de tela y de piel, incluso la limpieza en seco'),
(759, '96020', 'Peluquería y otros tratamientos de belleza'),
(760, '96030', 'Pompas fúnebres y actividades conexas'),
(761, '96091', 'Servicios de sauna y otros servicios para la estética corporal n.c.p.'),
(762, '96092', 'Servicios n.c.p.'),
(763, '97000', 'Actividad de los hogares en calidad de empleadores de personal doméstico'),
(764, '98100', 'Actividades indiferenciadas de producción de bienes de los hogares privados para uso propio'),
(765, '98200', 'Actividades indiferenciadas de producción de servicios de los hogares privados para uso propio'),
(766, '99000', 'Actividades de organizaciones y órganos extraterritoriales'),
(767, '10001', 'Empleados'),
(768, '10002', 'Jubilado'),
(769, '10003', 'Estudiante'),
(770, '10004', 'Desempleado'),
(771, '10005', 'Otros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_impuesto`
--

DROP TABLE IF EXISTS `t_impuesto`;
CREATE TABLE IF NOT EXISTS `t_impuesto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigoImpuesto` varchar(10) NOT NULL,
  `nombreImpuesto` varchar(50) NOT NULL,
  `porcentajeImpuesto` decimal(14,4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_impuesto`
--

INSERT INTO `t_impuesto` (`id`, `codigoImpuesto`, `nombreImpuesto`, `porcentajeImpuesto`) VALUES
(1, 'IVA', 'Impuesto al Valor Agregado', '13.0000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_impuestos_por_producto`
--

DROP TABLE IF EXISTS `t_impuestos_por_producto`;
CREATE TABLE IF NOT EXISTS `t_impuestos_por_producto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idImpuesto` int NOT NULL,
  `idProductoServicio` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Impuesto_2` (`idImpuesto`),
  KEY `FK_ProductoServicio_2` (`idProductoServicio`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_impuesto_por_persona`
--

DROP TABLE IF EXISTS `t_impuesto_por_persona`;
CREATE TABLE IF NOT EXISTS `t_impuesto_por_persona` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idImpuesto` int NOT NULL,
  `idPersona` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Impuesto_1` (`idImpuesto`),
  KEY `FK_Persona_6` (`idPersona`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_log_cambios`
--

DROP TABLE IF EXISTS `t_log_cambios`;
CREATE TABLE IF NOT EXISTS `t_log_cambios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idRegistroConexion` int DEFAULT NULL,
  `nomTabla` text,
  `nomColumna` int DEFAULT NULL,
  `valorEnteroAnterior` text,
  `valorEnteroActual` text,
  `valorTextoAnterior` text,
  `valorTextoActual` text,
  `valorNumericoAnterior` text,
  `valorNumericoActual` text,
  `fechaModificacion` text,
  `horaModificacion` text,
  PRIMARY KEY (`id`),
  KEY `FK_LogCambios_1` (`idRegistroConexion`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_lotes`
--

DROP TABLE IF EXISTS `t_lotes`;
CREATE TABLE IF NOT EXISTS `t_lotes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigoEnvio` varchar(50) NOT NULL,
  `idTipoDocumento` int NOT NULL,
  `fechaLote` date DEFAULT NULL,
  `fechaProcesamiento` varchar(50) DEFAULT NULL,
  `codigoLote` varchar(50) DEFAULT NULL,
  `codigoMsg` varchar(100) DEFAULT NULL,
  `descripcionMsg` varchar(1000) DEFAULT NULL,
  `idContingencia` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Contingencia1` (`idContingencia`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_municipio`
--

DROP TABLE IF EXISTS `t_municipio`;
CREATE TABLE IF NOT EXISTS `t_municipio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigoMunicipio` varchar(20) NOT NULL,
  `nombreMunicipio` varchar(255) NOT NULL,
  `idDepartamento` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Departamento_1` (`idDepartamento`)
) ENGINE=MyISAM AUTO_INCREMENT=263 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_municipio`
--

INSERT INTO `t_municipio` (`id`, `codigoMunicipio`, `nombreMunicipio`, `idDepartamento`) VALUES
(1, '01', 'Ahuachapán', 1),
(2, '02', 'Apaneca', 1),
(3, '03', 'Atiquizaya', 1),
(4, '04', 'Concepción de Ataco', 1),
(5, '05', 'El Refugio', 1),
(6, '06', 'Guaymango', 1),
(7, '07', 'Jujutla', 1),
(8, '08', 'San Francisco Menéndez', 1),
(9, '09', 'San Lorenzo (Ahuachapán)', 1),
(10, '10', 'San Pedro Puxtla', 1),
(11, '11', 'Tacuba', 1),
(12, '12', 'Turín', 1),
(13, '01', 'Candelaria de la Frontera', 2),
(14, '02', 'Coatepeque', 2),
(15, '03', 'Chalchuapa', 2),
(16, '04', 'El Congo', 2),
(17, '05', 'El Porvenir', 2),
(18, '06', 'Masahuat', 2),
(19, '07', 'Metapán', 2),
(20, '08', 'San Antonio Pajonal', 2),
(21, '09', 'San Sebastián Salitrillo', 2),
(22, '10', 'Santa Ana', 2),
(23, '11', 'Santa Rosa Guachipilín', 2),
(24, '12', 'Santiago de la Frontera', 2),
(25, '13', 'Texistepeque', 2),
(26, '01', 'Acajutla', 3),
(27, '02', 'Armenia', 3),
(28, '03', 'Caluco', 3),
(29, '04', 'Cuisnahuat', 3),
(30, '05', 'Santa Isabel Ishuatán', 3),
(31, '06', 'Izalco', 3),
(32, '07', 'Juayúa', 3),
(33, '08', 'Nahuizalco', 3),
(34, '09', 'Nahulingo', 3),
(35, '10', 'Salcoatitán', 3),
(36, '11', 'San Antonio del Monte', 3),
(37, '12', 'San Julián', 3),
(38, '13', 'Santa Catarina Masahuat', 3),
(39, '14', 'Santo Domingo de Guzmán', 3),
(40, '15', 'Sonsonate', 3),
(41, '16', 'Sonzacate', 3),
(42, '01', 'Agua Caliente', 4),
(43, '02', 'Arcatao', 4),
(44, '03', 'Azacualpa', 4),
(45, '04', 'Citalá', 4),
(46, '05', 'Comapala', 4),
(47, '06', 'Concepción Quezaltepeque', 4),
(48, '07', 'Chalatenango', 4),
(49, '08', 'Dulce Nombre de María', 4),
(50, '09', 'El Carrizal', 4),
(51, '10', 'El Paraíso', 4),
(52, '11', 'La Laguna', 4),
(53, '12', 'La Palma', 4),
(54, '13', 'La Reina', 4),
(55, '14', 'Las Vueltas', 4),
(56, '15', 'Nombre de Jesús', 4),
(57, '16', 'Nueva Concepción', 4),
(58, '17', 'Nueva Trinidad', 4),
(59, '18', 'Ojos de Agua', 4),
(60, '19', 'Potonico', 4),
(61, '20', 'San Antonio de la Cruz', 4),
(62, '21', 'San Antonio Los Ranchos', 4),
(63, '22', 'San Fernando (Chalatenango)', 4),
(64, '23', 'San Francisco Lempa', 4),
(65, '24', 'San Francisco Morazán', 4),
(66, '25', 'San Ignacio', 4),
(67, '26', 'San Isidro Labrador', 4),
(68, '27', 'San Jose Cancasque', 4),
(69, '28', 'San Jose Flores', 4),
(70, '29', 'San Luis del Carmen', 4),
(71, '30', 'San Miguel de Mercedes', 4),
(72, '31', 'San Rafael', 4),
(73, '32', 'Santa Rita', 4),
(74, '33', 'Tejutla', 4),
(75, '01', 'Antiguo Cuscatlán', 5),
(76, '02', 'Ciudad Arce', 5),
(77, '03', 'Colón', 5),
(78, '04', 'Comasagua', 5),
(79, '05', 'Chiltiupán', 5),
(80, '06', 'Huizúcar', 5),
(81, '07', 'Jayaque', 5),
(82, '08', 'Jicalapa', 5),
(83, '09', 'La Libertad', 5),
(84, '10', 'Nuevo Cuscatlán', 5),
(85, '11', 'Santa Tecla', 5),
(86, '12', 'Quezaltepeque', 5),
(87, '13', 'Sacacoyo', 5),
(88, '14', 'San José Villanueva', 5),
(89, '15', 'San Juan Opico', 5),
(90, '16', 'San Matías', 5),
(91, '17', 'San Pablo Tacachico', 5),
(92, '18', 'Tamanique', 5),
(93, '19', 'Talnique', 5),
(94, '20', 'Teotepeque', 5),
(95, '21', 'Tepecoyo', 5),
(96, '22', 'Zaragoza', 5),
(97, '01', 'Aguilares', 6),
(98, '02', 'Apopa', 6),
(99, '03', 'Ayutuxtepeque', 6),
(100, '04', 'Cuscatancingo', 6),
(101, '05', 'El Paisnal', 6),
(102, '06', 'Guazapa', 6),
(103, '07', 'Ilopango', 6),
(104, '08', 'Mejicanos', 6),
(105, '09', 'Nejapa', 6),
(106, '10', 'Panchimalco', 6),
(107, '11', 'Rosario de Mora', 6),
(108, '12', 'San Marcos', 6),
(109, '13', 'San Martín', 6),
(110, '14', 'San Salvador', 6),
(111, '15', 'Santiago Texacuangos', 6),
(112, '16', 'Santo Tomás', 6),
(113, '17', 'Soyapango', 6),
(114, '18', 'Tonacatepeque', 6),
(115, '19', 'Ciudad Delgado', 6),
(116, '01', 'Candelaria', 7),
(117, '02', 'Cojutepeque', 7),
(118, '03', 'El Carmen (Cuscatlán)', 7),
(119, '04', 'El Rosario (Cuscatlán)', 7),
(120, '05', 'Monte San Juan', 7),
(121, '06', 'Oratorio de Concepción', 7),
(122, '07', 'San Bartolomé Perulapía', 7),
(123, '08', 'San Cristóbal', 7),
(124, '09', 'San José Guayabal', 7),
(125, '10', 'San Pedro Perulapán', 7),
(126, '11', 'San Rafael Cedros', 7),
(127, '12', 'San Ramón', 7),
(128, '13', 'Santa Cruz Analquito', 7),
(129, '14', 'Santa Cruz Michapa', 7),
(130, '15', 'Suchitoto', 7),
(131, '16', 'Tenancingo', 7),
(132, '01', 'Cuyultitán', 8),
(133, '02', 'El Rosario (La Paz)', 8),
(134, '03', 'Jerusalén', 8),
(135, '04', 'Mercedes La Ceiba', 8),
(136, '05', 'Olocuilta', 8),
(137, '06', 'Paraíso de Osorio', 8),
(138, '07', 'San Antonio Masahuat', 8),
(139, '08', 'San Emigdio', 8),
(140, '09', 'San Francisco Chinameca', 8),
(141, '10', 'San Juan Nonualco', 8),
(142, '11', 'San Juan Talpa', 8),
(143, '12', 'San Juan Tepezontes', 8),
(144, '13', 'San Luis Talpa', 8),
(145, '14', 'San Miguel Tepezontes', 8),
(146, '15', 'San Pedro Masahuat', 8),
(147, '16', 'San Pedro Nonualco', 8),
(148, '17', 'San Rafael Obrajuelo', 8),
(149, '18', 'Santa María Ostuma', 8),
(150, '19', 'Santiago Nonualco', 8),
(151, '20', 'Tapalhuaca', 8),
(152, '21', 'Zacatecoluca', 8),
(153, '22', 'San Luis La Herradura', 8),
(154, '01', 'Cinquera', 9),
(155, '02', 'Guacotecti', 9),
(156, '03', 'Ilobasco', 9),
(157, '04', 'Jutiapa', 9),
(158, '05', 'San Isidro (Cabañas)', 9),
(159, '06', 'Sensuntepeque', 9),
(160, '07', 'Tejutepeque', 9),
(161, '08', 'Victoria', 9),
(162, '09', 'Dolores', 9),
(163, '01', 'Apastepeque', 10),
(164, '02', 'Guadalupe', 10),
(165, '03', 'San Cayetano Istepeque', 10),
(166, '04', 'Santa Clara', 10),
(167, '05', 'Santo Domingo', 10),
(168, '06', 'San Esteban Catarina', 10),
(169, '07', 'San Ildefonso', 10),
(170, '08', 'San Lorenzo (San Vicente)', 10),
(171, '09', 'San Sebastián', 10),
(172, '10', 'San Vicente', 10),
(173, '11', 'Tecoluca', 10),
(174, '12', 'Tepetitán', 10),
(175, '13', 'Verapaz', 10),
(176, '01', 'Alegría', 11),
(177, '02', 'Berlín', 11),
(178, '03', 'California', 11),
(179, '04', 'Concepción Batres', 11),
(180, '05', 'El Triunfo', 11),
(181, '06', 'Ereguayquín', 11),
(182, '07', 'Estanzuelas', 11),
(183, '08', 'Jiquilisco', 11),
(184, '09', 'Jucuapa', 11),
(185, '10', 'Jucuarán', 11),
(186, '11', 'Mercedes Umaña', 11),
(187, '12', 'Nueva Granada', 11),
(188, '13', 'Ozatlán', 11),
(189, '14', 'Puerto El Triunfo', 11),
(190, '15', 'San Agustín', 11),
(191, '16', 'San Buenaventura', 11),
(192, '17', 'San Dionisio', 11),
(193, '18', 'Santa Elena', 11),
(194, '19', 'San Francisco Javier', 11),
(195, '20', 'Santa María', 11),
(196, '21', 'Santiago de María', 11),
(197, '22', 'Tecapán', 11),
(198, '23', 'Usulután', 11),
(199, '01', 'Carolina', 12),
(200, '02', 'Ciudad Barrios', 12),
(201, '03', 'Comacarán', 12),
(202, '04', 'Chapeltique', 12),
(203, '05', 'Chinameca', 12),
(204, '06', 'Chirilagua', 12),
(205, '07', 'El Tránsito', 12),
(206, '08', 'Lolotique', 12),
(207, '09', 'Moncagua', 12),
(208, '10', 'Nueva Guadalupe', 12),
(209, '11', 'Nuevo Edén de San Juan', 12),
(210, '12', 'Quelepa', 12),
(211, '13', 'San Antonio del Mosco', 12),
(212, '14', 'San Gerardo', 12),
(213, '15', 'San Jorge', 12),
(214, '16', 'San Luis de la Reina', 12),
(215, '17', 'San Miguel', 12),
(216, '18', 'San Rafael Oriente', 12),
(217, '19', 'Sesori', 12),
(218, '20', 'Uluazapa', 12),
(219, '01', 'Arambala', 13),
(220, '02', 'Cacaopera', 13),
(221, '03', 'Corinto', 13),
(222, '04', 'Chilanga', 13),
(223, '05', 'Delicias de Concepción', 13),
(224, '06', 'El Divisadero', 13),
(225, '07', 'El Rosario (Morazán)', 13),
(226, '08', 'Gualococti', 13),
(227, '09', 'Guatajiagua', 13),
(228, '10', 'Joateca', 13),
(229, '11', 'Jocoaitique', 13),
(230, '12', 'Jocoro', 13),
(231, '13', 'Lolotiquillo', 13),
(232, '14', 'Meanguera', 13),
(233, '15', 'Osicala', 13),
(234, '16', 'Perquín', 13),
(235, '17', 'San Carlos', 13),
(236, '18', 'San Fernando (Morazán)', 13),
(237, '19', 'San Francisco Gotera', 13),
(238, '20', 'San Isidro (Morazán)', 13),
(239, '21', 'San Simón', 13),
(240, '22', 'Sensembra', 13),
(241, '23', 'Sociedad', 13),
(242, '24', 'Torola', 13),
(243, '25', 'Yamabal', 13),
(244, '26', 'Yoloaiquín', 13),
(245, '01', 'Anamoros', 14),
(246, '02', 'Bolívar', 14),
(247, '03', 'Concepción de Oriente', 14),
(248, '04', 'Conchagua', 14),
(249, '05', 'El Carmen (La Unión)', 14),
(250, '06', 'El Sauce', 14),
(251, '07', 'Intipucá', 14),
(252, '08', 'La Unión', 14),
(253, '09', 'Lislique', 14),
(254, '10', 'Meanguera del Golfo', 14),
(255, '11', 'Nueva Esparta', 14),
(256, '12', 'Pasaquina', 14),
(257, '13', 'Polorós', 14),
(258, '14', 'San Alejo', 14),
(259, '15', 'San José', 14),
(260, '16', 'Santa Rosa de Lima', 14),
(261, '17', 'Yayantique', 14),
(262, '18', 'Yucuaiquín', 14);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_persona`
--

DROP TABLE IF EXISTS `t_persona`;
CREATE TABLE IF NOT EXISTS `t_persona` (
  `id` int NOT NULL AUTO_INCREMENT,
  `razonSocial` text NOT NULL,
  `nombreComercial` text NOT NULL,
  `nit` text,
  `nrc` text,
  `telefono` text,
  `correoElectronico` text,
  `idMunicipio` int NOT NULL,
  `direccion` text,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Municipio_2` (`idMunicipio`),
  KEY `FK_Usuario_4` (`idUsuario`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_persona_giro_comercial`
--

DROP TABLE IF EXISTS `t_persona_giro_comercial`;
CREATE TABLE IF NOT EXISTS `t_persona_giro_comercial` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idPersona` int NOT NULL,
  `idGiroComercial` int NOT NULL,
  `principal` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_GiroComercial_2` (`idGiroComercial`),
  KEY `FK_Persona_2` (`idPersona`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_plazo_pagos`
--

DROP TABLE IF EXISTS `t_plazo_pagos`;
CREATE TABLE IF NOT EXISTS `t_plazo_pagos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombrePlazo` varchar(50) NOT NULL,
  `diasPlazo` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_plazo_pagos`
--

INSERT INTO `t_plazo_pagos` (`id`, `nombrePlazo`, `diasPlazo`) VALUES
(1, 'Contado', 0),
(2, '30 dias', 30),
(3, '60 dias', 60),
(4, '90 dias', 90);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_producto_servicio`
--

DROP TABLE IF EXISTS `t_producto_servicio`;
CREATE TABLE IF NOT EXISTS `t_producto_servicio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` text NOT NULL,
  `nombreProducto` text NOT NULL,
  `descripcionProducto` text NOT NULL,
  `idUnidadMedida` int DEFAULT NULL,
  `idTipoItem` int NOT NULL,
  `esSujeto` bit(1) NOT NULL,
  `idPersona` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Persona_7` (`idPersona`),
  KEY `FK_TipoItem_1` (`idTipoItem`),
  KEY `FK_UnidadMedida_1` (`idUnidadMedida`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_registro_conexion`
--

DROP TABLE IF EXISTS `t_registro_conexion`;
CREATE TABLE IF NOT EXISTS `t_registro_conexion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `datosBajados` text,
  `datosSubidos` text,
  `fechaIngreso` text,
  `fechaSalida` text,
  `horaIngreso` text,
  `horaSalida` text,
  `idUsuario` int DEFAULT NULL,
  `ipUsuario` text,
  `nombreEquipo` text,
  `nombreRed` text,
  `proveedorInternet` text,
  `puertoIngreso` text,
  `puertoSalida` text,
  `serviciosConectados` text,
  `tipoRed` text,
  `idToken` int DEFAULT NULL,
  `ubicacion` text,
  PRIMARY KEY (`id`),
  KEY `FK_RegistroConexion_1` (`idUsuario`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_registro_errores`
--

DROP TABLE IF EXISTS `t_registro_errores`;
CREATE TABLE IF NOT EXISTS `t_registro_errores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fechaError` text,
  `horaError` text,
  `idError` int DEFAULT NULL,
  `idRegistroConexion` int DEFAULT NULL,
  `pantallaError` text,
  PRIMARY KEY (`id`),
  KEY `FK_RegistroErrores_1` (`idError`),
  KEY `FK_RegistroErrores_3` (`idRegistroConexion`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_registro_token`
--

DROP TABLE IF EXISTS `t_registro_token`;
CREATE TABLE IF NOT EXISTS `t_registro_token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tokenAnterior` text,
  `tokenActual` text,
  `fechaGeneracion` text,
  `idPersona` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Persona_4` (`idPersona`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_registro_token`
--

INSERT INTO `t_registro_token` (`id`, `tokenAnterior`, `tokenActual`, `fechaGeneracion`, `idPersona`) VALUES
(11, NULL, 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIwNjE0MjgwMzkwMTEyMSIsImF1dGhvcml0aWVzIjpbIlVTRVIiLCJVU0VSX0FQSSIsIlVzdWFyaW8iXSwiaWF0IjoxNzE4NTY5NzA4LCJleHAiOjE3MTg2NTYxMDh9.hlFtjTeUleypTPpaiAS5JJ9ctTRX8Qn6lR5ptTg9ldYU-XgMb_gSBWC3K1PF5QBkj2jUs5NP54Y0tIc52fgO-A', '2024-06-16 14:28:26.969', 1),
(9, NULL, 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIwNjE0MjgwMzkwMTEyMSIsImF1dGhvcml0aWVzIjpbIlVTRVIiLCJVU0VSX0FQSSIsIlVzdWFyaW8iXSwiaWF0IjoxNzE4NTEyMzc2LCJleHAiOjE3MTg1OTg3NzZ9.x-8CqlnJNmWaPeVedwoSycnyQTyC-URizfPC6vPI9CbhY3cczLruNb5bKxsvy6o79xOTRlK4wUFJuBUicZWQIw', '2024-06-14 22:32:55.060', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_anulacion`
--

DROP TABLE IF EXISTS `t_tipo_anulacion`;
CREATE TABLE IF NOT EXISTS `t_tipo_anulacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipoAnulacion` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_aproximacion`
--

DROP TABLE IF EXISTS `t_tipo_aproximacion`;
CREATE TABLE IF NOT EXISTS `t_tipo_aproximacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  `tipoAproximacion` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_tipo_aproximacion`
--

INSERT INTO `t_tipo_aproximacion` (`id`, `descripcion`, `tipoAproximacion`) VALUES
(1, 'Defecto', 'Defecto'),
(2, 'Exceso', 'Exceso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_archivo`
--

DROP TABLE IF EXISTS `t_tipo_archivo`;
CREATE TABLE IF NOT EXISTS `t_tipo_archivo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contenido` text,
  `descripcion` text,
  `tipoArchivo` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_contingencia`
--

DROP TABLE IF EXISTS `t_tipo_contingencia`;
CREATE TABLE IF NOT EXISTS `t_tipo_contingencia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipoContingencia` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_tipo_contingencia`
--

INSERT INTO `t_tipo_contingencia` (`id`, `tipoContingencia`) VALUES
(1, 'No disponibilidad de sistema del MH'),
(2, 'No disponibilidad de sistema del emisor'),
(3, 'Falla en el suministro de servicio de Internet del Emisor'),
(4, 'Falla en el suministro de servicio de energía eléctrica del emisor que impida la transmisión de los DTE'),
(5, 'Otro (deberá digitar un máximo de 500 caracteres explicando el motivo)');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_documento_facturacion`
--

DROP TABLE IF EXISTS `t_tipo_documento_facturacion`;
CREATE TABLE IF NOT EXISTS `t_tipo_documento_facturacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombreTipoDocumento` varchar(50) NOT NULL,
  `codigoTipoDocumento` varchar(5) NOT NULL,
  `abreviatura` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_tipo_documento_facturacion`
--

INSERT INTO `t_tipo_documento_facturacion` (`id`, `nombreTipoDocumento`, `codigoTipoDocumento`, `abreviatura`) VALUES
(1, 'Factura', '01', 'FC'),
(2, 'Comprobante de crédito fiscal', '03', 'CCF'),
(3, 'Nota de remisión', '04', 'NR'),
(4, 'Nota de crédito', '05', 'NC'),
(5, 'Nota de débito', '06', 'ND'),
(6, 'Comprobante de retención', '07', 'CR'),
(7, 'Comprobante de liquidación', '08', 'CL'),
(8, 'Documento contable de liquidación', '09', 'DCL'),
(9, 'Facturas de exportación', '11', 'FEX'),
(10, 'Factura de sujeto excluido', '14', 'FSE'),
(11, 'Comprobante de donación', '15', 'CD');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_item`
--

DROP TABLE IF EXISTS `t_tipo_item`;
CREATE TABLE IF NOT EXISTS `t_tipo_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_moneda`
--

DROP TABLE IF EXISTS `t_tipo_moneda`;
CREATE TABLE IF NOT EXISTS `t_tipo_moneda` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  `tipoMoneda` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_tipo_moneda`
--

INSERT INTO `t_tipo_moneda` (`id`, `descripcion`, `tipoMoneda`) VALUES
(1, 'Dolar', 'USD'),
(2, 'Quetzal', 'Q');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_pago`
--

DROP TABLE IF EXISTS `t_tipo_pago`;
CREATE TABLE IF NOT EXISTS `t_tipo_pago` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombreTipoPago` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_tipo_pago`
--

INSERT INTO `t_tipo_pago` (`id`, `nombreTipoPago`) VALUES
(1, 'Contado'),
(2, 'Credito');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_usuario`
--

DROP TABLE IF EXISTS `t_tipo_usuario`;
CREATE TABLE IF NOT EXISTS `t_tipo_usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descripcion` text,
  `tipoUsuario` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_tipo_usuario`
--

INSERT INTO `t_tipo_usuario` (`id`, `descripcion`, `tipoUsuario`) VALUES
(1, 'Usuario que configura y administra el sistema', 'Administrador'),
(2, 'Profesionales contadores con infinitas contabilidades disponibles', 'Contador'),
(3, 'Usuarios independientes de contadores con máximo de 5 contabilidades', 'Emprendedor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_unidad_medida`
--

DROP TABLE IF EXISTS `t_unidad_medida`;
CREATE TABLE IF NOT EXISTS `t_unidad_medida` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` int NOT NULL,
  `nombreUnidadMedida` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_unidad_medida`
--

INSERT INTO `t_unidad_medida` (`id`, `codigo`, `nombreUnidadMedida`) VALUES
(1, 1, 'Metro'),
(2, 2, 'Yarda'),
(3, 3, 'Vara'),
(4, 4, 'Pie'),
(5, 5, 'Pulgada'),
(6, 6, 'Milímetro'),
(7, 8, 'Milla cuadrada'),
(8, 9, 'Kilómetro cuadrado'),
(9, 10, 'Hectárea'),
(10, 11, 'Manzana'),
(11, 12, 'Acre'),
(12, 13, 'Metro cuadrado'),
(13, 14, 'Yarda cuadrada'),
(14, 15, 'Vara cuadrada'),
(15, 16, 'Pie cuadrado'),
(16, 17, 'Pulgada cuadrada'),
(17, 18, 'Metro cúbico'),
(18, 19, 'Yarda cúbica'),
(19, 20, 'Barril'),
(20, 21, 'Pie cúbico'),
(21, 22, 'Galón'),
(22, 23, 'Litro'),
(23, 24, 'Botella'),
(24, 25, 'Pulgada cúbica'),
(25, 26, 'Mililitro'),
(26, 27, 'Onza fluida'),
(27, 29, 'Tonelada métrica'),
(28, 30, 'Tonelada'),
(29, 31, 'Quintal métrico'),
(30, 32, 'Quintal'),
(31, 33, 'Arroba'),
(32, 34, 'Kilogramo'),
(33, 35, 'Libra troy'),
(34, 36, 'Libra'),
(35, 37, 'Onza troy'),
(36, 38, 'Onza'),
(37, 39, 'Gramo'),
(38, 40, 'Miligramo'),
(39, 42, 'Megawatt'),
(40, 43, 'Kilowatt'),
(41, 44, 'Watt'),
(42, 45, 'Megavoltio-amperio'),
(43, 46, 'Kilovoltio-amperio'),
(44, 47, 'Voltio-amperio'),
(45, 49, 'Gigawatt-hora'),
(46, 50, 'Megawatt-hora'),
(47, 51, 'Kilowatt-hora'),
(48, 52, 'Watt-hora'),
(49, 53, 'Kilovoltio'),
(50, 54, 'Voltio'),
(51, 55, 'Millar'),
(52, 56, 'Medio millar'),
(53, 57, 'Ciento'),
(54, 58, 'Docena'),
(55, 59, 'Unidad'),
(56, 99, 'Otra');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_usuario`
--

DROP TABLE IF EXISTS `t_usuario`;
CREATE TABLE IF NOT EXISTS `t_usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `antecedentesPenales` int DEFAULT NULL,
  `apellidos` text NOT NULL,
  `codContaduria` text,
  `codUsuario` text,
  `contrato` int DEFAULT NULL,
  `correo` text NOT NULL,
  `correoSecundario` text,
  `credencialCVCP` int DEFAULT NULL,
  `dui` text,
  `fechaCreacion` text,
  `fechaInicio` text,
  `fechaFin` text,
  `idArchivo` int DEFAULT NULL,
  `idEstado` int DEFAULT NULL,
  `idDireccion` int DEFAULT NULL,
  `idTipoUsuario` int DEFAULT NULL,
  `ipUsuario` text,
  `llave` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `nit` text,
  `nombre` text NOT NULL,
  `nrc` text NOT NULL,
  `salt` text,
  `solvenciaPNC` int DEFAULT NULL,
  `telefono` text,
  PRIMARY KEY (`id`),
  KEY `id_direccion` (`idDireccion`),
  KEY `FK_Usuario_1` (`antecedentesPenales`),
  KEY `FK_Usuario_2` (`contrato`),
  KEY `FK_Usuario_3` (`credencialCVCP`),
  KEY `FK_Usuario_5` (`idEstado`),
  KEY `FK_Usuario_6` (`idTipoUsuario`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `t_usuario`
--

INSERT INTO `t_usuario` (`id`, `antecedentesPenales`, `apellidos`, `codContaduria`, `codUsuario`, `contrato`, `correo`, `correoSecundario`, `credencialCVCP`, `dui`, `fechaCreacion`, `fechaInicio`, `fechaFin`, `idArchivo`, `idEstado`, `idDireccion`, `idTipoUsuario`, `ipUsuario`, `llave`, `nit`, `nombre`, `nrc`, `salt`, `solvenciaPNC`, `telefono`) VALUES
(1, NULL, 'Diaz Luz', NULL, 'Luis09', NULL, 'luis@gmail.com', 'luis2@gmail.com', NULL, '25968475-6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2b$08$HMCNEM7PbghtQd1uH5lBKOcQqy3c.wqdkK.U0fhuOwk9i5aAcd8gS', NULL, 'Luis Alberto', '', NULL, NULL, NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
