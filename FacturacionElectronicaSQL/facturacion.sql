-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-06-2024 a las 22:47:03
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `facturacion`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_anulacion`
--

CREATE TABLE `t_anulacion` (
  `ID` int(11) NOT NULL,
  `IDDOCUMENTO` int(11) NOT NULL,
  `IDTIPOANULACION` int(11) NOT NULL,
  `CODIGOGENERACION` varchar(50) NOT NULL,
  `FECHAANULACION` date NOT NULL,
  `HORAANULACION` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_archivos`
--

CREATE TABLE `t_archivos` (
  `ID` int(11) NOT NULL,
  `IDUSUARIO` int(11) DEFAULT NULL,
  `IDTIPOARCHIVO` int(11) DEFAULT NULL,
  `LLAVE` longtext DEFAULT NULL,
  `RUTAARCHIVO` longtext DEFAULT NULL,
  `SALT` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_cliente`
--

CREATE TABLE `t_cliente` (
  `ID` int(11) NOT NULL,
  `NOMBRECLIENTE` varchar(255) NOT NULL,
  `NOMBRECOMERCIAL` varchar(255) DEFAULT NULL,
  `DIRECCION` varchar(255) NOT NULL,
  `TELEFONO` varchar(255) NOT NULL,
  `NITDUI` varchar(20) NOT NULL,
  `NRC` varchar(20) NOT NULL,
  `EXENTOIVA` int(11) NOT NULL,
  `CORREOELECTRONICO` varchar(255) NOT NULL,
  `IDMUNICIPIO` int(11) DEFAULT NULL,
  `IDGIROCOMERCIAL` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_contabilidad`
--

CREATE TABLE `t_contabilidad` (
  `ID` int(11) NOT NULL,
  `IDEMISOR` int(11) DEFAULT NULL,
  `IDUSUARIO` int(11) DEFAULT NULL,
  `ESTADO` int(11) DEFAULT NULL,
  `NOMBRECONTABILIDAD` longtext DEFAULT NULL,
  `TIPOAPROXIMACION` int(11) DEFAULT NULL,
  `TIPOMONEDA` int(11) DEFAULT NULL,
  `CIFRASSIGNIFICATIVAS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_contingencia`
--

CREATE TABLE `t_contingencia` (
  `ID` int(11) NOT NULL,
  `IDTIPOCONTINGENCIA` int(11) NOT NULL,
  `OBSERVACIONCONTINGENCIA` varchar(500) NOT NULL,
  `FECHAINICIO` date NOT NULL,
  `FECHAFIN` date NOT NULL,
  `HORAINICIO` time NOT NULL,
  `HORAFIN` time NOT NULL,
  `CODIGOGENERACION` varchar(50) DEFAULT NULL,
  `FECHATRANSMISION` date DEFAULT NULL,
  `HORATRANSMISION` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_departamento`
--

CREATE TABLE `t_departamento` (
  `ID` int(11) NOT NULL,
  `CODIGODEPARTAMENTO` varchar(20) NOT NULL,
  `NOMBREDEPARTAMENTO` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_detalle_documento_facturacion`
--

CREATE TABLE `t_detalle_documento_facturacion` (
  `ID` int(11) NOT NULL,
  `IDDOCUMENTOFACTURACION` int(11) NOT NULL,
  `NOLINEA` int(11) NOT NULL,
  `CANTIDAD` decimal(8,4) NOT NULL,
  `IDPRODUCTOSERVICIO` int(11) NOT NULL,
  `PRECIOSINIVA` decimal(14,4) NOT NULL,
  `PORCENTAJEDESCUENTO` decimal(4,2) NOT NULL,
  `VALORDESCUENTO` decimal(14,4) NOT NULL,
  `SUBTOTALEXENTAS` decimal(14,4) NOT NULL,
  `SUBTOTALNOSUJETAS` decimal(14,4) NOT NULL,
  `SUBTOTALGRAVADAS` decimal(14,4) NOT NULL,
  `IVADETALLE` decimal(14,4) NOT NULL,
  `TOTALDETALLE` decimal(14,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_documento_facturacion`
--

CREATE TABLE `t_documento_facturacion` (
  `ID` int(11) NOT NULL,
  `NODOCUMENTO` varchar(50) NOT NULL,
  `FECHADOCUMENTO` date NOT NULL,
  `HORADOCUMENTO` time NOT NULL,
  `IDESTADODOCUMENTO` int(11) NOT NULL,
  `IDCLIENTE` int(11) NOT NULL,
  `TOTALVENTASEXENTAS` decimal(14,4) NOT NULL,
  `TOTALVENTASNOSUJETAS` decimal(14,4) NOT NULL,
  `TOTALVENTASGRAVADAS` decimal(14,4) NOT NULL,
  `IVADOCUMENTO` decimal(14,4) NOT NULL,
  `RETENCIONIVA` decimal(14,4) NOT NULL,
  `TOTALDOCUMENTO` decimal(14,4) NOT NULL,
  `NUMEROCONTROL` varchar(50) DEFAULT NULL,
  `CODIGOGENERACION` varchar(50) DEFAULT NULL,
  `CLASIFICACIONMSG` varchar(100) DEFAULT NULL,
  `CODIGOMSG` varchar(100) DEFAULT NULL,
  `DESCRIPCIONMSG` varchar(1000) DEFAULT NULL,
  `IDARCHIVOJSON` int(11) DEFAULT NULL,
  `IDARCHIVOPDF` int(11) DEFAULT NULL,
  `IDTIPOPAGO` int(11) NOT NULL,
  `IDPLAZOPAGO` int(11) NOT NULL,
  `IDLOTE` int(11) DEFAULT NULL,
  `IDUSUARIO` int(11) NOT NULL,
  `IDEMISOR` int(11) NOT NULL,
  `IDTIPODOCUMENTO` int(11) NOT NULL,
  `COLUMN_26` char(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_emisor`
--

CREATE TABLE `t_emisor` (
  `ID` int(11) NOT NULL,
  `RAZONSOCIAL` longtext NOT NULL,
  `NOMBRECOMERCIAL` longtext NOT NULL,
  `NIT` longtext DEFAULT NULL,
  `NRC` longtext DEFAULT NULL,
  `TELEFONO` longtext DEFAULT NULL,
  `CORREOELECTRONICO` longtext DEFAULT NULL,
  `IDMUNICIPIO` int(11) NOT NULL,
  `DIRECCION` longtext DEFAULT NULL,
  `IDUSUARIO` int(11) DEFAULT NULL,
  `IDGIROCOMERCIAL` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_errores`
--

CREATE TABLE `t_errores` (
  `ID` int(11) NOT NULL,
  `AMBIENTE` varchar(25) DEFAULT NULL,
  `DESCRIPCION` longtext DEFAULT NULL,
  `NOMBREERROR` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_estado_documento`
--

CREATE TABLE `t_estado_documento` (
  `ID` int(11) NOT NULL,
  `NOMBRE` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_giro_comercial`
--

CREATE TABLE `t_giro_comercial` (
  `ID` int(11) NOT NULL,
  `CODIGOGIRO` varchar(10) NOT NULL,
  `NOMBREGIRO` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_log_cambios`
--

CREATE TABLE `t_log_cambios` (
  `ID` int(11) NOT NULL,
  `IDREGISTROCONEXION` int(11) DEFAULT NULL,
  `NOMTABLA` longtext DEFAULT NULL,
  `NOMCOLUMNA` int(11) DEFAULT NULL,
  `VALORENTEROANTERIOR` longtext DEFAULT NULL,
  `VALORENTEROACTUAL` longtext DEFAULT NULL,
  `VALORTEXTOANTERIOR` longtext DEFAULT NULL,
  `VALORTEXTOACTUAL` longtext DEFAULT NULL,
  `VALORNUMERICOANTERIOR` longtext DEFAULT NULL,
  `VALORNUMERICOACTUAL` longtext DEFAULT NULL,
  `FECHAMODIFICACION` longtext DEFAULT NULL,
  `HORAMODIFICACION` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_lotes`
--

CREATE TABLE `t_lotes` (
  `ID` int(11) NOT NULL,
  `CODIGOENVIO` varchar(50) NOT NULL,
  `IDTIPODOCUMENTO` int(11) NOT NULL,
  `FECHALOTE` date DEFAULT NULL,
  `FECHAPROCESAMIENTO` varchar(50) DEFAULT NULL,
  `CODIGOLOTE` varchar(50) DEFAULT NULL,
  `CODIGOMSG` varchar(100) DEFAULT NULL,
  `DESCRIPCIONMSG` varchar(1000) DEFAULT NULL,
  `IDCONTINGENCIA` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_municipio`
--

CREATE TABLE `t_municipio` (
  `ID` int(11) NOT NULL,
  `CODIGOMUNICIPIO` varchar(20) NOT NULL,
  `NOMBREMUNICIPIO` varchar(255) NOT NULL,
  `IDDEPARTAMENTO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_plazo_pagos`
--

CREATE TABLE `t_plazo_pagos` (
  `ID` int(11) NOT NULL,
  `NOMBREPLAZO` varchar(50) NOT NULL,
  `DIASPLAZO` int(11) NOT NULL,
  `IDEMISOR` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_producto_servicio`
--

CREATE TABLE `t_producto_servicio` (
  `ID` int(11) NOT NULL,
  `CODIGO` longtext NOT NULL,
  `NOMBREPRODUCTO` longtext NOT NULL,
  `DESCRIPCIONPRODUCTO` longtext NOT NULL,
  `IDUNIDADMEDIDA` int(11) DEFAULT NULL,
  `IDTIPOITEM` int(11) NOT NULL,
  `ESSUJETO` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_registro_conexion`
--

CREATE TABLE `t_registro_conexion` (
  `ID` int(11) NOT NULL,
  `DATOSBAJADOS` longtext DEFAULT NULL,
  `DATOSSUBIDOS` longtext DEFAULT NULL,
  `FECHAINGRESO` longtext DEFAULT NULL,
  `FECHASALIDA` longtext DEFAULT NULL,
  `HORAINGRESO` longtext DEFAULT NULL,
  `HORASALIDA` longtext DEFAULT NULL,
  `IDUSUARIO` int(11) DEFAULT NULL,
  `IPUSUARIO` longtext DEFAULT NULL,
  `NOMBREEQUIPO` longtext DEFAULT NULL,
  `NOMBRERED` longtext DEFAULT NULL,
  `PROVEEDORINTERNET` longtext DEFAULT NULL,
  `PUERTOINGRESO` longtext DEFAULT NULL,
  `PUERTOSALIDA` longtext DEFAULT NULL,
  `SERVICIOSCONECTADOS` longtext DEFAULT NULL,
  `TIPORED` longtext DEFAULT NULL,
  `IDTOKEN` int(11) DEFAULT NULL,
  `UBICACION` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_registro_errores`
--

CREATE TABLE `t_registro_errores` (
  `ID` int(11) NOT NULL,
  `FECHAERROR` longtext DEFAULT NULL,
  `HORAERROR` longtext DEFAULT NULL,
  `IDERROR` int(11) DEFAULT NULL,
  `IDREGISTROCONEXION` int(11) DEFAULT NULL,
  `PANTALLAERROR` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_registro_token`
--

CREATE TABLE `t_registro_token` (
  `ID` int(11) NOT NULL,
  `TOKENANTERIOR` longtext DEFAULT NULL,
  `TOKENACTUAL` longtext DEFAULT NULL,
  `FECHAGENERACION` longtext DEFAULT NULL,
  `IDEMISOR` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_anulacion`
--

CREATE TABLE `t_tipo_anulacion` (
  `ID` int(11) NOT NULL,
  `TIPOANULACION` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_aproximacion`
--

CREATE TABLE `t_tipo_aproximacion` (
  `ID` int(11) NOT NULL,
  `DESCRIPCION` longtext DEFAULT NULL,
  `TIPOAPROXIMACION` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_archivo`
--

CREATE TABLE `t_tipo_archivo` (
  `ID` int(11) NOT NULL,
  `CONTENIDO` longtext DEFAULT NULL,
  `DESCRIPCION` longtext DEFAULT NULL,
  `TIPOARCHIVO` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_contingencia`
--

CREATE TABLE `t_tipo_contingencia` (
  `ID` int(11) NOT NULL,
  `TIPOCONTINGENCIA` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_documento_facturacion`
--

CREATE TABLE `t_tipo_documento_facturacion` (
  `ID` int(11) NOT NULL,
  `NOMBRETIPODOCUMENTO` varchar(50) NOT NULL,
  `CODIGOTIPODOCUMENTO` varchar(5) NOT NULL,
  `ABREVIATURA` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_item`
--

CREATE TABLE `t_tipo_item` (
  `ID` int(11) NOT NULL,
  `CODIGO` int(11) NOT NULL,
  `NOMBRE` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_moneda`
--

CREATE TABLE `t_tipo_moneda` (
  `ID` int(11) NOT NULL,
  `DESCRIPCION` longtext DEFAULT NULL,
  `TIPOMONEDA` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_pago`
--

CREATE TABLE `t_tipo_pago` (
  `ID` int(11) NOT NULL,
  `NOMBRETIPOPAGO` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_tipo_usuario`
--

CREATE TABLE `t_tipo_usuario` (
  `ID` int(11) NOT NULL,
  `DESCRIPCION` longtext DEFAULT NULL,
  `TIPOUSUARIO` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_unidad_medida`
--

CREATE TABLE `t_unidad_medida` (
  `ID` int(11) NOT NULL,
  `CODIGO` int(11) NOT NULL,
  `NOMBREUNIDADMEDIDA` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_usuario`
--

CREATE TABLE `t_usuario` (
  `ID` int(11) NOT NULL,
  `APELLIDOS` longtext NOT NULL,
  `CODCONTADURIA` longtext DEFAULT NULL,
  `CODUSUARIO` longtext DEFAULT NULL,
  `CORREO` longtext NOT NULL,
  `CORREOSECUNDARIO` longtext DEFAULT NULL,
  `DUI` longtext DEFAULT NULL,
  `FECHACREACION` longtext DEFAULT NULL,
  `FECHAINICIO` longtext DEFAULT NULL,
  `FECHAFIN` longtext DEFAULT NULL,
  `IDARCHIVO` int(11) DEFAULT NULL,
  `IDDIRECCION` int(11) DEFAULT NULL,
  `IDTIPOUSUARIO` int(11) DEFAULT NULL,
  `IPUSUARIO` longtext DEFAULT NULL,
  `LLAVE` longtext DEFAULT NULL,
  `NIT` longtext DEFAULT NULL,
  `NOMBRE` longtext NOT NULL,
  `NRC` longtext NOT NULL,
  `SALT` longtext DEFAULT NULL,
  `SOLVENCIAPNC` int(11) DEFAULT NULL,
  `TELEFONO` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `t_anulacion`
--
ALTER TABLE `t_anulacion`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_DocumentoFacturacion_2` (`IDDOCUMENTO`),
  ADD KEY `FK_TipoAnulacion_1` (`IDTIPOANULACION`);

--
-- Indices de la tabla `t_archivos`
--
ALTER TABLE `t_archivos`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_ARCHIVOS_2` (`IDTIPOARCHIVO`);

--
-- Indices de la tabla `t_cliente`
--
ALTER TABLE `t_cliente`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_GIROCOMERCIAL` (`IDGIROCOMERCIAL`),
  ADD KEY `FK_Municipio_1` (`IDMUNICIPIO`);

--
-- Indices de la tabla `t_contabilidad`
--
ALTER TABLE `t_contabilidad`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_Contabilidad_4` (`TIPOAPROXIMACION`),
  ADD KEY `FK_Contabilidad_5` (`TIPOMONEDA`);

--
-- Indices de la tabla `t_contingencia`
--
ALTER TABLE `t_contingencia`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_TipoContingencia1` (`IDTIPOCONTINGENCIA`);

--
-- Indices de la tabla `t_departamento`
--
ALTER TABLE `t_departamento`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_detalle_documento_facturacion`
--
ALTER TABLE `t_detalle_documento_facturacion`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_DocumentoFacturacion_1` (`IDDOCUMENTOFACTURACION`),
  ADD KEY `FK_ProductoServicio_1` (`IDPRODUCTOSERVICIO`);

--
-- Indices de la tabla `t_documento_facturacion`
--
ALTER TABLE `t_documento_facturacion`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_ARCHIVOS_3` (`IDARCHIVOJSON`),
  ADD KEY `FK_Cliente_1` (`IDCLIENTE`),
  ADD KEY `FK_FK_EMISOR_6` (`IDEMISOR`),
  ADD KEY `FK_EstadoDocumento_1` (`IDESTADODOCUMENTO`),
  ADD KEY `FK_Lote1` (`IDLOTE`),
  ADD KEY `FK_PlazoPagos_1` (`IDPLAZOPAGO`),
  ADD KEY `FK_TIPODOCUMENTO` (`IDTIPODOCUMENTO`),
  ADD KEY `FK_TipoPago_1` (`IDTIPOPAGO`),
  ADD KEY `FK_Usuario_7` (`IDUSUARIO`);

--
-- Indices de la tabla `t_emisor`
--
ALTER TABLE `t_emisor`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_GIROCOMERCIAL_2` (`IDGIROCOMERCIAL`),
  ADD KEY `FK_Municipio_2` (`IDMUNICIPIO`),
  ADD KEY `FK_Usuario_4` (`IDUSUARIO`);

--
-- Indices de la tabla `t_errores`
--
ALTER TABLE `t_errores`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_estado_documento`
--
ALTER TABLE `t_estado_documento`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_giro_comercial`
--
ALTER TABLE `t_giro_comercial`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_log_cambios`
--
ALTER TABLE `t_log_cambios`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_LogCambios_1` (`IDREGISTROCONEXION`);

--
-- Indices de la tabla `t_lotes`
--
ALTER TABLE `t_lotes`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_Contingencia1` (`IDCONTINGENCIA`);

--
-- Indices de la tabla `t_municipio`
--
ALTER TABLE `t_municipio`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_Departamento_1` (`IDDEPARTAMENTO`);

--
-- Indices de la tabla `t_plazo_pagos`
--
ALTER TABLE `t_plazo_pagos`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_Persona_5` (`IDEMISOR`);

--
-- Indices de la tabla `t_producto_servicio`
--
ALTER TABLE `t_producto_servicio`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_TipoItem_1` (`IDTIPOITEM`),
  ADD KEY `FK_UnidadMedida_1` (`IDUNIDADMEDIDA`);

--
-- Indices de la tabla `t_registro_conexion`
--
ALTER TABLE `t_registro_conexion`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_RegistroConexion_1` (`IDUSUARIO`);

--
-- Indices de la tabla `t_registro_errores`
--
ALTER TABLE `t_registro_errores`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_RegistroErrores_1` (`IDERROR`),
  ADD KEY `FK_RegistroErrores_3` (`IDREGISTROCONEXION`);

--
-- Indices de la tabla `t_registro_token`
--
ALTER TABLE `t_registro_token`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_Persona_4` (`IDEMISOR`);

--
-- Indices de la tabla `t_tipo_anulacion`
--
ALTER TABLE `t_tipo_anulacion`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_tipo_aproximacion`
--
ALTER TABLE `t_tipo_aproximacion`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_tipo_archivo`
--
ALTER TABLE `t_tipo_archivo`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_tipo_contingencia`
--
ALTER TABLE `t_tipo_contingencia`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_tipo_documento_facturacion`
--
ALTER TABLE `t_tipo_documento_facturacion`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_tipo_item`
--
ALTER TABLE `t_tipo_item`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_tipo_moneda`
--
ALTER TABLE `t_tipo_moneda`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_tipo_pago`
--
ALTER TABLE `t_tipo_pago`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_tipo_usuario`
--
ALTER TABLE `t_tipo_usuario`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_unidad_medida`
--
ALTER TABLE `t_unidad_medida`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `t_usuario`
--
ALTER TABLE `t_usuario`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_Usuario_6` (`IDTIPOUSUARIO`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `t_archivos`
--
ALTER TABLE `t_archivos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `t_contabilidad`
--
ALTER TABLE `t_contabilidad`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `t_errores`
--
ALTER TABLE `t_errores`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `t_log_cambios`
--
ALTER TABLE `t_log_cambios`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `t_registro_conexion`
--
ALTER TABLE `t_registro_conexion`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `t_registro_errores`
--
ALTER TABLE `t_registro_errores`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `t_tipo_aproximacion`
--
ALTER TABLE `t_tipo_aproximacion`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `t_tipo_archivo`
--
ALTER TABLE `t_tipo_archivo`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `t_tipo_moneda`
--
ALTER TABLE `t_tipo_moneda`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `t_tipo_usuario`
--
ALTER TABLE `t_tipo_usuario`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `t_usuario`
--
ALTER TABLE `t_usuario`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `t_anulacion`
--
ALTER TABLE `t_anulacion`
  ADD CONSTRAINT `FK_DocumentoFacturacion_2` FOREIGN KEY (`IDDOCUMENTO`) REFERENCES `t_documento_facturacion` (`ID`),
  ADD CONSTRAINT `FK_TipoAnulacion_1` FOREIGN KEY (`IDTIPOANULACION`) REFERENCES `t_tipo_anulacion` (`ID`);

--
-- Filtros para la tabla `t_archivos`
--
ALTER TABLE `t_archivos`
  ADD CONSTRAINT `FK_ARCHIVOS_2` FOREIGN KEY (`IDTIPOARCHIVO`) REFERENCES `t_documento_facturacion` (`ID`),
  ADD CONSTRAINT `FK_Archivos_1` FOREIGN KEY (`IDTIPOARCHIVO`) REFERENCES `t_tipo_archivo` (`ID`);

--
-- Filtros para la tabla `t_cliente`
--
ALTER TABLE `t_cliente`
  ADD CONSTRAINT `FK_GIROCOMERCIAL` FOREIGN KEY (`IDGIROCOMERCIAL`) REFERENCES `t_giro_comercial` (`ID`),
  ADD CONSTRAINT `FK_Municipio_1` FOREIGN KEY (`IDMUNICIPIO`) REFERENCES `t_municipio` (`ID`);

--
-- Filtros para la tabla `t_contabilidad`
--
ALTER TABLE `t_contabilidad`
  ADD CONSTRAINT `FK_Contabilidad_4` FOREIGN KEY (`TIPOAPROXIMACION`) REFERENCES `t_tipo_aproximacion` (`ID`),
  ADD CONSTRAINT `FK_Contabilidad_5` FOREIGN KEY (`TIPOMONEDA`) REFERENCES `t_tipo_moneda` (`ID`);

--
-- Filtros para la tabla `t_contingencia`
--
ALTER TABLE `t_contingencia`
  ADD CONSTRAINT `FK_TipoContingencia1` FOREIGN KEY (`IDTIPOCONTINGENCIA`) REFERENCES `t_tipo_contingencia` (`ID`);

--
-- Filtros para la tabla `t_detalle_documento_facturacion`
--
ALTER TABLE `t_detalle_documento_facturacion`
  ADD CONSTRAINT `FK_DocumentoFacturacion_1` FOREIGN KEY (`IDDOCUMENTOFACTURACION`) REFERENCES `t_documento_facturacion` (`ID`),
  ADD CONSTRAINT `FK_ProductoServicio_1` FOREIGN KEY (`IDPRODUCTOSERVICIO`) REFERENCES `t_producto_servicio` (`ID`);

--
-- Filtros para la tabla `t_documento_facturacion`
--
ALTER TABLE `t_documento_facturacion`
  ADD CONSTRAINT `FK_ARCHIVOS_3` FOREIGN KEY (`IDARCHIVOJSON`) REFERENCES `t_archivos` (`ID`),
  ADD CONSTRAINT `FK_Cliente_1` FOREIGN KEY (`IDCLIENTE`) REFERENCES `t_cliente` (`ID`),
  ADD CONSTRAINT `FK_EstadoDocumento_1` FOREIGN KEY (`IDESTADODOCUMENTO`) REFERENCES `t_estado_documento` (`ID`),
  ADD CONSTRAINT `FK_FK_EMISOR_6` FOREIGN KEY (`IDEMISOR`) REFERENCES `t_emisor` (`ID`),
  ADD CONSTRAINT `FK_Lote1` FOREIGN KEY (`IDLOTE`) REFERENCES `t_lotes` (`ID`),
  ADD CONSTRAINT `FK_PlazoPagos_1` FOREIGN KEY (`IDPLAZOPAGO`) REFERENCES `t_plazo_pagos` (`ID`),
  ADD CONSTRAINT `FK_TIPODOCUMENTO` FOREIGN KEY (`IDTIPODOCUMENTO`) REFERENCES `t_tipo_documento_facturacion` (`ID`),
  ADD CONSTRAINT `FK_TipoPago_1` FOREIGN KEY (`IDTIPOPAGO`) REFERENCES `t_tipo_pago` (`ID`),
  ADD CONSTRAINT `FK_Usuario_7` FOREIGN KEY (`IDUSUARIO`) REFERENCES `t_usuario` (`ID`);

--
-- Filtros para la tabla `t_emisor`
--
ALTER TABLE `t_emisor`
  ADD CONSTRAINT `FK_GIROCOMERCIAL_2` FOREIGN KEY (`IDGIROCOMERCIAL`) REFERENCES `t_giro_comercial` (`ID`),
  ADD CONSTRAINT `FK_Municipio_2` FOREIGN KEY (`IDMUNICIPIO`) REFERENCES `t_municipio` (`ID`),
  ADD CONSTRAINT `FK_Usuario_4` FOREIGN KEY (`IDUSUARIO`) REFERENCES `t_usuario` (`ID`);

--
-- Filtros para la tabla `t_log_cambios`
--
ALTER TABLE `t_log_cambios`
  ADD CONSTRAINT `FK_LogCambios_1` FOREIGN KEY (`IDREGISTROCONEXION`) REFERENCES `t_registro_conexion` (`ID`);

--
-- Filtros para la tabla `t_lotes`
--
ALTER TABLE `t_lotes`
  ADD CONSTRAINT `FK_Contingencia1` FOREIGN KEY (`IDCONTINGENCIA`) REFERENCES `t_contingencia` (`ID`);

--
-- Filtros para la tabla `t_municipio`
--
ALTER TABLE `t_municipio`
  ADD CONSTRAINT `FK_Departamento_1` FOREIGN KEY (`IDDEPARTAMENTO`) REFERENCES `t_departamento` (`ID`);

--
-- Filtros para la tabla `t_plazo_pagos`
--
ALTER TABLE `t_plazo_pagos`
  ADD CONSTRAINT `FK_Persona_5` FOREIGN KEY (`IDEMISOR`) REFERENCES `t_emisor` (`ID`);

--
-- Filtros para la tabla `t_producto_servicio`
--
ALTER TABLE `t_producto_servicio`
  ADD CONSTRAINT `FK_TipoItem_1` FOREIGN KEY (`IDTIPOITEM`) REFERENCES `t_tipo_item` (`ID`),
  ADD CONSTRAINT `FK_UnidadMedida_1` FOREIGN KEY (`IDUNIDADMEDIDA`) REFERENCES `t_unidad_medida` (`ID`);

--
-- Filtros para la tabla `t_registro_conexion`
--
ALTER TABLE `t_registro_conexion`
  ADD CONSTRAINT `FK_RegistroConexion_1` FOREIGN KEY (`IDUSUARIO`) REFERENCES `t_usuario` (`ID`);

--
-- Filtros para la tabla `t_registro_errores`
--
ALTER TABLE `t_registro_errores`
  ADD CONSTRAINT `FK_RegistroErrores_1` FOREIGN KEY (`IDERROR`) REFERENCES `t_errores` (`ID`),
  ADD CONSTRAINT `FK_RegistroErrores_3` FOREIGN KEY (`IDREGISTROCONEXION`) REFERENCES `t_registro_conexion` (`ID`);

--
-- Filtros para la tabla `t_registro_token`
--
ALTER TABLE `t_registro_token`
  ADD CONSTRAINT `FK_Persona_4` FOREIGN KEY (`IDEMISOR`) REFERENCES `t_emisor` (`ID`);

--
-- Filtros para la tabla `t_usuario`
--
ALTER TABLE `t_usuario`
  ADD CONSTRAINT `FK_Usuario_6` FOREIGN KEY (`IDTIPOUSUARIO`) REFERENCES `t_tipo_usuario` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
