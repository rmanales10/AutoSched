<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

try {
    $stmt = $conn->prepare("SELECT * FROM subjects");
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "status" => "success",
        "data" => $result
    ]);
} catch (PDOException $e) {
    echo json_encode([
        "status" => "error",
        "message" => "Failed to fetch subjects: " . $e->getMessage()
    ]);
}
