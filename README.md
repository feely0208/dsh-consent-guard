# @deepwhale-cn/dsh-consent-guard

[![Listed on dsh-plugin.org](https://dsh-plugin.org/badges/listed.svg)](https://dsh-plugin.org/plugins/feely0208/dsh-consent-guard)


**关键词**：用户同意 · 个人信息保护法 · 个保法 · 隐私政策 · 默认勾选 · 撤回同意 · 授权同意 · 隐私合规 · 单独同意
**Keywords**: user consent · PIPL · privacy policy · pre-checked box · consent withdrawal · personal information protection law
**用户同意与授权确认** —— 查默认勾选、捆绑同意、没有撤回入口。

## 不装它会怎样

你的注册页有这么一个勾选框：

```jsx
<input type="checkbox" name="agreePrivacy" defaultChecked />
同意隐私政策和营销推广
```

**看起来是标准做法，实际上踩了三项：**

1. **默认勾选** —— 用户什么都没做就算同意了。《个保法》第 14 条要求「自愿、明确作出」
2. **捆绑** —— 隐私政策（必要）和营销推广（非必要）合成一个勾选框
3. **没有撤回入口**

监管认定「默认勾选」时**通常直接判违规**。而改成默认不勾选，是**最省事的合规修复之一**。

## 它查什么

| 级别 | 内容 | 依据 |
|---|---|---|
| 🔴 高 | 默认勾选 | 个保法 14 条 · GDPR Recital 32 |
| 🔴 高 | 采集但无同意机制 | 个保法 13/17 条 |
| 🟡 中 | 捆绑同意 | 个保法 16/17 条 |
| 🟡 中 | 无撤回入口 | 个保法 15 条 |

## 安装

```bash
dsh plugin --profile web add @deepwhale-cn/dsh-consent-guard
# 或纯 CLI
npx @deepwhale-cn/dsh-consent-guard
```

## 用法

```bash
dsh-consent-guard --demo
dsh-consent-guard --list-rules
dsh-consent-guard --html r.html
```

![报告示例](docs/report.png)

## 边界

- **只看代码，不看实际界面** —— 弹窗有没有真弹出来、用户能不能看懂，需人工验证。
- **「找不到就报」的两条是弱信号** —— 撤回入口可能在服务端或另一个仓库。报出来是提示确认。
- **不判断「必要性」** —— 某项采集是否属「提供服务所必需」是法律判断。
- 与 [dsh-cn-pipl-check](https://github.com/feely0208/dsh-cn-skills) 分工：
  那个做**个保法逐条对照**（更全），这个**专做同意机制**（更深）。

本插件是一个工具。使用者必须遵守所在地区法律法规，**对使用本项目造成的任何后果自行承担责任。**

## License

MIT © 深鲸 DeepWhale
