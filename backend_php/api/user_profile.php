<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

require(__DIR__ . '/../config/db.php');

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->user_id)) {
    $user_id = htmlspecialchars(strip_tags($data->user_id));

    // First, fetch the current user data
    $fetch_stmt = $conn->prepare("SELECT * FROM users WHERE user_id = ?");
    $fetch_stmt->execute([$user_id]);
    $user = $fetch_stmt->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        $updates = [];
        $params = [];

        // Update fields with new values if provided
        if (!empty($data->email)) {
            $updates[] = "email = ?";
            $params[] = htmlspecialchars(strip_tags($data->email));
        }
        if (!empty($data->password)) {
            $updates[] = "password = ?";
            $params[] = htmlspecialchars(strip_tags($data->password));
        }
        if (!empty($data->access_role)) {
            $updates[] = "access_role = ?";
            $params[] = htmlspecialchars(strip_tags($data->access_role));
        }
        if (!empty($data->username)) {
            $updates[] = "username = ?";
            $params[] = htmlspecialchars(strip_tags($data->username));
        }
        if (!empty($data->firstname)) {
            $updates[] = "firstname = ?";
            $params[] = htmlspecialchars(strip_tags($data->firstname));
        }
        if (!empty($data->lastname)) {
            $updates[] = "lastname = ?";
            $params[] = htmlspecialchars(strip_tags($data->lastname));
        }
        if (!empty($data->mobile_number)) {
            $updates[] = "mobile_number = ?";
            $params[] = htmlspecialchars(strip_tags($data->mobile_number));
        }
        if (!empty($data->profile_image)) {
            $updates[] = "profile_image = ?";
            // Don't strip tags for base64 image data
            $params[] = $data->profile_image;
        }

        if (!empty($updates)) {
            $sql = "UPDATE users SET " . implode(", ", $updates) . " WHERE user_id = ?";
            $params[] = $user_id;

            $update_stmt = $conn->prepare($sql);

            if ($update_stmt->execute($params)) {
                // Fetch the updated user data
                $fetch_stmt->execute([$user_id]);
                $updated_user = $fetch_stmt->fetch(PDO::FETCH_ASSOC);

                echo json_encode([
                    "status" => "success",
                    "message" => "User updated successfully",
                    "user" => $updated_user
                ]);
            } else {
                echo json_encode(["status" => "error", "message" => "Error updating user"]);
            }
        } else {
            echo json_encode(["status" => "info", "message" => "No fields to update"]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "User not found"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "User ID is required"]);
}
