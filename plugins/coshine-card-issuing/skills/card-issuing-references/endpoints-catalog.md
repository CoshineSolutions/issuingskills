# Endpoints Catalog

**API Base URL:** `https://march.sandbox.efaka.net/card-api` (sandbox; confirm production URL with Coshine)

All requests use `POST`, plaintext JSON body, with `Authorization: Bearer <token>` + `timestamp` headers.

## MVP — 3 Covered Endpoints

| API Name | Path | Description |
|---|---|---|
| CardApplication | `/cardmgr/cardApply` | Apply for a new card |
| CustomerCardInfoInquiry | `/custmgr/inquiryCardListByCIF` | List cards by `customerId` |
| CardActivation | `/cardmgr/cardActivate` | Activate a card |

## Full API Catalog (from PDF v4.3.17 + Postman)

### Application

| API | Path |
|---|---|
| CardApplication | `/cardmgr/cardApply` |
| CorporateCardApplication | `/cardmgr/corpCardApply` (to be confirmed) |

### Customer

| API | Path |
|---|---|
| CustomerCardInfoInquiry | `/custmgr/inquiryCardListByCIF` |
| CustomerAccountInfoInquiry | `/custmgr/inquiryAcctListByCIF` |
| CustomerInfoUpdate | `/custmgr/updateCustInfo` |

### Account

| API | Path |
|---|---|
| AcctLinkage | `/acctmgr/acctLinkage` |

### Card

| API | Path |
|---|---|
| CardInfoInquiry | `/cardmgr/inquiryCardInfoByToken` |
| CardActivation | `/cardmgr/cardActivate` |
| CardReissue | `/cardmgr/cardReissue` |
| CardReplacement | `/cardmgr/cardReplace` |
| CardCancellation | `/cardmgr/cardClose` |
| CardPlasticUpdate | `/cardmgr/cardPlasticUpdate` |
| CardStatusUpdate | `/cardmgr/cardStatusUpdate` |
| CardLimitSetting | `/cardmgr/cardLimitSetting` |
| CardNumberInquiry | `/cardmgr/inquiryCardNumberByToken` |
| CVV2Inquiry | `/cardmgr/inquiryCVV2ByToken` |
| CVV2Verify | `/cardmgr/verifyCVV2` |
| BusinessFlagUpdate | `/cardmgr/businessFlagUpdate` |

### PIN

| API | Path |
|---|---|
| GeneratePublicPinKey | `/paramgr/generatePublicPinKey` |
| PINReset | `/cardmgr/pinReset` |
| PINChange | `/cardmgr/pinChange` |
| PINVerify | `/cardmgr/pinVerify` |

### Transaction (ISO-8583)

| API | Path |
|---|---|
| tran8583 | `/tranmgr/tran8583` |

### JSON-style Transaction APIs

**To be confirmed:** LoadFund / BalanceInquiry / TransferFund / Purchase / Refund / Reversal and similar APIs are not exposed in the current Postman collection. Based on the naming pattern in PDF v4.3.17, they likely reside under `/tranmgr/<camelCase>` — confirm the exact paths with Coshine before integrating.

### Additional APIs in PDF v4.3.17

`CardFaceInquiry` / `CardExpiryDateUpdate` / `CustomerLinkage` / `CardInfoUpdate` / `CardNoBlock` / `BusinessFlagInquiry` / `BusinessOnOff` / `DropDownListInquiry` / `InquiryCardProduct` / `Verification` / `FileDownload` / `ConvertPrepaidtoDebit`

Paths for these APIs must be confirmed with Coshine.
