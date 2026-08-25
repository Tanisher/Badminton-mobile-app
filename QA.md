# Device migration & install QA (X.8)

Use this checklist when installing on a real phone (Android / iOS).

## Fresh install (new device)

1. Uninstall any previous Badminton Manager build (clears app data).
2. From the project root:
   ```bash
   flutter devices
   flutter run -d <deviceId>
   ```
3. Confirm app opens on **Player Pool**.
4. Add one male + one female player.
5. Create a Round Robin tournament (MS), register both, generate fixtures, enter a score.
6. Open **Rankings** — points should appear after results / external entries.
7. Open the **⋯** drawer → **Export SQLite backup** — share sheet appears.

## Upgrade path (v1 → v10)

If you still have an older install on the phone:

1. **Do not uninstall** (keeps the old DB file).
2. `flutter run -d <deviceId>` with the current codebase (schema **10**).
3. App should open without crash; Drift runs migrations through v10.
4. Existing players / teams still listed.
5. **Rankings** tab present; tier defaults seeded if empty.
6. Export a backup before heavy testing.

If the app crashes on open after upgrade: clear app storage once, then re-test fresh install (data loss). Export first when possible.

## Smoke paths after install

| Path | Pass? |
|------|-------|
| Players CRUD + edit + stats subtitle | |
| Doubles pair create | |
| Competition team + roster | |
| Tournament create (RR / KO / G+K) | |
| Register → generate → score → standings | |
| Clear fixtures / regenerate | |
| Group chips (not nested tabs) + KO phase | |
| External result + Rankings update | |
| Export / restore backup (restore needs app restart) | |

## Connected device note

Current machine last saw: `SM S918U1` (`R5CW50J182J`). Re-run `flutter devices` before install.
