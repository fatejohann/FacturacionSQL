<?php
header('Content-Type: application/json');
include 'config.php';

$sql = "SELECT id,razonSocial,nombreComercial, nit, nrc, telefono, correoElectronico, idMunicipio, direccion, idGiroComercial FROM t_persona";
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
