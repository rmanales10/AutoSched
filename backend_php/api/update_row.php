<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->table_name) && !empty($data->id_column) && !empty($data->id_value)) {
    $table_name = htmlspecialchars(strip_tags($data->table_name));
    $id_column = htmlspecialchars(strip_tags($data->id_column));
    $id_value = htmlspecialchars(strip_tags($data->id_value));

    $updates = [];
    $params = [];

    foreach ($data as $key => $value) {
        if ($key !== 'table_name' && $key !== 'id_column' && $key !== 'id_value') {
            $updates[] = "$key = :$key";
            $params[":$key"] = htmlspecialchars(strip_tags($value));
        }
    }

    if (!empty($updates)) {
        $query = "UPDATE $table_name SET " . implode(", ", $updates) . " WHERE $id_column = :id_value";
        $params[":id_value"] = $id_value;

        $stmt = $conn->prepare($query);

        if ($stmt->execute($params)) {
            echo json_encode(array("status" => "success", "message" => "Row updated successfully."));
        } else {
            echo json_encode(array("status" => "error", "message" => "Unable to update row."));
        }
    } else {
        echo json_encode(array("status" => "error", "message" => "No fields to update."));
    }
} else {
    echo json_encode(array("status" => "error", "message" => "Incomplete data. Please provide table_name, id_column, and id_value."));
}
