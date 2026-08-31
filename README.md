# Super Smash League Manager

Offline-first Flutter app for managing the **Super Smash League (SSL)** badminton competition: player pool, doubles pairs, team events, tournaments, standings, SSL rankings, external results, and PDF publishing.

Package name: `badminton_manager` · Database schema: **v11**

## Features

- **Player pool** — men/women lists, career stats (played / won / lost / titles), player profiles
- **Doubles pairs** — MD / WD / XD partnerships as distinct entities for registration and fixtures
- **Competition teams** — roster-based team events (unchanged from original module)
- **Tournaments** — Round Robin, Knockout, and Group + Knockout formats; fixtures, scores, standings
- **SSL rankings** — rolling **12-month** window
  - **MS / WS** — individual player boards
  - **MD / WD / XD** — partnership boards only (no personal doubles points)
  - Tier points: **Premier, Major, Open, Challenge, Development**
  - Pure RR awards by final standing cluster (Winner → R64)
  - Group-stage exits in G+K use the preceding knockout round’s points
- **U19 eligibility** — date of birth on or after **1 Jan 2008**
- **External results** — per-player points with optional free-text partner (no pair DB link)
- **PDF export** — rankings and player profile sheets (SSL branding)
- **Backup / restore** — export and restore the local SQLite database via the **⋯** menu (top right)

## Tech stack

| Layer | Choice |
|-------|--------|
| UI | Flutter (Material 3), SSL theme (maroon / green / gold) |
| State | Riverpod |
| Database | Drift (SQLite), offline-first |
| PDF | `pdf` + `printing` |

## Requirements

- Flutter SDK **3.9+** (Dart **^3.9.2**)
- Android SDK for APK builds; Xcode for iOS

## Getting started

```bash
cd "Badminton mobile app"
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Run tests:

```bash
flutter test
flutter analyze
```

## Release build (Android)

For a phone install (arm64):

```bash
flutter build apk --release --target-platform android-arm64
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

If a build fails with a locked file or disk-space error, stop Gradle/Java, run `flutter clean`, then rebuild.

## Project layout

```
lib/
  app/              # Theme, app shell
  data/
    database/       # Drift schema, tables, migrations
    repositories/   # Players, tournaments, rankings, fixtures, backup
  features/
    home/           # Landing + bottom navigation
    players/        # Player pool & profiles
    teams/          # Doubles pairs & competition teams
    tournaments/    # Events, fixtures, scores, standings
    rankings/       # SSL ranking boards
    external_results/
    publishing/     # PDF export
assets/branding/    # ssl_logo.png and reference artwork
test/               # Unit & widget tests
```

## Related docs

| File | Purpose |
|------|---------|
| `SSL_FEEDBACK_GAP_ANALYSIS.md` | SSL feedback mapping and implementation notes |
| `QA.md` | Device install and smoke-test checklist |
| `AMD.md` | Original module backlog / acceptance notes |

## Data & backup

All data lives in a local SQLite file on the device. Use **⋯ → Export SQLite backup** before major testing or device changes. After restore, force-close and reopen the app so it loads the restored database.
