# Admin Panel Plan

## Status

- Admin phase: M0 - Discovery and planning
- Phase status: PLACEHOLDER
- Current implementation state: no Next.js admin application code exists yet.
- Detail level: placeholder and dependency summary only, per M0 scope.

## Objective

Build a minimal operations-focused Next.js admin panel before customer-app beta. The admin panel shares the same Supabase project, schema, Auth system, RLS policies, storage buckets, contracts, and audit rules as the mobile app.

## Initial Admin Scope

- Catalog management for books, authors, publishers, categories, topics, pricing, previews, and publication status.
- Manual payment review for bKash and Nagad submissions.
- Entitlement visibility and support workflows.
- Content upload to private staging and content-processing job monitoring.
- Home sections, banners, content pages, theme presets, translations, payment channels, and app config.
- Audit visibility for sensitive actions.

## Explicit Initial Exclusions

- Broad analytics dashboards beyond operational metrics.
- Automated payment-provider management until provider integration is approved.
- Custom authentication or separate admin user store.
- Separate backend, schema, or contract definitions.

## Dependencies

- M1 creates admin shell and workspace conventions.
- M2 defines database, RLS, storage policies, admin roles, and shared contracts.
- M7 requires payment review workflows.
- M8 requires content-processing job operations.
- M12 validates admin security and audit controls.

## Security Requirements

- Admin must use Supabase Auth and current-role checks.
- Admin writes must be audited.
- Service keys must never be exposed to the browser.
- Admin APIs must verify current database roles rather than trusting stale client claims.
- Dangerous operations require confirmation, idempotency where relevant, and reversible states when possible.

## Next Action

After M1/M2 foundations, expand this placeholder into a detailed admin implementation plan before building admin features.
