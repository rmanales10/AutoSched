<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

$data = json_decode(file_get_contents("php://input"));

if (
    !empty($data->subject_code) &&
    !empty($data->descriptive_title) &&
    !empty($data->lec) &&
    !empty($data->lec_hrs) &&
    !empty($data->lab) &&
    !empty($data->lab_hrs) &&
    !empty($data->credit) &&
    !empty($data->subject_area) &&
    !empty($data->year_level) &&
    !empty($data->program) &&
    !empty($data->major) &&
    !empty($data->mode)
) {
    try {
        $query = "INSERT INTO subjects 
                  (subject_code, descriptive_title, lec, lec_hrs, lab, lab_hrs, credit, subject_area, year_level, program, major, mode) 
                  VALUES 
                  (:subject_code, :descriptive_title, :lec, :lec_hrs, :lab, :lab_hrs, :credit, :subject_area, :year_level, :program, :major, :mode)";

        $stmt = $conn->prepare($query);

        $stmt->bindParam(':subject_code', $data->subject_code);
        $stmt->bindParam(':descriptive_title', $data->descriptive_title);
        $stmt->bindParam(':lec', $data->lec);
        $stmt->bindParam(':lec_hrs', $data->lec_hrs);
        $stmt->bindParam(':lab', $data->lab);
        $stmt->bindParam(':lab_hrs', $data->lab_hrs);
        $stmt->bindParam(':credit', $data->credit);
        $stmt->bindParam(':subject_area', $data->subject_area);
        $stmt->bindParam(':year_level', $data->year_level);
        $stmt->bindParam(':program', $data->program);
        $stmt->bindParam(':major', $data->major);
        $stmt->bindParam(':mode', $data->mode);

        if ($stmt->execute()) {
            echo json_encode(array("status" => "success", "message" => "Subject added successfully."));
        } else {
            echo json_encode(array("status" => "error", "message" => "Failed to add subject."));
        }
    } catch (PDOException $e) {
        echo json_encode(array("status" => "error", "message" => "Database error: " . $e->getMessage()));
    }
} else {
    echo json_encode(array("status" => "error", "message" => "Incomplete data. Please provide all required fields."));
}
