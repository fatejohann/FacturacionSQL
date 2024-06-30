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
if (empty($data['nombreCliente']) || empty($data['direccion']) || 
    empty($data['telefono']) || empty($data['nitDui']) || empty($data['nrc']) || 
    !isset($data['exentoIVA']) || empty($data['correoElectronico']) || empty($data['idMunicipio'])) {
    http_response_code(400);
    echo json_encode(["error" => "Todos los campos son obligatorios."]);
    exit;
}

$nombreCliente = $data['nombreCliente'];
$nombreComercial = isset($data['nombreComercial']) ? $data['nombreComercial'] : NULL;
$direccion = $data['direccion'];
$telefono = $data['telefono'];
$nitDui = $data['nitDui'];
$nrc = $data['nrc'];
$exentoIVA = $data['exentoIVA'];
$correoElectronico = $data['correoElectronico'];
$idMunicipio = $data['idMunicipio'];

$sql = "INSERT INTO t_cliente (nombreCliente, nombreComercial, direccion, telefono, nitDui, nrc, exentoIVA, correoElectronico, idMunicipio) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $connection->prepare($sql);
if ($stmt === false) {
    http_response_code(500);
    echo json_encode(["error" => "Error al preparar la declaración: " . $connection->error]);
    exit;
}

$stmt->bind_param("ssssssisi", $nombreCliente, $nombreComercial, $direccion, $telefono, $nitDui, $nrc, $exentoIVA, $correoElectronico, $idMunicipio);

if ($stmt->execute()) {
    echo json_encode(["message" => "Cliente guardado exitosamente"]);
} else {
    http_response_code(500);
    echo json_encode(["error" => "Error al ejecutar la declaración: " . $stmt->error]);
}

$stmt->close();
$connection->close();
?>
