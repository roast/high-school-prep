#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CHECK="$REPO_ROOT/scripts/check-env.sh"

# 用例 1: 脚本存在且可执行
test_script_exists() {
  [ -x "$CHECK" ] || { echo "FAIL: check-env.sh 不存在或不可执行"; exit 1; }
}

# 用例 2: 运行后退出码 0 或 1（不应该是 127 命令未找到）
test_runs() {
  "$CHECK" >/dev/null 2>&1 || rc=$?
  [ "${rc:-0}" = "0" ] || [ "${rc:-0}" = "1" ] || { echo "FAIL: 退出码 $rc"; exit 1; }
}

# 用例 3: 输出含 weasyprint 关键字（无论是否安装都要提及）
test_mentions_weasyprint() {
  local out
  out="$("$CHECK" 2>&1)" || true
  echo "$out" | grep -q "weasyprint" || { echo "FAIL: 未提及 weasyprint"; exit 1; }
}

test_script_exists
test_runs
test_mentions_weasyprint
echo "PASS: test-env-check"
