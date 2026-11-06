# Endpoints Catalog

Source-confirmed Channel mappings, reviewed 2026-11-06 at commit `bce36fe`. These are relative to the assigned API base, not proof that the gateway exposes every route or that the client is entitled to invoke it. Administrative, PCI and notification receiver paths require their own integration scope. Use the assigned authentication profile.

## Common business-name mappings

| Business operation | POST path |
|---|---|
| CardApplication | `/cardmgr/cardApply` |
| CustomerCardInfoInquiry | `/custmgr/inquiryCardListByCIF` |
| CardActivation | `/cardmgr/cardActivate` |
| CardInfoInquiry | `/cardmgr/inquiryCardInfoByToken` |
| BalanceInquiry | `/tranmgr/inquiryBalance` |
| LoadFund / Deposit (4003) | `/tranmgr/deposit` |
| Withdraw | `/tranmgr/withdraw` |
| Card products | `/paramgr/inquiryCardProduct` |
| Dropdown/reference values | `/paramgr/inquiryDropdownList` |
| Issuer/programmer funding limit inquiry | `/paramgr/inquiryIssuerLimit` |

No generic `/tranmgr/loadFund` route is established. Do not guess TransferFund/Purchase/Refund/Reversal REST paths from document operation names. Obtain the applicable transport contract where no controller mapping is listed. Route existence alone does not define the complete request schema.

## Active source mappings

| Method | Relative path | Controller |
|---|---|---|
| POST | `/acctmgr/acctLinkage` | AcctMgrController |
| POST | `/cardmgr/cardApply` | CardMgrController |
| POST | `/cardmgr/cardActivate` | CardMgrController |
| POST | `/cardmgr/cardReissue` | CardMgrController |
| POST | `/cardmgr/cardReplace` | CardMgrController |
| POST | `/cardmgr/cardClose` | CardMgrController |
| POST | `/cardmgr/cardStatusUpdate` | CardMgrController |
| POST | `/cardmgr/cardLimitSetting` | CardMgrController |
| POST | `/cardmgr/pinVerify` | CardMgrController |
| POST | `/cardmgr/pinChange` | CardMgrController |
| POST | `/cardmgr/pinReset` | CardMgrController |
| POST | `/cardmgr/verifyCVV2` | CardMgrController |
| POST | `/cardmgr/cardPlasticUpdate` | CardMgrController |
| POST | `/cardmgr/cardInfoUpdate` | CardMgrController |
| POST | `/cardmgr/businessFlagUpdate` | CardMgrController |
| POST | `/cardmgr/cardNoBlock` | CardMgrController |
| POST | `/cardmgr/pci/inquiryCardInfoByCardNo` | CardMgrController |
| POST | `/cardmgr/pci/inquiryCVV2ByCardNo` | CardMgrController |
| POST | `/cardmgr/inquiryCardInfoByToken` | CardMgrController |
| POST | `/cardmgr/inquiryCardNumberByToken` | CardMgrController |
| POST | `/cardmgr/inquiryCVV2ByToken` | CardMgrController |
| POST | `/custmgr/updateCustInfo` | CustMgrController |
| POST | `/custmgr/pci/inquiryCardListByCIF` | CustMgrController |
| POST | `/custmgr/inquiryCardListByCIF` | CustMgrController |
| POST | `/paramgr/generatePublicPinKey` | ParaMgrController |
| POST | `/paramgr/importKey` | ParaMgrController |
| POST | `/paramgr/setIssuerLimit` | ParaMgrController |
| GET | `/paramgr/getJwks` | ParaMgrController |
| POST | `/paramgr/inquiryDropdownList` | ParaMgrController |
| POST | `/paramgr/inquiryCardProduct` | ParaMgrController |
| POST | `/paramgr/inquiryIssuerLimit` | ParaMgrController |
| POST | `/file/fileDownload` | ParaMgrController |
| POST | `/vts/tokenNotification` | ParaMgrController |
| POST | `/tranmgr/tran8583` | TranMgrController |
| POST | `/tranmgr/inquiryBalance` | TranMgrController |
| POST | `/tranmgr/deposit` | TranMgrController |
| POST | `/tranmgr/withdraw` | TranMgrController |
| POST | `/tranmgr/acctVerify` | TranMgrController |
| POST | `/tranmgr/inquiryTranList` | TranMgrController |
| POST | `/tranmgr/inquiryBillList` | TranMgrController |
| POST | `/tranmgr/retrieve` | TranMgrController |
| POST | `/tranmgr/inquiryTranByChlId` | TranMgrController |
