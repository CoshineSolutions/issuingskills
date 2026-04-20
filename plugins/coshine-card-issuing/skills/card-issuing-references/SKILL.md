---
name: card-issuing-references
description: EastPay 发卡系统的协议/字段/错误码参考知识库。被其他 card-issuing Skill 按需引用。
---

# EastPay Card Issuing — References

按需查阅的参考文档。其它 Skill（`card-issuing-auth` / `card-issuing-quickstart`）在需要具体字段或码值时指向本目录下的文件。

## 目录

- **api-introduction.md** — HTTP 头、编码、HTTP 状态码
- **public-headers.md** — 9 字段公共请求/响应头详解
- **data-dictionary.md** — 全部枚举值（卡标识、产品码、卡状态、交易渠道、证件类型等）
- **error-codes.md** — 业务响应码 + HTTP 状态码 + 排查指引
- **endpoints-catalog.md** — 完整 API 目录（含 MVP 外的所有 API）
- **samples/** — MVP 3 个 API 的请求/响应 JSON 样例

## 重要提示：Sandbox 实际协议

当前 Coshine EastPay sandbox（`https://march.sandbox.efaka.net/card-api`）使用的**实际协议**与 Coshine 官方 PDF/门户描述的目标协议不同：

| | Sandbox 实际 | 官方文档目标形态 |
|---|---|---|
| 认证 | 静态 Bearer Token | OAuth2 `private_key_jwt` + ES256 |
| 请求体 | 明文 JSON | JWE (`RSA-OAEP-256` + `A128GCM`) |

MVP Skill 按 **sandbox 实际**描述。若 Coshine 后续要求升级到 OAuth2+JWE，按官方文档实施并通知开发者。
