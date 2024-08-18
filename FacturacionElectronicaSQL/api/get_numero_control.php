<?php
header('Content-Type: application/json');
include 'config.php';

// Asegurarse de que se pase el tipo de DTE
if (!isset($_GET['tipoDte'])) {
    echo json_encode(["error" => "tipoDte no especificado"]);
    exit;
}

$tipoDte = $_GET['tipoDte'];

// Consulta para obtener el último número de control del tipo de DTE especificado
$sql = "SELECT numeroControl 
        FROM t_documento_facturacion 
        WHERE numeroControl LIKE ? 
        ORDER BY id DESC 
        LIMIT 1";

$tipoDtePattern = $tipoDte . "%"; // Para buscar el número de control que empieza con el tipo de DTE

$stmt = $connection->prepare($sql);
$stmt->bind_param("s", $tipoDtePattern);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $numeroControl = $row['numeroControl'];
    echo json_encode($numeroControl);
} else {
    // Si no hay ningún registro, se devuelve un mensaje indicando que no se encontró el número de control
    echo json_encode(["error" => "No se encontró número de control para el tipo de DTE especificado"]);
}

$stmt->close();
$connection->close();
?>
