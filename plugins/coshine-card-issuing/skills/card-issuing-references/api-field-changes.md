# Upstream API Field Changes — reviewed 2026-11-06

These are documented API contract changes, not evidence that a particular runtime has deployed them. Preserve endpoint-specific required/conditional rules and confirm the target version when generating a complete request.

## CardApplication, CardReissue and CardReplacement (148d5fb)

- CardApplication adds optional `customField1` (string, max 32; activation code) and `customField2` (string, max 64; user-defined information). Treat activation codes as sensitive. Existing optional `companyName` is max 60. Do not automatically copy these additions to CorporateCardApplication.
- CardReissue and CardReplacement add those same optional custom fields and `companyName` (max 60), plus physical fulfilment fields: `homeAddr1`–`homeAddr4` (max 40 each), `recipient` (max 60), `contactNo` (max 20), `carrier`, `packaging`, `dispatch`, `SLA` (max 10 each).
- Physical replacement requires `homeCountry`, `homeState`, `homeCity` (max 20 each), `homeAddr1` and `homePostalCode` (max 6) under its explicit cardFlag=P conditions. Reissue explicitly requires homeAddr1 for physical cards but retains its own other address rules. Do not treat the two schemas as identical.
- Documented fulfilment values include carrier `REGULAR`, packaging `NOINS` when no inserts, dispatch `IES_BULK` for batch dispatch, SLA `D02`. Follow the agreed product/bureau configuration; conditional fields without a documented trigger require confirmation.

## Cooperative Authorization / Authorization Advice (4aa14b6)

`settleAmount` and `settleCurrency` were removed from these two request contracts. Do not require or synthesize them. `tranAmount`/`tranCurrency` and `billAmount`/`billCurrency` keep their own conditions. The removal does not apply globally to settlement, clearing or reconciliation files.

## SMS and Email OTP (e34fe49)

The request adds optional `acquirerBin` (string, max 11) and `merchantId` (string, max 35). Keep strings and optionality. This specific diff concerns SMS/Email OTP; it does not make these fields mandatory on every OOB endpoint despite the commit subject mentioning OOB.

Sources: developer portal repository `docs/card-issuing/application.md`, `docs/card-issuing/card.md`, `docs/funding-resources/Remote APIs.md`, `docs/funding-resources/ACS APIs.md`, at the commits above.
