<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->user_id)) {
    try {
        $stmt = $conn->prepare("SELECT * FROM faculty WHERE user_id = ?");
        $stmt->execute([$data->user_id]);
        $users = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if (count($users) > 0) {
            echo json_encode([
                "status" => "success",
                "data" => $users
            ]);
        } else {
            echo json_encode([
                "status" => "error",
                "message" => "No faculty found for this user ID"
            ]);
        }
    } catch (PDOException $e) {
        echo json_encode([
            "status" => "error",
            "message" => "Database error: " . $e->getMessage()
        ]);
    }
} else {
    echo json_encode([
        "status" => "error",
        "message" => "User ID is required"
    ]);
}
