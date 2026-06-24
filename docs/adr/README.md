# Architecture Decision Records

Use this directory to record important technical and product architecture decisions.

## When to Create an ADR

Create an ADR when a decision affects:

- Authentication, JWT, roles, RLS, or session security.
- Database schema, migrations, storage policies, or generated contracts.
- Offline content protection, encryption, key wrapping, or reader limitations.
- Payment states, entitlement correctness, or manual review operations.
- Search architecture, Count-Min Sketch configuration, privacy filtering, or personalization.
- Theme-token schema, localization schema, deployment topology, or scaling strategy.

## File Naming

Use:

`NNNN-short-kebab-title.md`

Example:

`0001-use-one-shared-supabase-backend.md`

## ADR Template

```markdown
# NNNN - Title

## Status

Proposed | Accepted | Superseded

## Date

YYYY-MM-DD

## Context

What problem or tradeoff forced this decision?

## Decision

What choice was made?

## Consequences

What becomes easier, harder, riskier, or explicitly out of scope?

## Verification

What checks, tests, or review evidence support this decision?
```

## Initial ADR Candidates

- Use one shared Supabase backend.
- Use Supabase Auth instead of custom password storage.
- Use production DRM posture with documented limitations.
- Use manual bKash/Nagad workflow before automated provider integration.
- Use hybrid search architecture with Count-Min Sketch plus exact candidate dictionary.
- Use monorepo layout under `apps/*`.
