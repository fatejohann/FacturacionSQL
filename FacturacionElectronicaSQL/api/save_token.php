<?php
// api/save_token.php
include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

if (empty($data['tokenActual']) || empty($data['fechaGeneracion'])) {
    http_response_code(400);
    echo json_encode(["error" => "Todos los campos son obligatorios."]);
    exit;
}

$tokenActual = $data['tokenActual'];
$fechaGeneracion = $data['fechaGeneracion'];
$idPersona = isset($data['idPersona']) ? $data['idPersona'] : null;

// Obtener el token anterior del mismo idPersona, si existe
$tokenAnterior = null;
if ($idPersona !== null) {
    $sql = "SELECT tokenActual FROM t_registro_token WHERE idPersona = ? ORDER BY id DESC LIMIT 1";
    $stmt = $connection->prepare($sql);
    $stmt->bind_param("i", $idPersona);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $tokenAnterior = $row['tokenActual'];
    }
} else {
    $sql = "SELECT tokenActual FROM t_registro_token ORDER BY id DESC LIMIT 1";
    $result = $connection->query($sql);
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $tokenAnterior = $row['tokenActual'];
    }
}

$sql = "INSERT INTO t_registro_token (tokenAnterior, tokenActual, fechaGeneracion, idPersona) VALUES (?, ?, ?, ?)";
$stmt = $connection->prepare($sql);
$stmt->bind_param("sssi", $tokenAnterior, $tokenActual, $fechaGeneracion, $idPersona);

if ($stmt->execute()) {
    echo json_encode(["message" => "Token guardado exitosamente"]);
} else {
    http_response_code(500);
    echo json_encode(["error" => $stmt->error]);
}

$stmt->close();
$connection->close();
?>
