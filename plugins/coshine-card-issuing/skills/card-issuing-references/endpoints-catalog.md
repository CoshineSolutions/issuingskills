# Endpoints Catalog

**API Base URL:** `https://march.sandbox.efaka.net/card-api`（sandbox；生产请向 Coshine 确认）

所有请求：`POST`，body 明文 JSON，带 `Authorization: Bearer <token>` + `timestamp` header。

## MVP 覆盖的 3 个端点

| API 名 | 路径 | 说明 |
|---|---|---|
| CardApplication | `/cardmgr/cardApply` | 开卡 |
| CustomerCardInfoInquiry | `/custmgr/inquiryCardListByCIF` | 按 `customerId` 查卡列表 |
| CardActivation | `/cardmgr/cardActivate` | 激活卡片 |

## 完整 API 目录（引用 PDF v4.3.17 + Postman 实际命名）

### Application

| API | 路径 |
|---|---|
| CardApplication | `/cardmgr/cardApply` |
| CorporateCardApplication | `/cardmgr/corpCardApply`（待确认） |

### Customer

| API | 路径 |
|---|---|
| CustomerCardInfoInquiry | `/custmgr/inquiryCardListByCIF` |
| CustomerAccountInfoInquiry | `/custmgr/inquiryAcctListByCIF` |
| CustomerInfoUpdate | `/custmgr/updateCustInfo` |

### Account

| API | 路径 |
|---|---|
| AcctLinkage | `/acctmgr/acctLinkage` |

### Card

| API | 路径 |
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

| API | 路径 |
|---|---|
| GeneratePublicPinKey | `/paramgr/generatePublicPinKey` |
| PINReset | `/cardmgr/pinReset` |
| PINChange | `/cardmgr/pinChange` |
| PINVerify | `/cardmgr/pinVerify` |

### Transaction（ISO-8583）

| API | 路径 |
|---|---|
| tran8583 | `/tranmgr/tran8583` |

### JSON 风格的 Transaction API

**待确认**：LoadFund / BalanceInquiry / TransferFund / Purchase / Refund / Reversal 等在 sandbox 的 REST URL 未在现有 Postman 暴露；按 PDF v4.3.17 模块命名规律推测可能位于 `/tranmgr/<camelCase>`，使用时请向 Coshine 确认准确路径。

### PDF v4.3.17 相对原设计文档补齐的 API

`CardFaceInquiry` / `CardExpiryDateUpdate` / `CustomerLinkage` / `CardInfoUpdate` / `CardNoBlock` / `BusinessFlagInquiry` / `BusinessOnOff` / `DropDownListInquiry` / `InquiryCardProduct` / `Verification` / `FileDownload` / `ConvertPrepaidtoDebit`

各自的路径需向 Coshine 确认。
