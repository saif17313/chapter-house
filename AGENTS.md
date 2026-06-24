# Codex Operating Instructions

This repository uses Markdown project-memory files as the source of truth. Do not rely on chat history when a project-memory file can answer the question.

## Required Session Startup

Every Codex session must begin by reading:

1. `AGENTS.md`
2. `MASTER_PLAN.md`
3. `PROJECT_STATE.md`
4. The active application's plan file under `docs/plans/`
5. The active application's progress file under `apps/<app>/PROGRESS.md`

Then inspect:

1. `git status --short --branch`
2. `git branch --show-current`
3. The approved phase in `PROJECT_STATE.md` and `MASTER_PLAN.md`
4. Relevant dependencies, generated contracts, migrations, and environment notes

Before making changes, record the session objective, expected file areas, and phase scope in the relevant progress file.

## Phase Control

Use only these phase states:

`NOT_STARTED`, `PLANNING`, `AWAITING_APPROVAL`, `APPROVED`, `IN_PROGRESS`, `BLOCKED`, `READY_FOR_REVIEW`, `COMPLETED`

Rules:

- Work only inside the currently approved phase.
- Do not start the next phase automatically.
- Only one major phase may normally be `IN_PROGRESS`.
- A phase cannot move from `READY_FOR_REVIEW` to `COMPLETED` without user approval.
- Untested implementation cannot be called complete.
- External configuration must be tracked separately from code completion.
- A phase with a critical security blocker cannot be marked `READY_FOR_REVIEW`.

## Repository Map

- `apps/mobile/`: Flutter customer application and mobile progress log.
- `apps/admin/`: Next.js administrative website and admin progress log.
- `packages/contracts/`: Shared generated database types, DTOs, validation schemas, and enums.
- `supabase/`: Local Supabase config, migrations, seeds, storage policies, and Edge Functions.
- `workers/content/`: Background content validation, malware scanning integration, encryption, preview generation, and key wrapping.
- `workers/search/`: Search-event ingestion, Count-Min Sketch snapshots, candidate ranking, and suggestion metrics.
- `docs/plans/`: Phase plans for mobile, admin, and shared backend.
- `docs/adr/`: Architecture decision records.
- `scripts/`: Repeatable local, CI, generation, and verification helpers.

## Commands

Run the commands that apply to files touched in the current phase. If a tool is missing, record that fact in `PROJECT_STATE.md` and the relevant progress file.

Formatting:

- Flutter/Dart: `dart format apps/mobile packages/contracts`
- Admin/TypeScript/Markdown when configured: `npm run format --workspaces`
- Supabase SQL when configured: use the repo-approved SQL formatter only

Linting:

- Flutter: `flutter analyze`
- Admin: `npm run lint --workspace apps/admin`
- Contracts/workers: `npm run lint --workspaces`
- Supabase: `supabase db lint`

Testing:

- Flutter: `flutter test`
- Admin: `npm test --workspace apps/admin`
- Workers/contracts: `npm test --workspaces`
- Database/RLS: `supabase test db`

Builds:

- Flutter Android smoke: `flutter build apk --debug`
- Flutter iOS smoke: `flutter build ios --debug --no-codesign`
- Admin: `npm run build --workspace apps/admin`
- Supabase local reset: `supabase db reset`

## Migration Rules

- Keep all schema changes in timestamped migrations under `supabase/migrations/`.
- Every exposed table must have RLS enabled and explicit policies.
- Migrations must be reversible by restoring from version control and rerunning local reset.
- Never edit applied production migrations unless the project is still pre-production and the user explicitly approves.
- Keep storage bucket policies and database policies in the same phase as the tables they protect.

## Shared-Contract Rules

- Mobile, admin, Edge Functions, and workers must consume the same contract package.
- Database-generated types and DTOs must be regenerated after schema changes.
- Do not duplicate enums or wire shapes in app-specific folders.
- Any breaking contract change requires a contract version update and documented migration path.

## Security Rules

- Supabase Auth is the identity provider; do not create a competing password database.
- Never store tokens, passwords, service keys, content keys, or payment secrets in source code, ordinary preferences, logs, analytics, or crash reports.
- Public/publishable keys may be shipped to clients; secret/service-role keys must stay server-side.
- Sensitive authorization must be enforced by verified server logic and RLS, not by client-decoded JWTs.
- Use private storage buckets for protected content and explicit RLS/signed access for downloads.
- Device-bound offline licenses must never expose plaintext master keys or unprotected original content.

## Context Handoff

Before ending a session:

1. Format affected files when a formatter exists.
2. Run relevant linting, tests, and builds.
3. Inspect the diff and git status.
4. Update `PROJECT_STATE.md`.
5. Update the relevant `apps/<app>/PROGRESS.md`.
6. Update phase status in `MASTER_PLAN.md` when appropriate.
7. Record exact commands, results, failures, blockers, and the next exact action.
8. Stop at the approval gate.

## Definition of Done

A task is done only when:

- It stays inside approved scope.
- Required files are updated.
- Relevant checks have been run or clearly recorded as unavailable/not applicable.
- Security, localization, accessibility, and performance impacts are documented.
- Project-memory files reflect the final state.
- The next required approval is explicit.
