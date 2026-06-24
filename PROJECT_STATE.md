# Project State

## Project

- Project name: Chapter House
- Repository: `D:\Projects\E-Book App\chapter-house`
- Current branch: `m1-foundation`
- Last known good commit: `819dca443e700681474189e671662a1efbabc236`
- Last updated: `2026-06-25T03:17:45+06:00`
- Updated by: Codex

## Current Position

- Active application: global foundation, mobile, admin, and shared backend
- Active phase: M1 - Monorepo and engineering foundation
- Phase status: READY_FOR_REVIEW
- Current objective: Review and merge the M1 foundation branch, then stop before M2.
- Approval received: Yes, user approved the next work and required branch/commit/PR/merge workflow.
- Next approval required: User approval to begin M2 after M1 is completed and merged.

## Architecture Snapshot

- Flutter: M1 Flutter shell exists under `apps/mobile` with Riverpod, GoRouter, Supabase Flutter, secure storage, intl, and a bootstrap smoke test.
- Admin: M1 Next.js shell exists under `apps/admin` with TypeScript, ESLint, Vitest, and a minimal operations shell.
- Authentication: Supabase Auth is the only planned identity provider.
- JWT: Prefer Supabase asymmetric signing keys/JWKS where supported; client decoding is non-authoritative.
- Database: Canonical PostgreSQL schema planned for M2; M1 only generated `supabase/config.toml` and empty `seed.sql`.
- Storage: Private/public bucket model planned for M2 and secure content buckets in M8; no buckets created in M1.
- Edge Functions: Planned for authenticated operations, device activation, payments, entitlement sync, and license issuance; M1 only created placeholder directory.
- Worker: Planned content and search workers under `workers/content` and `workers/search`; M1 only created README placeholders.
- Search suggestions: Planned hybrid durable events plus Count-Min Sketch worker and exact candidate dictionary.
- Shared contracts: TypeScript skeleton exists under `packages/contracts`; generated database types do not exist yet.

## Current Versions

- Latest migration: none
- Contract version: `0.1.0-m1-foundation`
- Mobile version: `1.0.0+1`
- Admin version: `0.1.0`
- Search-sketch version: none
- Theme-schema version: none
- Localization-schema version: none

## Canonical Decisions

| Decision           | Choice                                      | Reason                                                                                                   | Date       | ADR     |
| ------------------ | ------------------------------------------- | -------------------------------------------------------------------------------------------------------- | ---------- | ------- |
| Repository model   | Monorepo under `apps/*`                     | Keeps mobile, admin, backend, workers, and contracts in one shared source of truth.                      | 2026-06-25 | Pending |
| Branch workflow    | Dedicated branch per focused work item      | Supports reviewable commits, PRs, context recovery, and safer phase control.                             | 2026-06-25 | Pending |
| Backend model      | One shared Supabase backend per environment | Prevents divergent auth, payments, entitlements, contracts, and policies.                                | 2026-06-25 | Pending |
| Auth provider      | Supabase Auth                               | Avoids custom password storage and integrates with RLS.                                                  | 2026-06-25 | Pending |
| Payment v1         | Manual bKash/Nagad review                   | Matches initial operational requirement without pretending to be automated provider integration.         | 2026-06-25 | Pending |
| Content protection | Production DRM posture with limitations     | Reduces leakage risk while acknowledging perfect protection is impossible.                               | 2026-06-25 | Pending |
| Admin timing       | Minimal operations admin before beta        | Supports catalog, payments, content processing, configuration, and support without delaying mobile beta. | 2026-06-25 | Pending |

## Completed Work

- [x] Repository inspected: greenfield repo with `.git` only before M0 file creation.
- [x] Current branch inspected: `main`, then M1 branch `m1-foundation` created.
- [x] Remote inspected: `origin` points to `https://github.com/saif17313/chapter-house.git`.
- [x] Local toolchain inspected: Flutter, Dart, Node, npm, Git, and Docker CLI available; global Supabase CLI and GitHub CLI missing.
- [x] M0 project-memory file set initialized.
- [x] M0 baseline committed as `819dca443e700681474189e671662a1efbabc236` and pushed to `origin/main`.
- [x] Branch workflow documented in `AGENTS.md` and `docs/development/BRANCH_WORKFLOW.md`.
- [x] M1 monorepo foundation files created.
- [x] Flutter mobile shell scaffolded and verified.
- [x] Next.js admin shell scaffolded and verified.
- [x] Shared contracts package skeleton scaffolded and verified.
- [x] Supabase local config generated with `npx supabase init`.
- [x] CI foundation and environment templates created.

