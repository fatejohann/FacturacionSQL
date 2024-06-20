<?php
// api/config.php
$host = 'localhost';
$db_name = 'bd_facturacion';
$username = 'root';
$password = '';
$connection = new mysqli($host, $username, $password, $db_name);

if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}
?>
