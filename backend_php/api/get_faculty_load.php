<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

try {
    $stmt = $conn->prepare("SELECT `subject_code`, `descriptive_title`, `lec`, `lab`, `faculty`, `section` FROM `auto_sched`.`faculty_load`");
    $stmt->execute();
    $faculty_load = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (count($faculty_load) > 0) {
        echo json_encode([
            "status" => "success",
            "data" => $faculty_load
        ]);
    } else {    
        echo json_encode([
            "status" => "error",
            "message" => "No faculty load found"
        ]);
    }
} catch (PDOException $e) {
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
