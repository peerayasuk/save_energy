<?php
require_once 'config.php';

// ตรวจสอบการเข้าสู่ระบบ
if (!isLoggedIn()) {
    redirect('login.php');
}

$user_id = $_SESSION['user_id'];

// ฟังก์ชันช่วยดึงค่าจากฐานข้อมูลแบบตัวเดียว (scalar)
function get_single_value($conn, $sql, $types, ...$params)
{
    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        return 0;
    }

    $stmt->bind_param($types, ...$params);
    $stmt->execute();

    // แก้ Intelephense: ประกาศ $value ก่อนใช้งาน
    $value = null;

    $stmt->store_result();
    $stmt->bind_result($value);
    $stmt->fetch();
    $stmt->close();

    return $value ?? 0;
}



// คำนวณคะแนนจากภารกิจ
$total_points = get_single_value(
    $conn,
    "SELECT COALESCE(SUM(m.points), 0) AS total_points
     FROM completed_missions cm
     JOIN missions m ON cm.mission_id = m.id
     WHERE cm.user_id = ?",
    "i",
    $user_id
);

// นับจำนวนภารกิจที่สำเร็จ
$completed_missions = get_single_value(
    $conn,
    "SELECT COUNT(*) AS completed FROM completed_missions WHERE user_id = ?",
    "i",
    $user_id
);

// ดึงคะแนนควิซล่าสุด
$quiz_score = '-';
$stmt = $conn->prepare("
    SELECT score 
    FROM quiz_results 
    WHERE user_id = ? 
    ORDER BY taken_at DESC 
    LIMIT 1
");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$stmt->bind_result($score);
if ($stmt->fetch()) {
    $quiz_score = $score;
}
$stmt->close();

// หน้าที่จะแสดง
$page = $_GET['page'] ?? 'home';
?>
<!DOCTYPE html>
<html lang="th">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Save-Energy Go!</title>
    <!-- ลิงก์ไปยังไฟล์ CSS ภายนอก -->
    <link rel="stylesheet" href="styles.css">
</head>

<body>
    <header>
        <div class="header-content">
            <div class="logo-section">
                <svg class="logo-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
                </svg>
                <span class="logo-text">Save-Energy Go!</span>
            </div>
            <div class="user-section">
                <div class="user-info">
                    <div class="user-name">
                        สวัสดี, <?php echo clean($_SESSION['name']); ?>
                    </div>
                    <div class="user-points">
                        <?php echo $total_points; ?> คะแนน
                    </div>
                </div>
                <form method="POST" action="logout.php" class="logout-form">
                    <button type="submit" class="btn-logout">ออกจากระบบ</button>
                </form>
            </div>
        </div>
    </header>

    <nav>
        <div class="nav-content">
            <a href="?page=home" class="nav-link <?php echo $page === 'home' ? 'active' : ''; ?>">หน้าหลัก</a>
            <a href="?page=learn" class="nav-link <?php echo $page === 'learn' ? 'active' : ''; ?>">เรียนรู้</a>
            <a href="?page=quiz" class="nav-link <?php echo $page === 'quiz' ? 'active' : ''; ?>">ควิซ</a>
            <a href="?page=missions" class="nav-link <?php echo $page === 'missions' ? 'active' : ''; ?>">ภารกิจ</a>
            <a href="?page=progress" class="nav-link <?php echo $page === 'progress' ? 'active' : ''; ?>">ความคืบหน้า</a>
        </div>
    </nav>

    <main>
        <?php
        // แสดงเนื้อหาตามหน้าที่เลือก
        switch ($page) {
            case 'learn':
                include 'pages/learn.php';
                break;
            case 'quiz':
                include 'pages/quiz.php';
                break;
            case 'missions':
                include 'pages/mission.php';
                break;
            case 'progress':
                include 'pages/progress.php';
                break;
            default:
                include 'pages/home.php';
                break;
        }
        ?>
    </main>
</body>

</html>