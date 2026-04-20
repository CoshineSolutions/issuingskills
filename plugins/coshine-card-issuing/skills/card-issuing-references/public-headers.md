# Public Headers（公共请求/响应头）

每个业务 API 的 **请求 body** 和 **响应 body** 都包含下列 9 个公共字段。

## Request / Response Body Header Fields

| # | 字段 | 必填 | 格式 | 说明 |
|---|---|---|---|---|
| 1 | `participantId` | 必填 | String ≤15 | 由 Coshine 分配 |
| 2 | `tranBranch` | 必填 | String ≤6 | 由 Coshine 分配 |
| 3 | `tranChnl` | 必填 | 2 chars | 交易渠道：`06=CMS` / `07=WEB` / `08=APP` / `09=ACS` / `10=UMPS` |
| 4 | `tranCode` | 可选 | String ≤6 | 可用于自有操作码标注 |
| 5 | `tranDate` | 必填 | `YYYYMMDD` | 交易日期 |
| 6 | `tranTime` | 必填 | `HHMISS` | 交易时间 |
| 7 | `tranId` | 必填 | String ≤32 | 全局唯一流水号——出错时请附上它联系 Coshine |
| 8 | `tellerNo` | 可选 | String ≤32 | 操作员 ID |
| 9 | `terminalNo` | 可选 | String ≤15 | 终端 ID |

## 响应额外字段

| 字段 | 说明 |
|---|---|
| `responseCode` | 2 字符业务响应码，见 `error-codes.md` |
| `responseDesc` | ≤120 字符描述 |

响应的 1-9 号字段**原样回显**请求侧（除 `tellerNo` / `terminalNo` 可能省略）。
