<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json');
include 'config.php';

$sql = "SELECT c.id, c.nombreCliente, c.nombreComercial, c.direccion, c.telefono, c.nitDui, c.nrc, c.exentoIVA, c.correoElectronico, 
        m.nombreMunicipio AS municipio, g.nombreGiro AS giroComercial
        FROM t_cliente c
        LEFT JOIN t_municipio m ON c.idMunicipio = m.id
        LEFT JOIN t_giro_comercial g ON c.idGiroComercial = g.id";

$result = $connection->query($sql);

if ($result === false) {
    http_response_code(500);
    echo json_encode(["error" => "Error al obtener los clientes: " . $connection->error]);
    exit;
}

$clientes = [];
while ($row = $result->fetch_assoc()) {
    $clientes[] = $row;
}

echo json_encode($clientes);

$connection->close();
?>
