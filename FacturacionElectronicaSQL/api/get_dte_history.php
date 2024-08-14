<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json');
include 'config.php';

$sql = "SELECT t_documento_facturacion.fechaDocumento, 
               t_estado_documento.nombre as estadoDocumento, 
               t_documento_facturacion.tipoDte, 
               t_documento_facturacion.codigoGeneracion 
        FROM t_documento_facturacion 
        JOIN t_estado_documento ON t_documento_facturacion.idEstadoDocumento = t_estado_documento.id 
        ORDER BY t_documento_facturacion.fechaDocumento DESC";

$result = $connection->query($sql);

if ($result === false) {
    http_response_code(500);
    echo json_encode(["error" => "Error al ejecutar la consulta: " . $connection->error]);
    error_log("Error al ejecutar la consulta: " . $connection->error);
    exit;
}

$dteHistory = [];
while ($row = $result->fetch_assoc()) {
    $dteHistory[] = $row;
}

echo json_encode($dteHistory);

$connection->close();
?>
