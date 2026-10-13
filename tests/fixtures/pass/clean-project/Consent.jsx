// 合规：默认不勾选 + 分开勾选 + 有撤回入口
export function Consent() {
  const [privacy, setPrivacy] = useState(false);
  const [marketing, setMarketing] = useState(false);
  return (
    <div>
      <label><input type="checkbox" checked={privacy} onChange={e=>setPrivacy(e.target.checked)} />我已阅读并同意《隐私政策》</label>
      <label><input type="checkbox" checked={marketing} onChange={e=>setMarketing(e.target.checked)} />（可选）同意营销推广</label>
      <a href="/settings/privacy">在设置中撤回同意</a>
    </div>
  );
}
