# Public Headers (Common Request/Response Body Fields)

The business message defines the following common fields; optional fields may be omitted.

## Request / Response Body Header Fields

| # | Field | Required | Format | Description |
|---|---|---|---|---|
| 1 | `participantId` | Required | String ≤15 | Assigned by Coshine |
| 2 | `tranBranch` | Required | String ≤6 | Assigned by Coshine |
| 3 | `tranChnl` | Required | 2 chars | Transaction channel: `06=CMS` / `07=WEB` / `08=APP` / `09=ACS` / `10=UMPS` |
| 4 | `tranCode` | Optional | String ≤6 | Selected by endpoint; normally omit |
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

Response public fields follow the endpoint contract; tranCode may be server-selected and optional fields may be omitted.

## Managed request clarification

All public and business fields are at the same JSON level before encryption, not inside a header/body/data wrapper. The controller selects `tranCode`; omit it unless the specific contract requires it, and do not use it as a custom operation label. Optional fields need not be sent. Responses may contain the server-selected transaction code. Customer calls use assigned participantId/tranBranch, not tenantId/X-Tenant.
