#!/usr/bin/env bash
# 环境前置检查：pandoc / xelatex / python3 + matplotlib + numpy
# 退出码 0 = 全部就绪；1 = 有缺失
set -uo pipefail

STATUS=0

check_cmd() {
  local cmd="$1"
  local hint="$2"
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "  [OK] $cmd: $(command -v "$cmd")"
  else
    echo "  [MISSING] $cmd"
    echo "    安装: $hint"
    STATUS=1
  fi
}

check_py_lib() {
  local lib="$1"
  if python3 -c "import $lib" 2>/dev/null; then
    echo "  [OK] python3 模块 $lib"
  else
    echo "  [MISSING] python3 模块 $lib"
    echo "    安装: pip install $lib"
    STATUS=1
  fi
}

echo "== 高中预习项目环境检查 =="

echo "[1/3] 命令行工具:"
check_cmd pandoc "brew install pandoc  或  https://pandoc.org/installing.html"
check_cmd xelatex "brew install --cask mactex  或  https://www.tug.org/texlive/"
check_cmd pdftotext "brew install poppler"

echo "[2/3] Python 模块:"
check_py_lib matplotlib
check_py_lib numpy

echo "[3/3] 完成"
if [ "$STATUS" = "0" ]; then
  echo "全部就绪。"
else
  echo "有缺失项，请按上述提示安装后再运行 Claude Code。"
fi

exit $STATUS
