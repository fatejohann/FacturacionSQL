<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json');
include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    parse_str(file_get_contents("php://input"), $data);
    $id = isset($data['id']) ? $data['id'] : null;

    if (empty($id)) {
        http_response_code(400);
        echo json_encode(["error" => "ID de cliente no proporcionado"]);
        exit;
    }

    $sql = "DELETE FROM t_cliente WHERE id = ?";
    $stmt = $connection->prepare($sql);

    if ($stmt === false) {
        http_response_code(500);
        echo json_encode(["error" => "Error al preparar la declaración: " . $connection->error]);
        exit;
    }

    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        echo json_encode(["message" => "Cliente eliminado exitosamente"]);
    } else {
        http_response_code(500);
        echo json_encode(["error" => "Error al ejecutar la declaración: " . $stmt->error]);
    }

    $stmt->close();
    $connection->close();
} else {
    http_response_code(405);
    echo json_encode(["error" => "Método no permitido"]);
}
?>
