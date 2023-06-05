<?php
$email = $_GET['email'];

$db_host = '127.0.0.1';
$db_user = 'root';
$db_password = '';
$db_name = 'beWellApp';

$conn = new mysqli($db_host, $db_user, $db_password, $db_name);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "UPDATE users SET registered='1' WHERE email='" . $email . "'";

if ($conn->query($sql) === true) {
  echo "Die Registrierung wurde bestätigt!";
} else {
  echo "Leider ist ein Fehler aufgetretten, registrieren Sie sich bitte erneut!";
}

$conn->close();
