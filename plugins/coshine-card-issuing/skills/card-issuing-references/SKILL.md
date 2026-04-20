---
name: card-issuing-references
description: EastPay card-issuing protocol and field reference knowledge base. Referenced on demand by other card-issuing skills.
---

# EastPay Card Issuing — References

On-demand reference material. Other skills (`card-issuing-auth` / `card-issuing-quickstart`) link here for specific field details or code values.

## Contents

- **api-introduction.md** — HTTP headers, encoding, HTTP status codes
- **public-headers.md** — 9-field public request/response body header details
- **data-dictionary.md** — all enum values (card flag, product code, card status, transaction channel, ID document type, etc.)
- **error-codes.md** — business response codes + HTTP status codes + troubleshooting guidance
- **endpoints-catalog.md** — complete API catalog (including APIs outside the MVP scope)
- **samples/** — request/response JSON samples for the 3 MVP APIs

## Important: Sandbox Actual Protocol

The **actual protocol** used by the current Coshine EastPay sandbox (`https://march.sandbox.efaka.net/card-api`) differs from the target protocol described in Coshine's official PDF and developer portal:

| | Sandbox (actual) | Official docs (target) |
|---|---|---|
| Authentication | Static Bearer Token | OAuth2 `private_key_jwt` + ES256 |
| Request body | Plaintext JSON | JWE (`RSA-OAEP-256` + `A128GCM`) |

These MVP skills are written for the **sandbox actual** protocol. If Coshine later requires upgrading to OAuth2 + JWE, follow the official documentation and notify developers accordingly.
