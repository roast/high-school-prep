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

test_knowledge_md() {
  local f="$REPO_ROOT/templates/knowledge.md"
  [ -f "$f" ] || { echo "FAIL: knowledge.md 不存在"; exit 1; }
  grep -q "## 初中基础" "$f" || { echo "FAIL: 缺少'初中基础'节"; exit 1; }
  grep -q "## 高中新知" "$f" || { echo "FAIL: 缺少'高中新知'节"; exit 1; }
  grep -q "## 例题" "$f" || { echo "FAIL: 缺少'例题'节"; exit 1; }
  grep -q "## 自检问题" "$f" || { echo "FAIL: 缺少'自检问题'节"; exit 1; }
  grep -q "## 思维导图" "$f" || { echo "FAIL: 缺少'思维导图'节"; exit 1; }
  grep -q "mermaid" "$f" || { echo "FAIL: 缺少 Mermaid 代码块"; exit 1; }
}

test_knowledge_md
echo "PASS: test-templates (knowledge)"
echo "PASS: test-templates (demo)"
