<?php

include 'config.php';

$data = json_decode(file_get_contents('php://input'), true);

$idDocumentoFacturacion = $data['idDocumentoFacturacion'];
$noLinea = $data['noLinea'];
$cantidad = $data['cantidad'];
$idProductoServicio = $data['idProductoServicio'];
$precioSinIVA = $data['precioUni'];
$porcentajeDescuento = $data['porcentajeDescuento'];
$valorDescuento = $data['valorDescuento'];
$subTotalExentas = $data['subTotalExentas'];
$subTotalNoSujetas = $data['subTotalNoSujetas'];
$subTotalGravadas = $data['ventaGravada'];
$ivaDetalle = $data['ivaDetalle'];
$totalDetalle = $data['ventaGravada'];

$sql = "INSERT INTO t_detalle_documento_facturacion (
    idDocumentoFacturacion, noLinea, cantidad, idProductoServicio, precioSinIVA,
    porcentajeDescuento, valorDescuento, subTotalExentas, subTotalNoSujetas,
    subTotalGravadas, ivaDetalle, totalDetalle
) VALUES (
    '$idDocumentoFacturacion', '$noLinea', '$cantidad', '$idProductoServicio', '$precioSinIVA',
    '$porcentajeDescuento', '$valorDescuento', '$subTotalExentas', '$subTotalNoSujetas',
    '$subTotalGravadas', '$ivaDetalle', '$totalDetalle'
)";

if ($connection->query($sql) === TRUE) {
    echo json_encode(["message" => "Detalle guardado exitosamente"]);
} else {
    echo json_encode(["error" => "Error al guardar el detalle: " . $connection->error]);
}

$connection->close();

?>
