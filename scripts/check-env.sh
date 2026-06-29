#!/usr/bin/env bash
# 环境前置检查：python3 + weasyprint/markdown/pypdf + matplotlib/numpy
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

echo "[1/2] 命令行工具:"
check_cmd python3 "https://www.python.org/downloads/"

echo "[2/2] Python 模块（pip 安装）:"
check_py_lib markdown
check_py_lib weasyprint
check_py_lib pypdf
check_py_lib matplotlib
check_py_lib numpy

if [ "$STATUS" = "0" ]; then
  echo "全部就绪。"
else
  echo "有缺失项，请按上述提示安装后再运行 Claude Code。"
  echo "一次性安装：pip install markdown weasyprint pypdf matplotlib numpy"
  echo "weasyprint 依赖系统库 pango/cairo；若报错缺库："
  echo "  macOS: brew install pango"
  echo "  Debian/Ubuntu: sudo apt install libpango-1.0-0 libpangoft2-1.0-0"
  echo "  Fedora: sudo dnf install pango"
fi

exit $STATUS
