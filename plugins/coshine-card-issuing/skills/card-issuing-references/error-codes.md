# Error Codes

## Business Response Codes (body.responseCode)

| Code | Meaning | Troubleshooting guidance |
|---|---|---|
| `00` | Success | — |
| `01` | Invalid participant | Check `participantId`; verify with Coshine |
| `02` | Invalid card number | `cardNumber` is wrong or card does not exist |
| `03` | Invalid card status | Card is closed or not yet activated; check `cardStatus` in `data-dictionary.md` |
| `04` | Invalid `cardToken` | Token format or value is incorrect |
| `10` | Restricted access, no data returned | Customer account lacks permission for this API; ask Coshine to grant access |
| `24` | PIN block format error | RSA-encrypted PIN flow is wrong — check the `GeneratePublicPinKey` flow |
| `55` | PIN verification failed | PIN value is incorrect |
| `99` | Unknown data retrieval error | Record `tranId` and contact Coshine technical support |


## HTTP and transport failures

| Result | Check |
|---|---|
| 200 | Decrypt managed response, then check business responseCode; only 00 means success. |
| 400 | Exact profile Content-Type, compact JWE serialization, key/algorithm, flat JSON and required fields. Incompatible ContentType is a pre-decryption failure. |
| 401 | Bearer header, OAuth expiry/assertion/registered keys. |
| 403 | Scope, path, IP, participant/branch entitlement and binding readiness; not necessarily an invalid token. |
| 404 | Assigned API base and exact controller route. |
| 307 | Verify approved destination before forwarding credentials or replaying any operation. |
| 500/502/timeout | Preserve sanitized traceId/tranId/time; a write outcome may be unknown. Reconcile before retry. |

For missing values, draft code with placeholders and request only the missing onboarding data. Never request private keys or tokens in chat. OAuth tokens can be reacquired after correcting expiry; static tokens require the assigned legacy process. Do not fall back from managed access to direct JSON.
