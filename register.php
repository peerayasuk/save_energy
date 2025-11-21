<?php
require_once 'config.php';

// ถ้าเข้าสู่ระบบแล้ว ไปหน้าหลัก
if (isLoggedIn()) {
    redirect('index.php');
}

$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    $confirm_password = $_POST['confirm_password'] ?? '';
    $name = trim($_POST['name'] ?? '');

    if (empty($username) || empty($password) || empty($name)) {
        $error = 'กรุณากรอกข้อมูลให้ครบถ้วน';
    } elseif (strlen($username) < 3) {
        $error = 'ชื่อผู้ใช้ต้องมีอย่างน้อย 3 ตัวอักษร';
    } elseif (strlen($password) < 6) {
        $error = 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
    } elseif ($password !== $confirm_password) {
        $error = 'รหัสผ่านไม่ตรงกัน';
    } else {
        $stmt = $conn->prepare("SELECT id FROM users WHERE username = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $error = 'ชื่อผู้ใช้นี้มีอยู่แล้ว';
        } else {
            $hashed_password = password_hash($password, PASSWORD_DEFAULT);
            $insert = $conn->prepare("INSERT INTO users (username, password, name) VALUES (?, ?, ?)");
            $insert->bind_param("sss", $username, $hashed_password, $name);

            if ($insert->execute()) {
                $success = 'ลงทะเบียนสำเร็จ! กำลังเข้าสู่ระบบ...';

                $_SESSION['user_id'] = $insert->insert_id;
                $_SESSION['username'] = $username;
                $_SESSION['name'] = $name;

                echo "<script>setTimeout(function(){ window.location.href = 'index.php'; }, 1500);</script>";
            } else {
                $error = 'เกิดข้อผิดพลาดในการลงทะเบียน';
            }
            $insert->close();
        }
        $stmt->close();
    }
}
?>
<!DOCTYPE html>
<html lang="th">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ลงทะเบียน - Save-Energy Go!</title>

    <!-- โหลดไฟล์ CSS รวมทั้งระบบ -->
    <link rel="stylesheet" href="styles.css">
</head>

<body class="register-page">

    <div class="register-container">
        <div class="logo-container">
            <div class="logo">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
                </svg>
            </div>

            <h1>ลงทะเบียน</h1>
            <p class="subtitle">สร้างบัญชีใหม่ Save-Energy Go!</p>
        </div>

        <?php if ($error): ?>
            <div class="error-message"><?php echo clean($error); ?></div>
        <?php endif; ?>

        <?php if ($success): ?>
            <div class="success-message"><?php echo clean($success); ?></div>
        <?php endif; ?>

        <form method="POST">
            <div class="form-group">
                <label>ชื่อ-นามสกุล</label>
                <input type="text" name="name" required value="<?php echo isset($_POST['name']) ? clean($_POST['name']) : ''; ?>">
            </div>

            <div class="form-group">
                <label>ชื่อผู้ใช้</label>
                <input type="text" name="username" required value="<?php echo isset($_POST['username']) ? clean($_POST['username']) : ''; ?>">
            </div>

            <div class="form-group">
                <label>รหัสผ่าน</label>
                <input type="password" name="password" required>
            </div>

            <div class="form-group">
                <label>ยืนยันรหัสผ่าน</label>
                <input type="password" name="confirm_password" required>
            </div>

            <button type="submit" class="btn-register">ลงทะเบียน</button>
        </form>

        <div class="login-link">
            <p>มีบัญชีอยู่แล้ว?</p>
            <a href="login.php">เข้าสู่ระบบที่นี่</a>
        </div>
    </div>

</body>

</html>