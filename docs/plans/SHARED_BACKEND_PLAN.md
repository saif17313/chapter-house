# Shared Backend Plan

## Status

- Active backend phase: M0 - Discovery and planning
- Phase status: READY_FOR_REVIEW
- Current implementation state: no migrations, Supabase config, Edge Functions, workers, or generated contracts exist yet.
- Next approval required: approve M1 before creating backend scaffolding or local Supabase files.

## Objective

Design one shared Supabase backend for the Flutter customer app and Next.js admin website. The backend owns canonical authentication, JWT/RLS authorization, database schema, storage buckets, payment states, entitlements, device sessions, localization, theme tokens, search events, Count-Min Sketch configuration, content processing, and shared contracts.

## Backend Components

- Supabase Auth for identity, sessions, password flows, OAuth, JWT issuance, and refresh handling.
- PostgreSQL for canonical business data, constraints, indexes, RLS, audit logs, and durable events.
- Supabase Storage for public assets, private uploads, proof files, staging originals, encrypted content, previews, and snapshots.
- Supabase Edge Functions for authenticated business operations requiring server-side validation.
- Supabase Realtime for payment/library/session updates where it improves UX.
- Background workers for content processing and search-frequency aggregation.
- Shared generated contracts for mobile, admin, functions, and workers.

## Trust Boundaries

- Mobile clients, admin browsers, uploaded files, payment proofs, and search queries are untrusted.
- Public/publishable keys are client-safe only when RLS and policies are correct.
- Secret/service-role credentials must stay in server, worker, Edge Function, or CI environments.
- Admin actions require role checks, current state validation, and audit logs.
- Workers process queued jobs and may not become general privileged mutation endpoints.

## Canonical Database Plan

The M2 implementation must define purpose, fields, constraints, indexes, RLS, retention, and growth expectations for the tables below. This plan records the intended responsibilities before schema creation.

| Table | Purpose | Key Requirements |
|---|---|---|
| `profiles` | App profile linked to `auth.users`. | One row per user, no password hash, user-owned reads/updates, admin support reads. |
| `user_settings` | Language, theme, privacy, notifications, reader defaults. | User-owned, versioned preferences, sane defaults. |
| `user_devices` | Stable registered device metadata and public key. | Installation ID hash/HMAC, device public key, platform, status, audit timestamps. |
| `device_sessions` | Active-device enforcement and Supabase `session_id` correlation. | One active session per user, session version, revocation reason, transactional locking. |
| `authors`, `publishers`, `categories`, `topics` | Catalog dimensions. | Localized names/slugs, publish state, search fields, admin-only mutation. |
| `books` | Canonical book records. | Localized metadata, ISBN, publisher, status, visibility, price display dependencies. |
| `book_authors`, `book_categories`, `book_topics` | Many-to-many catalog joins. | Unique join constraints and indexed foreign keys. |
| `book_files` | Protected source and encrypted file versions. | Format, version, checksums, encryption metadata, processing state, private access. |
| `book_previews` | Preview assets separate from protected full content. | Public/private policy by preview type, localized preview metadata. |
| `book_prices` | Authoritative current and historical BDT prices. | Effective windows, active price constraint, admin-only writes. |
| `payment_channels` | Active bKash/Nagad manual payment instructions. | Provider, account name/number, QR asset, limits, expiry rules, localized instructions. |
| `orders`, `order_items` | Idempotent purchase intent and book line items. | Current price snapshot, order status, idempotency key, user ownership. |
| `payment_submissions` | Manual transaction submission and review state. | Transaction ID, sender number handling, proof path, duplicate checks, review audit. |
| `entitlements` | Exactly-once ownership/access rights. | Unique user/book/order constraints, status, grant/revoke audit. |
| `offline_licenses` | Device-bound offline access. | User, device, entitlement, book, file version, expiry, license version, wrapped key metadata. |
| `reading_progress`, `bookmarks` | Reader state and annotations. | User/book/file scoping, sync timestamps, conflict strategy. |
| `search_events` | Durable privacy-filtered search events. | Partitioning, retention, consent state, anonymous ID rotation, no raw PII exposure. |
| `search_term_candidates` | Exact candidate dictionary for suggestions. | Normalized/display terms, locale, source, safety status, admin approval where needed. |
| `search_sketch_configs` | Count-Min Sketch definitions. | Width, depth, namespace, locale, hash seed version, counter type, active status. |
| `search_sketch_snapshots` | Periodic sketch state, not per-counter updates. | Window type/start/end, snapshot location/binary, checksum, status, total updates. |
| `search_suggestion_metrics` | Quality and impression/click metrics. | Aggregated, privacy-safe, retention policy. |
| `book_events` | Catalog/reader/purchase events for analytics and recommendations. | Batched, privacy-aware, partitioned if high volume. |
| `user_topic_affinity` | Personalization signals. | User-owned, decayed scores, topic IDs, opt-out behavior. |
| `theme_presets` | Remote design-token schema and presets. | Versioned tokens, validation status, bundled fallback compatibility. |
| `ui_translations` | Dynamic localized strings. | Locale, namespace, key, version, fallback, publish state. |
| `home_sections`, `home_section_books`, `banners`, `content_pages` | Configurable store and public content. | Localized content, publish windows, admin-only writes, public reads when published. |
| `app_config` | Remote app configuration. | Versioned keys, typed values, safe defaults, rollout targeting later. |
| `content_processing_jobs` | Worker queue and processing status. | Idempotent job keys, retry state, error details, auditability. |
| `notifications` | User notification records. | User-scoped reads, delivery state, localized content references. |
| `audit_logs` | Security and operational audit events. | Append-only, privileged writes, retention, redacted sensitive values. |

