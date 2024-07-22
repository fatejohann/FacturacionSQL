<?php
header('Content-Type: application/json');
include 'config.php';

// Verifica si se ha proporcionado un ID
if (isset($_GET['id'])) {
    $receptorId = $_GET['id'];

    // Prepara y ejecuta la consulta
    $stmt = $connection->prepare("SELECT t_cliente.*, t_municipio.idDepartamento, t_giro_comercial.codigoGiro AS codigoGiroComercial, t_giro_comercial.nombreGiro AS nombreGiroComercial 
                                  FROM t_cliente 
                                  JOIN t_municipio ON t_cliente.idMunicipio = t_municipio.id 
                                  JOIN t_giro_comercial ON t_cliente.idGiroComercial = t_giro_comercial.id 
                                  WHERE t_cliente.id = ?");
    $stmt->bind_param("i", $receptorId);
    $stmt->execute();
    $result = $stmt->get_result();

    // Verifica si se encontraron resultados
    if ($result->num_rows > 0) {
        $receptor = $result->fetch_assoc();
        echo json_encode($receptor);
    } else {
        echo json_encode(['error' => 'No se encontró el receptor']);
    }

    $stmt->close();
} else {
    echo json_encode(['error' => 'ID no proporcionado']);
}

$connection->close();
?>
