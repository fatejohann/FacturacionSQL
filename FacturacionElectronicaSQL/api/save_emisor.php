<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json'); // Asegurarse de que la respuesta es JSON

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

// Verificar errores de decodificación JSON
if (json_last_error() !== JSON_ERROR_NONE) {
    http_response_code(400);
    echo json_encode(["error" => "Error al decodificar JSON"]);
    exit;
}

// Verificar que todos los campos obligatorios estén presentes
if (empty($data['nombreComercial']) || empty($data['nit']) || empty($data['nrc']) || 
    empty($data['telefono']) || empty($data['correoElectronico']) || 
    empty($data['direccion'])) {
    http_response_code(400);
    echo json_encode(["error" => "Todos los campos son obligatorios."]);
    exit;
}

$nombreComercial = $data['nombreComercial'];
$nit = $data['nit'];
$nrc = $data['nrc'];
$telefono = $data['telefono'];
$correoElectronico = $data['correoElectronico'];
$idMunicipio = 1; // Provisional
$direccion = $data['direccion'];

// Asignar valores provisionales a los campos no utilizados
$razonSocial = "hola";
$idUsuario = 1;

$sql = "INSERT INTO t_persona (razonSocial, nombreComercial, nit, nrc, telefono, correoElectronico, idMunicipio, direccion, idUsuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $connection->prepare($sql);
if ($stmt === false) {
    http_response_code(500);
    echo json_encode(["error" => "Error al preparar la declaración: " . $connection->error]);
    exit;
}

$stmt->bind_param("ssssssisi", $razonSocial, $nombreComercial, $nit, $nrc, $telefono, $correoElectronico, $idMunicipio, $direccion, $idUsuario);

if ($stmt->execute()) {
    echo json_encode(["message" => "Emisor guardado exitosamente"]);
} else {
    http_response_code(500);
    echo json_encode(["error" => "Error al ejecutar la declaración: " . $stmt->error]);
}

$stmt->close();
$connection->close();
?>
