---
name: card-issuing
description: EastPay card-issuing integration assistant — detects user intent and routes to the appropriate sub-skill (auth / quickstart / references). Trigger words: EastPay, card issuing, card apply, open card, Coshine
---

# EastPay Card Issuing — Integration Assistant

## System Overview

EastPay is Coshine Software's SaaS card-issuing platform, providing:

- Card Issuing API (~58 endpoints across Application / Customer / Account / Card / PIN / Transaction / Token / Loyalty modules)
- Payment Gateway API
- Funding Resources API
- Reconciliation File API

**The current MVP covers only 3 Card Issuing APIs**, forming the minimum end-to-end integration loop.

## Intent Detection and Routing

Route the user to the appropriate sub-skill based on their request:

| User says (examples) | Route to |
|---|---|
| "how to authenticate / how to use the token / how to set Authorization" | `card-issuing-auth` |
| "how to open a card / give me a minimal integration example / quickstart / demo" | `card-issuing-quickstart` |
| "what are the public header fields / cardStatus enum values / error code meanings" | `card-issuing-references` |
| "I need to integrate LoadFund / BalanceInquiry / other advanced features" | **Inform user: not in MVP scope** — path to be confirmed with Coshine |
| "CardReplacement / Cancellation / 3DS / Loyalty" | Same as above — Phase 1 P1 or Phase 2 |

## Key Protocol Facts (always communicate to users)

1. **Current sandbox auth uses a static Bearer Token** (not OAuth2/JWE); URL pattern is `/cardmgr/cardApply` etc. in lowerCamelCase
2. **Bearer Token / participantId / tranBranch / cardProdCode are all assigned by Coshine** — do not fabricate values
3. **MVP loop is exactly 3 APIs**: CardApplication → CustomerCardInfoInquiry → CardActivation
4. Paths for other APIs must be confirmed directly with Coshine

## Python Reference Implementation

The `reference-impl/` directory in this repo contains a Python reference implementation:

- `eastpay/` package: `Client` class + 3 endpoint wrappers
- `scripts/mock_server.py`: minimal mock server for flow validation without real credentials
- `scripts/validate_quickstart.py`: CLI runner for the 3-step loop
- `scripts/lint_fixtures.py`: validates samples are consistent with test fixtures

This skill remains **language-agnostic**. The Python implementation is an engineering validation tool only; for other languages, generate code based on the protocol described in these skills.

## Reference Documents

- Developer portal: `https://developer.sandbox.efaka.net`
- Upstream PDF: `CARD_API_list_Card_v4.3.17.pdf`
