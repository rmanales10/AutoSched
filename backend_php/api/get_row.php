<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

// Check if it's a GET or POST request
if ($_SERVER['REQUEST_METHOD'] === 'GET' || $_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get parameters from the request
    $table_name = isset($_GET['table_name']) ? $_GET['table_name'] : null;

    // For POST requests, check for user_id, column_name, and value
    $user_id = null;
    $column_name = null;
    $value = null;
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $data = json_decode(file_get_contents("php://input"));
        $user_id = isset($data->user_id) ? $data->user_id : null;
        $column_name = isset($data->column_name) ? $data->column_name : null;
        $value = isset($data->value) ? $data->value : null;
    }

    // Validate required parameters
    if (!$table_name) {
        echo json_encode([
            "status" => "error",
            "message" => "Missing required parameter. Please provide table_name."
        ]);
        exit;
    }

    try {
        // Prepare the SQL query
        if ($user_id !== null && $column_name !== null && $value !== null) {
            $query = "SELECT * FROM $table_name WHERE user_id = :user_id AND $column_name = :value";
            $stmt = $conn->prepare($query);
            $stmt->bindParam(':user_id', $user_id);
            $stmt->bindParam(':value', $value);
        } elseif ($user_id !== null) {
            $query = "SELECT * FROM $table_name WHERE user_id = :user_id";
            $stmt = $conn->prepare($query);
            $stmt->bindParam(':user_id', $user_id);
        } else {
            $query = "SELECT * FROM $table_name";
            $stmt = $conn->prepare($query);
        }

        // Execute the query
        $stmt->execute();

        // Fetch all results
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if ($results) {
            echo json_encode([
                "status" => "success",
                "data" => $results
            ]);
        } else {
            echo json_encode([
                "status" => "success",
                "message" => "No rows found in the table.",
                "data" => []
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
        "message" => "Invalid request method. Use GET or POST."
    ]);
}
