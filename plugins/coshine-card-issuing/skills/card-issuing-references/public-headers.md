# Public Headers (Common Request/Response Body Fields)

Every business API **request body** and **response body** contains the following 9 common fields.

## Request / Response Body Header Fields

| # | Field | Required | Format | Description |
|---|---|---|---|---|
| 1 | `participantId` | Required | String ≤15 | Assigned by Coshine |
| 2 | `tranBranch` | Required | String ≤6 | Assigned by Coshine |
| 3 | `tranChnl` | Required | 2 chars | Transaction channel: `06=CMS` / `07=WEB` / `08=APP` / `09=ACS` / `10=UMPS` |
| 4 | `tranCode` | Optional | String ≤6 | Optional internal operation code |
| 5 | `tranDate` | Required | `YYYYMMDD` | Transaction date |
| 6 | `tranTime` | Required | `HHMISS` | Transaction time |
| 7 | `tranId` | Required | String ≤32 | Globally unique transaction ID — include this when reporting issues to Coshine |
| 8 | `tellerNo` | Optional | String ≤32 | Operator / teller ID |
| 9 | `terminalNo` | Optional | String ≤15 | Terminal ID |

## Additional Response Fields

| Field | Description |
|---|---|
| `responseCode` | 2-character business response code — see `error-codes.md` |
| `responseDesc` | Response description, ≤120 characters |

Fields 1–9 are **echoed back** from the request in the response (except `tellerNo` / `terminalNo`, which may be omitted).
