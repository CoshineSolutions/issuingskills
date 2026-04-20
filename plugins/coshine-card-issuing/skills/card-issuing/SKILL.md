---
name: card-issuing
description: EastPay 发卡系统集成助手——识别用户意图，引导到具体子 Skill（auth / quickstart / references）。触发词：EastPay、发卡、card issuing、开卡、Coshine
---

# EastPay 发卡系统集成助手

## 系统概览

EastPay 是 Coshine Software 的 SaaS 发卡系统，提供：

- Card Issuing API（~58 端点，覆盖 Application / Customer / Account / Card / PIN / Transaction / Token / Loyalty 模块）
- Payment Gateway API
- Funding Resources API
- Reconciliation File API

**当前 MVP 仅覆盖 Card Issuing 的 3 个 API**，形成最小端到端闭环。

## 意图识别与路由

根据用户需求，引导到对应子 Skill：

| 用户说法（示例） | 路由到 |
|---|---|
| "怎么认证 / token 怎么用 / Authorization 怎么写" | `card-issuing-auth` |
| "怎么开卡 / 给我最小对接例子 / quickstart / demo" | `card-issuing-quickstart` |
| "公共头都有啥字段 / cardStatus 枚举 / 错误码含义" | `card-issuing-references` |
| "我要对接 LoadFund / BalanceInquiry / 其他高级功能" | **先告知 MVP 不含**，路径待确认 |
| "CardReplacement / Cancellation / 3DS / Loyalty" | 同上，Phase 1 P1 或 Phase 2 |

## 重要协议事实（务必告诉用户）

1. **当前 sandbox 认证是静态 Bearer Token**（不是 OAuth2/JWE），URL 格式是 `/cardmgr/cardApply` 等 lowerCamelCase
2. **Bearer Token / participantId / tranBranch / cardProdCode 全部由 Coshine 分配**——AI 不要编造具体值
3. **MVP 闭环只 3 个 API**：CardApplication → CustomerCardInfoInquiry → CardActivation
4. 其他 API 的路径需向 Coshine 单独确认

## Python 参考实现

同仓库 `reference-impl/` 提供 Python 参考实现：

- `eastpay/` 包：`Client` + 3 个端点包装
- `scripts/mock_server.py`：无需真凭证即可验证流程
- `scripts/validate_quickstart.py`：CLI 跑通 3 步闭环
- `scripts/lint_fixtures.py`：校验 samples 与 tests fixtures 一致

Skill 本身保持**语言无关**，Python 实现只是工程验证工具；如果用户需要其他语言代码，AI 按 Skill 描述的协议自行生成。

## 参考文档

- 设计规范：`docs/superpowers/specs/2026-04-20-eastpay-card-issuing-skill-mvp-design.md`
- 实施计划：`docs/superpowers/plans/2026-04-20-eastpay-card-issuing-skill-mvp.md`
- 上游 PDF：`CARD_API_list_Card_v4.3.17.pdf`
- Coshine 开发者门户：`https://developer.sandbox.efaka.net`
