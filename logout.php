
<?php
require_once 'config.php';

// ล้าง session
session_destroy();

// ไปหน้า login
redirect('login.php');
?>