# Chapter House

Chapter House is a bilingual e-book commerce and secure reading platform. The repository is organized as a monorepo so the mobile app, admin app, shared contracts, Supabase backend, and workers evolve against one source of truth.

## M1 Foundation

This phase creates the engineering foundation only:

- Flutter customer app shell under `apps/mobile`
- Next.js admin shell under `apps/admin`
- Shared contracts package under `packages/contracts`
- Supabase local configuration under `supabase`
- CI, environment templates, and tool checks

Business features, database schema, RLS policies, Edge Functions, and workers begin in later approved phases.

## Required Reading

Start every session with:

1. `AGENTS.md`
2. `MASTER_PLAN.md`
3. `PROJECT_STATE.md`
4. Active app plan and progress files
5. Current `git status` and branch

## Common Commands

```powershell
npm install
npm run lint --workspaces --if-present
npm run test --workspaces --if-present
npm run build --workspaces --if-present

Set-Location apps/mobile
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

Use `npx supabase` for CLI commands unless a supported global install is available.
