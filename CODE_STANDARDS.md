# 代码规范文档

## 📋 概述
本文档定义了 yujia-homework-cat 项目的代码编写规范,确保代码质量、可维护性和团队协作效率。

---

## 🔤 JavaScript 规范

### 命名规范

```javascript
// ✅ 推荐: 驼峰命名
let userName = '张三';
let isTimerRunning = false;
let currentPoints = 100;

// ✅ 推荐: 常量使用全大写下划线
const MAX_POINTS = 1000;
const TIMER_DURATION = 25 * 60 * 1000;

// ✅ 推荐: 类名使用大驼峰
class PomodoroTimer {
    constructor() {
        this.timerId = null;
        this.remainingTime = 0;
    }
}

// ✅ 推荐: 私有方法使用下划线前缀
_updateDisplay() {
    // ...
}
```

### 函数定义

```javascript
// ✅ 推荐: 使用箭头函数(回调函数)
const handleClick = (event) => {
    event.preventDefault();
    startTimer();
};

// ✅ 推荐: 传统函数(方法/构造函数)
function calculatePoints(completedPomodoros) {
    return completedPomodoros * 10;
}

// ✅ 推荐: 解构参数
function updateTask({ id, status, timeSpent }) {
    const task = findTaskById(id);
    task.status = status;
    task.timeSpent = timeSpent;
}
```

### 异步处理

```javascript
// ✅ 推荐: async/await
async function loadData() {
    try {
        const data = await fetchData();
        return processData(data);
    } catch (error) {
        console.error('加载数据失败:', error);
        showError('无法加载数据,请稍后重试');
    }
}

// ✅ 推荐: Promise 链式调用(简单场景)
fetchData()
    .then(processData)
    .catch(handleError);
```

### DOM 操作

```javascript
// ✅ 推荐: 缓存 DOM 查询
const timerDisplay = document.getElementById('timer-display');
const startButton = document.querySelector('.start-button');

// ✅ 推荐: 事件委托
document.addEventListener('click', (event) => {
    if (event.target.matches('.task-checkbox')) {
        handleTaskToggle(event.target);
    }
});

// ❌ 避免: 频繁 DOM 操作
for (let i = 0; i < 100; i++) {
    document.body.innerHTML += `<div>Item ${i}</div>`;
}

// ✅ 推荐: 批量更新
const fragments = document.createDocumentFragment();
for (let i = 0; i < 100; i++) {
    const div = document.createElement('div');
    div.textContent = `Item ${i}`;
    fragments.appendChild(div);
}
document.body.appendChild(fragments);
```

### 错误处理

```javascript
// ✅ 推荐: 始终捕获错误
async function saveData() {
    try {
        await localStorage.setItem('data', JSON.stringify(data));
    } catch (error) {
        console.error('保存数据失败:', error);
        // 向用户显示友好提示
        showToast('数据保存失败,请检查存储空间');
    }
}

// ✅ 推荐: 验证输入
function addTask(task) {
    if (!task || !task.title) {
        throw new Error('任务标题不能为空');
    }
    // ...
}
```

---

## 🎨 CSS 规范

### 命名规范

```css
/* ✅ 推荐: BEM 命名 */
.timer-container { }
.timer-container__display { }
.timer-container__button { }
.timer-container__button--primary { }
.timer-container__button--disabled { }

/* ✅ 推荐: kebab-case */
.header-title { }
.card-container { }
.button-primary { }
```

### 组织结构

```css
/* 1. CSS 变量 */
:root {
    --primary-color: #FF6B35;
    --success-color: #4ECDC4;
    --spacing-sm: 8px;
    --spacing-md: 16px;
}

/* 2. 基础重置 */
* { margin: 0; padding: 0; box-sizing: border-box; }
body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; }

/* 3. 布局组件 */
.container { }
.header { }
.main { }

/* 4. 功能模块 */
.timer { }
.task-list { }
.points-display { }

/* 5. 工具类 */
.text-center { text-align: center; }
.mt-4 { margin-top: 16px; }
```

### 响应式设计

```css
/* ✅ 推荐: 移动优先 */
.container {
    width: 100%;
    padding: 16px;
}

@media (min-width: 768px) {
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 24px;
    }
}

/* ✅ 推荐: 使用相对单位 */
.button {
    padding: 0.75rem 1.5rem; /* 使用 rem */
    font-size: 1rem;
    margin: 8px; /* 使用倍数关系 */
}
```

### 动画性能

