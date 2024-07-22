<?php
header('Content-Type: application/json');
include 'config.php';

// Verifica si se ha proporcionado un ID
if (isset($_GET['id'])) {
    $emisorId = $_GET['id'];

    // Prepara y ejecuta la consulta
    $stmt = $connection->prepare("
        SELECT t_persona.*, t_municipio.idDepartamento, t_giro_comercial.nombreGiro AS nombreGiroComercial, t_giro_comercial.codigoGiro AS codigoGiroComercial
        FROM t_persona 
        JOIN t_municipio ON t_persona.idMunicipio = t_municipio.id
        JOIN t_giro_comercial ON t_persona.idGiroComercial = t_giro_comercial.id
        WHERE t_persona.id = ?
    ");
    $stmt->bind_param("i", $emisorId);
    $stmt->execute();
    $result = $stmt->get_result();

    // Verifica si se encontraron resultados
    if ($result->num_rows > 0) {
        $emisor = $result->fetch_assoc();
        echo json_encode($emisor);
    } else {
        echo json_encode(['error' => 'No se encontró el emisor']);
    }

    $stmt->close();
} else {
    echo json_encode(['error' => 'ID no proporcionado']);
}

$connection->close();
?>
