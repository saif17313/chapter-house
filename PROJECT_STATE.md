# Project State

## Project

- Project name: Chapter House
- Repository: `D:\Projects\E-Book App\chapter-house`
- Current branch: `main`
- Last known good commit: `none - repository has no commits yet`
- Last updated: `2026-06-25T02:45:17+06:00`
- Updated by: Codex

## Current Position

- Active application: global planning, mobile and shared backend
- Active phase: M0 - Discovery and planning
- Phase status: READY_FOR_REVIEW
- Current objective: Initialize the approved Markdown project-memory files without production application code.
- Approval received: Yes, for M0 Markdown project-memory implementation only.
- Next approval required: User approval to mark M0 complete and begin M1 monorepo and engineering foundation.

## Architecture Snapshot

- Flutter: Planned under `apps/mobile`; no Flutter app code exists yet.
- Admin: Planned under `apps/admin`; no Next.js app code exists yet.
- Authentication: Supabase Auth is the only planned identity provider.
- JWT: Prefer Supabase asymmetric signing keys/JWKS where supported; client decoding is non-authoritative.
- Database: Canonical PostgreSQL schema planned for M2.
- Storage: Private/public bucket model planned for M2 and secure content buckets in M8.
- Edge Functions: Planned for authenticated operations, device activation, payments, entitlement sync, and license issuance.
- Worker: Planned content and search workers under `workers/content` and `workers/search`.
- Search suggestions: Planned hybrid durable events plus Count-Min Sketch worker and exact candidate dictionary.
- Shared contracts: Planned under `packages/contracts`; no generated types exist yet.

## Current Versions

- Latest migration: none
- Contract version: none
- Mobile version: none
- Admin version: none
- Search-sketch version: none
- Theme-schema version: none
- Localization-schema version: none

## Canonical Decisions

| Decision | Choice | Reason | Date | ADR |
|---|---|---|---|---|
| Repository model | Monorepo under `apps/*` | Keeps mobile, admin, backend, workers, and contracts in one shared source of truth. | 2026-06-25 | Pending |
| Backend model | One shared Supabase backend per environment | Prevents divergent auth, payments, entitlements, contracts, and policies. | 2026-06-25 | Pending |
| Auth provider | Supabase Auth | Avoids custom password storage and integrates with RLS. | 2026-06-25 | Pending |
| Payment v1 | Manual bKash/Nagad review | Matches initial operational requirement without pretending to be automated provider integration. | 2026-06-25 | Pending |
| Content protection | Production DRM posture with documented limitations | Reduces leakage risk while acknowledging perfect protection is impossible. | 2026-06-25 | Pending |
| Admin timing | Minimal operations admin before beta | Supports catalog, payments, content processing, configuration, and support without delaying mobile beta for broad analytics. | 2026-06-25 | Pending |

## Completed Work

- [x] Repository inspected: greenfield repo with `.git` only before M0 file creation.
- [x] Current branch inspected: `main`.
- [x] Remote inspected: `origin` points to `https://github.com/saif17313/chapter-house.git`.
- [x] Local toolchain inspected: Flutter, Dart, Node, npm, Git, and Docker available; Supabase CLI and GitHub CLI missing.
- [x] M0 project-memory file set initialized.

## Work In Progress

- [ ] M0 review and user approval.

## Remaining Work

- [ ] User reviews M0 project-memory files.
- [ ] User approves M0 completion.
- [ ] User approves or rejects starting M1.
- [ ] M1 installs or documents Supabase CLI and GitHub CLI path decisions.
- [ ] M1 initializes monorepo, app shells, local Supabase config, CI, environment templates, and test foundation.

## Verification

| Command | Result | Date | Notes |
|---|---|---|---|
| `git status --short --branch` | Passed | 2026-06-25 | Shows no commits on `main`; new untracked M0 docs only. |
| `rg --files` | Passed | 2026-06-25 | Lists all nine requested Markdown files. |
| `Test-Path` required files | Passed | 2026-06-25 | All requested paths returned `True`. |
| `git diff --check` | Passed | 2026-06-25 | No whitespace errors reported. |
| Markdown formatter | Not configured | 2026-06-25 | No repository formatter exists yet. |

## Files Changed

| File | Change | Reason |
|---|---|---|
| `AGENTS.md` | Added permanent Codex operating instructions. | Enforce startup, phase control, checks, security, and handoff rules. |
| `MASTER_PLAN.md` | Added cross-platform source of truth. | Track product scope, architecture, phase order, dependencies, risks, and change control. |
| `PROJECT_STATE.md` | Added current project snapshot. | Provide global state and next action for future sessions. |
| `docs/plans/MOBILE_APP_PLAN.md` | Added detailed mobile plan. | Define Flutter app requirements, phase details, and acceptance criteria. |
| `docs/plans/SHARED_BACKEND_PLAN.md` | Added detailed shared backend plan. | Define Supabase, database, auth, security, payments, search, and content workflows. |
| `docs/plans/ADMIN_PANEL_PLAN.md` | Added placeholder and dependency summary. | Scope minimal ops admin and defer detailed admin planning. |
| `apps/mobile/PROGRESS.md` | Added mobile progress tracker. | Track mobile phase evidence and dependencies. |
| `apps/admin/PROGRESS.md` | Added admin progress placeholder. | Track future admin execution evidence. |
| `docs/adr/README.md` | Added ADR index and template. | Prepare decision logging. |

## Known Issues

| Issue | Severity | Workaround | Target phase |
|---|---|---|---|
| Supabase CLI is not installed or not on PATH. | Medium | Install in M1 before local Supabase setup, or document an approved alternate path. | M1 |
| GitHub CLI is not installed or not on PATH. | Low | Use browser/manual PR flow until installed. | M1 |
| Repository has no initial commit. | Low | Commit M0 files after user requests a commit. | M0/M1 |
| `origin/main` is gone. | Low | Push first branch/main after user approval for git workflow. | M0/M1 |

## Blockers

| Blocker | Required action | Responsible party |
|---|---|---|
| M1 cannot begin until M0 is approved. | Review project-memory files and approve next phase. | User |
| Supabase local development cannot run until Supabase CLI is installed. | Install or approve installation path. | User/Codex in M1 |
| External services are not configured. | Provide or approve setup for Supabase, OAuth providers, payment channels, signing, hosting, and workers. | User |

## External Configuration

- [ ] Supabase
- [ ] Google OAuth
- [ ] Facebook OAuth
- [ ] Android signing
- [ ] iOS signing
- [ ] Admin deployment
- [ ] Worker deployment

## Next Exact Action

Review the M0 Markdown files, then explicitly approve either "mark M0 complete" or "begin M1 foundation".

## Session Handoff

- What was attempted: Initialized the M0 Markdown project-memory system from the approved plan.
- What succeeded: Requested files were created with phase gates, architecture decisions, progress tracking, and security constraints.
- What failed: No M0 file-creation failures. Supabase CLI and GitHub CLI remain unavailable locally and must be handled in a later approved phase.
- What must be read: `AGENTS.md`, `MASTER_PLAN.md`, `PROJECT_STATE.md`, `docs/plans/MOBILE_APP_PLAN.md`, `docs/plans/SHARED_BACKEND_PLAN.md`, and the active progress file.
- Commands to continue: `git status --short --branch`, `rg --files`, then review diffs.
- Files that must not be modified: Do not add production app code, migrations, Edge Functions, workers, or deployment files until M1 or later is explicitly approved.
