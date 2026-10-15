#!/bin/bash
set -uo pipefail
export PATH="/usr/local/bin:$PATH"
cd "$(dirname "$0")/.."
PASS=0; FAIL=0
ok(){ echo "  ✅ $1"; PASS=$((PASS+1)); }
bad(){ echo "  ❌ $1"; FAIL=$((FAIL+1)); }
echo ""; echo "  @deepwhale-cn/dsh-consent-guard · 双向验证"
echo "  ────────────────────────────────────────────────"
J=$(node bin/cli.mjs --root tests/fixtures/fail/demo-project --json 2>&1)
for rid in CONSENT-PRECHECKED CONSENT-BUNDLED CONSENT-NO-WITHDRAW; do
  c=$(echo "$J" | python3 -c "
import json,sys; d=json.load(sys.stdin)
print(len([f for f in d['findings'] if f['ruleId']=='$rid']))" 2>/dev/null)
  [ "${c:-0}" -gt 0 ] && ok "$rid 报出" || bad "$rid 未报出"
done
M=$(node bin/cli.mjs --root tests/fixtures/pass/clean-project --quiet 2>&1 | grep -oE '^[0-9]+' | head -1)
[ "${M:-1}" = "0" ] && ok "合规样本 0 命中" || bad "误报 ${M} 条"
echo ""; echo "  【能力验证】受控勾选（checked={state}）不是「默认勾选」，不该报"
K=$(echo "$J" | python3 -c "
import json,sys; d=json.load(sys.stdin)
print(len([f for f in d['findings'] if f['ruleId']=='CONSENT-PRECHECKED' and 'privacy' in (f.get('evidence') or '').lower() and 'default' not in (f.get('evidence') or '').lower()]))" 2>/dev/null)
[ "${K:-1}" = "0" ] && ok "未把受控状态误判为默认勾选" || bad "把受控状态误判了"
echo ""; echo "  【溯源】每条规则必须带 source（且须引法条）"
python3 - <<'PY' && ok "全部规则均有 source 且含法条" || bad "有规则缺 source 或法条"
import json,glob,sys
for f in glob.glob('rules/*.json'):
    r=json.load(open(f,encoding='utf-8'))
    s=r.get('source','')
    if not s: print('缺 source:',r.get('id'),file=sys.stderr); sys.exit(1)
    if '第' not in s and 'GDPR' not in s and '认定方法' not in s:
        print('未引法条:',r.get('id'),file=sys.stderr); sys.exit(1)
PY
echo ""; echo "  ────────────────────────────────────────────────"
echo "  通过 $PASS · 失败 $FAIL"; echo ""
[ "$FAIL" -eq 0 ] || exit 1
