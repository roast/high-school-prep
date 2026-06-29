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

# weasyprint 仅 import 成功不够，native glib/pango 缺失时 render 才报错
# 用一次微型 HTML→PDF 渲染探活
check_weasyprint_render() {
  local tmp
  tmp="$(mktemp -t hsp-check.XXXXXX).pdf"
  if python3 -c "
import weasyprint
weasyprint.HTML(string='<p>ok</p>').write_pdf('$tmp')
" 2>/dev/null; then
    echo "  [OK] weasyprint 渲染探活通过"
  else
    echo "  [MISSING] weasyprint 渲染失败（native glib/pango 缺失）"
    echo "    macOS 踩坑：brew install pango 后仍找不到库，需设 DYLD_LIBRARY_PATH"
    echo "      Intel:      export DYLD_LIBRARY_PATH=\"/usr/local/lib:\$DYLD_LIBRARY_PATH\""
    echo "      Apple Silicon: export DYLD_LIBRARY_PATH=\"/opt/homebrew/lib:\$DYLD_LIBRARY_PATH\""
    echo "    或一行: export DYLD_LIBRARY_PATH=\"\$(brew --prefix)/lib:\$DYLD_LIBRARY_PATH\""
    echo "    Debian/Ubuntu: sudo apt install libpango-1.0-0 libpangoft2-1.0-0"
    echo "    Fedora: sudo dnf install pango"
    STATUS=1
  fi
  rm -f "$tmp"
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

# weasyprint import 通过后再做一次 render 探活，捕捉 native 库问题
if python3 -c "import weasyprint" 2>/dev/null; then
  check_weasyprint_render
fi

if [ "$STATUS" = "0" ]; then
  echo "全部就绪。"
else
  echo "有缺失项，请按上述提示安装后再运行 Claude Code。"
  echo "一次性安装：pip install markdown weasyprint pypdf matplotlib numpy"
fi

exit $STATUS
