<?php
$email = $_POST['email'];
$password = $_POST['password'];

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

if ($result->num_rows > 0) {
  while ($row = $result->fetch_assoc()) {

    if ($row["registered"] == "1") {
      if ($row["password"] == $password) {
        $output = array("state" => "1", "message" => "Angemeldet", "uid" => $row["id"], "email" => $row["email"], "username" => $row["username"], "reported" => $row["reported"]);
      } else {
        // To prevent User Enumeration, no details are provided if only email or only password is wrong
        $output = array("state" => "0", "message" => "E-Mail oder Passwort ist nicht korrekt!");
      }
    } else {
      $output = array("state" => "0", "message" => "Die Registrierung wurde noch nicht bestätigt!");
    }
  }
} else {
  // To prevent User Enumeration, no details are provided if only email or only password is wrong
  $output = array("state" => "0", "message" => "E-Mail oder Passwort ist nicht korrekt!");
}

echo json_encode($output, JSON_UNESCAPED_UNICODE);

$conn->close();