```css
/* ✅ 推荐: 使用 transform 和 opacity */
.card {
    transform: translateY(0);
    opacity: 1;
    transition: transform 0.3s ease, opacity 0.3s ease;
}

.card:hover {
    transform: translateY(-8px);
}

/* ❌ 避免: 动画中使用 width、height、left、top */
.bad {
    width: 100px;
    transition: width 0.3s; /* 触发重排,性能差 */
}
```

---

## 📐 HTML 规范

### 语义化标签

```html
<!-- ✅ 推荐: 使用语义化标签 -->
<header class="header">
    <h1 class="header-title">学习计时器</h1>
</header>

<main class="main">
    <section class="timer-section">
        <h2>番茄钟</h2>
        <div class="timer-display">25:00</div>
    </section>
</main>

<footer class="footer">
    <p>© 2026 学习计时器</p>
</footer>
```

### 可访问性

```html
<!-- ✅ 推荐: 添加 alt 文本 -->
<img src="avatar.png" alt="用户头像">

<!-- ✅ 推荐: 表单标签关联 -->
<label for="task-input">任务名称</label>
<input type="text" id="task-input" placeholder="输入任务名称">

<!-- ✅ 推荐: 按钮类型明确 -->
<button type="submit">提交</button>
<button type="button">取消</button>
```

### 性能优化

```html
<!-- ✅ 推荐: 延迟加载非关键资源 -->
<script src="main.js" defer></script>
<link rel="preload" href="fonts.woff2" as="font" crossorigin>

<!-- ✅ 推荐: 避免内联样式和脚本 -->
<!-- ❌ 不好 -->
<div style="color: red;">红色文字</div>

<!-- ✅ 好 -->
<div class="text-danger">红色文字</div>
```

---

## 📦 代码组织

### 文件结构

```
yujia-homework-cat/
├── index.html                 # 主入口
├── yujia.html                 # 羽佳页面
├── yuhan.html                 # 羽羽菡页面
├── parent_dashboard.html      # 家长看板
├── data/                      # 数据文件
│   ├── points.json
│   └── tasks.json
└── README.md                  # 项目说明
```

### JavaScript 模块化

```javascript
// ✅ 推荐: 使用 IIFE 避免全局污染
(function() {
    'use strict';

    // 私有变量
    let timerData = null;

    // 公共接口
    window.TimerModule = {
        start() { /* ... */ },
        stop() { /* ... */ },
        pause() { /* ... */ }
    };
})();

// ✅ 推荐: 分离关注点
// storage.js - 数据存储
const Storage = {
    save(key, data) { /* ... */ },
    load(key) { /* ... */ },
    remove(key) { /* ... */ }
};

// timer.js - 计时器逻辑
const Timer = {
    init() { /* ... */ },
    start() { /* ... */ },
    stop() { /* ... */ }
};

// ui.js - UI 更新
const UI = {
    updateDisplay() { /* ... */ },
    showNotification() { /* ... */ }
};
```

---

## 🧪 最佳实践

### 性能优化

```javascript
// ✅ 推荐: 防抖和节流
const debouncedSearch = debounce(handleSearch, 300);

// ✅ 推荐: 虚拟滚动(大列表)
// ✅ 推荐: 懒加载图片
// ✅ 推荐: 缓存计算结果
```

### 安全性

```javascript
// ✅ 推荐: 防止 XSS
function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

// ✅ 推荐: 验证用户输入
function validateInput(input) {
    const sanitized = escapeHtml(input.trim());
    if (sanitized.length === 0) {
        throw new Error('输入不能为空');
    }
    return sanitized;
}
```

---

## 📝 注释规范

```javascript
// ✅ 推荐: 函数注释
/**
 * 计算任务完成后的积分奖励
 * @param {number} pomodoros - 完成的番茄钟数量
 * @param {boolean} continuous - 是否连续完成
 * @returns {number} 积分数值
 */
function calculatePoints(pomodoros, continuous = false) {
    const basePoints = pomodoros * 10;
    const bonus = continuous ? pomodoros * 5 : 0;
    return basePoints + bonus;
}

// ✅ 推荐: 复杂逻辑注释
// 如果今天是周末,积分翻倍
const isWeekend = [0, 6].includes(new Date().getDay());
const multiplier = isWeekend ? 2 : 1;
```

---

## 🔍 代码审查清单

提交代码前,请确认:

- [ ] 代码符合上述命名规范
- [ ] 函数单一职责,功能明确
- [ ] 添加了必要的错误处理
- [ ] 性能优化(避免不必要的 DOM 操作)
- [ ] 添加了适当的注释
- [ ] 测试通过(功能测试 + 浏览器兼容性)
- [ ] 无 console.log 或调试代码残留
- [ ] 符合可访问性要求

---

**最后更新**: 2026-04-06
**维护人**: 技术团队
