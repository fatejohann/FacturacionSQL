<?php
header('Content-Type: application/json');
include 'config.php';

$sql = "SELECT id, nombreDepartamento,codigoDepartamento FROM t_departamento";
$result = $connection->query($sql);

$departamentos = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $departamentos[] = $row;
    }
} else {
    echo json_encode(["message" => "No se encontraron datos."]);
    exit;
}

echo json_encode($departamentos);

$connection->close();
?>
