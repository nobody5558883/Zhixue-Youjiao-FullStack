<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的课表 - 智学优教</title>
    <style>
        html, body {
            height: 100%;
            width: 100vw;
            overflow-x: hidden;
            position: relative;
        }
        body {
            min-height: 100vh;
            width: 100vw;
            background: #F5F7FA;
            font-family: Arial, Helvetica, sans-serif;
            padding-top: 72px;
        }
        .navbar {
            width: 100vw;
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.18);
            display: flex;
            align-items: center;
            justify-content: center;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 72px;
            z-index: 20;
        }
        .navbar-inner {
            width: 100%;
            max-width: 1200px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 24px;
        }
        .navbar-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .navbar-logo {
            height: 48px;
        }
        .navbar-title {
            font-size: 24px;
            color: #2A4D9B;
            font-weight: bold;
        }
        .navbar-page-title {
            font-size: 22px;
            color: #1e88e5;
            font-weight: 500;
            padding-left: 16px;
            margin-left: 16px;
            border-left: 1px solid #ccc;
        }
        .navbar-right .back-btn {
            background: #1e88e5;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 10px 24px;
            font-size: 15px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.2s;
        }
        .navbar-right .back-btn:hover {
            background: #1565c0;
        }
        .bg-img {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            width: 100vw;
            height: 100vh;
            z-index: 0;
            background: url('background.jpg') center center/cover no-repeat;
        }
        .bg-mask {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(255,255,255,0.85);
            z-index: 1;
        }
        .main-container {
            position: relative;
            z-index: 2;
            max-width: 1200px;
            margin: 24px auto 0 auto;
            display: flex;
            gap: 32px;
            background: rgba(255, 255, 255, 0.7);
            border-radius: 16px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.08);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.18);
            padding: 32px 24px;
            min-height: 700px;
        }
        .calendar-section {
            width: 380px;
            min-width: 280px;
            border-right: 1px solid rgba(255, 255, 255, 0.5);
            padding-right: 32px;
        }
        .calendar-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 18px;
        }
        .calendar-header button {
            background: #1e88e5;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 6px 18px;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.2s;
        }
        .calendar-header button:hover {
            background: #1565c0;
        }
        .calendar-table {
            width: 100%;
            border-collapse: collapse;
            background: transparent;
            border-radius: 12px;
            overflow: hidden;
        }
        .calendar-table th, .calendar-table td {
            width: 14.28%;
            text-align: center;
            vertical-align: middle;
            font-size: 15px;
            position: relative;
        }
        .calendar-table th {
            color: #1e88e5;
            font-weight: bold;
            background: rgba(227, 234, 253, 0.5);
            padding: 14px 0;
        }
        .calendar-table td {
            cursor: pointer;
            background: transparent;
            transition: background 0.2s;
            padding: 2px;
        }
        .day-wrapper {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 60px;
            width: 100%;
            border-radius: 8px;
            transition: background .2s;
        }
        .calendar-table td:hover .day-wrapper {
            background: rgba(30, 136, 229, 0.08);
        }
        .calendar-table td.selected .day-wrapper {
            background: #bbdefb;
        }
        .calendar-table td.today .day-wrapper {
            border: 2px solid #1e88e5;
        }
        .calendar-table .dot {
            width: 7px;
            height: 7px;
            background: #43a047;
            border-radius: 50%;
            display: inline-block;
            margin-top: 4px;
        }
        .calendar-table .course-time {
            display: none;
        }
        .details-section {
            flex: 1;
            padding-left: 16px;
            display: flex;
            flex-direction: column;
        }
        .details-title {
            font-size: 20px;
            color: #1e88e5;
            font-weight: bold;
            margin-bottom: 18px;
        }
        .reminder {
            font-size: 16px;
            color: #43a047;
            margin-bottom: 10px;
            font-weight: 500;
        }
        .course-list {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }
        .course-card {
            background: rgba(232, 245, 253, 0.9);
            border: 1px solid rgba(30, 136, 229, 0.15);
            border-radius: 14px;
            padding: 18px 22px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            border-left: 6px solid #1e88e5;
            position: relative;
            box-shadow: 0 2px 8px rgba(30,136,229,0.06);
        }
        .course-title {
            font-size: 18px;
            color: #1e88e5;
            font-weight: bold;
        }
        .course-type {
            font-size: 14px;
            color: #888;
            margin-left: 8px;
        }
        .course-time {
            font-size: 15px;
            color: #1e88e5;
        }
        .course-status {
            font-size: 14px;
            color: #fff;
            background: #43a047;
            border-radius: 8px;
            padding: 2px 12px;
            display: inline-block;
            margin-right: 8px;
        }
        .course-status.finished {
            background: #aaa;
        }
        .course-status.upcoming {
            background: #ffb300;
            color: #fff;
        }
        .course-status.attend {
            background: #1e88e5;
            color: #fff;
        }
        .course-duration {
            font-size: 14px;
            color: #888;
        }
        .enter-class-btn, .punch-btn {
            background: #43a047;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 8px 18px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            align-self: flex-end;
            margin-top: 6px;
            transition: background 0.2s;
        }
        .enter-class-btn:hover, .punch-btn:hover {
            background: #388e3c;
        }
        @media (max-width: 900px) {
            .main-container {
                flex-direction: column;
                gap: 18px;
                min-height: 400px;
            }
            .calendar-section {
                width: 100%;
                min-width: 0;
                border-right: none;
                border-bottom: 1.5px solid #E3EAFD;
                padding-right: 0;
                padding-bottom: 18px;
            }
            .details-section {
                padding-left: 0;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="navbar-inner">
            <div class="navbar-left">
                <img src="logo.jpg" alt="logo" class="navbar-logo">
                <span class="navbar-title">智学优教</span>
                <span class="navbar-page-title">我的课表</span>
            </div>
            <div class="navbar-right">
                <a href="student_main.html" class="back-btn">返回</a>
            </div>
        </div>
    </div>
    <div class="bg-img"></div>
    <div class="bg-mask"></div>
    <div class="main-container">
        <div class="calendar-section">
            <div class="calendar-header">
                <button onclick="changeMonth(-1)">上个月</button>
                <span id="calendarMonth"></span>
                <button onclick="changeMonth(1)">下个月</button>
                <button onclick="goToday()">今天</button>
            </div>
            <table class="calendar-table" id="calendarTable">
                <!-- 日历内容由JS渲染 -->
            </table>
        </div>
        <div class="details-section">
            <div class="details-title" id="detailsTitle">我的课程安排</div>
            <div class="reminder" id="reminder">今日还有2节课，加油！</div>
            <div class="course-list" id="courseList">
                <!-- 课程卡片由JS渲染 -->
            </div>
        </div>
    </div>
    <script>
        // 模拟课程数据
        const mockCourses = [
            {
                id: 1,
                name: '高一数学直播课',
                type: '直播',
                date: '2024-06-10',
                time: '19:00-20:30',
                status: '待上课',
                duration: '0分钟',
                isLive: true,
                canPunch: true
            },
            {
                id: 2,
                name: '高一数学录播课',
                type: '录播',
                date: '2024-06-10',
                time: '21:00-21:40',
                status: '已完成',
                duration: '40分钟',
                isLive: false,
                canPunch: false
            },
            {
                id: 3,
                name: '高二英语直播课',
                type: '直播',
                date: '2024-06-12',
                time: '18:00-19:00',
                status: '待上课',
                duration: '0分钟',
                isLive: true,
                canPunch: true
            },
            {
                id: 4,
                name: '高三物理录播课',
                type: '录播',
                date: '2024-06-15',
                time: '20:00-21:00',
                status: '已完成',
                duration: '60分钟',
                isLive: false,
                canPunch: false
            }
        ];

        let currentDate = new Date();
        let selectedDate = formatDate(currentDate);

        function formatDate(date) {
            const y = date.getFullYear();
            const m = (date.getMonth() + 1).toString().padStart(2, '0');
            const d = date.getDate().toString().padStart(2, '0');
            return `${y}-${m}-${d}`;
        }

        function renderCalendar() {
            const year = currentDate.getFullYear();
            const month = currentDate.getMonth();
            document.getElementById('calendarMonth').textContent = `${year}年${month + 1}月`;

            // 获取本月第一天是星期几
            const firstDay = new Date(year, month, 1).getDay();
            // 获取本月天数
            const daysInMonth = new Date(year, month + 1, 0).getDate();

            // 生成日历表格
            let html = '<tr>';
            const weekDays = ['日','一','二','三','四','五','六'];
            for (let i = 0; i < 7; i++) {
                html += `<th>${weekDays[i]}</th>`;
            }
            html += '</tr><tr>';

            let dayOfWeek = firstDay;
            for (let i = 0; i < firstDay; i++) {
                html += '<td></td>';
            }
            for (let day = 1; day <= daysInMonth; day++) {
                const dateStr = `${year}-${(month+1).toString().padStart(2,'0')}-${day.toString().padStart(2,'0')}`;
                const isToday = dateStr === formatDate(new Date());
                const isSelected = dateStr === selectedDate;
                const dayCourses = mockCourses.filter(c => c.date === dateStr);
                html += `<td class="${isToday ? 'today' : ''} ${isSelected ? 'selected' : ''}" onclick="selectDate('${dateStr}')">
                    <div class="day-wrapper">
                        <span>${day}</span>`;
                if (dayCourses.length > 0) {
                    html += '<div class="dot"></div>';
                }
                html += `</div></td>`;
                dayOfWeek++;
                if (dayOfWeek === 7 && day !== daysInMonth) {
                    html += '</tr><tr>';
                    dayOfWeek = 0;
                }
            }
            for (let i = dayOfWeek; i < 7 && dayOfWeek !== 0; i++) {
                html += '<td></td>';
            }
            html += '</tr>';
            document.getElementById('calendarTable').innerHTML = html;
        }

        function selectDate(dateStr) {
            selectedDate = dateStr;
            renderCalendar();
            renderCourseList();
        }

        function changeMonth(offset) {
            currentDate.setMonth(currentDate.getMonth() + offset);
            renderCalendar();
            renderCourseList();
        }

        function goToday() {
            currentDate = new Date();
            selectedDate = formatDate(currentDate);
            renderCalendar();
            renderCourseList();
        }

        function renderCourseList() {
            const list = document.getElementById('courseList');
            const courses = mockCourses.filter(c => c.date === selectedDate);
            list.innerHTML = '';
            if (courses.length === 0) {
                list.innerHTML = '<div style="color:#888; font-size:16px; margin-top:40px; text-align:center;">当天暂无课程安排</div>';
                document.getElementById('detailsTitle').textContent = `${selectedDate} 我的课程安排`;
                document.getElementById('reminder').textContent = '';
                return;
            }
            document.getElementById('detailsTitle').textContent = `${selectedDate} 我的课程安排`;
            document.getElementById('reminder').textContent = `今日还有${courses.length}节课，加油！`;
            for (const c of courses) {
                let statusClass = '';
                if (c.status === '已完成') statusClass = 'finished';
                else if (c.status === '待上课') statusClass = 'upcoming';
                else if (c.status === '可打卡') statusClass = 'attend';
                let card = `<div class="course-card">
                    <div><span class="course-title">${c.name}</span><span class="course-type">（${c.type}）</span></div>
                    <div class="course-time">上课时间：${c.time}</div>
                    <div><span class="course-status ${statusClass}">${c.status}</span><span class="course-duration">累计学习时长：${c.duration}</span></div>`;
                if (c.isLive && c.status !== '已完成') {
                    card += `<button class="enter-class-btn" onclick="enterLiveClass(${c.id})">进入教室</button>`;
                }
                if (c.canPunch && c.status !== '已完成') {
                    card += `<button class="punch-btn" onclick="punch(${c.id})">打卡</button>`;
                }
                card += '</div>';
                list.innerHTML += card;
            }
        }

        function enterLiveClass(courseId) {
            alert('跳转到直播教室，课程ID：' + courseId);
        }
        function punch(courseId) {
            alert('打卡成功！课程ID：' + courseId);
        }
        // 初始化
        renderCalendar();
        renderCourseList();
    </script>
</body>
</html> 