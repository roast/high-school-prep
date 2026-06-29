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

## 快速开始

1. 安装依赖：`pandoc`、`texlive`（或 MacTeX）、`python3 + matplotlib + numpy`
2. 检查环境：`bash scripts/check-env.sh`
3. 在仓库根目录启动 Claude Code，按 `CLAUDE.md` 约束对话

## 协议

MIT，见 `LICENSE`。
