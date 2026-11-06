---
name: card-issuing-references
description: "Use when looking up EastPay API paths, public fields, error meanings, participant routing, funding or implementation prerequisites."
---

# EastPay Card Issuing — References

Baseline: 2026-11-06. Read only the relevant reference:

- [api-introduction.md](api-introduction.md): managed JWE versus explicitly provisioned legacy direct JSON.
- [public-headers.md](public-headers.md): flat business fields; endpoint-selected transaction code.
- [endpoints-catalog.md](endpoints-catalog.md): source-confirmed Channel routes and deployment/permission boundaries.
- [implementation-notes.md](implementation-notes.md): participant routing, institution/product setup, funding and readiness.
- [data-dictionary.md](data-dictionary.md): historical field enumerations; product values are assigned, not defaults.
- [error-codes.md](error-codes.md): HTTP, crypto, entitlement and business failures.
- [samples/](samples/): legacy example JSON, also usable as plaintext input to JWE after replacing example values.

Use the assigned customer/environment contract for actual URLs, credentials, scopes, keys and enabled APIs. Do not infer live availability from source code or design documents. Current managed UAT uses OAuth2/JWE; it is not merely a future migration.
