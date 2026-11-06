---
name: card-issuing-quickstart
description: "Use when validating first EastPay connectivity or implementing the minimal application, customer card inquiry and activation flow."
---

# EastPay Card Issuing — Quickstart

## Prerequisites and first connection

Obtain the assigned API base, authentication profile, participant, allowed branch and product. For managed HTTP, follow [authentication](../card-issuing-auth/SKILL.md) to obtain a token and encrypt/decrypt messages. Historical sample JSON files represent plaintext before encryption, not the managed wire body. Sample product codes and identities are not assigned customer values.

First validate access with an entitled read-only endpoint such as `POST /paramgr/inquiryCardProduct` or `POST /paramgr/inquiryDropdownList`. Use the assigned fields from its schema. Check HTTP status, decrypt if applicable, and require business `responseCode="00"`. An empty product list does not prove product setup is complete. Do not issue cards or move funds merely to test connectivity.

## Minimal card flow

| Step | POST path | Input and verification |
|---|---|---|
| 1. Apply | `/cardmgr/cardApply` | Public fields plus assigned `cardProdCode`, `cardFlag`, `customerId`, `custIdType`, `custIdNo`; persist returned `cardToken`. Physical-card address/embossing fields and other product requirements are conditional. |
| 2. Read back | `/custmgr/inquiryCardListByCIF` | Same `customerId`; verify returned `cardList[]` contains the token from step 1. |
| 3. Activate | `/cardmgr/cardActivate` | Use the returned token and required identity/verification fields from the selected product contract; check success and query actual status. |

Historical activation samples use `expiryDate`, `CVV2`, `customerId`, `custIdType`, `custIdNo`. Do not fabricate missing CVV2 or assume every product exposes it. Do not put sensitive response data in logs. Product activation settings govern whether a new card needs activation; do not assert an unconditional N-to-U transition for all products.

All business/public fields are flat, before JWE encryption. The [samples](../card-issuing-references/samples/) illustrate the three-step legacy contract; replace identities, dates, products and transaction IDs with actual assigned/current values.

## Verification and recovery

- Stop on non-`00` business results and inspect [errors](../card-issuing-references/error-codes.md).
- Keep `cardToken` as a string and use the returned value; do not invent one.
- For ambiguous apply/activation outcomes, reconcile by customer/card inquiry before retrying.
- Account linkage is conditional on the account model, not universally required in this minimal flow.
- Balance and funding APIs are separate workflows. See the [endpoint catalog](../card-issuing-references/endpoints-catalog.md) and [onboarding/funding notes](../card-issuing-references/implementation-notes.md); do not infer write permission from a successful inquiry.

The optional workspace Python mock/client validates the legacy JSON samples only. Managed integration also needs token acquisition, JWE round-trip and entitlement checks against the assigned environment.

For optional activation-code/custom/company fields and physical reissue/replacement schemas, read [upstream field changes](../card-issuing-references/api-field-changes.md). Do not make optional fields mandatory in the minimal flow.
