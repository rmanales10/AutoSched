<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

// Check if it's a POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get JSON data from the request body
    $data = json_decode(file_get_contents("php://input"), true);

    // Validate required parameters
    if (!isset($data['table_name']) || !isset($data['columns']) || !is_array($data['columns'])) {
        echo json_encode([
            "status" => "error",
            "message" => "Missing required parameters. Please provide table_name and columns."
        ]);
        exit;
    }

    $table_name = $data['table_name'];
    $columns = $data['columns'];

    try {
        // Prepare column names and placeholders for the SQL query
        $column_names = implode(", ", array_keys($columns));
        $placeholders = ":" . implode(", :", array_keys($columns));

        // Prepare the SQL query
        $query = "INSERT INTO $table_name ($column_names) VALUES ($placeholders)";
        $stmt = $conn->prepare($query);

        // Bind parameters
        foreach ($columns as $key => $value) {
            $stmt->bindValue(":$key", $value);
        }

        // Execute the query
        if ($stmt->execute()) {
            $last_insert_id = $conn->lastInsertId();
            echo json_encode([
                "status" => "success",
                "message" => "Row added successfully",
                "id" => $last_insert_id
            ]);
        } else {
            echo json_encode([
                "status" => "error",
                "message" => "Failed to add row"
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
        "message" => "Invalid request method. Use POST."
    ]);
}
