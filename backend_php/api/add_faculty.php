<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

// Enable error reporting
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Log the raw input
$raw_input = file_get_contents("php://input");
error_log("Raw input: " . $raw_input);

$data = json_decode($raw_input);

// Log the decoded data
error_log("Decoded data: " . print_r($data, true));

$query = "INSERT INTO faculty (user_id, first_name, last_name, email, mobile_number, position, status, department, designation, constraints) 
              VALUES (:user_id, :first_name, :last_name, :email, :mobile_number, :position, :status, :department, :designation, :constraints)";

$stmt = $conn->prepare($query);

$stmt->bindParam(":user_id", $data->user_id);
$stmt->bindParam(":first_name", $data->first_name);
$stmt->bindParam(":last_name", $data->last_name);
$stmt->bindParam(":email", $data->email);
$stmt->bindParam(":mobile_number", $data->mobile_number);
$stmt->bindParam(":position", $data->position);
$stmt->bindParam(":status", $data->status);
$stmt->bindParam(":department", $data->department);
$stmt->bindParam(":designation", $data->designation);
$stmt->bindParam(":constraints", $data->constraints);

try {
    if ($stmt->execute()) {
        $faculty_id = $conn->lastInsertId();
        $response = [
            "status" => "success",
            "message" => "Faculty member added successfully",
            "faculty_id" => $faculty_id
        ];
        http_response_code(201);
    } else {
        $error = $stmt->errorInfo();
        $response = [
            "status" => "error",
            "message" => "Failed to add faculty member: " . $error[2],
            "error_code" => $error[1]
        ];
        http_response_code(500);
        error_log("Database error: " . print_r($error, true));
    }
} catch (PDOException $e) {
    $response = [
        "status" => "error",
        "message" => "Database error: " . $e->getMessage(),
    ];
    http_response_code(500);
    error_log("PDO Exception: " . $e->getMessage());
}

echo json_encode($response);
error_log("Response sent: " . json_encode($response));
