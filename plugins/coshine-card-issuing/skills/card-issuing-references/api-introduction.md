# API Introduction

## Encoding

请求/响应均使用 UTF-8 编码。推荐 Content-Type：

```
Content-Type: application/json; charset=UTF-8
```

## HTTP Request Headers

| Header | 说明 | 长度 |
|---|---|---|
| `Authorization` | `Bearer <access-token>`，token 由 Coshine 分配（sandbox 为静态长效） | ≤64 chars |
| `timestamp` | 消息发送时的 Unix 时间戳（秒级） | ≤15 chars |
| `Content-Type` | 固定 `application/json; charset=UTF-8` | — |

## HTTP Response Headers

| Header | 说明 |
|---|---|
| `timestamp` | 响应生成时的 Unix 时间戳（秒级） |

## HTTP Status Codes

| 码 | 含义 | 说明 |
|---|---|---|
| 200 | Success | 继续检查业务 `responseCode` |
| 307 | Temporary Redirect | 按 Location 沿用原 method 重发 |
| 400 | Bad Request | 参数错 / 必填缺失 / 枚举非法 |
| 401 | Unauthorized | `Authorization` 缺失或格式错 |
| 403 | Invalid access token | Bearer 值无效 |
| 404 | Not Found | URL 路径拼写错或 API_BASE_URL 错 |
| 500 | Internal Server Error | 上报 Coshine，附 `tranId` |
| 502 | Bad Gateway | 同上 |

## URL 命名约定

实际 sandbox 端点使用 **按功能分组 + lowerCamelCase 动作**：

- `/cardmgr/*`：卡管理（开卡、激活、挂失、销卡等）
- `/custmgr/*`：客户管理（客户信息、按 CIF 查卡/账户）
- `/acctmgr/*`：账户管理
- `/paramgr/*`：参数（PIN 公钥、下拉列表等）
- `/tranmgr/*`：交易（ISO-8583 报文等）

完整 URL 路径见 `endpoints-catalog.md`。
