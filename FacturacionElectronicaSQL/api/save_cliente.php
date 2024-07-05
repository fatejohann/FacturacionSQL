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

$nombreCliente = $data['nombreCliente'];
$nombreComercialCliente = isset($data['nombreComercialCliente']) ? $data['nombreComercialCliente'] : null;
$direccionCliente = $data['direccionCliente'];
$telefonoCliente = isset($data['telefonoCliente']) ? $data['telefonoCliente'] : null;
$nitDui = $data['nitDui'];
$nrcCliente = $data['nrcCliente'];
$giroComercialCliente = $data['giroComercialCliente']; // ID del giro comercial
$exentoIVA = isset($data['exentoIVA']) ? $data['exentoIVA'] : 0;
$correoElectronicoCliente = $data['correoElectronicoCliente'];
$municipioCliente = $data['municipioCliente'];

$sql = "INSERT INTO t_cliente (nombreCliente, nombreComercial, direccion, telefono, nitDui, nrc, idGiroComercial, exentoIVA, correoElectronico, idMunicipio) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $connection->prepare($sql);
if ($stmt === false) {
    http_response_code(500);
    echo json_encode(["error" => "Error al preparar la declaración: " . $connection->error]);
    exit;
}

$stmt->bind_param("ssssssissi", $nombreCliente, $nombreComercialCliente, $direccionCliente, $telefonoCliente, $nitDui, $nrcCliente, $giroComercialCliente, $exentoIVA, $correoElectronicoCliente, $municipioCliente);

if ($stmt->execute()) {
    echo json_encode(["message" => "Cliente guardado exitosamente"]);
} else {
    http_response_code(500);
    echo json_encode(["error" => "Error al ejecutar la declaración: " . $stmt->error]);
}

$stmt->close();
$connection->close();
?>
