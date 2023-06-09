<?php
// Error reporting for testing purposes, remove in production to prevent leaking system info
ini_set('display_errors', 1);
error_reporting(E_ALL);

$type = $_POST['type'];
$image = $_POST['image'];
$quote = $_POST['quote'];
$quoteAuthor = $_POST['quoteAuthor'];
$uid = $_POST['uid'];
$category = $_POST['category'];
$reported = $_POST['reported'];

// Prevent empty input // TODO: Prevent empty image
if ($type == "quote" && $quote == "") {
  exit();
}

$db_host = '127.0.0.1';
$db_user = 'root';
$db_password = '';
$db_name = 'beWellApp';

$conn = new mysqli($db_host, $db_user, $db_password, $db_name);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$output = [];

// Prevent SQL Injection
$stmt = $conn->prepare("INSERT INTO posts(type, image, quote, quoteAuthor, uid, category, reported) VALUES (?, ?, ?, ?, ?, ?, ?)");
$stmt->bind_param("sssssss", $type, $image, $quote, $quoteAuthor, $uid, $category, $reported);

if ($stmt->execute()) {
  $output = array("state" => "1", "message" => "Neuer Post wurde eingetragen!");
} else {
  $output = array("state" => "0", "message" => "Error");
}

echo json_encode($output, JSON_UNESCAPED_UNICODE);

$stmt->close();
$conn->close();
