<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json');
include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

// Verificar errores de decodificación JSON
if (json_last_error() !== JSON_ERROR_NONE) {
    http_response_code(400);
    echo json_encode(["error" => "Error al decodificar JSON"]);
    exit;
}

$noDocumento = $data['noDocumento'] ?? '';
$fechaDocumento = $data['fechaDocumento'] ?? '';
$horaDocumento = $data['horaDocumento'] ?? '';
$idEstadoDocumento=$data['idEstadoDocumento'] ?? '';

$idCliente = $data['idCliente'] ?? 1;

$totalVentasExentas = $data['totalVentasExentas'] ?? 0;
$totalVentasNoSujetas = $data['totalVentasNoSujetas'] ?? 0;
$totalVentasGravadas = $data['totalVentasGravadas'] ?? 0;
$ivaDocumento = $data['ivaDocumento'] ?? 0;
$retencionIVA = $data['retencionIVA'] ?? 0;
$totalDocumento = $data['totalDocumento'] ?? 0;
$numeroControl = $data['numeroControl'] ?? '';
$codigoGeneracion = $data['codigoGeneracion'] ?? '';
$clasificacionMsg = $data['clasificacionMsg'] ?? '';
$codigoMsg = $data['codigoMsg'] ?? '';
$descripcionMsg = $data['descripcionMsg'] ?? '';
$idArchivoJson = $data['idArchivoJson'] ?? 1;
$idArchivoPDF = $data['idArchivoPDF'] ?? 1;
$idTipoPago = $data['idTipoPago'] ?? 1;
$idPlazoPago = $data['idPlazoPago'] ?? 1;
$idLote = $data['idLote'] ?? 1;
$idBodegaSucursal = $data['idBodegaSucursal'] ?? 1;
$idUsuario = $data['idUsuario'] ?? 1;
$subTotalVentas = $data['subTotalVentas'] ?? 0;
$descuentoNoSujetas = $data['descuentoNoSujetas'] ?? 0;
$descuentoExentas = $data['descuentoExentas'] ?? 0;
$descuentoGravadas = $data['descuentoGravadas'] ?? 0;

$porcentajeDescuento = $data['porcentajeDescuento'] ?? 0;
$totalDescuentos = $data['totalDescuentos'] ?? 0;
$subTotal = $data['subTotal'] ?? 0;
$ivaPercibido = $data['ivaPercibido'] ?? 0;
$retencionRenta = $data['retencionRenta'] ?? 0;
$montoTotalOperacion = $data['montoTotalOperacion'] ?? 0;
$totalNoGravado = $data['totalNoGravado'] ?? 0;
$totalPagar = $data['totalPagar'] ?? 0;
$totalLetras = $data['totalLetras'] ?? '';
$totalIva = $data['totalIva'] ?? 0;
$tipoDte = $data['tipoDte'] ?? '';


$sql = "INSERT INTO t_documento_facturacion (noDocumento, fechaDocumento, horaDocumento, idEstadoDocumento, idCliente, totalVentasExentas, totalVentasNoSujetas, totalVentasGravadas, ivaDocumento, retencionIVA, totalDocumento, numeroControl, codigoGeneracion, clasificacionMsg, codigoMsg, descripcionMsg, idArchivoJson, idArchivoPDF, idTipoPago, idPlazoPago, idLote, idBodegaSucursal, idUsuario, subTotalVentas, descuentoNoSujetas, descuentoExentas, descuentoGravadas, porcentajeDescuento, totalDescuentos, subTotal, ivaPercibido, retencionRenta, montoTotalOperacion, totalNoGravado, totalPagar, totalLetras, totalIva,tipoDte) VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $connection->prepare($sql);
if ($stmt === false) {
    http_response_code(500);
    echo json_encode(["error" => "Error al preparar la declaración: " . $connection->error]);
    error_log("Error al preparar la declaración: " . $connection->error);
    exit;
}

try {
    $stmt->bind_param("sssiiddddddsssssiiiiiiiddddddddddddsds", $noDocumento, $fechaDocumento, $horaDocumento, $idEstadoDocumento, $idCliente, $totalVentasExentas, $totalVentasNoSujetas, $totalVentasGravadas, $ivaDocumento, $retencionIVA, $totalDocumento, $numeroControl, $codigoGeneracion, $clasificacionMsg, $codigoMsg, $descripcionMsg, $idArchivoJson, $idArchivoPDF, $idTipoPago, $idPlazoPago, $idLote, $idBodegaSucursal, $idUsuario, $subTotalVentas, $descuentoNoSujetas, $descuentoExentas, $descuentoGravadas, $porcentajeDescuento, $totalDescuentos, $subTotal, $ivaPercibido, $retencionRenta, $montoTotalOperacion, $totalNoGravado, $totalPagar, $totalLetras, $totalIva,$tipoDte);
} catch (\Throwable $th) {
    throw $th;
}

if ($stmt->execute()) {
    echo json_encode(["message" => "Documento de facturación guardado exitosamente"]);
} else {
    http_response_code(500);
    echo json_encode(["error" => "Error al ejecutar la declaración: " . $stmt->error]);
    error_log("Error al ejecutar la declaración: " . $stmt->error);
}

$stmt->close();
$connection->close();

?>
