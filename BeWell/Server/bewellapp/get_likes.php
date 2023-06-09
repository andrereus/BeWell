<?php
$db_host = '127.0.0.1';
$db_user = 'root';
$db_password = '';
$db_name = 'beWellApp';

$conn = new mysqli($db_host, $db_user, $db_password, $db_name);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$output = [];

$sql = "SELECT * FROM likes";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  while ($row = $result->fetch_assoc()) {
    $output[] = $row;
  }
} else {
  $output = array("state" => "0");
}

echo json_encode($output, JSON_UNESCAPED_UNICODE);

$conn->close();
