---
name: card-issuing
description: "Use when integrating EastPay/Coshine card issuing, selecting authentication, opening cards, querying balances, or configuring participant access."
---

# EastPay Card Issuing — Integration Assistant

Protocol baseline: 2026-11-06. Choose the assigned environment and access profile before generating requests.

| Request | Read |
|---|---|
| OAuth token, ES256, JWE, HTTP 400/401/403 | `../card-issuing-auth/SKILL.md` |
| First connection, card application, inquiry, activation | `../card-issuing-quickstart/SKILL.md` |
| Paths, fields, errors, funding, onboarding | `../card-issuing-references/SKILL.md` |

The three-step card flow is a minimal example, not the platform's API limit. Balance, deposit, withdrawal and other implemented paths are listed in the endpoint catalog; path existence does not establish customer entitlement or deployment.

## Integration boundaries

- Managed HTTP access uses OAuth2 plus JWE; the old direct sandbox uses static Bearer plus JSON only where explicitly provisioned. Do not downgrade after an authentication failure.
- The customer supplies assigned `participantId` and `tranBranch`, not internal `tenantId` or `X-Tenant`. An identifier alone is not authentication.
- Do not invent environment URLs, credentials, participant/branch/product values, scopes or key IDs. Reuse supplied onboarding data; missing values can remain placeholders in code.
- The separate scheme Card Gateway TCP interface does not acquire the HTTP OAuth/JWE contract. Confirm its configured participant-routing or legacy tenant-routing mode.
- Treat reviewed source capabilities, configured access, deployed versions and verified operation as distinct evidence.

## Reference implementation

The workspace `reference-impl/` Python client and fixtures illustrate the legacy three-step JSON flow. They are not an OAuth/JWE client and are not required for customers using another language. Package users need only these skills; do not assume the Python project is installed.
