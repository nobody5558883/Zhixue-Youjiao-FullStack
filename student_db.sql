<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册账号 - 智学优教</title>
    <style>
        html, body { height: 100%; }
        body {
            min-height: 100vh;
            width: 100vw;
            overflow-x: hidden;
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
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
            background: rgba(255,255,255,0.75);
            z-index: 1;
        }
        .register-container {
            width: 100%;
            max-width: 380px;
            background: rgba(255,255,255,0.95);
            border-radius: 12px;
            box-shadow: 0 6px 24px rgba(42,77,155,0.10);
            padding: 28px 20px 18px 20px;
            text-align: center;
            position: relative;
            z-index: 2;
        }
        .register-title {
            font-size: 24px;
            font-weight: bold;
            color: #2A4D9B;
            margin-bottom: 10px;
        }
        .form-group {
            margin-bottom: 18px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #2A4D9B;
            font-size: 15px;
        }
        .form-group input {
            width: 100%;
            max-width: 320px;
            margin: 0 auto;
            display: block;
            padding: 11px 10px;
            border: 1px solid #BFD2F6;
            border-radius: 6px;
            font-size: 15px;
            background: #F7FAFF;
            color: #2A4D9B;
            transition: border 0.2s;
        }
        .form-group input:focus {
            outline: none;
            border-color: #2A4D9B;
            box-shadow: 0 0 0 2px rgba(42,77,155,0.10);
        }
        .send-code-btn {
            padding: 8px 16px;
            background: #2A4D9B;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 8px;
            transition: background 0.3s;
        }
        .send-code-btn:disabled {
            background: #BFD2F6;
            cursor: not-allowed;
        }
        .register-btn {
            width: 100%;
            padding: 13px;
            background: #2A4D9B;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            margin-top: 10px;
            box-shadow: 0 2px 8px rgba(42,77,155,0.10);
            transition: background 0.3s;
        }
        .register-btn:hover {
            background: #1d3570;
        }
        .error {
            color: #e53935;
            font-size: 13px;
            margin-top: 4px;
            margin-bottom: 0;
        }
        .success {
            color: #2A4D9B;
            font-size: 16px;
            margin-top: 18px;
            word-break: break-all;
        }
        .back-link {
            display: block;
            margin-top: 18px;
            color: #2A4D9B;
            text-decoration: none;
            font-size: 14px;
        }
        .back-link:hover {
            color: #FFD600;
        }
        @media (max-width: 500px) {
            .register-container {
                max-width: 98vw;
                padding: 12px 2vw 10px 2vw;
            }
        }
        .role-buttons {
            display: flex;
            justify-content: center;
            gap: 16px;
            margin-bottom: 18px;
        }
        .role-button {
            padding: 9px 28px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 15px;
            transition: all 0.3s;
            background: #F0F4FF;
            color: #2A4D9B;
            font-weight: 500;
        }
        .role-button.active {
            background: #2A4D9B;
            color: #fff;
            box-shadow: 0 2px 8px rgba(42,77,155,0.10);
        }
        .role-button:not(.active):hover {
            background: #E3EAFD;
        }
    </style>
