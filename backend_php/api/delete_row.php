<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the data from the POST request
    $data = json_decode(file_get_contents("php://input"), true);
    $table = isset($data['table']) ? $data['table'] : null;
    $column_name = isset($data['column_name']) ? $data['column_name'] : 'id';
    $value = isset($data['value']) ? $data['value'] : null;

    if ($table && $value) {
        try {
            // Prepare the SQL statement
            $stmt = $conn->prepare("DELETE FROM $table WHERE $column_name = :value");
            $stmt->bindParam(':value', $value, PDO::PARAM_STR);

            // Execute the statement
            if ($stmt->execute()) {
                if ($stmt->rowCount() > 0) {
                    echo json_encode(["status" => "success", "message" => "Deleted successfully"]);
                } else {
                    echo json_encode(["status" => "error", "message" => "Not found with the given value"]);
                }
            } else {
                echo json_encode(["status" => "error", "message" => "Failed to delete"]);
            }
        } catch (PDOException $e) {
            echo json_encode(["status" => "error", "message" => "Database error: " . $e->getMessage()]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "Table and value are required"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}
