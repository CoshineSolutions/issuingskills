# Error Codes

## 业务响应码（body.responseCode）

| 码 | 含义 | AI 应引导的排查 |
|---|---|---|
| `00` | 成功 | — |
| `01` | 无效 participant | 检查 `participantId`；联系 Coshine 核对 |
| `02` | 无效卡号 | `cardNumber` 错或卡不存在 |
| `03` | 无效卡状态 | 卡已销卡/未激活；查 `data-dictionary.md` 的 cardStatus 机 |
| `04` | 无效 `cardToken` | token 格式或值错误 |
| `10` | 受限访问，无数据返回 | 客户没有该 API 权限；找 Coshine 开通 |
| `24` | PIN block 格式错误 | RSA 加密 PIN 流程错——查 `GeneratePublicPinKey` 流程 |
| `55` | PIN 验证失败 | PIN 值错 |
| `99` | 未知数据检索错误 | 记录 `tranId` 联系 Coshine 技术支持 |

## HTTP 状态码

| 码 | 含义 | AI 应引导的排查 |
|---|---|---|
| `200` | Success | 继续看业务 `responseCode` |
| `307` | Temporary Redirect | 按 Location 沿用原 method 重发 |
| `400` | Bad Request | JSON/必填/枚举；重点查公共头 9 字段 |
| `401` | Unauthorized | `Authorization` header 缺失或格式错 |
| `403` | Invalid access token | Bearer 无效——找 Coshine 要新 token |
| `404` | Not Found | URL 路径拼错或 API_BASE_URL 错 |
| `500` | Internal Server Error | 上报 Coshine，附 `tranId` 和时间 |
| `502` | Bad Gateway | 同上 |

## AI 应主动暂停并提问的情景

1. 客户未提供 Bearer token → **不要编造**，引导客户联系 Coshine
2. 客户未提供 `participantId` / `tranBranch` → 不要用示例值（`100000` / `GTW100000`）直接提交
3. 响应 `99` → 要求客户提供 `tranId` 联系 Coshine
4. 响应 `10` → 检查客户账户是否已被 Coshine 授予该 API 权限
