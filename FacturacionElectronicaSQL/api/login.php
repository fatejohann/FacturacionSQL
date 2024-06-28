<?php
// api/login.php
include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

if (empty($data['correo']) || empty($data['nit'])) {
    http_response_code(400);
    echo json_encode(["error" => "Todos los campos son obligatorios."]);
    exit;
}

$correo = $data['correo'];
$nit = $data['nit'];

$sql = "SELECT * FROM t_usuario WHERE correo = ? AND nit = ?";
$stmt = $connection->prepare($sql);
$stmt->bind_param("ss", $correo, $nit);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    session_start();
    $_SESSION['user_id'] = $user['id'];
    $_SESSION['user_name'] = $user['nombre'];
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false]);
}

$stmt->close();
$connection->close();
?>
