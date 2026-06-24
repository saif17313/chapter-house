# Mobile Progress

## Current Mobile Phase

- Phase: M1 - Monorepo and engineering foundation
- Status: READY_FOR_REVIEW
- Last updated: `2026-06-25T03:17:45+06:00`
- Updated by: Codex

## Phase Objective

Create the Flutter application shell, routing placeholder, dependency baseline, test setup, environment template, and verification evidence without building business feature screens.

## Approved Scope

- Create Flutter shell under `apps/mobile`.
- Add foundation dependencies needed by later phases.
- Add smoke tests and app structure.
- Record verification results and handoff context.
- Do not create catalog, auth, payment, reader, schema, Edge Function, or worker business implementation.

## Completed Tasks

- [x] Mobile plan created at `docs/plans/MOBILE_APP_PLAN.md`.
- [x] Global project state initialized at `PROJECT_STATE.md`.
- [x] Master phase plan initialized at `MASTER_PLAN.md`.
- [x] Future Codex operating rules initialized at `AGENTS.md`.
- [x] Mobile progress tracker initialized.
- [x] Flutter shell scaffolded.
- [x] Foundation dependencies installed.
- [x] Mobile smoke checks run.
- [x] Android debug build verified.

## Remaining Tasks

- [ ] Merge M1 branch or record PR fallback.
- [ ] Stop before M2 database/contracts implementation.

## Changed Mobile Files

| File                                                                        | Change                                                                              |
| --------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `apps/mobile/PROGRESS.md`                                                   | Updated M1 mobile progress tracker.                                                 |
| `docs/plans/MOBILE_APP_PLAN.md`                                             | Updated mobile implementation state.                                                |
| `apps/mobile/lib/main.dart`                                                 | Replaced counter app with ProviderScope bootstrap entrypoint.                       |
| `apps/mobile/lib/src/app/chapter_house_app.dart`                            | Added `MaterialApp.router` shell.                                                   |
| `apps/mobile/lib/src/routing/app_router.dart`                               | Added initial GoRouter route.                                                       |
| `apps/mobile/lib/src/features/bootstrap/presentation/bootstrap_screen.dart` | Added foundation bootstrap screen.                                                  |
| `apps/mobile/test/widget_test.dart`                                         | Added bootstrap smoke test.                                                         |
| `apps/mobile/pubspec.yaml`                                                  | Added routing, Riverpod, Supabase, secure storage, and intl dependencies.           |
| `apps/mobile/android/gradle.properties`                                     | Disabled Kotlin incremental compilation to avoid Windows cross-drive cache failure. |

## API Dependencies

- Public catalog queries/RPCs.
- Search and suggestion APIs.
- Supabase Auth and profile tables.
- Device activation and validation.
- Order creation and manual payment submission.
- Entitlement synchronization and offline-license issuance.
- Protected storage access.
- Dynamic theme and localization config.

## Schema Dependencies

- M2 canonical schema and contracts must exist before backend-integrated mobile features.
- M3 design-token and localization schemas must exist before feature screens standardize UI.
- M4 auth/device schema must exist before protected routes and one-device enforcement.
- M7 payment schema must exist before checkout.
- M8/M9 license and content schema must exist before secure reading.

## Tests

| Command                                   | Result | Notes                                                                                        |
| ----------------------------------------- | ------ | -------------------------------------------------------------------------------------------- |
| `dart format lib test`                    | Passed | Formatted mobile Dart files.                                                                 |
| `flutter analyze`                         | Passed | No issues found.                                                                             |
| `flutter test`                            | Passed | Bootstrap widget test passed.                                                                |
| `flutter build apk --debug`               | Passed | Built debug APK after `flutter clean`, `flutter pub get`, and Kotlin incremental workaround. |
| `flutter build ios --debug --no-codesign` | Failed | This Windows Flutter toolchain did not expose iOS build options.                             |
| `flutter build ios --no-codesign`         | Failed | This Windows Flutter toolchain did not expose iOS build options.                             |

## Build Results

- Android debug APK built at `apps/mobile/build/app/outputs/flutter-apk/app-debug.apk`.
- iOS build was not available from this Windows Flutter toolchain.

## Platform-Specific Results

- Android: debug build passed.
- iOS: deferred to macOS/release validation.

## Accessibility Status

- Bootstrap shell uses standard Material semantics only.
- Full accessibility implementation remains planned for M3 and M11.

## Localization Status

- English/Bangla support planned; no l10n implementation exists yet.
- `intl` dependency is present for later localization/currency/date work.

## Theme Consistency Status

- M1 uses a temporary Material seed color only.
- Five premium themes remain planned for M3.

## Performance Notes

- Candidate SLOs are documented in the mobile and master plans.
- No runtime performance measurement exists yet.

## Known Limitations

- Supabase CLI is missing globally, but `npx supabase` works from the repo.
- Reader package/library selection is not approved yet.
- OAuth and signing configuration are external setup items.
- Android build emits plugin Built-in Kotlin migration warnings from dependencies.

## Next Action

Merge M1 foundation or record the PR fallback, then stop before M2.
