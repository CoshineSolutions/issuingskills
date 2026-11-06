# API Introduction

## Profiles and wire encoding

Read [authentication](../card-issuing-auth/SKILL.md) before constructing requests.

| Item | Managed HTTP gateway | Explicit legacy direct Channel |
|---|---|---|
| Authorization | OAuth2 Bearer access token | Assigned static Bearer token |
| Content-Type | `application/jose+json` | `application/json; charset=UTF-8` |
| Body | Raw compact JWE containing flat UTF-8 JSON | Flat UTF-8 JSON |
| Timestamp | Follow assigned gateway contract; not a substitute for OAuth claims | Unix-seconds `timestamp` HTTP header |
| Response | Decrypt business JWE; inspect errors before decryption | JSON |

A sandbox hostname does not identify the profile. Do not downgrade between profiles on failure. Business endpoints normally use POST; explicit GET routes such as key discovery are separate.

## Request/response rules

- No nested `header`, `body`, `data` or `jwe` wrapper.
- ES256 signs the OAuth assertion only; encrypt business JSON directly with RSA-OAEP-256/A128GCM.
- Public fields and API fields occupy the same JSON level. Keep identifiers including cardToken as strings.
- `participantId`/`tranBranch` select an authorized business context. Customer HTTP requests do not supply internal tenantId/X-Tenant.
- The endpoint selects tranCode. Do not treat it as a free-form client operation label.
- HTTP 200 still requires `responseCode="00"` after decryption when applicable.
- For redirects, verify the destination is the approved service before forwarding credentials or resending a write.
- On errors record sanitized HTTP/business codes, tranId, X-Trace-Id and time; see [error-codes.md](error-codes.md).
