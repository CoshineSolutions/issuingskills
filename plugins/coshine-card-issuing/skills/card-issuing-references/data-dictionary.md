# Data Dictionary

## cardFlag (Card Type)

| Value | Meaning |
|---|---|
| `V` | Virtual card |
| `P` | Physical card |

## cardProdCode (Card Product Code)

**Assigned by Coshine per customer.** Common sandbox values:

| Sandbox value | Card network |
|---|---|
| `2201` | Visa |
| `5200` | Mastercard |

> The official PDF uses `1000=Debit` / `2000=Credit` as product category notation — these differ from the customer-specific codes assigned for actual sandbox use. **Always use the value Coshine assigns.**

## cardProductType (Card Product Type)

| Value | Meaning |
|---|---|
| `C` | Credit |
| `D` | Debit |
| `G` | Gift |
| `P` | Prepaid |
| `B` | Business |
| `R` | Corporate |

## cardStatus (Card Status)

| Value | Meaning |
|---|---|
| `N` | New (not yet activated) |
| `U` | Active (in use) |
| `D` | Cancelled |
| `L` | Lost/blocked |
| `P` | Pending |
| `O` | Open |
| `X` | Closed |
| `E` | **Expired** (added in PDF v4.3.13) |

## cardOptFlag (Card Operation Flag — CardStatusUpdate)

| Value | Meaning |
|---|---|
| `B` | Block (report lost) |
| `C` | Unblock |
| `D` | Freeze |
| `E` | Unfreeze |
| `G` | PIN lock |
| `H` | PIN unlock |

## tranChnl (Transaction Channel)

| Value | Meaning |
|---|---|
| `06` | CMS (Card Management System) |
| `07` | WEB |
| `08` | APP |
| `09` | ACS |
| `10` | UMPS |

## custIdType (ID Document Type)

| Value | Meaning |
|---|---|
| `D` | Driver's license |
| `P` | Passport (default) |
| `I` | National ID card |
| `U` | UMID |
| `Z` | Postal ID |
| `V` | Voter's ID |
| `S` | SSS |
| `T` | TIN |
| `O` | Other |

## Replacement reasonCode (Card Replacement Reason)

| Value | Meaning |
|---|---|
| `001` | Damaged card |
| `002` | Lost card |
| `003` | Stolen card |
| `004` | Expired card |
| `999` | Other |
