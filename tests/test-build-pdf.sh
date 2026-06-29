#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BUILD="$REPO_ROOT/scripts/build-pdf.py"
SAMPLE="$REPO_ROOT/tests/sample-questions.md"
OUT="$REPO_ROOT/tests/sample-questions.pdf"

# 前置：python3 + weasyprint/markdown/pypdf 必须就绪，否则跳过而非失败
if ! command -v python3 >/dev/null 2>&1; then
  echo "SKIP: python3 未安装，跳过 PDF 冒烟测试"
  exit 0
fi
if ! python3 -c "import weasyprint, markdown, pypdf" 2>/dev/null; then
  echo "SKIP: python3 模块 weasyprint/markdown/pypdf 未安装，跳过 PDF 冒烟测试"
  echo "  安装: pip install weasyprint markdown pypdf"
  exit 0
fi

test_pdf_built() {
  rm -f "$OUT"
  python3 "$BUILD" "$SAMPLE"
  [ -f "$OUT" ] || { echo "FAIL: PDF 未生成"; exit 1; }
}

test_page_count() {
  local pages
  pages=$(python3 -c "import pypdf; print(len(pypdf.PdfReader('$OUT').pages))")
  [ "$pages" -ge 2 ] || { echo "FAIL: 页数 $pages < 2，答案未分页"; exit 1; }
}

test_answer_on_last_page() {
  local last
  last=$(python3 -c "import pypdf; r=pypdf.PdfReader('$OUT'); print(r.pages[-1].extract_text())")
  echo "$last" | grep -q "参考答案与解析" || { echo "FAIL: 末页无答案标题"; exit 1; }
}

test_pdf_built
test_page_count
test_answer_on_last_page
echo "PASS: test-build-pdf"
