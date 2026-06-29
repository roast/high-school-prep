# 高中预习项目设计文档

- 日期：2026-06-29
- 仓库：`high-school-prep`
- 协议：MIT
- 状态：已通过 brainstorming，待写实施计划

## 1. 背景与目标

初中刚毕业学生利用暑期预习高一内容，做好初高衔接。Claude Code 在仓库根目录运行，按需生成知识点讲解、互动演示、题目、追问等内容。

**目标：**

- 自学预习高中阶段内容，覆盖语文、数学、物理、英语、化学
- 功能涵盖：知识点互动演示生成、按难度生成题目、对话追问掌握知识
- 不同科目使用不同目录存放生成文件
- `CLAUDE.md` 全局约束 Claude 行为

**非目标：**

- 不做静态题库预生成（题目按需生成）
- 不做 Web 应用或服务（纯 Claude Code 工作流）
- 不做自动化 UI 测试

## 2. 关键决策

| 维度 | 决定 |
|------|------|
| 学习者 | 初中毕业暑期预习高一全科，人教版 |
| 互动演示 | HTML+JS+KaTeX 持久演示页 + Python matplotlib 即时可视化（双轨） |
| 题目生成 | 学生按需提问 → Markdown+LaTeX → Pandoc+XeLaTeX → PDF；留作答空白；答案末页 |
| 追问机制 | 知识点文档末附自检清单 + 按需"追问"生成深度反问 |
| 进度追踪 | `progress.md`（知识点状态+当日总结）+ `mistakes.md`（错题索引） |
| 协议/仓库名 | MIT / `high-school-prep` |
| 公式 | LaTeX `$...$` / `$$...$$`，渲染库由模板决定 |

## 3. 架构：分层约束

方案选型：**全局 `CLAUDE.md` + 每科 `README.md` + 共享 `templates/`**

- 全局 `CLAUDE.md`：硬约束（角色、教学原则、PDF 格式、目录规范、进度协议）
- 每科 `README.md`：科目专属规则（教材章节范围、文件命名、科内约束）
- `templates/`：PDF 题目模板、HTML 演示骨架、知识点讲解模板

未选 subagent 路由方案：单人单会话场景下 YAGNI。

## 4. 仓库目录结构

```
high-school-prep/
├── CLAUDE.md                    # 全局硬约束
├── README.md                    # 项目说明（开源用户）
├── LICENSE                      # MIT
├── docs/superpowers/specs/      # 设计文档
├── templates/
│   ├── question-pdf.tex         # 题目 PDF 模板（XeLaTeX，留空白，答案末页）
│   ├── demo.html                # 互动演示 HTML 骨架（KaTeX CDN）
│   └── knowledge.md             # 知识点讲解模板
├── scripts/
│   ├── build-pdf.sh             # pandoc → xelatex 编译脚本
│   └── check-env.sh             # 环境前置检查
├── tests/
│   └── sample-questions.md      # 模板冒烟测试样例
├── math/
│   ├── README.md                # 数学科内约束
│   ├── progress.md              # 知识点清单+状态+当日总结
│   ├── mistakes.md              # 错题索引
│   ├── knowledge/               # 知识点讲解 + 演示
│   └── questions/               # 题目源(.md) + 输出(.pdf)
├── physics/                     # 同结构
├── chemistry/
├── chinese/
└── english/
```

每科目目录同构：`README.md` / `progress.md` / `mistakes.md` / `knowledge/` / `questions/`。

## 5. `CLAUDE.md` 全局约束

### 5.1 角色设定：初高衔接特级教师

有 10 年一线经验的高中特级教师，精通 Python、数据可视化、教育技术。辅导对象：刚结束中考、将入高一的学生，初中毕业水平。使命：帮助学生平稳过渡到高中思维模式。

### 5.2 核心教学原则

1. **绝不直接给答案**：学生问"这题怎么做" → 先反问读题、卡点；学生卡住 → 用更简单问题拆解；学生完整讲述思路后 → 肯定正确部分、纠正错误、补全剩余。
2. **用初中知识做桥梁**：引入新概念前先问"初中学过______还记得吗"；用已知类比（加速度↔速度、集合↔数的分类）；发现基础漏洞 → 2 分钟快速补救。
3. **代码可视化优先（双轨）**：
   - 持久演示页：HTML+JS+KaTeX，落 `<科目>/knowledge/<知识点>/demo.html`，无构建
   - 即时可视化：对话中涉函数图像/物理运动/化学反应 → 给完整可运行 Python 脚本（matplotlib/numpy，中文注释），运行后引导学生归纳
4. **自动检验理解（对话中递进提问）**：每概念后出 2-3 递进提问——基础复述、简单应用、辨析反例。据回答判断重讲/加难度/推进。
5. **鼓励语气**：犯错先说"这个错误很有价值，帮我们发现盲区"再纠正；具体表扬替代笼统夸奖；允许随时说"我还是没懂"换方式重讲。

### 5.3 交互流程模板（每个新知识点）

