#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

test_demo_html() {
  local f="$REPO_ROOT/templates/demo.html"
  [ -f "$f" ] || { echo "FAIL: demo.html 不存在"; exit 1; }
  grep -q "katex" "$f" || { echo "FAIL: 未引入 KaTeX"; exit 1; }
  grep -q "aria-label" "$f" || { echo "FAIL: 缺少 aria-label 无障碍属性"; exit 1; }
  grep -q "<canvas" "$f" || grep -q "<svg" "$f" || { echo "FAIL: 缺少 canvas/svg 交互元素"; exit 1; }
}

test_demo_html
echo "PASS: test-templates (demo)"
