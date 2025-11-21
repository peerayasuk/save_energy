<?php
session_start();

// ตั้งค่าการเชื่อมต่อฐานข้อมูล
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '09112525');
define('DB_NAME', 'save_energy_go');

// เชื่อมต่อฐานข้อมูล
$conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

// ตรวจสอบการเชื่อมต่อ
if ($conn->connect_error) {
    die("การเชื่อมต่อล้มเหลว: " . $conn->connect_error);
}

// ตั้งค่า charset
$conn->set_charset("utf8mb4");

// ฟังก์ชันตรวจสอบการเข้าสู่ระบบ
function isLoggedIn()
{
    return isset($_SESSION['user_id']);
}

// ฟังก์ชันเปลี่ยนเส้นทาง
function redirect($url)
{
    header("Location: $url");
    exit();
}

// ฟังก์ชันป้องกัน XSS
function clean($data)
{
    return htmlspecialchars($data, ENT_QUOTES, 'UTF-8');
}
