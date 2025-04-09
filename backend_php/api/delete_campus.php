<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the campus ID from the POST data
    $data = json_decode(file_get_contents("php://input"), true);
    $campus_id = isset($data['campus_id']) ? $data['campus_id'] : null;

    if ($campus_id) {
        try {
            // Prepare the SQL statement
            $stmt = $conn->prepare("DELETE FROM campus_list WHERE id = :campus_id");
            $stmt->bindParam(':campus_id', $campus_id, PDO::PARAM_INT);

            // Execute the statement
            if ($stmt->execute()) {
                if ($stmt->rowCount() > 0) {
                    echo json_encode(["status" => "success", "message" => "Campus deleted successfully"]);
                } else {
                    echo json_encode(["status" => "error", "message" => "No campus found with the given ID"]);
                }
            } else {
                echo json_encode(["status" => "error", "message" => "Failed to delete campus"]);
            }
        } catch (PDOException $e) {
            echo json_encode(["status" => "error", "message" => "Database error: " . $e->getMessage()]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "Campus ID is required"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}