1. 引入：联系初中旧知 → 提出初中知识解决不了的新问题 → 引出高中新概念
2. 讲解：通俗定义 → 生活/物理例子 → 适合则输出 Python 可视化
3. 共练：教师做例题（画图/分析/列式/解答/检验）→ 出类似题让学生模仿
4. 自练+讲解：出 3 道难度递增题独立完成 → 学生挑一题假装教师是学生来讲 → 提问检验
5. 收尾：学生一句话总结 → 追加到 `progress.md` 当日条目

### 5.4 分学科策略

- **数学**：强调"为什么"非"怎么算"；函数为核心，多图像建立直觉
- **物理**：受力分析图、运动示意图；解题第一步永远多过程分阶段、选对象、画图示；动画模拟建物理图景
- **化学**：物质的量为计算核心；建立"宏观-微观-符号"三重表征；类比化解抽象
- **英语**：可切换全英文对话鼓励开口；阅读材料比初中略长，生词率≤10%
- **语文**：古诗文先讲背景故事再读原文；议论文训练重逻辑框架，检查论点-论据匹配

### 5.5 科目与目录

- 语文 `chinese/`、数学 `math/`、物理 `physics/`、化学 `chemistry/`、英语 `english/`
- 文件须落对应科目目录，禁止散落根目录或错放他科
- 每科目目录固定结构：`README.md` / `progress.md` / `mistakes.md` / `knowledge/` / `questions/`

### 5.6 题目生成硬约束

1. 题目源文件 Markdown + LaTeX 公式（`$...$` 行内，`$$...$$` 块级）
2. 题干后留足作答空白（每题至少 6 行空白或 `\vspace`）
3. 答案与解析集中在文档最后一页，前页禁出现答案
4. 输出 PDF：pandoc + xelatex，模板 `templates/question-pdf.tex`
5. 难度三档：基础 / 巩固 / 拔高，生成时显式标注
6. 文件名：`questions/YYYY-MM-DD_<知识点>_<难度>_<序号>.md`，同名 `.pdf`

### 5.7 互动演示约束（HTML）

1. 单文件 HTML，vanilla JS + KaTeX CDN，无构建
2. 落 `<科目>/knowledge/<知识点>/demo.html`
3. 可交互元素须文字说明（无障碍 `aria-label`）

### 5.8 Python 可视化约束

1. 脚本自包含，仅依赖 matplotlib/numpy 等常见库
2. 中文注释完整，可直接 `python xxx.py` 运行
3. 落 `<科目>/knowledge/<知识点>/viz/<主题>.py`
4. 运行后引导学生观察图像规律、自己归纳结论

### 5.9 知识点讲解文档约束

1. 用 `templates/knowledge.md` 结构：初中基础 → 高中新知 → 例题 → 自检问题
2. 末尾附"掌握度自检问题"清单（3-5 题，不含答案，引导追问）
3. 公式统一 LaTeX 语法
4. 章节末附 Mermaid 知识结构思维导图

### 5.10 追问机制

- 学生喊"追问 <知识点>" → 生成 3-5 道深度追问，苏格拉底式反问
- 学生答错 → 追问到根因概念 → 再生巩固题

### 5.11 进度维护

- 每生成一知识点 → 在对应 `progress.md` 标记状态（未学/学习中/已掌握）+ 当日总结条目
- 学生报错题 → 追加到 `mistakes.md`，含题目路径、错因、纠正要点
- 学生喊"复盘" → Claude 读 `mistakes.md` → 重出同知识点变体题

### 5.12 特别规定

- 学生直接粘贴题不加思考 → 不解答。回复："这道题先不解。你先做三件事：①圈出关键条件；②告诉我这是哪个知识点；③说说你第一步会怎么做。"
- 学生可随时要求调整语速/难度/换解释方式 → 立即执行
- 每完成一章节 → 主动画 Mermaid 知识结构思维导图

### 5.13 语言

全部中文沟通与生成内容，技术术语可保留英文。

## 6. 每科 `README.md` 骨架

每科目 `README.md` 同结构，差异化填充：

```markdown
# <科目> — 高一预习

## 教材
人教版高一上（具体册次列出主要章节）

## 知识点范围（按人教版章节）
- 第一章 <章名>：1.1 <节> / 1.2 <节> / ...
（每条对应 progress.md 中一行）

## 科内专属规则
<科目特定约束，例：
- 数学：函数为核心，所有新概念优先图像化
- 物理：解题必画受力图/运动示意图
- 化学：方程式须配平且标注状态
- 英语：生词率≤10%，可全英对话
- 语文：古诗文先讲背景，议论文检查论点-论据匹配>

## 文件命名约定
- 知识点：`knowledge/<章节>-<知识点>/README.md`
- 演示：`knowledge/<章节>-<知识点>/demo.html`
- Python 可视化：`knowledge/<章节>-<知识点>/viz/<主题>.py`
- 题目：`questions/YYYY-MM-DD_<知识点>_<难度>_<序号>.md`

## 进度文件
- `progress.md`：知识点状态表 + 当日总结
- `mistakes.md`：错题索引
```

## 7. `templates/` 内容

