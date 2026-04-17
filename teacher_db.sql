<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>上课状态 - 智学优教</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        html, body { height: 100%; width: 100vw; overflow-x: hidden; }
        body { background: #F5F7FA; font-family: Arial, Helvetica, sans-serif; padding-top: 72px; }
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
        .navbar { z-index: 20; position: fixed; width: 100vw; background: rgba(255,255,255,0.25); backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px); border-bottom: 1px solid rgba(255,255,255,0.18); display: flex; align-items: center; justify-content: center; top: 0; left: 0; right: 0; height: 72px; }
        .navbar-inner { width: 100%; max-width: 1200px; display: flex; align-items: center; justify-content: space-between; padding: 0 24px; }
        .navbar-left { display: flex; align-items: center; gap: 16px; }
        .navbar-logo { height: 48px; }
        .navbar-title { font-size: 24px; color: #2A4D9B; font-weight: bold; }
        .navbar-page-title { font-size: 22px; color: #2A4D9B; font-weight: 500; padding-left: 16px; margin-left: 16px; border-left: 1px solid #ccc; }
        .navbar-right .back-btn { background: #2A4D9B; color: #fff; border: none; border-radius: 8px; padding: 10px 24px; font-size: 15px; cursor: pointer; text-decoration: none; transition: background 0.2s; }
        .navbar-right .back-btn:hover { background: #1d3570; }
        .main-container { z-index: 2; position: relative; max-width: 900px; margin: 32px auto 0 auto; background: rgba(255,255,255,0.8); border-radius: 16px; box-shadow: 0 8px 32px 0 rgba(31,38,135,0.08); padding: 32px 24px 24px 24px; min-height: 600px; }
        .record-list { display: flex; flex-direction: column; gap: 18px; }
        .record-card { background: rgba(247,250,255,0.95); border-radius: 14px; box-shadow: 0 2px 8px rgba(42,77,155,0.08); padding: 18px 22px; display: flex; align-items: center; justify-content: space-between; border-left: 6px solid #2A4D9B; cursor: pointer; transition: box-shadow 0.2s; }
        .record-card:hover { box-shadow: 0 4px 16px rgba(42,77,155,0.15); }
        .record-info { display: flex; flex-direction: column; gap: 6px; }
        .record-meta { font-size: 15px; color: #555; }
        .record-title { font-size: 18px; color: #2A4D9B; font-weight: bold; }
        /* 弹窗样式 */
        .modal-overlay { position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.3); z-index: 100; display: none; align-items: center; justify-content: center; }
        .modal-content { background: #fff; border-radius: 16px; padding: 32px 28px 24px 28px; width: 95%; max-width: 480px; text-align: center; }
        .modal-title { font-size: 20px; font-weight: bold; color: #2A4D9B; margin-bottom: 16px; }
        .modal-body { font-size: 16px; color: #333; line-height: 1.6; margin-bottom: 24px; }
        .modal-actions { display: flex; gap: 12px; justify-content: center; }
        .modal-btn { padding: 10px 24px; border-radius: 8px; border: none; cursor: pointer; font-size: 15px; }
        .close-btn { background: #f0f0f0; color: #555; }
        .screenshot-btn { background: #FFD600; color: #2A4D9B; font-weight: bold; }
        .focus-chart { width: 100%; height: 200px; margin: 18px 0 10px 0; }
        .highlight { color: #e74c3c; font-weight: bold; }
        .screenshot-img { width: 90%; max-width: 320px; border-radius: 10px; margin: 12px auto; display: block; box-shadow: 0 2px 8px rgba(42,77,155,0.12); }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="navbar-inner">
            <div class="navbar-left">
                <img src="logo.jpg" alt="logo" class="navbar-logo">
                <span class="navbar-title">智学优教</span>
                <span class="navbar-page-title">上课状态</span>
            </div>
            <div class="navbar-right">
                <a href="student_main.html" class="back-btn">返回</a>
            </div>
        </div>
    </div>
    <div class="bg-img"></div>
    <div class="bg-mask"></div>
    <div class="main-container">
        <div class="record-list" id="recordList">
            <!-- 课程记录卡片由JS渲染 -->
        </div>
    </div>
    <!-- 详情弹窗 -->
    <div class="modal-overlay" id="detailModal">
        <div class="modal-content">
            <div class="modal-title">专注度详情</div>
            <div class="modal-body" id="detailModalBody"></div>
            <div class="modal-actions" id="detailModalActions"></div>
        </div>
    </div>
    <!-- 截图弹窗 -->
    <div class="modal-overlay" id="screenshotModal">
        <div class="modal-content">
            <div class="modal-title">走神截图</div>
            <img id="screenshotImg" class="screenshot-img" src="" alt="走神截图">
            <div class="modal-actions">
                <button class="modal-btn close-btn" onclick="closeScreenshotModal()">关闭</button>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
    <script>
        // 示例课程记录数据
        let records = [
            {
                id: 'rec001',
                time: '2024-06-10 19:00-20:30',
                subject: '数学',
                teacher: '王老师',
                focusMinutes: 78,
                absentCount: 2,
                focus: [80, 85, 90, 60, 55, 88, 92, 85],
                absentNodes: [3, 4], // 走神发生在第4、5次
                screenshots: ['absent1.jpg', 'absent2.jpg']
            },
            {
                id: 'rec002',
                time: '2024-06-08 10:00-11:30',
                subject: '英语',
                teacher: '李老师',
                focusMinutes: 90,
                absentCount: 0,
                focus: [95, 92, 98, 97, 96, 99, 100, 98],
                absentNodes: [],
                screenshots: []
            }
        ];
        function loadRecords() {
            const list = document.getElementById('recordList');
            list.innerHTML = '';
            for (const r of records) {
                let card = `<div class="record-card" onclick="showDetailModal('${r.id}')">
                    <div class="record-info">
                        <div class="record-title">${r.subject}</div>
                        <div class="record-meta">${r.time}</div>
                        <div class="record-meta">授课教师：${r.teacher}</div>
                    </div>
                </div>`;
                list.innerHTML += card;
            }
        }
        let currentDetail = null;
        function showDetailModal(recordId) {
            currentDetail = records.find(r => r.id === recordId);
            if (!currentDetail) return;
            let html = '';
            html += `<div>专注时间总计：<span class="highlight">${currentDetail.focusMinutes} 分钟</span></div>`;
            html += `<div>走神次数：<span class="highlight">${currentDetail.absentCount}</span></div>`;
            html += `<div id="focusChart" class="focus-chart"></div>`;
            if (currentDetail.absentCount > 0) {
                html += `<div style='margin:10px 0 6px 0;'>走神节点：`;
                html += currentDetail.absentNodes.map(i => `<span class='highlight'>第${i+1}次</span>`).join('、');
                html += `</div>`;
            }
            document.getElementById('detailModalBody').innerHTML = html;
            // 按钮区
            let actions = '';
            if (currentDetail.absentCount > 0) {
                actions += `<button class="modal-btn screenshot-btn" onclick="showScreenshotModal()">查看截图</button>`;
            } else {
                actions += `<span style='color:#2A4D9B;font-size:16px;'>本节课专注力满分！</span>`;
            }
            actions += `<button class="modal-btn close-btn" onclick="closeDetailModal()">关闭</button>`;
            document.getElementById('detailModalActions').innerHTML = actions;
            document.getElementById('detailModal').style.display = 'flex';
            setTimeout(renderFocusChart, 100);
        }
        function renderFocusChart() {
            if (!currentDetail) return;
            let chartDom = document.getElementById('focusChart');
            let myChart = echarts.init(chartDom);
            let option = {
                xAxis: { type: 'category', data: currentDetail.focus.map((_, i) => `第${i+1}次`) },
                yAxis: { type: 'value', min: 0, max: 100 },
                series: [{
                    data: currentDetail.focus,
                    type: 'line',
                    smooth: true,
                    areaStyle: {},
                    lineStyle: { color: '#2A4D9B' },
                    itemStyle: { color: '#FFD600' }
                }],
                tooltip: { trigger: 'axis' },
                markPoint: currentDetail.absentNodes.length > 0 ? {
                    data: currentDetail.absentNodes.map(i => ({ name: '走神', value: '走神', xAxis: i, yAxis: currentDetail.focus[i], itemStyle: { color: '#e74c3c' } }))
                } : undefined
            };
            myChart.setOption(option);
        }
        function closeDetailModal() {
            document.getElementById('detailModal').style.display = 'none';
        }
        function showScreenshotModal() {
            if (!currentDetail || !currentDetail.screenshots.length) return;
            // 这里只展示第一张截图，实际可做成轮播
            document.getElementById('screenshotImg').src = currentDetail.screenshots[0];
            document.getElementById('screenshotModal').style.display = 'flex';
        }
        function closeScreenshotModal() {
            document.getElementById('screenshotModal').style.display = 'none';
        }
        loadRecords();
    </script>
</body>
</html> 