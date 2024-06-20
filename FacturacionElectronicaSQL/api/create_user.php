<?php
// api/create_user.php
include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

// Validaciones en el backend
if (empty($data['nombre']) || empty($data['apellidos']) || empty($data['correo']) || 
    empty($data['dui']) || empty($data['nit']) || empty($data['nrc']) || empty($data['telefono'])) {
    http_response_code(400);
    echo json_encode(["error" => "Todos los campos son obligatorios."]);
    exit;
}

if (!filter_var($data['correo'], FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(["error" => "Correo electrónico no válido."]);
    exit;
}

if (!preg_match("/^\d{8}-\d{1}$/", $data['dui'])) {
    http_response_code(400);
    echo json_encode(["error" => "DUI no válido. Debe tener el formato 12345678-9."]);
    exit;
}

$apellidos = $data['apellidos'];
$correo = $data['correo'];
$nombre = $data['nombre'];
$nrc = $data['nrc'];
$dui = $data['dui'];
$nit = $data['nit'];
$telefono = $data['telefono'];

$sql = "INSERT INTO t_usuario (apellidos, correo, nombre, nrc, dui, nit, telefono) VALUES (?, ?, ?, ?, ?, ?, ?)";

$stmt = $connection->prepare($sql);
$stmt->bind_param("sssssss", $apellidos, $correo, $nombre, $nrc, $dui, $nit, $telefono);

if ($stmt->execute()) {
    echo json_encode(["message" => "User created successfully"]);
} else {
    http_response_code(500);
    echo json_encode(["error" => $stmt->error]);
}

$stmt->close();
$connection->close();
?>
