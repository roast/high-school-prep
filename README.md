# high-school-prep

一个爸爸为儿子做的初升高预科学习项目。

## 为什么做这个

儿子马上初中毕业，要进高中了。暑假这段空白期，与其报班刷题，不如换个思路：让他用 AI 工具把高一内容自学一遍。一举两得——既完成了初升高预科，又学会了怎么用 AI 帮自己学习。

AI 这两年发展得特别快，已经从"会聊天的玩具"变成了能写代码、画图、做课件、讲题目的实用工具。这一代孩子以后无论干什么——做研究、写文章、搞工程、甚至做生意——都离不开 AI。早一点把它当成学习伙伴，比晚一点被动适应要好得多。

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

MIT，见 `LICENSE`。
