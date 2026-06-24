# Chapter House Master Plan

## Product Objective

Chapter House is a production-oriented bilingual e-book commerce and reading platform for Android, iOS, and web administration. It combines a Flutter customer application, a Next.js administrative website, and one shared Supabase backend for authentication, catalog, payments, entitlements, secure content, search, personalization, localization, and theme configuration.

## Scope

- Public bookstore with dynamic home sections, catalog browsing, search, book details, previews, public content pages, language selection, and appearance settings.
- Authenticated customer workflows for purchases, manual bKash/Nagad payment submissions, personal library, secure downloads, offline licenses, reading progress, bookmarks, profile, settings, and account lifecycle.
- Shared backend using Supabase Auth, PostgreSQL, Storage, Realtime where useful, Edge Functions, background workers, RLS, shared contracts, and generated database types.
- Minimal operations admin before beta for catalog, content processing, payment review, configuration, and support workflows.
- English and Bangla content, five premium themes, search suggestions with Count-Min Sketch, personalization, staged scalability, and security validation.

## Non-Goals

- No separate mobile and admin backends.
- No custom password-authentication database while Supabase Auth is used.
- No automated bKash/Nagad integration in the initial payment workflow.
- No claim of perfect DRM or impossible screen-capture prevention.
- No next-phase implementation without explicit user approval.

## Architecture Summary

- `apps/mobile`: Flutter customer app using Supabase Flutter, secure storage, `go_router`, Riverpod, and generated shared contracts.
- `apps/admin`: Next.js App Router admin using TypeScript, server-side Supabase access, role-gated operations, and shared contracts.
- `packages/contracts`: Shared enums, DTOs, validation schemas, generated database types, API contracts, and content-processing contracts.
- `supabase`: Local Supabase config, PostgreSQL migrations, seeds, storage policies, and Edge Functions.
- `workers/content`: Long-running content validation, malware scan integration, encryption, preview generation, and key wrapping.
- `workers/search`: Durable search-event ingestion, Count-Min Sketch maintenance, candidate dictionaries, snapshots, and suggestion ranking support.

## Shared Domain Boundaries

- Catalog reads may use public RLS-backed tables, materialized views, or read-only RPCs.
- Purchases, device activation, payment submission, entitlement sync, and offline-license issuance must go through server-side RPCs or Edge Functions.
- Admin mutations must be server-side, role checked, audited, and protected from direct client privilege escalation.
- Workers may use secret credentials but only for queued processing and controlled status updates.
- Mobile and admin must use the same book identifiers, payment states, entitlement states, device-session states, localization keys, theme-token schema, search-event schema, Count-Min Sketch config, and API contracts.

## Current Approval State

| Area | State | Notes |
|---|---|---|
| M0 Discovery and planning | READY_FOR_REVIEW | Markdown project-memory initialization is the only approved implementation scope. |
| M1 Foundation | NOT_STARTED | Requires user approval after M0 review. |
| External configuration | NOT_STARTED | Supabase, OAuth, signing, deployment, and payment channels are not configured. |

## Global Phase Order

