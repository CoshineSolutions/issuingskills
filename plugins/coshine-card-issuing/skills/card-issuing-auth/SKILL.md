---
name: card-issuing-auth
description: EastPay card-issuing authentication guide — static Bearer Token + timestamp (current sandbox mode), covering HTTP headers, body format, and the future OAuth2/JWE migration path
---

# EastPay Card Issuing — Auth

## Current Sandbox Authentication (Simplified Mode)

All APIs use a **static Bearer Token** + **timestamp header** + **plaintext JSON body**.

### What to send on every request

1. HTTP Header `Authorization: Bearer <TOKEN>` — TOKEN is assigned by Coshine; it remains valid for an extended period
2. HTTP Header `timestamp: <unix_seconds>` — 10-digit integer string
3. HTTP Header `Content-Type: application/json; charset=UTF-8`
4. Body: **plaintext** JSON (no JWE encryption); contains 9 public header fields (see `card-issuing-references/public-headers.md`) plus API-specific fields

### Minimal request example

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

## AI Behavior Rules

1. **Never fabricate** Bearer Token, `participantId`, or `tranBranch` values — direct the user to obtain them from Coshine
2. If the user does not have a token, guide them:
   > "Please contact your Coshine integration lead to obtain the sandbox Bearer Token, `participantId`, and `tranBranch`."
3. On HTTP 401/403, **do not auto-retry** — static tokens cannot be refreshed; check whether the token has expired or been revoked by Coshine
4. Never hard-code a token in generated code — read it from an environment variable or config file

## Response Parsing

- Check HTTP status code first: see `card-issuing-references/error-codes.md`
- After HTTP 200, you must also check the business field `responseCode`: only `"00"` means true success

## Future Migration Path: OAuth2 + JWE

Coshine's official documentation (PDF + developer portal) describes an alternative auth mode that is the **target architecture** — not yet enabled in the current sandbox:

- **OAuth2 `private_key_jwt` + `client_credentials`**: the client signs a `client_assertion` JWT (ES256) with an EC private key and exchanges it for a 60-minute access token
- **Body encryption**: `RSA-OAEP-256` wrapping AES-128-GCM (JWE); requests encrypted with EastPay's RSA public key, responses decrypted with the client's RSA private key

**When to migrate:** only when notified by Coshine, or when the user explicitly requests OAuth2/JWE. Migration steps:

1. Obtain the token endpoint URL, scope, and EastPay RSA public key from Coshine
2. Generate an EC key pair (ES256) and an RSA key pair (RSA-OAEP-256); submit public keys to Coshine
3. Implement JWT signing + JWE encrypt/decrypt per the Authentication section of the official PDF
4. Keep the original Bearer Token mode as a fallback or for testing

This skill does **not** provide OAuth2/JWE code generation until Coshine explicitly requires it.

## References

- `card-issuing-references/public-headers.md` — 9-field public body header details
- `card-issuing-references/error-codes.md` — HTTP and business error codes
- `card-issuing-references/samples/` — complete request/response JSON samples
