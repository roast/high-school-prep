# high-school-prep

初高衔接自学项目。Claude Code 在本仓库根目录运行，按 `CLAUDE.md` 全局约束为初中毕业生预习高一全科生成内容。

## 覆盖科目

- 语文 `chinese/`
- 数学 `math/`
- 物理 `physics/`
- 化学 `chemistry/`
- 英语 `english/`

## 功能

- 知识点讲解（衔接初中 → 高中新知，附自检问题）
- 互动演示（HTML+JS 持久页面 + Python 即时可视化）
- 按难度生成题目 PDF（留作答空白，答案末页）
- 对话追问（苏格拉底式反问 + 错题复盘）

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

MIT，见 `LICENSE`。
