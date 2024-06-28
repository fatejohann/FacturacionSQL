<?php
header('Content-Type: application/json'); // Asegurarse de que la respuesta es JSON

include 'config.php';

$sql = "SELECT id, nombreDepartamento AS nombre FROM t_departamento";
$result = $connection->query($sql);

if (!$result) {
    http_response_code(500);
    echo json_encode(["error" => "Error al consultar la base de datos"]);
    exit;
}

$departamentos = [];
while($row = $result->fetch_assoc()) {
    $departamentos[] = $row;
}

echo json_encode($departamentos);
$connection->close();
?>
