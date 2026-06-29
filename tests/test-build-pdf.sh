#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BUILD="$REPO_ROOT/scripts/build-pdf.sh"
SAMPLE="$REPO_ROOT/tests/sample-questions.md"
OUT="$REPO_ROOT/tests/sample-questions.pdf"

# 前置：pandoc + xelatex + pdftotext 必须存在，否则跳过而非失败
if ! command -v pandoc >/dev/null 2>&1 || \
   ! command -v xelatex >/dev/null 2>&1 || \
   ! command -v pdftotext >/dev/null 2>&1; then
  echo "SKIP: pandoc/xelatex/pdftotext 未安装，跳过 PDF 冒烟测试"
  exit 0
fi

test_pdf_built() {
  rm -f "$OUT"
  "$BUILD" "$SAMPLE"
  [ -f "$OUT" ] || { echo "FAIL: PDF 未生成"; exit 1; }
}

test_page_count() {
  local pages
  pages=$(pdftotext "$OUT" - 2>/dev/null | grep -c $'\f' || true)
  pages=$((pages + 1))
  [ "$pages" -ge 2 ] || { echo "FAIL: 页数 $pages < 2，答案未分页"; exit 1; }
}

test_answer_on_last_page() {
  local text
  text=$(pdftotext "$OUT" - 2>/dev/null)
  local last_page
  last_page=$(printf '%s' "$text" | awk 'BEGIN{RS="\f"} END{print}')
  echo "$last_page" | grep -q "参考答案与解析" || { echo "FAIL: 末页无答案标题"; exit 1; }
}

test_pdf_built
test_page_count
test_answer_on_last_page
echo "PASS: test-build-pdf"
