<?php
// api/get_token.php
include 'config.php';

$sql = "SELECT tokenActual, fechaGeneracion FROM t_registro_token ORDER BY id DESC";
$result = $connection->query($sql);

if ($result->num_rows > 0) {
    $tokens = array();
    while ($row = $result->fetch_assoc()) {
        $tokens[] = array(
            "tokenActual" => $row['tokenActual'],
            "fechaGeneracion" => $row['fechaGeneracion']
        );
    }
    echo json_encode($tokens);
} else {
    http_response_code(404);
    echo json_encode(["error" => "No se encontraron tokens."]);
}

$connection->close();
?>
