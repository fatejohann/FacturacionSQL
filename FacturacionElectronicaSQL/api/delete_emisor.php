<?php
header('Content-Type: application/json');
include 'config.php';

if (!isset($_GET['id'])) {
    http_response_code(400);
    echo json_encode(["error" => "ID del emisor no proporcionado."]);
    exit;
}

$id = $_GET['id'];

$sql = "DELETE FROM t_persona WHERE id = ?";
$stmt = $connection->prepare($sql);
if ($stmt === false) {
    http_response_code(500);
    echo json_encode(["error" => "Error al preparar la declaración: " . $connection->error]);
    exit;
}

$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    echo json_encode(["message" => "Emisor eliminado exitosamente"]);
} else {
    http_response_code(500);
    echo json_encode(["error" => "Error al ejecutar la declaración: " . $stmt->error]);
}

$stmt->close();
$connection->close();
?>
