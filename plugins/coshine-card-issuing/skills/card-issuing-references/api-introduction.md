# API Introduction

## Encoding

All requests and responses use UTF-8 encoding. Recommended Content-Type:

```
Content-Type: application/json; charset=UTF-8
```

## HTTP Request Headers

| Header | Description | Length |
|---|---|---|
| `Authorization` | `Bearer <access-token>` — token assigned by Coshine (static long-lived token in sandbox) | ≤64 chars |
| `timestamp` | Unix timestamp (seconds) at the time the message is sent | ≤15 chars |
| `Content-Type` | Fixed value: `application/json; charset=UTF-8` | — |

## HTTP Response Headers

| Header | Description |
|---|---|
| `timestamp` | Unix timestamp (seconds) when the response was generated |

## HTTP Status Codes

| Code | Meaning | Notes |
|---|---|---|
| 200 | Success | Always check business `responseCode` in the response body |
| 307 | Temporary Redirect | Re-send the original request using the URL in the `Location` header |
| 400 | Bad Request | Invalid parameters / missing required fields / illegal enum value |
| 401 | Unauthorized | `Authorization` header missing or malformed |
| 403 | Invalid access token | Bearer token value is invalid |
| 404 | Not Found | URL path misspelled or `API_BASE_URL` is wrong |
| 500 | Internal Server Error | Report to Coshine with `tranId` and timestamp |
| 502 | Bad Gateway | Same as above |

## URL Naming Convention

Sandbox endpoints use **module-prefixed + lowerCamelCase action** paths:

- `/cardmgr/*` — card management (apply, activate, block, close, etc.)
- `/custmgr/*` — customer management (customer info, card/account inquiry by CIF)
- `/acctmgr/*` — account management
- `/paramgr/*` — parameters (PIN public key, drop-down lists, etc.)
- `/tranmgr/*` — transactions (ISO-8583 messages, etc.)

See `endpoints-catalog.md` for full URL paths.
