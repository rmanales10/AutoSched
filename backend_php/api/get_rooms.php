<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

// Check if user_id is provided in the GET request
if (isset($_GET['user_id'])) {
    $user_id = $_GET['user_id'];

    try {
        $stmt = $conn->prepare("SELECT * FROM rooms WHERE user_id = ?");
        $stmt->execute([$user_id]);
        $rooms = $stmt->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode([
            "status" => "success",
            "data" => $rooms
        ]);
    } catch (PDOException $e) {
        echo json_encode([
            "status" => "error",
            "message" => "Failed to fetch rooms: " . $e->getMessage()
        ]);
    }
} else {
    echo json_encode([
        "status" => "error",
        "message" => "User ID is required"
    ]);
}
