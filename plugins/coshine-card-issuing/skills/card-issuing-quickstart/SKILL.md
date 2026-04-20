---
name: card-issuing-quickstart
description: EastPay card-issuing end-to-end minimum integration guide — 3-step card open flow (Application → Inquiry → Activation)
---

# EastPay Card Issuing — Quickstart (3-Step Minimum Loop)

## Prerequisites

Obtain the following 5 items from Coshine:

1. `API_BASE_URL` (sandbox: `https://march.sandbox.efaka.net/card-api`)
2. Bearer Token
3. `participantId`
4. `tranBranch`
5. `cardProdCode` (sandbox common values: Visa=`2201` / Mastercard=`5200`)

Set up authentication first (see `card-issuing-auth`), then proceed:

## 3-Step Flow

```
Step 1: Apply   (cardApply)             → receive cardToken + expiryDate + CVV2
Step 2: Inquire (inquiryCardListByCIF)  → verify the new card is visible by customerId
Step 3: Activate (cardActivate)         → card moves to active state (responseCode="00")
```

### Step 1 · CardApplication

**Path:** `POST {API_BASE_URL}/cardmgr/cardApply`

**Required fields (virtual card, minimal set):**

| Field | Description |
|---|---|
| `cardFlag` | `V` (virtual) or `P` (physical) |
| `cardProdCode` | Assigned by Coshine |
| `customerId` | Your customer identifier / CIF (≤32 chars) |
| `custIdType` | ID document type — see data-dictionary |
| `custIdNo` | ID document number |

**Key response fields:** `cardToken` (reference handle for all subsequent operations), `expiryDate` (YYMM format), `CVV2`

> Physical cards (`cardFlag=P`) also require `cardEmbossName` and mailing address fields — see `card-issuing-references/endpoints-catalog.md`.

**Samples:** `card-issuing-references/samples/card_application_request.json` / `card_application_response.json`

### Step 2 · CustomerCardInfoInquiry

**Path:** `POST {API_BASE_URL}/custmgr/inquiryCardListByCIF`

**Required:** `customerId` (same value used in Step 1)

**Key response field:** `cardList[]` — assert it contains the `cardToken` from Step 1.

**Purpose:** Validates the read path ("card is retrievable by CIF"); also commonly used to list all cards under a customer.

**Samples:** `card-issuing-references/samples/customer_card_info_inquiry_*.json`

### Step 3 · CardActivation

**Path:** `POST {API_BASE_URL}/cardmgr/cardActivate`

**Required fields:**

| Field | Source |
|---|---|
| `cardToken` | Step 1 response |
| `expiryDate` | Step 1 response |
| `CVV2` | Step 1 response |
| `customerId` / `custIdType` / `custIdNo` | Cardholder identity verification |

**Response:** `responseCode == "00"` means activation succeeded; card status transitions from `N` to `U`.

**Samples:** `card-issuing-references/samples/card_activation_*.json`

## Testing Strategy (Protocol-Level, Language-Agnostic)

Use any HTTP client (curl, Postman, or any language's HTTP library) to validate the 3-step loop:

1. **Field-level pre-check (no real credentials):** Assemble 3 request bodies from `card-issuing-references/samples/*_request.json`, add `Authorization: Bearer <any-string>` + `timestamp` header, and send to a mock or stub server. Assert:
   - Step 1 response contains `cardToken` / `expiryDate` / `CVV2`
   - Step 2 response `cardList[]` includes the `cardToken` from Step 1
   - Step 3 response `responseCode == "00"`
2. **Switch to real sandbox:** Replace `Bearer <TOKEN>`, `participantId`, `tranBranch` with Coshine-assigned values and `API_BASE_URL` with the real base URL. Run the same 3-step sequence. Stop immediately on any `responseCode != "00"` and consult `card-issuing-references/error-codes.md`.
3. **No language requirement:** Bearer Token + plaintext JSON requires no JWT/JWE computation; any HTTP client works — curl, Postman, httpx/requests, OkHttp, axios, Go net/http, etc.

### Reference Implementation (Python, optional)

This repo ships a **Python reference implementation** for engineering validation only — it is not a protocol requirement:

- `reference-impl/scripts/mock_server.py` — minimal FastAPI mock returning ideal responses from `samples/`
- `reference-impl/scripts/validate_quickstart.py` — CLI runner for the 3-step loop
- `reference-impl/scripts/lint_fixtures.py` — validates samples are consistent with Python test fixtures

If your stack is not Python, implement the protocol-level approach above directly; there is no need to run the Python version first.

## AI Behavior Rules

1. Follow the 3-step sequence strictly — do not skip steps
2. `cardToken` is the critical handle; it must be read from the Step 1 response — **never fabricate it**
3. On any `responseCode != "00"` → stop immediately and consult `card-issuing-references/error-codes.md`
4. Do not assume `AccountLinkage` is required in the MVP — it has been removed from the minimum loop
5. **Transaction APIs** (LoadFund / BalanceInquiry / etc.) have unconfirmed sandbox URLs in the current MVP — confirm with Coshine before integrating

## References

- `card-issuing-auth` — authentication setup
- `card-issuing-references/public-headers.md` — 9-field public body headers
- `card-issuing-references/samples/` — complete JSON samples for all 3 APIs
- `card-issuing-references/endpoints-catalog.md` — full endpoint catalog
