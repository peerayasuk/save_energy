<?php
require_once 'config.php';

// ถ้าเข้าสู่ระบบแล้ว ไปหน้าหลัก
if (isLoggedIn()) {
    redirect('index.php');
}

$error = '';

// ตรวจสอบการ submit form
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    $stmt = $conn->prepare("SELECT id, username, password, name FROM users WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows == 1) {
        $user = $result->fetch_assoc();

        if (password_verify($password, $user['password'])) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['username'] = $user['username'];
            $_SESSION['name'] = $user['name'];
            redirect('index.php');
        } else {
            $error = 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง';
        }
    } else {
        $error = 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง';
    }
    $stmt->close();
}
?>
<!DOCTYPE html>
<html lang="th">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>เข้าสู่ระบบ - Save-Energy Go!</title>

    <!-- แยก CSS ออกไปอยู่อีกไฟล์ -->
    <link rel="stylesheet" href="styles.css">
</head>

<body class="login-page">
    <div class="login-container">
        <div class="logo-container">
            <div class="logo">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
                </svg>
            </div>
            <h1>Save-Energy Go!</h1>
            <p class="subtitle">เกมความรู้และภารกิจประหยัดพลังงาน</p>
        </div>

        <?php if ($error): ?>
            <div class="error-message">
                <?php echo clean($error); ?>
            </div>
        <?php endif; ?>

        <form method="POST" action="">
            <div class="form-group">
                <label for="username">ชื่อผู้ใช้</label>
                <input type="text" id="username" name="username" placeholder="demo" required>
            </div>

            <div class="form-group">
                <label for="password">รหัสผ่าน</label>
                <input type="password" id="password" name="password" placeholder="demo123" required>
            </div>

            <button type="submit" class="btn-login">เข้าสู่ระบบ</button>
        </form>

        <div class="register-link">
            <p>ยังไม่มีบัญชี?</p>
            <a href="register.php">ลงทะเบียนที่นี่</a>
        </div>
    </div>
</body>

</html>