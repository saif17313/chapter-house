# Mobile App Plan

## Status

- Active mobile phase: M0 - Discovery and planning
- Phase status: READY_FOR_REVIEW
- Current implementation state: no Flutter application code exists yet.
- Next approval required: approve M1 before creating the Flutter shell.

## Objective

Build a premium bilingual Flutter customer app for Android and iOS that supports public bookstore browsing, authentication, profile management, manual payments, purchased library, secure online/offline reading, personalization, and English/Bangla localization against one shared Supabase backend.

## Product Capabilities

### Public Bookstore

Unauthenticated visitors can open the app, browse dynamic home sections, view featured books, new releases, popular books, categories, topics, authors, publishers, book-detail pages, covers, prices, limited previews, public content pages, language settings, and public appearance settings.

Authentication is required for purchases, payment submission, personal library, complete content downloads, offline licenses, progress sync, private account data, and account deletion. Auth-gated routes must preserve the intended destination.

### Authentication

Plan email/password registration, email verification, email/password login, password reset, Google sign-in, Facebook sign-in, logout, refresh-token handling, session-expiration handling, account suspension handling, account-deletion request, OAuth callback deep links, email-verification deep links, and password-reset deep links.

Supabase Auth owns all password creation, hashing, salting, and verification. Flutter must never store passwords after auth calls or send them to application tables.

### Profile

Profile covers display name, avatar, email, optional phone, preferred language, purchase history, purchased library, reading history, download status, reader preferences, active-device information, privacy preferences, notification settings, and account deletion.

### Reader and Offline Access

The reader must support PDF and EPUB formats, online access, offline access, progress resume, bookmarks, PDF navigation and zoom, EPUB typography settings, table of contents, local reading settings, license expiry, interrupted downloads, low-storage handling, corrupted data handling, and revocation where feasible.

Local content handling must persist ciphertext only, decrypt required chunks in memory, avoid complete plaintext files in shared storage, disable export/print/open-with where feasible, and clearly document residual risk.

## App Architecture

- Feature-first Flutter structure under `apps/mobile/lib/features`.
- Shared app foundation for navigation, theming, localization, config, Supabase client, auth state, error handling, logging, analytics consent, and offline state.
- Riverpod for state management unless M1 chooses another approved app-wide standard.
- `go_router` for deep links, auth guards, preserved intended routes, and reader routes.
- Shared contracts consumed from `packages/contracts`; no duplicate DTOs or enums in app features.
- Network layer wraps Supabase queries, RPCs, Edge Functions, storage access, retry/backoff, cancellation, and token redaction.

## Navigation Areas

- Public shell: home, search, categories, topics, authors, publishers, book detail, preview, public pages, settings.
- Auth shell: profile, purchase history, payment submissions, library, downloads, reader preferences, devices, privacy, notifications.
- Checkout flow: order creation, payment channel selection, instructions, submission, pending/rejected/approved states.
- Reader flow: online preview, protected PDF, protected EPUB, bookmarks, progress, offline/license status.

## Premium Design System

Define semantic tokens for colors, typography, spacing, radius, elevation, shadows, animation durations, motion curves, icon sizing, breakpoints, reader surfaces, focus states, disabled states, success, warning, error, and information.

Themes:

1. Paper Ivory
2. Midnight Sapphire
3. Obsidian Gold
4. Emerald Ink
5. Rosewood Library

Each theme requires light and dark variants, reader background, reader text, primary and secondary surfaces, accessible contrast, consistent controls, remote-token schema validation, and bundled safe fallback. Feature screens must not invent independent visual styles.

## Localization

- Use English and Bangla for UI, catalog metadata, payment instructions, notifications, legal pages, dates, BDT currency, and error states.
- Bundle essential offline startup translations.
- Version dynamic translations through shared backend config.
- No hardcoded visible strings in widgets.
- Support English fallback and Bangla fallback rules.
- Use Bangla-compatible fonts and locale-aware formatting.

## Security Requirements

- Store refresh/session credentials only through maintained secure storage backed by Android and iOS secure mechanisms.
- Do not store tokens in ordinary preferences, plaintext SQLite, logs, analytics, crash reports, or source code.
- Redact tokens and secrets from network logs.
- Clear tokens during confirmed logout, account deletion, or session revocation.
- Treat client-decoded JWT claims as non-authoritative.
- Enforce sensitive authorization through server-verified logic and RLS.
- Enforce one-active-device state through backend activation and periodic validation.
- Use protected reader screen controls: Android secure-window behavior and iOS capture/mirroring detection with overlays.

