<?php
// api/get_last_token.php
include 'config.php';

$sql = "SELECT tokenActual, fechaGeneracion FROM t_registro_token ORDER BY id DESC LIMIT 1";
$result = $connection->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode([
        "tokenActual" => $row['tokenActual'],
        "fechaGeneracion" => $row['fechaGeneracion']
    ]);
} else {
    http_response_code(404);
    echo json_encode(["error" => "No se encontró ningún token."]);
}

$connection->close();
?>
