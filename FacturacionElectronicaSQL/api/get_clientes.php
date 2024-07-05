<?php
header('Content-Type: application/json');
include 'config.php';

$sql = "SELECT id,nombreCliente, nombreComercial, direccion, telefono, nitDui, nrc, idGiroComercial, exentoIVA, correoElectronico, idMunicipio FROM t_cliente";
$result = $connection->query($sql);

$emisores = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $emisores[] = $row;
    }
} else {
    echo json_encode(["message" => "No se encontraron datos."]);
    exit;
}

echo json_encode($emisores);

$connection->close();
?>
