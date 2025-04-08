<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->load_id) && !empty($data->faculty) && !empty($data->section)) {

    $query = "UPDATE faculty_load 
              SET faculty = :faculty,
                  section = :section
              WHERE load_id = :load_id";

    $stmt = $conn->prepare($query);

    $stmt->bindParam(':load_id', $data->load_id);
    $stmt->bindParam(':faculty', $data->faculty);
    $stmt->bindParam(':section', $data->section);

    if ($stmt->execute()) {
        echo json_encode(array("status" => "success", "message" => "Faculty and section updated successfully."));
    } else {
        echo json_encode(array("status" => "error", "message" => "Unable to update faculty and section."));
    }
} else {
    echo json_encode(array("status" => "error", "message" => "Incomplete data. Please provide load_id, faculty, and section."));
}
