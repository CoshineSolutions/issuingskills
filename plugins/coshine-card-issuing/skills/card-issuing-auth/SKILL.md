---
name: card-issuing-auth
description: "Use when implementing EastPay OAuth2/private_key_jwt, business JWE, legacy direct Bearer access, or diagnosing authentication and encryption errors."
---

# EastPay Card Issuing — Authentication

## Select the assigned access profile

| Profile | Token | Business body | Content-Type |
|---|---|---|---|
| Managed HTTP gateway (current UAT contract) | OAuth2 access token | Raw five-part compact JWE | `application/jose+json` |
| Explicitly provisioned legacy direct Channel | Assigned static Bearer | Plain UTF-8 JSON plus Unix-seconds `timestamp` header | `application/json; charset=UTF-8` |

The historical direct base is `https://march.sandbox.efaka.net/card-api`. Managed UAT evidence uses `https://gateway.sandbox.efaka.net/api/uat`; obtain the customer's approved base rather than deriving a route from their name. Never use the legacy profile as an automatic fallback.

## Managed HTTP sequence

1. Obtain the token URL, `client_id`, allowed scope, API base, participant/branch, server encryption JWKS and registered client key IDs from onboarding. Keep EC signing and RSA decryption private keys with the customer; register public keys only.
2. Sign an ES256 `client_assertion`: `iss` and `sub` equal `client_id`, `aud` is the assigned token endpoint, `iat`/`exp` are short-lived, `jti` is unique, signing `kid` matches the registered EC public key. Use current time; do not copy sample timestamps.
3. POST form-encoded `grant_type=client_credentials`, `client_id`, assigned `scope`, `client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer`, and `client_assertion` to that token URL. Use the returned `expires_in`; do not hard-code a one-hour lifetime or sample `ACS` scope.
4. Build a flat JSON object with public fields and business fields at the same level. **Do not sign the business body as JWT/JWS.** ES256 is for the OAuth assertion. Encrypt the UTF-8 JSON directly with the gateway RSA public key: `alg=RSA-OAEP-256`, `enc=A128GCM`, and the matching server encryption `kid`.
5. Send `Authorization: Bearer <access_token>` and `Content-Type: application/jose+json`. The entire body is the raw five-part compact JWE string, without JSON quotes or a `jwe` wrapper. Optional `X-Trace-Id` helps correlate diagnostics.
6. Decrypt a successful business response using the customer's registered RSA response private key; check `responseCode == "00"`. HTTP 200 alone is not business success. Gateway errors can be plaintext; inspect HTTP status and content type before trying to decrypt them.

```http
POST {API_BASE_URL}/cardmgr/inquiryCardInfoByToken
Authorization: Bearer <access_token>
Content-Type: application/jose+json
X-Trace-Id: <unique_trace_id>

<raw_compact_JWE>
```

Before encryption, the body is:

```json
{
  "participantId": "<assigned_participant>",
  "tranBranch": "<assigned_branch>",
  "tranChnl": "07",
  "tranDate": "<YYYYMMDD>",
  "tranTime": "<HHMMSS>",
  "tranId": "<unique_max_32_chars>",
  "cardToken": "<existing_card_token>"
}
```

`cardToken` remains a string. Do not add `tenantId`, `X-Tenant`, or nested `header`/`body`/`data` wrappers. The endpoint selects its transaction code.

## Failure handling

- HTTP 400 `Incompatible ContentType`: verify the exact media type and raw compact serialization first. Rejection before decryption says nothing about payload cryptographic validity.
- HTTP 401/403: check token expiry, assertion audience/key, IP, scope, route and participant/branch entitlement. Correct the cause; do not blindly retry or switch profiles. OAuth expiry can require a new token; a static token cannot be refreshed through OAuth.
- Keep tokens and keys out of generated source and logs. Use supplied environment/configuration references.
- A timeout on card creation or a financial operation is an unknown outcome. Query/reconcile before resubmission; a fresh `tranId` does not make a retry safe.

Read [protocol](../card-issuing-references/api-introduction.md), [public fields](../card-issuing-references/public-headers.md), and [errors](../card-issuing-references/error-codes.md) as needed.
