<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

// Check if user_id is provided
if (isset($_GET['user_id'])) {
    $user_id = intval($_GET['user_id']);

    // Prepare the SQL statement
    $sql = "SELECT * FROM teaching_load_list WHERE user_id = ?";

    $stmt = $conn->prepare($sql);

    if ($stmt->execute([$user_id])) {
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if (count($result) > 0) {
            echo json_encode([
                "status" => "success",
                "message" => "Teaching load data retrieved successfully",
                "data" => $result
            ]);
        } else {
            echo json_encode([
                "status" => "error",
                "message" => "No teaching load data found for this user"
            ]);
        }
    } else {
        echo json_encode([
            "status" => "error",
            "message" => "Error executing query"
        ]);
    }
} else {
    echo json_encode([
        "status" => "error",
        "message" => "User ID is required"
    ]);
}
