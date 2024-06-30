<?php
header('Content-Type: application/json');
include 'config.php';

if (!isset($_GET['departamento_id'])) {
    http_response_code(400);
    echo json_encode(["error" => "ID del departamento no proporcionado."]);
    exit;
}

$departamento_id = $_GET['departamento_id'];

$sql = "SELECT id, nombreMunicipio FROM t_municipio WHERE idDepartamento = ?";
$stmt = $connection->prepare($sql);
if ($stmt === false) {
    http_response_code(500);
    echo json_encode(["error" => "Error al preparar la declaración: " . $connection->error]);
    exit;
}

$stmt->bind_param("i", $departamento_id);

if ($stmt->execute()) {
    $result = $stmt->get_result();
    $municipios = [];
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $municipios[] = $row;
        }
        echo json_encode($municipios);
    } else {
        echo json_encode(["message" => "No se encontraron datos."]);
    }
} else {
    http_response_code(500);
    echo json_encode(["error" => "Error al ejecutar la declaración: " . $stmt->error]);
}

$stmt->close();
$connection->close();
?>
