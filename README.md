# high-school-prep

一个爸爸为儿子做的初升高预科学习项目。

## 为什么做这个

初升高这个阶段暑假的空白期，与其报班刷题，不如换个思路：让他用 AI 工具把高一内容自学一遍。一举两得——既完成了初升高预科，又学会了怎么用 AI 帮自己学习。

AI 的发展非常快，已经从"会聊天的玩具"变成了能写代码、画图、做课件、讲题目的实用工具。这一代孩子以后无论干什么——做研究、写文章、搞工程、甚至做生意——都离不开 AI。早一点把它当成学习伙伴，比晚一点被动适应要好得多。

AI 不会替你思考，但它能让一个人学习的效率翻好几倍：
- 不懂的概念随时问，不用等老师有空
- 一道题能反复变着花样出，直到真正弄懂
- 抽象的知识能可视化，看图比看字快
- 学完能立刻自检，错题不用自己抄

这个项目就是把上面这些好处打包好，让一个初中毕业生打开终端就能用。

## 怎么用

在仓库根目录启动 Claude Code，按 `CLAUDE.md` 的约束对话。Claude 扮演一位初高衔接的特级教师：不直接给答案、用初中知识搭桥、生成可交互的演示、出题、追问、记错题。

## 覆盖科目

- 语文 `chinese/`
- 数学 `math/`
- 物理 `physics/`
- 化学 `chemistry/`
- 英语 `english/`

教材用人教版高一上学期（必修第一册 / 必修上册）。

## 功能

- 知识点讲解（衔接初中 → 高中新知，附自检问题）
- 互动演示（HTML+JS 持久页面 + Python 即时可视化）
- 按难度生成题目 PDF（留作答空白，答案末页）
- 对话追问（苏格拉底式反问 + 错题自动记录与复盘）

## 10 个场景与提示词样板

下面 10 个场景覆盖预习、练习、复盘、可视化、计划等全部用法。把提示词复制到 Claude Code 里直接发，按需替换方括号内容。

### 场景 1：预习新知识点（从零讲起）

```
讲一下数学 ch3 的「3.2 函数的基本性质」。先问我初中学过哪些相关内容，
等我回答后再讲。讲完出 3 道递进难度的自检题，不要给答案。
```

### 场景 2：按难度出题打印作答

```
出 10 道物理 ch2「匀变速直线运动」的题目，难度=巩固。
生成 PDF，留作答空白，答案放最后一页。编译后告诉我文件路径。
```

### 场景 3：追问检验掌握

```
追问 数学 ch1「1.3 集合的基本运算」。出 4 道苏格拉底式反问，
我答错的话追到根因概念，再出变体题巩固。
```

### 场景 4：错题复盘重练

```
复盘。读 mistakes.md，按我之前的错题知识点重出 5 道变体题，
难度比原题高一档。答对连续 2 次的提示我可以标记已掌握。
```

### 场景 5：函数/运动可视化

```
讲数学 ch4「4.2 指数函数」时，生成一个 HTML 互动演示页：
滑块调节底数 a，实时画 y=a^x 图像，标注关键点。
生成后在浏览器打开。
```

```
讲物理 ch2 自由落体时，写个 Python 脚本动画演示：
两个小球同时从不同高度释放，对比落地时间。带中文注释，
我能直接 python3 运行。
```

### 场景 6：文言文/古诗文学习

```
讲语文 u3「短歌行 / 归园田居」。先讲建安文学和陶渊明背景故事，
再逐字落实重点实词虚词，最后出 3 道默写+理解题。
```

### 场景 7：英语全英对话 + 语法点

```
切到全英文模式练 u2「Travelling Around」。你扮演旅行社职员，
我扮演游客咨询行程。对话 5 轮后停下来，挑我语法错误讲解，
重点讲将来时态 will / be going to / be doing 的区别。
```

### 场景 8：章节复习 + 思维导图

```
数学 ch1「集合与常用逻辑用语」学完了。检查 progress.md 这一章
所有知识点的状态，没掌握的列清单，全部掌握的话画一张
Mermaid 思维导图总结整章结构。
```

### 场景 9：暑期整体学习计划

```
帮我排一个 6 周暑期预习计划，覆盖数学+物理+化学三科必修第一册。
每周哪几天学哪几节，留出复盘和休息日。输出到一份 markdown
计划文件，落 math/knowledge/ 目录外（放根目录的 schedule.md）。
```

### 场景 10：调整讲解节奏

```
这部分讲太快了，我没跟上。换成更慢的节奏，每讲一个概念
停一下让我复述，复述对了再继续。难度也降一档。
```

```
这道题先不解。我贴给你只是想让你帮我圈关键条件、判断知识点、
提示第一步思路。
```

> 提示词只是起点。随时用自己的话补充需求——语速、难度、可视化偏好、口吻严肃或活泼，Claude 都会立刻调整。

## 依赖安装

依赖：`pandoc`、`xelatex`（TeX 发行版）、`pdftotext`（poppler）、`python3 + matplotlib + numpy`。

### macOS（Homebrew）

```bash
brew install pandoc poppler
brew install --cask mactex
python3 -m pip install matplotlib numpy
```

### Linux（Debian / Ubuntu）

```bash
sudo apt update
sudo apt install -y pandoc poppler-utils texlive-xetex texlive-lang-chinese python3 python3-pip
python3 -m pip install matplotlib numpy
```

### Linux（Fedora）

```bash
sudo dnf install -y pandoc poppler texlive-xetex texlive-xetex-fonts python3 python3-pip
python3 -m pip install matplotlib numpy
```

### Windows（Chocolatey）

需管理员权限的 PowerShell 或 cmd。

```powershell
choco install -y pandoc poppler miktex python
python -m pip install matplotlib numpy
```

### Windows（Scoop，无需管理员）

```powershell
scoop install pandoc poppler
scoop bucket add extras
scoop install miktex python
python -m pip install matplotlib numpy
```

> Windows 下运行 `scripts/*.sh` 需 Git Bash（随 Git for Windows 安装）或 WSL。

## 快速开始

1. 按上方对应平台安装依赖
2. 检查环境：
   ```bash
   bash scripts/check-env.sh
   ```
   全部 `[OK]` 即就绪；`[MISSING]` 项按提示安装
3. 在仓库根目录启动 Claude Code，按 `CLAUDE.md` 约束对话

## 协议

MIT，见 `LICENSE`。欢迎其他家长拿去给自家孩子用。
