<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

try {
    $query = "SELECT * FROM campus_list";
    $stmt = $conn->prepare($query);
    $stmt->execute();

    $campuses = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($campuses) {
        $response = [
            "status" => "success",
            "message" => "Campuses retrieved successfully",
            "data" => $campuses
        ];
    } else {
        $response = [
            "status" => "success",
            "message" => "No campuses found",
            "data" => []
        ];
    }
} catch (PDOException $e) {
    $response = [
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ];
}

echo json_encode($response);
