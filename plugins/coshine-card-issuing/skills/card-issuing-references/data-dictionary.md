# Data Dictionary

## cardFlag（卡标识）

| 值 | 含义 |
|---|---|
| `V` | 虚拟卡 (Virtual) |
| `P` | 实体卡 (Physical) |

## cardProdCode（卡产品代码）

**由 Coshine 按客户分配。** 常见值：

| Sandbox 值 | 卡组织 |
|---|---|
| `2201` | Visa |
| `5200` | Mastercard |

> 原官方文档中 `1000=Debit` / `2000=Credit` 是产品大类表达，与 sandbox 实际使用的客户分配码不同。**以 Coshine 分配值为准。**

## cardProductType（卡产品类型）

| 值 | 含义 |
|---|---|
| `C` | 信用卡 (Credit) |
| `D` | 借记卡 (Debit) |
| `G` | 礼品卡 (Gift) |
| `P` | 预付卡 (Prepaid) |
| `B` | 商务卡 (Business) |
| `R` | 企业卡 (Corporate) |

## cardStatus（卡状态）

| 值 | 含义 |
|---|---|
| `N` | 新卡（未激活） |
| `U` | 正常使用中 |
| `D` | 注销 |
| `L` | 挂失 |
| `P` | 待处理 |
| `O` | 打开 |
| `X` | 已销卡 |
| `E` | **已过期**（PDF v4.3.13 新增） |

## cardOptFlag（卡操作标识，CardStatusUpdate）

| 值 | 含义 |
|---|---|
| `B` | 挂失 |
| `C` | 解挂 |
| `D` | 冻结 |
| `E` | 解冻 |
| `G` | PIN 锁定 |
| `H` | PIN 解锁 |

## tranChnl（交易渠道）

| 值 | 含义 |
|---|---|
| `06` | CMS（卡管理系统） |
| `07` | WEB |
| `08` | APP |
| `09` | ACS |
| `10` | UMPS |

## custIdType（证件类型）

| 值 | 含义 |
|---|---|
| `D` | 驾照 |
| `P` | 护照（默认） |
| `I` | 国民身份证 |
| `U` | UMID |
| `Z` | 邮政 ID |
| `V` | 选民 ID |
| `S` | SSS |
| `T` | TIN |
| `O` | 其他 |

## Replacement reasonCode（换卡原因码）

| 值 | 含义 |
|---|---|
| `001` | 卡损坏 |
| `002` | 卡丢失 |
| `003` | 卡被盗 |
| `004` | 卡过期 |
| `999` | 其他 |