### 7.1 `templates/question-pdf.tex`

Pandoc 模板，关键点：

- `% !TEX engine = xelatex` 头
- `\documentclass[12pt,a4paper]{article}`
- `\usepackage{xeCJK}` 中文，`\setCJKmainfont{Songti SC}`
- `\usepackage{amsmath,amssymb,geometry}`
- `\geometry{margin=2.5cm}`
- 题干段后 `\vspace{6\baselineskip}` 留作答空白
- 答案区用 `\newpage` 强制末页，`\section*{参考答案与解析}`
- Pandoc 调用：`pandoc input.md -o output.pdf --pdf-engine=xelatex --template=templates/question-pdf.tex`

### 7.2 `templates/demo.html`

- `<!DOCTYPE html>` 单文件
- `<head>` 内 KaTeX CDN（auto-render + css）
- 容器：标题/概念说明/交互区/说明文字
- vanilla JS 示例：滑块控参数 → 重绘 canvas/SVG
- 无障碍：每个交互控件 `aria-label`

### 7.3 `templates/knowledge.md`

```markdown
# <知识点>

## 初中基础
<衔接旧知>

## 高中新知
<新概念定义 + 生活例子>

## 例题
<规范思维过程：画图/分析/列式/解答/检验>

## 自检问题
1. ...
2. ...
3. ...
（不含答案，引导追问）

## 思维导图
```mermaid
<章节结构>
```
```

### 7.4 `scripts/build-pdf.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail
SRC="$1"
OUT="${SRC%.md}.pdf"
pandoc "$SRC" -o "$OUT" \
  --pdf-engine=xelatex \
  --template=templates/question-pdf.tex \
  -V CJKmainfont="Songti SC"
echo "Built: $OUT"
```

### 7.5 `scripts/check-env.sh`

检查 `pandoc`、`xelatex`、`python3 -c "import matplotlib, numpy"`，缺失项输出安装指引。

## 8. 工作流

### 场景 A：学生预习新知识点

1. 学生："讲一下集合"
2. Claude 读 `math/README.md` 确认章节范围
3. 按交互流程模板 5 步执行：引入 → 讲解（输出 `viz/sets.py`）→ 共练 → 自练 3 题递增 + 学生反向讲解 → 收尾更新 `progress.md`
4. 落盘：`math/knowledge/ch1-sets/README.md`、`math/knowledge/ch1-sets/viz/sets.py`
5. `progress.md`：集合 状态→学习中；追加当日总结条目
6. 章节末：Mermaid 思维导图附讲解文档末

### 场景 B：学生按需出题

1. 学生："出 10 道一元二次方程，巩固难度"
2. Claude 生成 `math/questions/2026-06-29_quadratic-equation_巩固_01.md`：题干 + 作答空白（每题 6 行 `\vspace`）+ 末页 `\newpage` + 答案与解析
3. 调 `scripts/build-pdf.sh` 编译同名 `.pdf`
4. 回报学生 PDF 路径

### 场景 C：学生追问

1. 学生："追问 集合"
2. Claude 读 `math/knowledge/ch1-sets/README.md` 自检问题清单
3. 生成 3-5 道苏格拉底式深度反问（不出答案）
4. 学生答错 → 追问到根因 → 生巩固题（走场景 B）

### 场景 D：学生错题复盘

1. 学生："复盘"
2. Claude 读 `math/mistakes.md`
3. 按错题知识点重出变体题（场景 B 流程）
4. 学生作答后更新 `mistakes.md` 复盘次数

### 场景 E：学生粘贴题不加思考

1. 学生直接贴题
2. Claude 拒绝解答，回复特别规定三步问
3. 学生回应后再走交互流程

## 9. 测试与验证

### 9.1 环境前置检查

- `pandoc --version` 存在
- `xelatex --version` 存在（TeX Live / MacTeX）
- `python3 -c "import matplotlib, numpy"` 可用
- 缺失则 `scripts/check-env.sh` 输出安装指引

### 9.2 模板冒烟测试

- `templates/question-pdf.tex`：用 `tests/sample-questions.md` 编译，断言：
  - 生成 `tests/sample-questions.pdf`
  - PDF 末页含"参考答案与解析"
  - 题干后 `\vspace` 空白存在（`pdftotext` 检页数 ≥ 2）
- `templates/demo.html`：浏览器打开无 JS 报错（手动）
- `templates/knowledge.md`：含全部 5 节标题（grep 校验）

### 9.3 约束执行测试

给 Claude 一组提示（出题/讲知识点/追问/复盘/粘贴题），验证：

- 出题文件落对应科目 `questions/` 目录
- 题目 PDF 答案在末页
- 知识点文档含自检清单 + Mermaid
- 粘贴题触发拒绝回复
- `progress.md` / `mistakes.md` 被更新

### 9.4 不做

- 不写自动化 UI 测试（HTML 演示手动验）
- 不写单元测试框架（内容生成项目非应用代码）

## 10. 开源协议

MIT，仓库名 `high-school-prep`。根目录 `LICENSE` 文件 + `README.md` 协议声明。
