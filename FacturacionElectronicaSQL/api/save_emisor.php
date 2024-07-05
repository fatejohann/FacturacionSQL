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

// Verificar que todos los campos obligatorios estén presentes
if (empty($data['razonSocial']) || empty($data['nombreComercial']) || empty($data['nit']) || empty($data['nrc']) ||
    empty($data['telefono']) || empty($data['correoElectronico']) || empty($data['idMunicipio']) || empty($data['direccion']) ||
    empty($data['giroComercial']) || empty($data['tipoEstablecimiento'])) {
    http_response_code(400);
    echo json_encode(["error" => "Todos los campos son obligatorios."]);
    exit;
}

$razonSocial = $data['razonSocial'];
$nombreComercial = $data['nombreComercial'];
$nit = $data['nit'];
$nrc = $data['nrc'];
$telefono = $data['telefono'];
$correoElectronico = $data['correoElectronico'];
$idMunicipio = $data['idMunicipio'];
$direccion = $data['direccion'];
$idGiroComercial = $data['giroComercial'];
$tipoEstablecimiento = $data['tipoEstablecimiento'];
$idUsuario = 1; // Suponiendo que hay un usuario relacionado

$sql = "INSERT INTO t_persona (razonSocial, nombreComercial, nit, nrc, telefono, correoElectronico, idMunicipio, direccion, idGiroComercial, tipoEstablecimiento, idUsuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $connection->prepare($sql);
if ($stmt === false) {
    http_response_code(500);
    echo json_encode(["error" => "Error al preparar la declaración: " . $connection->error]);
    exit;
}

$stmt->bind_param("ssssssisssi", $razonSocial, $nombreComercial, $nit, $nrc, $telefono, $correoElectronico, $idMunicipio, $direccion, $idGiroComercial, $tipoEstablecimiento, $idUsuario);

if ($stmt->execute()) {
    echo json_encode(["message" => "Emisor guardado exitosamente"]);
} else {
    http_response_code(500);
    echo json_encode(["error" => "Error al ejecutar la declaración: " . $stmt->error]);
}

$stmt->close();
$connection->close();
?>
