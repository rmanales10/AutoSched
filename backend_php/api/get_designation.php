<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

try {
    $query = "SELECT id, designation, office_or_department, time_release FROM designation_list";

    // If you want to add filtering, you can uncomment and modify these lines
    // $filters = [];
    // $params = [];

    // if (isset($_GET['designation'])) {
    //     $filters[] = "designation LIKE :designation";
    //     $params[':designation'] = '%' . $_GET['designation'] . '%';
    // }

    // if (isset($_GET['office_or_department'])) {
    //     $filters[] = "office_or_department LIKE :office_or_department";
    //     $params[':office_or_department'] = '%' . $_GET['office_or_department'] . '%';
    // }

    // if (!empty($filters)) {
    //     $query .= " WHERE " . implode(" AND ", $filters);
    // }

    $stmt = $conn->prepare($query);

    // Uncomment this line if you're using parameters for filtering
    // $stmt->execute($params);

    $stmt->execute();

    $designations = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if ($designations) {
        $response = [
            "status" => "success",
            "message" => "Designations retrieved successfully",
            "data" => $designations
        ];
    } else {
        $response = [
            "status" => "success",
            "message" => "No designations found",
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
