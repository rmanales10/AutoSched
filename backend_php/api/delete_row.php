<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the ID from the POST data
    $data = json_decode(file_get_contents("php://input"), true);
    $id = isset($data['id']) ? $data['id'] : null;
    $table = isset($data['table']) ? $data['table'] : null;

    if ($id) {
        try {
            // Prepare the SQL statement
            $stmt = $conn->prepare("DELETE FROM $table WHERE id = :id");
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);

            // Execute the statement
            if ($stmt->execute()) {
                if ($stmt->rowCount() > 0) {
                    echo json_encode(["status" => "success", "message" => "Deleted successfully"]);
                } else {
                    echo json_encode(["status" => "error", "message" => "Not found with the given ID"]);
                }
            } else {
                echo json_encode(["status" => "error", "message" => "Failed to delete"]);
            }
        } catch (PDOException $e) {
            echo json_encode(["status" => "error", "message" => "Database error: " . $e->getMessage()]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "ID is required"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}
