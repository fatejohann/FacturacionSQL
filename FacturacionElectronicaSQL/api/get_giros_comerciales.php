<?php
header('Content-Type: application/json');
include 'config.php';

$sql = "SELECT id, codigoGiro, nombreGiro FROM t_giro_comercial";
$result = $connection->query($sql);

$girosComerciales = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $girosComerciales[] = $row;
    }
} else {
    echo json_encode(["message" => "No se encontraron datos."]);
    exit;
}

echo json_encode($girosComerciales);

$connection->close();
?>
