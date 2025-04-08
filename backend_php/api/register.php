<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->email) && !empty($data->password) && !empty($data->access_role)) {
    $email = htmlspecialchars(strip_tags($data->email));
    $password = password_hash($data->password, PASSWORD_DEFAULT); // Hash the password
    $access_role = htmlspecialchars(strip_tags($data->access_role));

    // Check if email already exists
    $check_stmt = $conn->prepare("SELECT email FROM users WHERE email = ?");
    $check_stmt->execute([$email]);

    if ($check_stmt->rowCount() > 0) {
        echo json_encode(["status" => "error", "message" => "Email already exists"]);
    } else {
        // Insert new user
        $insert_stmt = $conn->prepare("INSERT INTO users (email, password, access_role) VALUES (?, ?, ?)");

        if ($insert_stmt->execute([$email, $password, $access_role])) {
            echo json_encode([
                "status" => "success",
                "message" => "User registered successfully",
                "user" => [
                    "id" => $conn->lastInsertId(),
                    "email" => $email,
                    "access_role" => $access_role
                ]
            ]);
        } else {
            echo json_encode(["status" => "error", "message" => "Registration failed"]);
        }
    }
} else {
    echo json_encode(["status" => "error", "message" => "Incomplete data"]);
}
