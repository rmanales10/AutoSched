<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->user_id) && !empty($data->room_number) && !empty($data->room_name) && !empty($data->room_type) && !empty($data->description)) {
    try {
        $stmt = $conn->prepare("INSERT INTO rooms (user_id, room_number, room_name, room_type, description) VALUES (:user_id, :room_number, :room_name, :room_type, :description)");
        $stmt->bindParam(':user_id', $data->user_id);
        $stmt->bindParam(':room_number', $data->room_number);
        $stmt->bindParam(':room_name', $data->room_name);
        $stmt->bindParam(':room_type', $data->room_type);
        $stmt->bindParam(':description', $data->description);

        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "message" => "Room added successfully."]);
        } else {
            echo json_encode(["status" => "error", "message" => "Failed to add room."]);
        }
    } catch (PDOException $e) {
        echo json_encode(["status" => "error", "message" => "Database error: " . $e->getMessage()]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid input."]);
}