## RLS and Authorization Plan

- Enable RLS on every exposed schema table.
- Public catalog data is readable only when published and safe.
- User-private data uses `auth.uid()` ownership checks.
- Admin operations require current role verification through server-side checks, not stale client claims alone.
- Sensitive functions verify current database state for role, account status, active device, entitlement, and session version.
- Service-role access is limited to server-side operations and audited.

## JWT Authentication Plan

- Use Supabase Auth as the identity provider.
- Prefer Supabase asymmetric JWT signing keys and JWKS verification where supported.
- Validate `iss`, `aud`, `exp`, `sub`, `role`, `aal`, and `session_id`.
- Short-lived access tokens and refresh-token rotation are required.
- Mobile may decode claims only for non-authoritative routing or display.
- Server logic must verify claims and current database state before sensitive actions.
- Role changes must avoid stale-claim authorization by checking current roles in database/functions.

## Password and Sensitive-Value Plan

- Supabase Auth owns password hashing, salting, verification, recovery, and password storage.
- Do not store password hashes, duplicate password records, password logs, password analytics, or cached passwords in app tables.
- Configure password strength, breached-password protection, CAPTCHA/bot protection, and rate limits.
- For deterministic sensitive comparisons, evaluate keyed HMAC-SHA-256 with a server-only key.
- For recoverable sensitive values, use encryption with strict access controls.
- For non-recoverable values, use salted irreversible hashing according to purpose.
- Do not confuse password hashing, general hashing, encryption, and HMAC.

## Device-Session Plan

The device activation operation must be transactional:

1. Authenticate the Supabase JWT.
2. Validate `session_id`.
3. Validate installation identifier.
4. Validate device-generated public key.
5. Lock the user's session state.
6. Revoke prior active device sessions.
7. Increment the user session version.
8. Register or update the device.
9. Mark it active.
10. Revoke previous-device offline licenses.
11. Write an audit event.
12. Return safe session state.

Use periodic validation and Realtime notifications when online. Document that a fully offline old device cannot be notified instantly.

## Search and Suggestion Plan

Search must support English and Bangla titles, subtitles, authors, publishers, categories, topics, ISBN, keywords, prefix matching, typo tolerance, normalization, history, safe anonymous event tracking, cursor pagination, filters, sort order, suggestions, trending searches, and personalized suggestions.

Initial implementation should combine:

- PostgreSQL full-text search where useful.
- `pg_trgm` for typo tolerance and fuzzy matching.
- Exact ISBN lookup.
- Prefix indexes.
- Language-specific normalization.
- Materialized searchable documents.
- Replaceable search RPC or server endpoint.

## Count-Min Sketch Plan

Use Count-Min Sketch only for high-volume approximate frequency estimation, never for authentication, authorization, payments, entitlements, inventory correctness, or audits.

Pipeline:

`Search event -> normalization/privacy filtering -> durable event -> CMS update -> candidate/top-K maintenance -> suggestion ranking -> exact verification -> localized suggestions`

Initial configuration:

- Width: `4096`
- Depth: `7`
- Target error: about `0.066%` of total updates
- Target confidence: about `99.9%`
- Hash strategy: HMAC-SHA-256-derived row indexes with versioned seeds
- Counter type: unsigned 64-bit, with saturation/rotation handling
- Updates: evaluate conservative update after deterministic baseline tests
- Persistence: periodic snapshots in database or Storage with checksum
- Recovery: rebuild from durable events or latest compatible snapshot
- Rotation: recent/hourly, daily, weekly, and long-term baseline windows
- Separation: namespace, locale, prefix, topic, global, and segment/personalized contexts

