<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->campus_name) && !empty($data->campus_type) && !empty($data->address)) {
    try {
        $query = "INSERT INTO campus_list (campus_name, campus_type, address) VALUES (:campus_name, :campus_type, :address)";

        $stmt = $conn->prepare($query);

        $stmt->bindParam(':campus_name', $data->campus_name);
        $stmt->bindParam(':campus_type', $data->campus_type);
        $stmt->bindParam(':address', $data->address);

        if ($stmt->execute()) {
            $response = [
                "status" => "success",
                "message" => "Campus added successfully",
                "id" => $conn->lastInsertId()
            ];
        } else {
            $response = [
                "status" => "error",
                "message" => "Failed to add campus"
            ];
        }
    } catch (PDOException $e) {
        $response = [
            "status" => "error",
            "message" => "Database error: " . $e->getMessage()
        ];
    }
} else {
    $response = [
        "status" => "error",
        "message" => "Incomplete data. Please provide campus_name, campus_type, and address."
    ];
}

echo json_encode($response);
