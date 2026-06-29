#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SUBJECTS=(math physics chemistry chinese english)

for s in "${SUBJECTS[@]}"; do
  for f in README.md progress.md mistakes.md; do
    [ -f "$REPO_ROOT/$s/$f" ] || { echo "FAIL: $s/$f 不存在"; exit 1; }
  done
  [ -d "$REPO_ROOT/$s/knowledge" ] || { echo "FAIL: $s/knowledge/ 不存在"; exit 1; }
  [ -d "$REPO_ROOT/$s/questions" ] || { echo "FAIL: $s/questions/ 不存在"; exit 1; }
done

# progress.md 必含状态表头
for s in "${SUBJECTS[@]}"; do
  grep -q "知识点" "$REPO_ROOT/$s/progress.md" || { echo "FAIL: $s/progress.md 缺知识点表头"; exit 1; }
  grep -q "状态" "$REPO_ROOT/$s/progress.md" || { echo "FAIL: $s/progress.md 缺状态列"; exit 1; }
done

# mistakes.md 必含表头
for s in "${SUBJECTS[@]}"; do
  grep -q "错题" "$REPO_ROOT/$s/mistakes.md" || { echo "FAIL: $s/mistakes.md 缺错题表头"; exit 1; }
done

# 每科 README 必含"教材"与"科内专属规则"节
for s in "${SUBJECTS[@]}"; do
  grep -q "## 教材" "$REPO_ROOT/$s/README.md" || { echo "FAIL: $s/README.md 缺教材节"; exit 1; }
  grep -q "## 科内专属规则" "$REPO_ROOT/$s/README.md" || { echo "FAIL: $s/README.md 缺科内规则节"; exit 1; }
done

# 根级文档断言
grep -q "^## 13\." "$REPO_ROOT/CLAUDE.md" || { echo "FAIL: CLAUDE.md 缺第 13 节"; exit 1; }
grep -q "MIT" "$REPO_ROOT/LICENSE" || { echo "FAIL: LICENSE 非 MIT"; exit 1; }
grep -q ".DS_Store" "$REPO_ROOT/.gitignore" || { echo "FAIL: .gitignore 缺 .DS_Store"; exit 1; }

echo "PASS: test-scaffold"
