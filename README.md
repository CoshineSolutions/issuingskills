# Coshine EastPay — Claude Code / Gemini / Codex Skills

This repo is a **[Claude Code plugin marketplace](https://docs.claude.com/en/docs/claude-code/plugin-marketplaces)** for Coshine EastPay API integration. It packages language-agnostic AI skills that guide coding assistants (Claude Code, Gemini CLI, OpenAI Codex CLI) through integrating with Coshine's card-issuing sandbox.

**Upstream project site:** https://developer.sandbox.efaka.net/docs/skills/

## Quick start (Claude Code)

```
/plugin marketplace add CoshineSolutions/issuingskills
/plugin install coshine-card-issuing@coshine-plugins
```

That's it — restart Claude Code and the 4 skills (main router, auth, quickstart, references) become available. Run `/plugin` to inspect them.

## Quick start (Gemini CLI / Codex CLI / manual install)

Clone and run the installer; symlinks the skills into `~/.claude/skills/` **and** `~/.agents/skills/` (shared standard used by Gemini CLI and OpenAI Codex CLI):

```bash
git clone https://github.com/CoshineSolutions/issuingskills.git
cd issuingskills
bash scripts/install_skills.sh          # installs to both
bash scripts/install_skills.sh --claude-only
bash scripts/install_skills.sh --agents-only
```

To update later: `cd issuingskills && git pull` — the installed symlinks pick up changes automatically.

## What's inside

```
.claude-plugin/marketplace.json              # marketplace catalogue
plugins/coshine-card-issuing/
├── .claude-plugin/plugin.json               # plugin manifest
└── skills/
    ├── card-issuing/                        # main router — intent detection
    ├── card-issuing-auth/                   # Bearer + timestamp auth
    ├── card-issuing-quickstart/             # 3-step MVP open-card flow
    └── card-issuing-references/             # protocol knowledge base
        ├── api-introduction.md
        ├── public-headers.md
        ├── data-dictionary.md
        ├── error-codes.md
        ├── endpoints-catalog.md
        └── samples/                         # request/response JSON samples
scripts/install_skills.sh                    # non-marketplace installer
```

## Scope

**MVP (v0.2):** covers the **3-API minimum integration loop** for virtual card issuing:

1. `POST /cardmgr/cardApply` — apply for a card → receive `cardToken`
2. `POST /custmgr/inquiryCardListByCIF` — look up cards by customer ID
3. `POST /cardmgr/cardActivate` — activate the card

Later releases will add card lifecycle operations (replacement, cancellation, status updates), transactions (LoadFund, BalanceInquiry), PIN operations, tokens, loyalty, and other API groups (Payment Gateway, Funding Resources, Reconciliation File).

## Feedback

- **Skill content issues** — open a GitHub issue in this repo.
- **EastPay API access / Bearer tokens / participantId assignment** — contact your Coshine integration lead.
