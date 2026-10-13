import { createPlugin, pkgRootFrom } from '@deepwhale-cn/dsh-guard-core/plugin';

export const { name, inject, apply } = createPlugin({
  name: 'consent-guard',
  pkgRoot: pkgRootFrom(import.meta.url),
  skillFile: 'skill/consent-guard.md',
  binFile: 'bin/cli.mjs',
  description: '查同意机制是否合规：默认勾选、捆绑同意、没有撤回入口 —— 个保法有明确要求',
  whenToUse: 'TODO：写清什么时候该用（用户会说的话也列上）',
});
