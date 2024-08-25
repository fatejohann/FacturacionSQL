<?php

include 'config.php';

// Asegurarte de que la variable correcta de conexión es usada ($connection)
$sql = "SELECT id FROM t_documento_facturacion ORDER BY id DESC LIMIT 1";
$result = $connection->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode(array("id" => $row["id"]));
} else {
    echo json_encode(array("id" => null));
}

$connection->close();
?>
