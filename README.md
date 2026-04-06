# yujia-homework-cat 项目文档

---

## 📖 文档索引

### 核心文档
- [README.md](README.md) - 项目介绍和快速开始
- [CODE_STANDARDS.md](CODE_STANDARDS.md) - 代码规范文档 ⭐
- [TEAM_PLAN.md](TEAM_PLAN.md) - 团队技术提升方案 ⭐
- [CHANGELOG.md](CHANGELOG.md) - 版本更新日志

### 技术文档
- [项目技术方案.md](../项目技术方案.md) - 技术架构和实施计划
- [团队技术提升方案.md](../团队技术提升方案.md) - 团队技术能力提升
- [数据问题记录.md](数据问题记录.md) - 数据同步问题记录

---

## 🚀 快速开始

### 项目简介
`yujia-homework-cat` 是一个帮助孩子自主完成作业的 HTML 静态网页系统,通过番茄计时和积分激励,提供家长监控功能。

### 技术栈
- **前端**: 原生 HTML5 + CSS3 + JavaScript (ES6+)
- **数据存储**: localStorage + GitHub API
- **部署**: GitHub Pages

### 功能模块
1. **番茄计时器**: 25分钟专注 + 5分钟休息
2. **积分系统**: 完成任务获得积分,激励学习
3. **任务管理**: 添加、完成、统计作业任务
4. **家长看板**: 实时监控孩子学习进度

---

## 📂 项目结构

```
yujia-homework-cat/
├── index.html                 # 主入口(选择孩子)
├── yujia.html                 # 羽佳学习页面
├── yuhan.html                 # 羽菡学习页面
├── parent_dashboard.html      # 家长看板
├── test-diagnostic.html       # 诊断测试页面
├── data/                      # 数据目录
│   ├── points.json            # 积分数据
│   └── tasks.json             # 任务数据
├── backup.sh                  # 备份脚本
├── gen_yuhan.py               # 生成羽菡页面
├── CODE_STANDARDS.md          # 代码规范 ⭐
├── TEAM_PLAN.md               # 团队计划 ⭐
├── CHANGELOG.md               # 更新日志 ⭐
└── README.md                  # 本文档
```

---

## 👥 团队规范

### 代码提交规范
```bash
# 功能
git commit -m "feat: 添加番茄钟暂停功能"

# 修复
git commit -m "fix: 修复积分计算错误"

# 文档
git commit -m "docs: 更新 README 文档"
```

### 代码审查流程
1. 按 `CODE_STANDARDS.md` 自查代码
2. 提交 PR 或审查请求
3. 高级开发者审查代码质量
4. 根据反馈修改代码
5. 通过审查后合并

### 学习计划
详见 [TEAM_PLAN.md](TEAM_PLAN.md)

---

## 📊 技术规范

### 命名规范
- **JavaScript**: 驼峰命名 (`userName`, `isTimerRunning`)
- **CSS**: BEM 命名 (`.timer-container__button--primary`)
- **文件**: kebab-case (`parent-dashboard.html`)

### 性能标准
- 页面加载时间 < 1 秒
- 动画帧率 ≥ 60fps
- DOM 操作最小化

### 浏览器支持
- Chrome (推荐)
- Firefox
- Safari
- Edge

---

## 🔧 开发工具

### 推荐工具
- **编辑器**: VS Code / WebStorm
- **浏览器**: Chrome DevTools
- **调试**: Chrome Extensions (React DevTools, Redux DevTools)

### 代码检查 (规划中)
- **ESLint**: JavaScript 代码检查
- **Prettier**: 代码格式化
- **Stylelint**: CSS 代码检查

---

## 📈 技术提升计划

### 阶段一: 技术栈规范 ✅
- [x] 确定技术栈
- [x] 制定代码规范文档
- [x] 定义性能标准

### 阶段二: 代码质量体系 (进行中)
- [ ] 建立代码审查机制
- [ ] 添加单元测试框架
- [ ] 性能优化实践

### 阶段三: 团队协作流程 (待实施)
- [ ] Git 分支管理规范
- [ ] CI/CD 自动化流程
- [ ] 技术分享会

### 阶段四: 架构设计能力 (持续)
- [ ] 设计模式应用
- [ ] 系统架构优化
- [ ] 性能优化策略

---

## 📞 联系方式

- **技术负责人**: 老板
- **项目仓库**: yujia-homework-cat
- **文档位置**: 项目根目录

---

## 📝 文档维护

- **维护人**: 技术团队
- **更新频率**: 每次重大变更后更新
- **最后更新**: 2026-04-06

---

## 🔗 相关链接

- [团队技术提升方案](../团队技术提升方案.md)
- [项目技术方案](../项目技术方案.md)
- [代码规范](CODE_STANDARDS.md)
- [更新日志](CHANGELOG.md)

---

**⭐ 标记表示重点文档,开发前必读**
