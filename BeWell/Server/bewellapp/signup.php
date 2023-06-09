<?php
$email = $_POST['email'];
$password = $_POST['password'];
$username = $_POST['username'];

$db_host = '127.0.0.1';
$db_user = 'root';
$db_password = '';
$db_name = 'beWellApp';

$conn = new mysqli($db_host, $db_user, $db_password, $db_name);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$output = [];

$check = "SELECT * FROM users WHERE email = '" . $email . "'";
$result = $conn->query($check);

if ($result->num_rows <= 0) {
  $sql = "INSERT INTO users(email, password, username) VALUES ('" . $email . "','" . $password . "','" . $username . "')";

  if ($conn->query($sql) === true) {
    $output = array("state" => "1", "message" => "Bitte prüfen Sie ihre E-Mails und bestätigen Sie die Registrierung!");
  } else {
    $output = array("state" => "0", "message" => "Error");
  }

  $message  = "Bitte bestätigen Sie Ihre Registrierung durch das Klicken auf den Link:" . "\r\n";
  $message .= "http://127.0.0.1/bewellapp/register.php?username=" . $username . "\r\n";
  $message .= "Vielen Dank!";

  // Note: Don't forget to set up permissions on folders
  $fp = fopen("emails/" . date("y.m.d_h.i.s") . "_" . $username . ".txt", "w");
  fwrite($fp, $message);
  fclose($fp);
} else {
  $output = array("state" => "0", "txt" => "Nutzername existiert schon, versuchen Sie bitte einen anderen!");
}

echo json_encode($output, JSON_UNESCAPED_UNICODE);

$conn->close();