## Mobile Phase Plan

| Phase | Status | Mobile Objective | Included Scope | Explicit Exclusions | Required Evidence |
|---|---|---|---|---|---|
| M0 | READY_FOR_REVIEW | Plan app and initialize memory files. | Mobile plan, progress tracker, security constraints, phase gates. | Flutter code. | Requested Markdown files and git status. |
| M1 | NOT_STARTED | Create Flutter shell and engineering foundation. | App project, package structure, routing placeholder, test setup, CI hooks, env templates. | Business features. | `flutter analyze`, `flutter test`, debug build smoke when feasible. |
| M2 | NOT_STARTED | Consume shared contracts from canonical backend. | Generated types, DTO imports, API client boundaries. | Handwritten duplicate contracts. | Contract drift tests. |
| M3 | NOT_STARTED | Implement premium design system and localization. | Tokens, five themes, l10n pipeline, shared states, responsive layout foundation. | Auth/catalog/payments. | Widget/golden/contrast/l10n checks. |
| M4 | NOT_STARTED | Implement auth, JWT session handling, profile, devices. | Email/password, OAuth, deep links, secure storage, device activation, profile settings. | Catalog purchase flow. | Auth flow tests, token redaction, device-session tests. |
| M5 | NOT_STARTED | Implement public catalog and previews. | Home, catalog browse, details, previews, public pages, pagination, caching. | CMS suggestions and payments. | Widget/API/performance/localization tests. |
| M6 | NOT_STARTED | Implement search and recommendation UI integration. | Search UX, suggestions, filters, history, event batching, privacy consent. | Worker internals except integration contracts. | Search UX tests, privacy filtering evidence. |
| M7 | NOT_STARTED | Implement manual payment customer flow. | Orders, bKash/Nagad instructions, transaction submission, proof upload, status. | Automated provider integration. | Payment flow tests, idempotency scenarios. |
| M8 | NOT_STARTED | Integrate entitlements and content-processing outputs. | Library entitlement sync and preview/content version awareness. | Full protected reader. | Entitlement sync tests. |
| M9 | NOT_STARTED | Implement secure downloads and PDF reader. | Device-bound license use, encrypted downloads, PDF reader, progress, screen controls. | EPUB reader. | Platform checks, interrupted download tests, revocation tests. |
| M10 | NOT_STARTED | Implement EPUB and complete offline workflow. | EPUB reader, settings, bookmarks, expiry, revocation, device-switch behavior. | Major new commerce features. | EPUB/offline/corruption/expiry tests. |
| M11 | NOT_STARTED | Finish settings, accessibility, tablet support, polish. | Privacy, notifications, complete settings, a11y, tablet, animation/performance. | New backend features. | Accessibility audit, tablet checks, performance notes. |
| M12 | NOT_STARTED | Support security and scale validation. | Mobile load behavior, token review, offline attack review, telemetry validation. | Scope expansion. | Security and performance evidence. |
| M13 | NOT_STARTED | Prepare mobile release. | E2E, signing docs, release checklist, rollback checklist. | New features. | Build/signing/staging evidence. |

## API Dependencies

- Public catalog queries/RPCs.
- Search and suggestion endpoints.
- Auth and profile tables.
- Device activation RPC/Edge Function.
- Order creation and payment submission APIs.
- Entitlement synchronization.
- Offline license issuance.
- Storage access for covers, previews, encrypted content, and proof uploads.
- Dynamic theme and localization config.

## Accessibility and Performance Requirements

- Text scaling support, screen reader labels, focus order, contrast validation, tap targets, reduced-motion handling, keyboard/tablet support where applicable.
- Debounced search, request cancellation, cursor pagination, skeleton loading, image caching, retry with jitter, offline fallbacks, and bounded local storage.
- Candidate SLOs: home p95 under 1.5s, search p95 under 500ms, suggestions p95 under 250ms, checkout p95 under 700ms, license issuance p95 under 1s, download start p95 under 2s on healthy networks.

## Risks

- Reader packages may not support all required secure/offline controls equally on Android and iOS.
- OAuth deep-link behavior must be tested on physical devices.
- Offline DRM is limited against compromised devices and external cameras.
- Bangla typography, search normalization, and mixed-script metadata require explicit QA.
- Payment UX must prevent users from mistaking manual review for instant automated settlement.

## Exit Criteria for M0

- This file exists and reflects the approved mobile scope.
- `apps/mobile/PROGRESS.md` is initialized.
- No production Flutter code has been created.
- Next action requires explicit user approval.
