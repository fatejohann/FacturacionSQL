<?php
header('Content-Type: application/json');
include 'config.php';

if (!isset($_GET['idMunicipio'])) {
    http_response_code(400);
    echo json_encode(["error" => "ID de municipio no proporcionado."]);
    exit;
}

$idMunicipio = $_GET['idMunicipio'];

$sql = "SELECT idDepartamento FROM t_municipio WHERE id = ?";
$stmt = $connection->prepare($sql);
if ($stmt === false) {
    http_response_code(500);
    echo json_encode(["error" => "Error al preparar la declaración: " . $connection->error]);
    exit;
}

$stmt->bind_param("i", $idMunicipio);

if ($stmt->execute()) {
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $idDepartamento = $row['idDepartamento'];
        echo json_encode(["idDepartamento" => $idDepartamento]);
    } else {
        echo json_encode(["message" => "No se encontró el departamento para este municipio."]);
    }
} else {
    http_response_code(500);
    echo json_encode(["error" => "Error al ejecutar la declaración: " . $stmt->error]);
}

$stmt->close();
$connection->close();
?>