## Work In Progress

- [ ] M1 commit, PR creation, and merge workflow.

## Remaining Work

- [ ] M1 PR is created and merged, or blocker/fallback is recorded.
- [ ] User approves or rejects starting M2.

## Verification

| Command                                     | Result                             | Date       | Notes                                                                                                          |
| ------------------------------------------- | ---------------------------------- | ---------- | -------------------------------------------------------------------------------------------------------------- |
| `npm run format:check`                      | Passed                             | 2026-06-25 | Prettier check passed after formatting `apps/admin/tsconfig.json`.                                             |
| `npm run lint --workspaces --if-present`    | Passed                             | 2026-06-25 | Admin ESLint and contracts TypeScript lint passed.                                                             |
| `npm run test --workspaces --if-present`    | Passed                             | 2026-06-25 | Admin Vitest 1 test and contracts Vitest 3 tests passed.                                                       |
| `npm run build --workspaces --if-present`   | Passed                             | 2026-06-25 | Next.js production build and contracts TypeScript build passed.                                                |
| `npm audit --audit-level=moderate`          | Passed                             | 2026-06-25 | Zero vulnerabilities after PostCSS override for Next dependency.                                               |
| `npx supabase --version`                    | Passed                             | 2026-06-25 | Supabase CLI `2.107.0` runs through `npx`.                                                                     |
| `npm run check:tools`                       | Passed with missing optional tools | 2026-06-25 | Git, Node, npm, Flutter, Dart, and Docker CLI found; global Supabase CLI and GitHub CLI missing.               |
| `flutter analyze`                           | Passed                             | 2026-06-25 | No Flutter analyzer issues.                                                                                    |
| `flutter test`                              | Passed                             | 2026-06-25 | Mobile bootstrap widget test passed.                                                                           |
| `flutter build apk --debug`                 | Passed                             | 2026-06-25 | Built `build\app\outputs\flutter-apk\app-debug.apk` after disabling Kotlin incremental compilation on Windows. |
| `git diff --check`                          | Passed                             | 2026-06-25 | No whitespace errors reported before final project-memory updates.                                             |
| `docker info --format '{{.ServerVersion}}'` | Failed                             | 2026-06-25 | Docker Desktop daemon is not running.                                                                          |
| `npx supabase status`                       | Failed                             | 2026-06-25 | Supabase local stack cannot be inspected while Docker daemon is stopped.                                       |
| `flutter build ios --debug --no-codesign`   | Failed                             | 2026-06-25 | Windows Flutter toolchain did not expose iOS build options.                                                    |
| `flutter build ios --no-codesign`           | Failed                             | 2026-06-25 | Windows Flutter toolchain did not expose iOS build options.                                                    |

## Files Changed

