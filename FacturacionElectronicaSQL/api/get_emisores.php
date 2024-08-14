<?php
header('Content-Type: application/json');
include 'config.php';

// Modificación de la consulta para unirse a las tablas de municipios y giros comerciales
$sql = "SELECT p.id, p.razonSocial, p.nombreComercial, p.nit, p.nrc, p.telefono, p.correoElectronico, 
        m.nombreMunicipio AS municipio, p.direccion, g.nombreGiro AS giroComercial 
        FROM t_persona p
        LEFT JOIN t_municipio m ON p.idMunicipio = m.id
        LEFT JOIN t_giro_comercial g ON p.idGiroComercial = g.id";

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
