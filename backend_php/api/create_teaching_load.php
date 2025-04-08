<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

$data = json_decode(file_get_contents("php://input"));

if (
    !empty($data->user_id) && !empty($data->semester) && !empty($data->program) &&
    !empty($data->major) && isset($data->{'1st_year'}) && isset($data->{'2nd_year'}) &&
    isset($data->{'3rd_year'}) && isset($data->{'4th_year'})
) {

    $user_id = htmlspecialchars(strip_tags($data->user_id));
    $semester = htmlspecialchars(strip_tags($data->semester));
    $program = htmlspecialchars(strip_tags($data->program));
    $major = htmlspecialchars(strip_tags($data->major));
    $first_year = intval($data->{'1st_year'});
    $second_year = intval($data->{'2nd_year'});
    $third_year = intval($data->{'3rd_year'});
    $fourth_year = intval($data->{'4th_year'});

    // Prepare the SQL statement
    $sql = "INSERT INTO teaching_load_list (user_id, semester, program, major, `1st_year`, `2nd_year`, `3rd_year`, `4th_year`) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    $stmt = $conn->prepare($sql);

    if ($stmt->execute([$user_id, $semester, $program, $major, $first_year, $second_year, $third_year, $fourth_year])) {
        echo json_encode([
            "status" => "success",
            "message" => "Teaching load added successfully",
            "teaching_load_id" => $conn->lastInsertId()
        ]);
    } else {
        echo json_encode(["status" => "error", "message" => "Error adding teaching load"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Incomplete data"]);
}
