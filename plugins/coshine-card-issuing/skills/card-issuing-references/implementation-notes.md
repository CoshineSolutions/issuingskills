# Implementation and Onboarding Notes

## Customer identity and environment

Managed HTTP customers provide participantId/tranBranch. The control plane manages environment/client/participant/branch access and the internal tenant mapping. Participant ID is not a secret or an authentication credential. Do not expose internal Bearer credentials, tenant routing headers or database configuration in customer instructions.

A deployment can share service processes while isolating tenant data/configuration; do not promise a dedicated process for every customer. Verify the assigned deployment model. The separate scheme Card Gateway TCP ingress retains its framing/network contract; it does not use the managed HTTP OAuth flow. Confirm its configured routing mode before sending messages.

## Institution and product setup

The customer workbook differentiates issuer/sponsor and programmer responsibilities. Use the latest approved, non-superseded customer form and its import evidence. Collect institution/branch mapping, scheme/BIN ownership, product/account type, currencies, limits, fees, settlement, cooperative authorization, notifications/reports, API access and back-office users. Configuring a workbook is not proof of runtime activation.

Check that card product, account type and currency match the intended program. Do not infer currency from a product code or populate codes from another customer's examples. Public API permissions and back-office user permissions are separate.

## Funding

`PROGRAMMER_FUNDED` is a funding-control mode, separate from the customer card/account balance model. Reviewed code scopes issuer-limit inquiry to the resolved participant/branch and its programmer; the request cannot select another programmer by supplying an arbitrary identifier.

`POST /paramgr/inquiryIssuerLimit` can return `programmerId`, `acctCurrency`, `issuerLimit` (available amount), `bookAmount`, `heldAmount`, `deficit`, `fundingStatus` in this mode. Supply a three-digit numeric `acctCurrency`; omission is ambiguous if multiple funding currencies exist. Confirm deployed support and permissions first.

Card LoadFund/Deposit (`/tranmgr/deposit`) must not be described as automatically replenishing the programmer funding ledger. Funding top-up, holds, release, fee treatment, reversals and recovery require the agreed ledger workflow and operational ownership. On timeout or unknown result, reconcile before replay.

## Go-live evidence

Confirm configuration accepted and activated, consumer version/health, database migrations, product availability, OAuth/JWE round-trip, positive and negative participant/branch checks, lifecycle acceptance, relevant funding/notification/report tests and operations sign-off. A source implementation, workbook import or a healthy TCP listener alone does not establish end-to-end readiness.

## Evidence baseline

- 2026-11-04 UAT customer troubleshooting record: managed compact JWE, exact media type and no business-body JWS.
- Gateman `WebUtils`/`JweUtils`: media type and RSA-OAEP-256/A128GCM serialization.
- Channel `bce36fe`: controllers and `ProgrammerFundingAccess`.
- 2026-10-31 workbook implementation verification explicitly reported LOCAL_IMPLEMENTATION_NOT_DEPLOYED; later customer forms supersede the earlier draft. Do not infer live deployment from that report.

Environment-specific addresses, client IDs, key IDs and customer identifiers must come from the assigned onboarding package.
