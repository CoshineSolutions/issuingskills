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
    ├── card-issuing-auth/                   # OAuth2/JWE and legacy auth
    ├── card-issuing-quickstart/             # card onboarding and 3-step flow
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

Version 0.3.1 (2026-11-06) covers managed OAuth2/JWE, explicitly provisioned legacy direct access, participant/branch routing, a read-only connectivity check followed by the three-step card example, and source-confirmed transaction/parameter routes. Funding and workbook notes distinguish implemented capability from deployed entitlement. See the bundled references for details.

## Feedback

- **Skill content issues** — open a GitHub issue in this repo.
- **EastPay API access / Bearer tokens / participantId assignment** — contact your Coshine integration lead.
