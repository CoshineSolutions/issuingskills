---
name: card-issuing-quickstart
description: EastPay 发卡系统端到端最小闭环对接指南 — 3 步开卡流程（Application → Inquiry → Activation）
---

# EastPay Card Issuing — Quickstart（3 步最小闭环）

## 前置条件

从 Coshine 获取以下 5 项：

1. `API_BASE_URL`（sandbox：`https://march.sandbox.efaka.net/card-api`）
2. Bearer Token
3. `participantId`
4. `tranBranch`
5. `cardProdCode`（sandbox 常见：Visa=`2201` / Mastercard=`5200`）

配置好认证（见 `card-issuing-auth`）后开始：

## 3 步流程

```
Step 1: 开卡  (cardApply)            → 拿到 cardToken + expiryDate + CVV2
Step 2: 读查  (inquiryCardListByCIF) → 验证按 customerId 能找到新卡
Step 3: 激活  (cardActivate)         → 卡进入可用状态 (responseCode="00")
```

### Step 1 · CardApplication

**路径：** `POST {API_BASE_URL}/cardmgr/cardApply`

**必填字段（虚拟卡，最小集）：**

| 字段 | 说明 |
|---|---|
| `cardFlag` | `V`（虚拟）或 `P`（实体） |
| `cardProdCode` | 来自 Coshine 分配 |
| `customerId` | 客户自定义 CIF（≤32 chars） |
| `custIdType` | 证件类型，见 data-dictionary |
| `custIdNo` | 证件号 |

**响应关键字段：** `cardToken`（后续所有操作的引用）、`expiryDate`（YYMM）、`CVV2`

> 实体卡（`cardFlag=P`）还需 `cardEmbossName` + 邮寄地址字段；见 `card-issuing-references/endpoints-catalog.md`。

**样例：** `card-issuing-references/samples/card_application_request.json` / `card_application_response.json`

### Step 2 · CustomerCardInfoInquiry

**路径：** `POST {API_BASE_URL}/custmgr/inquiryCardListByCIF`

**必填：** `customerId`（Step 1 用的那个）

**响应关键字段：** `cardList[]`——断言其中包含 Step 1 拿到的 `cardToken`。

**用途：** 验证"按 CIF 能读回刚开的卡"；这是一次读路径验证，也常用于列出客户名下所有卡。

**样例：** `card-issuing-references/samples/customer_card_info_inquiry_*.json`

### Step 3 · CardActivation

**路径：** `POST {API_BASE_URL}/cardmgr/cardActivate`

**必填字段：**

| 字段 | 来源 |
|---|---|
| `cardToken` | Step 1 响应 |
| `expiryDate` | Step 1 响应 |
| `CVV2` | Step 1 响应 |
| `customerId` / `custIdType` / `custIdNo` | 持卡人身份校验 |

**响应：** `responseCode == "00"` 即激活成功，卡从 `N` 转为 `U`。

**样例：** `card-issuing-references/samples/card_activation_*.json`

## 测试策略（协议层，语言无关）

验证 3 步闭环的通用方式——用任意 HTTP 客户端（curl、Postman、任何语言的 HTTP 库）：

1. **字段层预检（无真凭证）**：根据 `card-issuing-references/samples/*_request.json` 组装 3 份请求体，带上 `Authorization: Bearer <任意字符串>` + `timestamp` header 打给 mock 服务或桩服务；断言：
   - Step 1 响应含 `cardToken` / `expiryDate` / `CVV2`
   - Step 2 响应的 `cardList[]` 中出现 Step 1 拿到的 `cardToken`
   - Step 3 响应 `responseCode == "00"`
2. **切真 sandbox**：把 `Bearer <TOKEN>`、`participantId`、`tranBranch` 换成 Coshine 分配的真实值，URL 前缀换成真 `API_BASE_URL`，按同样 3 步串行跑；任一步 `responseCode != "00"` 立即停，按 `card-issuing-references/error-codes.md` 排查。
3. **语言无要求**：Bearer + 明文 JSON 不需要 JWT/JWE 计算；curl、Postman、httpx/requests、OkHttp、axios、Go net/http 等任一客户端都能直接对接。

### 参考实现（Python，可选）

本仓库附带一套 **Python 参考实现**，仅作工程验证样本，不是协议要求：

- `reference-impl/scripts/mock_server.py` — FastAPI 最小 mock，返回 `samples/` 的理想响应
- `reference-impl/scripts/validate_quickstart.py` — CLI 串跑 3 步
- `reference-impl/scripts/lint_fixtures.py` — 校验 samples 与 Python tests fixture 同源

客户栈若非 Python，按上述「协议层」方式自行实现即可，无需先跑 Python 版本。

## AI 应遵守的行为规则

1. 严格按 3 步顺序，不要跳步
2. `cardToken` 是关键句柄，必须从 Step 1 响应读取，**不要**捏造
3. 任何一步 `responseCode != "00"` → 立即停止，查 `card-issuing-references/error-codes.md`
4. 不要假设 `AccountLinkage` 在 MVP 里也要调用——已从最小闭环中移除
5. **Transaction 类 API**（LoadFund / BalanceInquiry 等）的 URL 在当前 MVP 未确认，需向 Coshine 确认后再对接

## 参考

- `card-issuing-auth` — 认证方式
- `card-issuing-references/public-headers.md` — 9 字段公共头
- `card-issuing-references/samples/` — 3 个 API 的完整样例
- `card-issuing-references/endpoints-catalog.md` — 完整端点目录
