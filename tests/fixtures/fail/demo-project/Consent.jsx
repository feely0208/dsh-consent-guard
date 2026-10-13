// 违规：默认勾选 + 捆绑同意 + 无撤回入口
export function Consent() {
  return (
    <label>
      <input type="checkbox" name="agreePrivacy" defaultChecked />
      同意隐私政策和营销推广
    </label>
  );
}
