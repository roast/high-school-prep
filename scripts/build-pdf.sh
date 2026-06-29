#!/usr/bin/env bash
# 编译 Markdown 题目为 PDF（答案末页）
# 用法: build-pdf.sh <source.md>
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE="$REPO_ROOT/templates/question-pdf.tex"

if [ $# -lt 1 ]; then
  echo "用法: $0 <source.md>" >&2
  exit 2
fi

SRC="$1"
if [ ! -f "$SRC" ]; then
  echo "ERROR: 源文件不存在: $SRC" >&2
  exit 2
fi

OUT="${SRC%.md}.pdf"

pandoc "$SRC" \
  -o "$OUT" \
  --pdf-engine=xelatex \
  --template="$TEMPLATE" \
  -V CJKmainfont="Songti SC"

echo "Built: $OUT"