| Phase | Status | Objective | Approval Gate |
|---|---|---|---|
| M0 Discovery and planning | READY_FOR_REVIEW | Repository assessment, architecture, project-memory files, risks, decisions, and approval gates. | User approves M0 completion and M1 start. |
| M1 Monorepo and engineering foundation | NOT_STARTED | Flutter shell, admin shell, shared packages, Supabase local environment, CI, environment handling, and test foundation. | User approves M2. |
| M2 Canonical database, RLS, and shared contracts | NOT_STARTED | Schema, constraints, indexes, RLS, storage policies, seed data, generated types, and contract tests. | User approves M3. |
| M3 Premium mobile design system and localization | NOT_STARTED | Mobile architecture, navigation, five themes, English/Bangla, dynamic configuration, and shared UI states. | User approves M4. |
| M4 Authentication, JWT, profile, and devices | NOT_STARTED | Supabase Auth, password security configuration, JWT validation, secure token storage, OAuth, one-device enforcement, and profile foundation. | User approves M5. |
| M5 Public catalog and previews | NOT_STARTED | Home, categories, topics, authors, publishers, book details, public preview, caching, and pagination. | User approves M6. |
| M6 Search, Count-Min Sketch, and recommendations | NOT_STARTED | Search normalization, search indexes, event pipeline, candidate dictionary, CMS, suggestions, trending, personalization, and privacy filters. | User approves M7. |
| M7 Orders and manual payments | NOT_STARTED | Idempotent orders, bKash/Nagad instructions, transaction submission, duplicate detection, payment status, and financial tests. | User approves M8. |
| M8 Entitlements and content-processing foundation | NOT_STARTED | Entitlements, content worker, file validation, encryption, key wrapping, content versioning, and preview processing. | User approves M9. |
| M9 Secure downloads and PDF reader | NOT_STARTED | Device-bound licenses, download manager, PDF reader, progress, and platform screen controls. | User approves M10. |
| M10 EPUB reader and complete offline workflow | NOT_STARTED | EPUB reader, reader settings, bookmarks, offline expiry, revocation, and device-switch behavior. | User approves M11. |
| M11 Settings, accessibility, and premium polish | NOT_STARTED | Complete settings, privacy, themes, localization, accessibility, tablet support, animation, and performance. | User approves M12. |
| M12 Security and scale validation | NOT_STARTED | Threat-model verification, load testing, query/storage/JWT/CMS review, recovery tests, and monitoring. | User approves M13. |
| M13 Release preparation | NOT_STARTED | End-to-end tests, staging, signing documentation, deployment guides, release checklist, rollback checklist, and known limitations. | User approves release. |

## Dependency Graph

- M0 gates all future work.
- M1 must precede all implementation because it creates the repo structure, toolchain, CI, and environment conventions.
- M2 must precede backend-dependent app features because it defines canonical schema, RLS, storage policies, and shared contracts.
- M3 can begin after M1 and should complete before broad feature screens.
- M4 depends on M2 contracts and auth configuration.
- M5 depends on M2 and M3.
- M6 depends on M2, M3, and M5 catalog data.
- M7 depends on M2, M4, and M5.
- M8 depends on M2 and informs M9/M10 secure reader work.
- M9 depends on M4 and M8.
- M10 depends on M9.
- M11 depends on M3 through M10 feature surfaces.
- M12 depends on implemented security- and scale-sensitive features.
- M13 depends on all previous phases reaching reviewable quality.

## Release Milestones

| Milestone | Target Content | Required Prior Phases |
|---|---|---|
| Planning baseline | Project-memory files and approval gates. | M0 |
| Engineering baseline | Monorepo, local Supabase, app shells, CI, contracts pipeline. | M1 |
| Backend alpha | Schema, RLS, storage, contracts, seed catalog. | M2 |
| Mobile catalog alpha | Premium localized shell and public bookstore. | M3-M5 |
| Commerce beta | Auth, devices, orders, manual payments, entitlements. | M4-M8 |
| Secure reader beta | Device-bound offline PDF and EPUB workflows. | M9-M10 |
| Release candidate | Accessibility, polish, security, scale, deployment, rollback. | M11-M13 |

## Detailed Phase Requirements

Each phase must document expected file areas, database impact, API impact, security impact, required tests, performance checks, accessibility checks, localization checks, documentation, risks, rollback strategy, exit criteria, evidence required, and approval gate in the active progress file before work begins.

