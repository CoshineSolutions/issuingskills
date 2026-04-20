# Error Codes

## Business Response Codes (body.responseCode)

| Code | Meaning | Troubleshooting guidance |
|---|---|---|
| `00` | Success | — |
| `01` | Invalid participant | Check `participantId`; verify with Coshine |
| `02` | Invalid card number | `cardNumber` is wrong or card does not exist |
| `03` | Invalid card status | Card is closed or not yet activated; check `cardStatus` in `data-dictionary.md` |
| `04` | Invalid `cardToken` | Token format or value is incorrect |
| `10` | Restricted access, no data returned | Customer account lacks permission for this API; ask Coshine to grant access |
| `24` | PIN block format error | RSA-encrypted PIN flow is wrong — check the `GeneratePublicPinKey` flow |
| `55` | PIN verification failed | PIN value is incorrect |
| `99` | Unknown data retrieval error | Record `tranId` and contact Coshine technical support |

## HTTP Status Codes

| Code | Meaning | Troubleshooting guidance |
|---|---|---|
| `200` | Success | Check business `responseCode` in the response body |
| `307` | Temporary Redirect | Re-send request to the URL in the `Location` header using the original method |
| `400` | Bad Request | Check JSON format, required fields, and enum values; focus on the 9 public header fields |
| `401` | Unauthorized | `Authorization` header is missing or malformed |
| `403` | Invalid access token | Bearer token is invalid — request a new token from Coshine |
| `404` | Not Found | URL path is misspelled or `API_BASE_URL` is wrong |
| `500` | Internal Server Error | Report to Coshine with `tranId` and request timestamp |
| `502` | Bad Gateway | Same as above |

## Situations Where AI Should Pause and Ask

1. User has not provided a Bearer token → **do not fabricate one** — direct the user to contact Coshine
2. User has not provided `participantId` / `tranBranch` → do not submit example values (`100000` / `GTW100000`) as real credentials
3. Response code `99` → ask the user to provide `tranId` and contact Coshine support
4. Response code `10` → check whether the user's account has been granted permission for the API by Coshine