</head>
<body>
    <div class="bg-img"></div>
    <div class="bg-mask"></div>
    <div class="register-container">
        <div class="register-title">注册账号</div>
        <form id="registerForm" autocomplete="off" onsubmit="return false;">
            <div class="form-group" style="text-align:center; margin-bottom:18px;">
                <div class="role-buttons" style="display:flex; justify-content:center; gap:16px; margin-bottom:0;">
                    <button type="button" class="role-button active" onclick="switchRole(this, true)">我是学生</button>
                    <button type="button" class="role-button" onclick="switchRole(this, false)">我是教师</button>
                </div>
            </div>
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" maxlength="20" placeholder="设置用户名" required>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" maxlength="20" placeholder="设置密码" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">重新输入密码</label>
                <input type="password" id="confirmPassword" maxlength="20" placeholder="请再次输入密码" required oninput="checkPasswordMatch()">
                <div class="error" id="passwordError" style="display:none;">请重新输入，两次密码不同</div>
            </div>
            <div class="form-group">
                <label for="phone">手机号</label>
                <input type="text" id="phone" maxlength="11" placeholder="请输入手机号" required>
                <div style="text-align: right; max-width: 320px; margin: 4px auto 0 auto;">
                    <button type="button" class="send-code-btn" id="sendCodeBtn" onclick="sendCode()">发送验证码</button>
                </div>
            </div>
            <div class="form-group">
                <label for="code">验证码</label>
                <input type="text" id="code" maxlength="6" placeholder="请输入验证码" required>
            </div>
            <button class="register-btn" onclick="registerUser()">注册</button>
        </form>
        <div class="success" id="successMsg" style="display:none;"></div>
        <a href="index.html" class="back-link">返回登录</a>
    </div>
    <script>
        let codeSent = false;
        let timer = null;
        let countdown = 60;
        let generatedCode = '';
        let isStudent = true;

        function switchRole(button, student) {
            isStudent = student;
            document.querySelectorAll('.role-button').forEach(btn => {
                btn.classList.remove('active');
            });
            button.classList.add('active');
        }

        function validatePhone(phone) {
            return /^1[3-9]\d{9}$/.test(phone);
        }

        function checkPasswordMatch() {
            const pwd = document.getElementById('password').value;
            const confirmPwd = document.getElementById('confirmPassword').value;
            const errorDiv = document.getElementById('passwordError');
            if (confirmPwd && pwd !== confirmPwd) {
                errorDiv.style.display = 'block';
            } else {
                errorDiv.style.display = 'none';
            }
        }

        function sendCode() {
            const phone = document.getElementById('phone').value.trim();
            if (!validatePhone(phone)) {
                alert('请输入有效的手机号');
                return;
            }
            generatedCode = String(Math.floor(100000 + Math.random() * 900000));
            alert('验证码已发送: ' + generatedCode + '（演示用，实际应通过短信发送）');
            codeSent = true;
            const btn = document.getElementById('sendCodeBtn');
            btn.disabled = true;
            countdown = 60;
            btn.textContent = countdown + '秒后重发';
            timer = setInterval(() => {
                countdown--;
                btn.textContent = countdown + '秒后重发';
                if (countdown <= 0) {
                    clearInterval(timer);
                    btn.disabled = false;
                    btn.textContent = '发送验证码';
                }
            }, 1000);
        }

        function registerUser() {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const phone = document.getElementById('phone').value.trim();
            const code = document.getElementById('code').value.trim();
            if (!username) {
                alert('请设置用户名');
                return;
            }
            if (!password) {
                alert('请设置密码');
                return;
            }
            if (password !== confirmPassword) {
                document.getElementById('passwordError').style.display = 'block';
                return;
            }
            document.getElementById('passwordError').style.display = 'none';
            if (!validatePhone(phone)) {
                alert('请输入有效的手机号');
                return;
            }
            if (!codeSent) {
                alert('请先获取验证码');
                return;
            }
            if (code !== generatedCode) {
                alert('验证码错误');
                return;
            }
            // 校验手机号唯一性
            var dbKey = isStudent ? 'students' : 'teachers';
            var users = JSON.parse(localStorage.getItem(dbKey) || '[]');
            if (users.find(u => u.phone === phone)) {
                alert('该手机号已被注册');
                return;
            }
            // 存储注册信息
            users.push({ phone, password, username });
            localStorage.setItem(dbKey, JSON.stringify(users));
            document.getElementById('registerForm').style.display = 'none';
            document.getElementById('successMsg').style.display = 'block';
            document.getElementById('successMsg').innerHTML = '注册成功！<br>请返回登录页面登录。';
        }
    </script>
</body>
</html> 