| File                                    | Change                                                                                                                                          | Reason                                                                                 |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| `AGENTS.md`                             | Added branch/PR workflow and work-log requirement.                                                                                              | Persist user-requested workflow.                                                       |
| `MASTER_PLAN.md`                        | Updated M0/M1 statuses.                                                                                                                         | Reflect M1 work readiness.                                                             |
| `PROJECT_STATE.md`                      | Updated global state, verification, blockers, and next action.                                                                                  | Preserve current branch context.                                                       |
| `docs/work/2026-06-25-m1-foundation.md` | Added M1 work log.                                                                                                                              | Preserve branch context, plan, progress, verification, and handoff.                    |
| Root workspace files                    | Added `.editorconfig`, `.gitattributes`, `.gitignore`, `.prettierignore`, `.env.example`, `README.md`, `package.json`, and `package-lock.json`. | Establish monorepo defaults, formatting, env templates, and Node workspace lockfile.   |
| `.github/workflows/ci.yml`              | Added CI foundation.                                                                                                                            | Verify Node workspaces, Flutter app, and Supabase CLI smoke checks on PRs/main pushes. |
| `docs/development/BRANCH_WORKFLOW.md`   | Added branch/PR workflow.                                                                                                                       | Persist branch/commit/PR/merge workflow.                                               |
| `scripts/check-tools.ps1`               | Added tool availability check.                                                                                                                  | Record local prerequisites and missing tools.                                          |
| `apps/mobile` Flutter files             | Added Flutter Android/iOS shell, app routing, bootstrap screen, env example, and smoke test.                                                    | Establish mobile foundation without business features.                                 |
| `apps/admin` Next.js files              | Added admin shell, lint/test/build setup, env example, and smoke test.                                                                          | Establish admin foundation without business workflows.                                 |
| `packages/contracts`                    | Added TypeScript contracts skeleton and tests.                                                                                                  | Establish shared contract package foundation.                                          |
| `supabase`                              | Added generated config, empty seed, README, and placeholder dirs.                                                                               | Establish local Supabase foundation without schema/RLS/functions.                      |
| `workers/*/README.md`                   | Added content and search worker placeholders.                                                                                                   | Reserve worker areas for later approved phases.                                        |

## Known Issues

| Issue                                                           | Severity | Workaround                                                                                    | Target phase |
| --------------------------------------------------------------- | -------- | --------------------------------------------------------------------------------------------- | ------------ |
| Supabase CLI is not installed globally or not on PATH.          | Low      | Use `npx supabase` in repo scripts and docs, or install via Scoop/standalone binary later.    | M1/M2        |
| GitHub CLI is not installed or not on PATH.                     | Low      | Use GitHub API only if a token appears, otherwise provide the compare URL/manual PR fallback. | M1           |
| Docker Desktop daemon is not running.                           | Medium   | Start Docker Desktop before `npx supabase start` or Supabase stack checks.                    | M1/M2        |
| iOS build is not available from this Windows Flutter toolchain. | Medium   | Run iOS build on macOS during later release validation.                                       | M13          |
| Flutter plugin Kotlin warning appears during Android build.     | Low      | Track plugin upgrades for Built-in Kotlin compatibility.                                      | M1/M11       |

## Blockers

| Blocker                                                                     | Required action                                                                                          | Responsible party   |
| --------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- | ------------------- |
| Supabase local stack cannot run until Docker Desktop daemon is started.     | Start Docker Desktop, then run `npx supabase start`.                                                     | User/Codex in M1/M2 |
| Automated PR creation/merge may be unavailable without GitHub CLI or token. | Install/authenticate `gh`, provide `GH_TOKEN`, or use manual PR fallback URL.                            | User/Codex          |
| External services are not configured.                                       | Provide or approve setup for Supabase, OAuth providers, payment channels, signing, hosting, and workers. | User                |

## External Configuration

- [ ] Supabase
- [ ] Google OAuth
- [ ] Facebook OAuth
- [ ] Android signing
- [ ] iOS signing
- [ ] Admin deployment
- [ ] Worker deployment

## Next Exact Action

Commit and push branch `m1-foundation`, create/merge PR if tooling permits, otherwise record manual PR fallback, then stop before M2.

## Session Handoff

- What was attempted: Implemented M1 monorepo and engineering foundation on `m1-foundation`.
- What succeeded: Root workspace, Flutter shell, Next admin shell, contracts skeleton, Supabase config, CI, env templates, worker placeholders, branch workflow docs, and verification were completed.
- What failed: Docker daemon was not running, so Supabase local stack status/start was not verified. iOS build is unavailable from this Windows Flutter toolchain. GitHub CLI/token are unavailable, so PR automation may need manual fallback.
- What must be read: `AGENTS.md`, `MASTER_PLAN.md`, `PROJECT_STATE.md`, `docs/work/2026-06-25-m1-foundation.md`, and relevant app progress files.
- Commands to continue: `git status --short --branch`, `git diff --check`, stage and commit M1, push `m1-foundation`, then create/merge PR or record fallback URL.
- Files that must not be modified: Do not add M2 schema migrations, RLS policies, storage policies, production Edge Functions, or business feature screens until M2 or later is explicitly approved.
