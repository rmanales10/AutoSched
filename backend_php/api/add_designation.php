<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->designation) && !empty($data->office_or_department) && !empty($data->time_release)) {
    try {
        $query = "INSERT INTO designation_list (designation, office_or_department, time_release) VALUES (:designation, :office_or_department, :time_release)";

        $stmt = $conn->prepare($query);

        $stmt->bindParam(':designation', $data->designation);
        $stmt->bindParam(':office_or_department', $data->office_or_department);
        $stmt->bindParam(':time_release', $data->time_release);

        if ($stmt->execute()) {
            $response = [
                "status" => "success",
                "message" => "Designation added successfully",
                "id" => $conn->lastInsertId()
            ];
        } else {
            $response = [
                "status" => "error",
                "message" => "Failed to add designation"
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
        "message" => "Incomplete data. Please provide designation, office_or_department, and time_release."
    ];
}

echo json_encode($response);