| Phase | Included Scope | Explicit Exclusions | Expected File Areas | Required Evidence |
|---|---|---|---|---|
| M0 | Planning docs, project-memory files, repo assessment, risks, phase gates. | Production app code, migrations, Edge Functions, workers, deployment files. | `AGENTS.md`, `MASTER_PLAN.md`, `PROJECT_STATE.md`, `docs/plans`, `apps/*/PROGRESS.md`, `docs/adr`. | Files exist, git status recorded, verification commands recorded, next approval is M1. |
| M1 | Monorepo structure, Flutter shell, admin shell, local Supabase config, CI skeleton, env templates, test foundation. | Business screens, database schema beyond tool-required defaults. | `apps`, `packages`, `supabase`, `.github`, `scripts`. | Format/lint/build smoke, missing tools tracked, rollback by deleting scaffolds before first release. |
| M2 | Canonical schema, RLS, storage buckets, seed data, generated contracts. | UI feature work. | `supabase`, `packages/contracts`, tests. | `supabase db reset`, RLS tests, generated type drift check, schema ADRs. |
| M3 | Mobile app architecture, navigation, design tokens, themes, localization pipeline, shared UI states. | Auth, catalog business logic, payments. | `apps/mobile`, `packages/contracts`. | Widget/golden/contrast/l10n checks, fallback token validation. |
| M4 | Supabase Auth, JWT/session handling, secure token storage, OAuth/deep links, profile, devices. | Purchases and reader licensing. | `apps/mobile`, `supabase/functions`, `supabase/migrations`, contracts. | Auth tests, device transaction tests, token redaction review, RLS evidence. |
| M5 | Store home, catalog browse, book detail, previews, public pages, caching, pagination. | Search CMS and payments. | `apps/mobile`, catalog RPCs/contracts. | Widget/API/performance/localization tests and unauthenticated access checks. |
| M6 | Search normalization, event pipeline, candidate dictionary, CMS, suggestions, trending, personalization. | Payment, content encryption. | `workers/search`, `supabase`, `packages/contracts`, `apps/mobile`. | CMS deterministic tests, privacy filters, exact-count comparison, load sample. |
| M7 | Idempotent orders, manual bKash/Nagad flow, payment submission, admin review dependencies. | Automated provider integration. | `apps/mobile`, `apps/admin`, `supabase`, contracts. | Duplicate prevention, atomic entitlement tests, audit evidence. |
| M8 | Entitlements, content-processing jobs, validation, encryption, key wrapping, previews. | Reader UI beyond integration stubs. | `workers/content`, `supabase`, contracts. | Encryption/decryption tests, scan integration tests, job recovery evidence. |
| M9 | Secure download manager, PDF reader, offline license use, progress sync, screen controls. | EPUB reader. | `apps/mobile`, license APIs/contracts. | Platform checks, license revocation tests, interrupted download tests. |
| M10 | EPUB reader, reader preferences, bookmarks, complete offline expiry/revocation flows. | Broad settings polish. | `apps/mobile`, contracts. | EPUB rendering tests, corrupted data tests, offline expiry tests. |
| M11 | Complete settings, privacy controls, accessibility, tablet layouts, animations, performance polish. | New major backend features. | `apps/mobile`, `apps/admin` if needed. | A11y audits, tablet screenshots, performance measurements. |
| M12 | Threat-model validation, scale tests, query review, storage review, JWT review, CMS accuracy, recovery. | New product features except fixes. | `docs`, `scripts`, tests, monitoring config. | Load reports, security report, recovery tests, critical blocker clearance. |
| M13 | E2E, staging, signing docs, deployment guides, release and rollback checklist. | Scope expansion. | `docs`, CI/deployment config, app release config. | E2E/build evidence, deployment dry runs, rollback evidence, user release approval. |

## Shared Risks

- RLS policy mistakes could expose user, payment, or protected content data.
- Stale JWT claims could grant outdated roles without current server-side checks.
- Manual payment review can create fraud, duplicate transaction, and operational backlog risks.
- Offline content protection is inherently imperfect and must be documented honestly.
- Search-query events may contain private data unless filtered before candidate promotion.
- Count-Min Sketch estimates cannot be used for correctness-sensitive domains.
- Supabase CLI and GitHub CLI are currently missing on this machine.

## Change-Control Protocol

- Any scope change must update `MASTER_PLAN.md`, `PROJECT_STATE.md`, and the active progress file.
- Any backend contract change must update `packages/contracts` and regenerate clients in the same phase.
- Any security-sensitive decision should be captured as an ADR.
- Any phase transition requires explicit user approval.
- Do not claim checks passed unless command results are recorded.
