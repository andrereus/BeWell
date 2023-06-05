<?php
$type = $_POST['type'];
$image = $_POST['image'];
$quote = $_POST['quote'];
$quoteAuthor = $_POST['quoteAuthor'];
$uid = $_POST['uid'];
$category = $_POST['category'];
$reported = $_POST['reported'];

$db_host = '127.0.0.1';
$db_user = 'root';
$db_password = '';
$db_name = 'beWellApp';

$conn = new mysqli($db_host, $db_user, $db_password, $db_name);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$output = [];

// Prepared Statement um SQL Injection zu verhindern
$sql = "INSERT INTO posts(type, image, quote, quoteAuthor, uid, category, reported) VALUES (?, ?, ?, ?, ?, ?, ?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param("sssssss", $type, $image, $quote, $quoteAuthor, $uid, $category, $reported);

if ($stmt->execute()) {
    $output = array("state"=>"1");
} else {
    $output = array("state"=>"0");
}

echo json_encode($output);

$stmt->close();
$conn->close();
