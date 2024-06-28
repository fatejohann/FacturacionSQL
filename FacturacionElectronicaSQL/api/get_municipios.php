<?php
header('Content-Type: application/json'); // Asegurarse de que la respuesta es JSON

include 'config.php';

if (!isset($_GET['departamentoId'])) {
    http_response_code(400);
    echo json_encode(["error" => "Falta el parámetro departamentoId"]);
    exit;
}

$departamentoId = $_GET['departamentoId'];
$sql = "SELECT id, nombreMunicipio AS nombre FROM t_municipio WHERE idDepartamento = ?";
$stmt = $connection->prepare($sql);

if (!$stmt) {
    http_response_code(500);
    echo json_encode(["error" => "Error al preparar la consulta"]);
    exit;
}

$stmt->bind_param("i", $departamentoId);
$stmt->execute();
$result = $stmt->get_result();

if (!$result) {
    http_response_code(500);
    echo json_encode(["error" => "Error al ejecutar la consulta"]);
    exit;
}

$municipios = [];
while($row = $result->fetch_assoc()) {
    $municipios[] = $row;
}

echo json_encode($municipios);
$stmt->close();
$connection->close();
?>
