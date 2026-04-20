---
name: card-issuing-auth
description: EastPay 发卡系统认证指南 — Bearer Token + timestamp（sandbox 当前模式），覆盖 HTTP 头、Body 格式、未来 OAuth2/JWE 迁移路径
---

# EastPay Card Issuing — Auth

## 当前 sandbox 认证方式（简化模式）

所有 API 使用 **静态 Bearer Token** + **timestamp header** + **明文 JSON body**。

### 每次请求需要发送的三个东西

1. HTTP Header `Authorization: Bearer <TOKEN>`——TOKEN 由 Coshine 分配，在一段时期内保持不变
2. HTTP Header `timestamp: <unix_秒>`——10 位整数字符串
3. HTTP Header `Content-Type: application/json; charset=UTF-8`
4. Body：**明文** JSON（无 JWE 加密）；包含 9 个公共头字段（见 `card-issuing-references/public-headers.md`）+ API 特定字段

### 最小请求示例

```
POST https://march.sandbox.efaka.net/card-api/cardmgr/cardApply
Authorization: Bearer <TOKEN_FROM_COSHINE>
timestamp: 1713600000
Content-Type: application/json; charset=UTF-8

{
  "participantId": "<ASSIGNED_BY_COSHINE>",
  "tranBranch": "<ASSIGNED_BY_COSHINE>",
  "tranChnl": "07",
  "tranDate": "20260420",
  "tranTime": "143052",
  "tranId": "TXN20260420143052001",
  "cardFlag": "V",
  "cardProdCode": "2201",
  "customerId": "CIF001",
  "custIdType": "P",
  "custIdNo": "E12345678"
}
```

## AI 应遵守的行为规则

1. **绝不编造** Bearer Token、`participantId`、`tranBranch` 的具体值——让客户从 Coshine 获取
2. 若客户没有 Token，引导客户：
   > "请联系 Coshine（你的对接人），索取 sandbox Bearer Token、`participantId`、`tranBranch`。"
3. 响应 HTTP 401/403 时，**不要自动重试**——静态 Token 刷新无效；检查 Token 是否过期或被 Coshine 撤销
4. 不要在任何生成的代码中硬编码 Token——从环境变量或配置文件读取

## 响应解析

- HTTP 状态码检查：见 `card-issuing-references/error-codes.md`
- 成功 HTTP 200 后，必须再检查业务字段 `responseCode`：`"00"` 才是真成功

## 未来迁移路径：OAuth2 + JWE

Coshine 的官方文档（PDF + developer portal）描述了另一套认证模式，是**目标形态**，当前 sandbox **未启用**：

- **OAuth2 `private_key_jwt` + `client_credentials`**：客户端用 EC 私钥签名 `client_assertion`（JWT, ES256），向 token endpoint 换取 60 分钟 access token
- **Body 加密**：`RSA-OAEP-256` 包 AES 128-GCM（JWE），用 EastPay RSA 公钥加密请求，用客户端 RSA 私钥解密响应

**何时迁移？** 由 Coshine 通知；或客户明确要求使用 OAuth2/JWE。迁移时：

1. 向 Coshine 索取 token endpoint URL、scope、EastPay RSA 公钥
2. 客户端生成 EC 密钥对（ES256）和 RSA 密钥对（RSA-OAEP-256），将公钥提交给 Coshine
3. 参考官方 PDF 的 Authentication 章节实现 JWT 签名 + JWE 加解密
4. 保留原 Bearer Token 模式代码作为 fallback 或测试

本 Skill 当前**不**提供 OAuth2/JWE 代码生成，直至 Coshine 明确要求。

## 参考

- `card-issuing-references/public-headers.md` — 9 字段公共头详解
- `card-issuing-references/error-codes.md` — HTTP 和业务错误码
- `card-issuing-references/samples/` — 完整请求/响应样例