Candidate dictionary sources:

- Book titles
- Author names
- Publisher names
- Category names
- Topic names
- Approved user queries
- Editorial suggestions

Final suggestions must pass safety, privacy, and exact/sampled verification before display.

## Recommendation Plan

Ranking combines prefix relevance, exact text relevance, CMS estimate, recent trend score, user-topic affinity, book availability, editorial boost, language preference, diversity, and safety/privacy eligibility.

Personalization v1 uses search history, book events, reading/purchase signals, and `user_topic_affinity`. Avoid per-user sketches until scale and privacy review justify them.

## Payment Plan

Manual payment workflow:

1. User chooses a book.
2. Server verifies active JWT session and active device.
3. Server verifies publication and ownership status.
4. Server fetches authoritative current price.
5. Server creates an idempotent order.
6. App displays active payment channels.
7. User selects bKash or Nagad.
8. App shows account name, number, QR code, instructions, amount, and expiry.
9. User sends money manually.
10. User submits transaction ID.
11. User may submit sender number.
12. User may upload proof.
13. Submission becomes pending.
14. Finance admin reviews it.
15. Approval updates payment and order atomically.
16. Approval creates exactly one entitlement.
17. App receives updated library state.

Future automation fields must include verification mode, provider reference, webhook event ID, idempotency, signature verification, replay protection, provider payload, and automation failure state.

## Secure Content Plan

Protected file workflow:

1. Admin uploads original file to private staging.
2. Worker validates it.
3. Worker performs malware-scanning integration.
4. Worker calculates SHA-256.
5. Worker generates a random content-encryption key.
6. Worker encrypts content with authenticated encryption.
7. Worker uploads ciphertext.
8. Worker wraps the content key with server-controlled key management.
9. Original remains private or is removed according to policy.
10. Preview content is generated separately.

Offline licenses bind user, device, entitlement, book, exact file version, expiration, license version, and device public key. The server returns encrypted-content location, checksum, algorithm metadata, wrapped content key, license validity, and version information.

## Storage Plan

Planned buckets:

- Public covers and safe public marketing assets.
- Private proof uploads.
- Private original-content staging.
- Private encrypted content.
- Private or public previews depending on preview model.
- Private search/CMS snapshots when needed.

All protected buckets require storage policies and server-side access patterns appropriate to content sensitivity.

## API and Edge Function Plan

Candidate server operations:

- `activate_device`
- `validate_device_session`
- `create_order`
- `submit_manual_payment`
- `sync_entitlements`
- `issue_offline_license`
- `record_search_events`
- `get_search_suggestions`
- `admin_review_payment`
- `admin_enqueue_content_processing`

Functions invoked by signed-in users should use platform JWT verification and caller-scoped Supabase clients where appropriate. Service-to-service functions must use named secret keys and explicit audit logging.

## Testing Plan

Required test categories:

- Schema constraints and generated type drift.
- RLS allow/deny cases.
- Storage policy allow/deny cases.
- JWT claim validation and stale-role protections.
- Device activation transaction and revocation behavior.
- Idempotent orders and exactly-once entitlement creation.
- Payment duplicate detection and audit history.
- CMS deterministic hashing, update behavior, collision behavior, no negative counts, serialization, deserialization, merge compatibility, version mismatch, window rotation, snapshot recovery, locale isolation, prefix isolation, overflow handling, exact-count sampling, suggestion quality, privacy filtering, and spam suppression.
- Content encryption/decryption, checksum verification, key wrapping, malware-scan integration, job retry/recovery.
- Load tests at 100, 1,000, 10,000 concurrent users and larger infrastructure-specific exercises.

## Deployment Plan

- Local: Docker plus Supabase CLI, local migrations, seeds, functions, and test fixtures.
- Staging: separate Supabase project, test OAuth credentials, test payment channels, preview admin deployment, worker staging.
- Production: separate locked Supabase project, monitored functions and workers, backup/PITR, deployment rollback plan, signing credentials, and release checklist.

## Risks

- RLS mistakes can leak sensitive data.
- Service-role key leakage is catastrophic.
- Stale JWT claims must not authorize sensitive admin or entitlement actions.
- Manual payment review is fraud-sensitive.
- Search events can contain private data without filtering.
- CMS estimates are approximate and cannot drive correctness.
- Offline DRM has inherent limits.
- Supabase CLI is currently missing locally and must be installed or otherwise addressed in M1.

## Exit Criteria for M0

- This backend plan exists.
- No migrations, Supabase config, Edge Functions, workers, storage policies, or deployment files have been created.
- Backend implementation is blocked on explicit user approval for M1.
