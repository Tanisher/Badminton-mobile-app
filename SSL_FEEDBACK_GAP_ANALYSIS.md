# Super Smash League Manager — Feedback Gap Analysis & Fix Guide

**Source:** `Super Smash League Manager App Feedback & Updates.docx`  
**Codebase under review:** `Badminton mobile app` (Flutter + Drift, schema v10)  
**Date:** 2026-08-26  
**Scope of this document:** Analysis and implementation guide only — **no code changes yet**.

---

## Executive summary

The feedback says the **overall structure is working well**. Gaps are **refinements**, not a rewrite:

| # | Feedback topic | Verdict vs current app | Severity |
|---|----------------|------------------------|----------|
| 1 | Doubles partnership rankings (pair as entity); **no personal doubles points** | **FAIL** | Critical |
| 2 | PDF export — rankings | **FAIL** | High |
| 3 | PDF export — player profile | **FAIL** | High |
| 4 | Ranking period = **rolling 12 months** (+ movement) | **FAIL** | High |
| 5 | Tier labels Premier→Development + stage point table | **FAIL** | Critical |
| 6 | Schema stages R32 / R64 | **PARTIAL** | Critical (blocks #5) |
| 7 | Group-stage elimination → preceding KO round points | **FAIL** | Critical |
| 8 | Pure RR clustered standings → stage points | **FAIL** | Critical |
| 9 | U19 eligibility (DOB ≥ 2008-01-01) | **FAIL** | High |
| 10 | App rename → Super Smash League Manager | **FAIL** | Medium |
| 11 | SSL logo + colour identity throughout UI | **FAIL** (assets **received**) | Medium |
| 12 | Team-event system changes | **N/A — leave alone** | — |
| 13 | External results (per-player + optional partner text) | **PASS — keep as-is** | — |

**What already aligns (do not break):**

- Doubles pairs exist as `IndividualTeams` (A+B ≠ A+E) for registration/fixtures.
- Individual player stats (P/W/L/titles) exist.
- Tournament tiers exist (`Tournaments.tier` + `TierPointValues`).
- Rankings UI exists (MS/WS/MD/WD/XD tabs) but ranks **individuals**, not partnerships for doubles.
- Competition **TEAM** events: feedback explicitly says leave as-is for now.

---

## How to read this document

- **FAIL** = requirement not met in current product behaviour.  
- **PARTIAL** = plumbing exists but wrong shape / incomplete.  
- **PASS** = meets feedback or explicitly deferred by feedback.  
- **Blocked** = needs materials from SSL (logo, colours, final confirmation of points).

Each section maps **feedback wording → current behaviour → why it fails → step-by-step fix**.

---

## 1. Doubles partnerships & rankings

### Feedback requirement

> Points must be associated with the **specific doubles partnership**, not only individuals.  
> A+B and A+E are **separate ranking entities**.  
> Doubles tables show partnership + **combined** points.  
> Individuals still keep their **own** ranking points and statistics.

### Current behaviour

| Piece | Status | Evidence |
|-------|--------|----------|
| Pair entities for play | PASS | `IndividualTeams` stores unique pairs; fixtures register the pair as a participant |
| MD/WD/XD **rankings** | **FAIL** | `RankingRepository.computePlayerRankingPoints` awards points to **each player id**; Rankings screen lists players |
| Partnership combined ranking view | **FAIL** | No `computePartnershipRankingPoints` / no pair rows in UI |
| Individual singles rankings (MS/WS) | PASS (keep) | Player-keyed ranking is correct for singles |
| Individual career stats | PASS (keep) | `matchesPlayed` / won / lost / titles on `Players` |

### Why it fails

Feedback wants **two parallel ranking spaces**:

1. **Player rankings** — MS/WS (and possibly individual career aggregates).  
2. **Partnership rankings** — MD/WD/XD keyed by `individual_team_id` (or ordered player-pair key).

Today doubles results **inflate each player’s personal points**, which merges A+B and A+E into “player A’s pile”.

### Step-by-step fix

1. **Confirm product rule (1 decision)**  
   - MD/WD/XD **leaderboard** = partnerships only.  
   - Does each player **also** get a personal MD/WD/XD points total (sum across partners), or only MS/WS personally?  
   - Feedback: “individuals retain own ranking points and statistics” — recommend: keep **MS/WS** as player rankings; for doubles show **partnership board**; keep career W/L/titles on the player (already separate from ranking points).

2. **Data model**  
   - Ranking computation for MD/WD/XD must key by `IndividualTeam.id` (or `min(player1Id), max(player2Id), eventType`).  
   - External doubles results: today one row per player; for partnership ranking, either:  
     - link `individualTeamId` on external results, or  
     - match external rows that share tournament + event + partner name to a known pair.

3. **Engine changes (`ranking_repository.dart`)**  
   - Add `computePartnershipRankingPoints({required String eventType})` for MD/WD/XD.  
   - Resolve fixture participants of type `pair` → `individualTeamId`.  
   - Award **one** stage/points total to the **pair** (combined points for that partnership).  
   - Keep `computePlayerRankingPoints` for **MS/WS only** (and external singles).  
   - **Do not** add personal MD/WD/XD point totals for players (locked decision D1).  
   - Filter all ranking compute to **rolling 12 months** (D3).  
   - Seeding for doubles KO/G+K: use **partnership** ranking; singles: player ranking.

4. **UI (`rankings_screen.dart`)**  
   - MS/WS tabs: player name + points (unchanged shape).  
   - MD/WD/XD tabs: columns **Rank | Partnership (A + B) | Combined points**.  
   - Optional secondary view: “My partners” on player profile.

5. **Tests**  
   - A+B earns X; A+E earns Y; partnership board shows two rows; player A is not a single MD row that sums X+Y unless you explicitly want a personal aggregate view.

6. **Do not change** competition TEAM event ranking (feedback §1 last paragraph / summary item 5).

---

## 2. PDF export & publishing

### Feedback requirement

**Rankings PDF** from Rankings screen: event/category, ranking period, rank, player or partnership, points, **ranking movement**, tournaments played in period. Doubles as partnerships.

**Player Profile PDF** from player profile: identity, age category, club, current rankings, W/L/titles, tournament history, partnerships, points. Clean/professional for SSL publishing.

### Current behaviour

| Piece | Status |
|-------|--------|
| Any PDF generation | **FAIL** — no `pdf` / `printing` usage in `lib/` |
| Rankings export button | **FAIL** |
| Player profile screen (rich) | **PARTIAL** — edit sheet + stats subtitle; no dedicated profile / history / export |
| Ranking period | **FAIL** — live all-time totals only |
| Ranking movement (↑↓) | **FAIL** — no snapshots |
| Tournaments played in period | **FAIL** — not aggregated for rankings UI |

### Why it fails

Publishing needs **period-scoped** rankings and **history snapshots**. The engine only computes **all-time live totals**.

### Step-by-step fix

#### 2A — Prerequisites (shared)

1. Add packages: e.g. `pdf`, `printing` (share/print), optionally `path_provider` (already present) for save.  
2. Define **ranking period** model (e.g. calendar year, or rolling 12 months, or manual “SSL Season 2026”). Store as config or season table.  
3. Add **ranking snapshots** (optional but needed for movement):  
   - Table e.g. `RankingSnapshots(periodId, eventType, entityType player|pair, entityId, rank, points, capturedAt)`.  
   - Capture on schedule or when organiser taps “Close ranking period”.  
4. **Movement** = compare current rank vs previous snapshot rank.

#### 2B — Rankings PDF

1. Rankings screen AppBar: **Export as PDF**.  
2. Dialog: choose event (current tab), period, include movement yes/no.  
3. Build PDF layout (header SSL logo when available, title, period, table).  
4. MD/WD/XD rows = partnership names.  
5. Share sheet / print / save to Downloads.

#### 2C — Player Profile PDF

1. Add a real **Player Profile** screen (from player tile): stats, rankings summary, partnerships list, recent tournaments, external results.  
2. **Export Profile as PDF** action.  
3. Age category: derive from DOB vs SSL age bands (confirm bands with SSL if not in this doc).  
4. Same visual language as rankings PDF.

#### 2D — QA

- Export empty rankings → friendly empty PDF or block with message.  
- Long names / many rows → multi-page table.  
- Android share works offline.

---

## 3. Tournament tier names & ranking points

### Feedback requirement

Replace existing tiers with prepared system:

| Stage | T1 – Premier | T2 – Major | T3 – Open | T4 – Challenge | T5 – Development |
|-------|-------------:|-----------:|----------:|---------------:|-----------------:|
| Winner | 525 | 425 | 350 | 283 | 190 |
| Final | 440 | 355 | 293 | 236 | 157 |
| Semi-final | 365 | 293 | 243 | 195 | 130 |
| Quarter-final | 290 | 230 | 192 | 153 | 102 |
| Round of 16 | 190 | 156 | 130 | 100 | 67 |
| Round of 32 | 110 | 86 | 72 | 58 | 39 |
| Round of 64 | 41 | 33 | 27 | 21 | 14 |

Feedback also says: *“I will provide the exact tier names and points… separately”* — treat the table above as the **working spec** until a newer sheet arrives.

### Current behaviour

| Piece | Status | Detail |
|-------|--------|--------|
| Tier field on tournament | PARTIAL | Free-text (`hint: e.g. Tier 1`), not forced T1–T5 labels |
| `TierPointValues` seed | **FAIL** | Only **Tier 1/2/3** with **wrong** point values (1000/600/…) |
| Columns on tier table | **PARTIAL** | Has winner, runner-up, SF, QF, R16, `groupWinPoints` — **no R32 / R64** |
| Create-tournament UX | PARTIAL | Organiser can type any string; mismatches break lookups |

### Why it fails

Wrong labels, wrong values, missing stages, free-text tiers that don’t match seeded rows.

### Step-by-step fix

1. **Schema migration (v11)** — extend `TierPointValues`:  
   - Keep/rename columns to match stages: winner, finalist (runner-up), semi, quarter, r16, **r32**, **r64**.  
   - Decide fate of `groupWinPoints` (see §4 — group elimination is **not** “points per group win”).  
2. **Reseed / replace rows**  
   - Delete or migrate old `Tier 1/2/3`.  
   - Insert five rows with canonical labels (**D4**):  
     `Premier`, `Major`, `Open`, `Challenge`, `Development`  
     Point values from the feedback table (T1→Premier … T5→Development).
3. **Tournament create/edit UI**  
   - Replace free-text tier with **dropdown** bound to those five labels.
4. **Pure Round Robin (D2)** — after final standings sort, map position → stage band (1→Winner, 2→Final, 3–4→SF, 5–8→QF, 9–16→R32, 17+→R64); award once per participant (or partnership for doubles events).
5. **Ranking engine**  
   - Map KO rounds including R32/R64; apply rolling 12-month date filter (D3).
6. **Existing DBs on devices**  
   - Migration must update in place; re-map old tournament.tier strings where possible (`Tier 1`→`Premier`, etc.).

---

## 4. Group Stage → Knockout ranking-points rule

### Feedback requirement

When format is **Group + Knockout**, players **eliminated in the group stage** receive points for the **round immediately before the first knockout round**:

| Knockout starts at | Group-stage elimination gets |
|--------------------|------------------------------|
| Round of 16 | Round of 32 points |
| Quarter-final | Round of 16 points |
| Semi-final | Quarter-final points |

Knockout finishers still get Winner / Final / SF / QF / etc. as normal.

### Current behaviour

| Piece | Status | Detail |
|-------|--------|--------|
| G+K fixtures | PASS | Groups + KO phases exist |
| `knockoutStartStage` | PASS | Stored on `GroupKnockoutSettings` |
| Group ranking awards | **FAIL** | Engine adds **`groupWinPoints` per group/RR win**, not “eliminated at preceding round” lump sum |
| Preceding-round inheritance | **FAIL** | No mapping from start stage → previous stage points |

### Why it fails

Wrong model: per-win bonuses ≠ SSL “group elimination = previous bracket round value”.

### Step-by-step fix

1. **Define helpers**  
   - `precedingStage(knockoutStartStage)` → e.g. `quarterfinal` → `roundOf16`.  
   - `pointsForStage(tier, stage)` including R32/R64 after §3.  
2. **Award rules for G+K tournaments**  
   - Qualifiers who play KO: award based on **furthest KO stage** only (no double-dip with group elimination points).  
   - Non-qualifiers (or all who never appear in KO): award **once** `pointsForStage(tier, precedingStage(start))`.  
3. **Remove or disable** per-win `groupWinPoints` for G+K (or keep only if SSL later asks — feedback’s group rule supersedes it).  
4. **Pure Round Robin**  
   - Confirm with SSL: still use standings-based points, old groupWin, or a separate table? **Not specified in this doc** — flag as open question before coding RR-only awards.  
5. **Tests**  
   - G+K, start=QF, player out in groups → R16 points for that tier.  
   - Champion → Winner points only (not Winner + group elim).

---

## 5. App name & branding (SSL)

### Feedback requirement

Official name: **Super Smash League Manager**.  
Visual identity from existing SSL logo, colour scheme, overall look — login/home, nav, headings, rankings, tournaments, profiles, buttons, PDFs.

### Current behaviour

| Piece | Status | Detail |
|-------|--------|--------|
| Display name | **FAIL** | Android label / UI still “Badminton Manager” (or similar) |
| Theme | **FAIL** | Generic gold court theme (`AppTheme`), not SSL palette |
| Logo | **FAIL** | Generated shuttlecock asset, not SSL logo |
| Landing | PARTIAL | Branded landing exists but wrong brand |
| PDF branding | **FAIL** | No PDFs yet |

### Branding materials received (2026-08-26)

Stored under `assets/branding/` for implementation:

| File | Use |
|------|-----|
| `ssl_logo.png` | App icon / splash / PDF header (feathers green–yellow–red + 3 gold stars on black) |
| `ssl_poster_ref.jpg` | Colour reference: deep red, bright green, yellow, white; “SUPER SMASH” wordmark |
| `ssl_certificate_ref.jpg` | Print/PDF tone: geometric corners red/green/yellow, navy titles, gold seal |

**Extracted palette (from poster/certificate — confirm hex if SSL has a formal brand sheet):**

| Role | Approx colour |
|------|----------------|
| Primary red | Deep maroon / blood red (titles, accents) |
| Primary green | Bright sports green (secondary titles, CTAs) |
| Accent yellow / gold | Medal / star / seal gold |
| Ink / navy | Certificate title navy |
| Surfaces | White / light grey court watermark |

### Step-by-step fix

1. ~~Collect logo~~ — **received** (`ssl_logo.png` + poster/certificate refs). Prefer formal hex codes if SSL has a brand PDF later.  
2. Rename everywhere:  
   - `AndroidManifest` `android:label` → `Super Smash League Manager`  
   - iOS display name  
   - `MaterialApp.title`, landing copy, drawer title, PDF headers  
3. Point launcher icons + splash at `ssl_logo.png` (regenerate `flutter_launcher_icons` / `flutter_native_splash`).  
4. Rewrite `AppTheme` to SSL red/green/yellow tokens; keep high-contrast button labels (white on filled red/green).  
5. Pass logo into PDF header widgets; optionally mirror certificate geometry lightly on profile PDF chrome.  
6. Visual QA pass on Home, Rankings, Tournament, Player profile, buttons.

---

## 6. Explicitly out of scope (this feedback)

| Topic | Instruction |
|-------|-------------|
| Competition **team events** further changes | **Leave current system as-is**; revisit later |
| External results doubles linking to DB pairs | **Leave as-is** — per-player points + optional free-text partner (see locked decisions) |
| Unrelated AMD polish already done | Not contradicted by this feedback |

---

## Locked product decisions (answered 2026-08-26)

These replace the former “open questions”. Implementers must follow these exactly.

### D1 — Personal doubles points

**Decision: No.**  
Doubles players must **not** accumulate personal ranking points across MD/WD/XD (or across partners).

| Event | Ranking entity |
|-------|----------------|
| MS / WS | **Player** |
| MD / WD / XD | **Partnership only** (`IndividualTeam` / A+B ≠ A+E) |
| Player career W/L/titles | Keep on player (stats, not doubles ranking points) |

### D2 — Pure Round Robin points (clustered by final standing)

**Decision: Cluster final RR standings into KO-equivalent stages** using that tournament’s tier point row:

| Final RR position(s) | Award as |
|----------------------|----------|
| 1st | Winner |
| 2nd | Final (runner-up) |
| 3rd–4th | Semi-final |
| 5th–8th | Quarter-final |
| 9th–16th | Round of 32 |
| 17th and below | Round of 64 |

Notes:

- Uses the **same tier matrix** as knockout (Premier / Major / …).  
- Replaces the old per-win `groupWinPoints` model for pure RR.  
- Ties in standings: resolve with existing H2H / standings sort before banding; if still tied, document a deterministic rule (e.g. share the **lower** band, or split — **default: both get the better band only if sort already split them; if true tie after sort, award the worse of the two bands** — confirm in QA if needed).

### D3 — Ranking period

**Decision: Rolling 12 months.**  
Include only results (in-app + external) with event date ≥ `today − 365 days` (or calendar-accurate 12 months).  
Movement = compare current rolling rank vs rank as-of ~12 months ago snapshot **or** vs previous publish — recommend: snapshot weekly/on-export of “rank 12 months ago window end” is heavy; simpler MVP: movement vs **last exported / last frozen snapshot** optional, or compute rank using window ending 7 days ago as “previous” — **MVP for PDF: show current rolling points/rank; movement column = vs snapshot taken at last app “Freeze rankings” or last export, else “—” until two snapshots exist.**

### D4 — Canonical tier labels

**Decision: Short names (no `T1 –` prefix in UI/DB canonical form):**

| Label | Former feedback code |
|-------|----------------------|
| **Premier** | T1 |
| **Major** | T2 |
| **Open** | T3 |
| **Challenge** | T4 |
| **Development** | T5 |

Tournament dropdown and `TierPointValues.tierLabel` must use these exact strings. Point values remain those in the feedback table (§3).

### D5 — Age category / eligibility (U19 for now)

**Decision: U19 only for now** (no senior category in product yet).

- **Eligible:** date of birth **on or after 1 January 2008**.  
- **Ineligible:** born **before 1 January 2008**.  
- Enforce on player create/edit and on tournament registration (block or warn — **recommend hard block with clear message**).  
- Profile / PDF: show **U19** (and optionally age) when eligible; show ineligible state if somehow present in DB from older data.

*Cut-off is fixed to 2008-01-01 for this season’s definition; revisit when seniors are added.*

### D6 — External results & doubles partners

**Decision: Keep current External Results design.**

- Points are entered **per player** (each partner gets their own external row).  
- `partnerName` stays **optional free text** (supports internationals / seniors not in DB).  
- Do **not** require linking external doubles rows to an `IndividualTeam` for ranking.  
- **Implication for partnership boards (MD/WD/XD):** in-app pair results feed **partnership** rankings; external points feed **that player only** — they do **not** invent a partnership rank row from free-text partners. (External remains player-scoped contribution; if SSL later wants external to boost a pair entity, that would be a new requirement.)

**Clarification for MS/WS:** external points continue to count toward that player’s singles ranking within the rolling year.

**Clarification for MD/WD/XD partnership leaderboard:** only in-app results attributed to a registered pair count toward that pair’s combined points, unless product later changes D6.

---

## Dependency order (recommended implementation sequence)

```text
Phase F1 — Points foundation (unblocks rankings accuracy)
  1. Extend TierPointValues (R32/R64); reseed Premier→Development from feedback table
  2. Tournament tier dropdown (Premier / Major / Open / Challenge / Development)
  3. Fix KO stage → points mapping
  4. G+K: group elimination → preceding KO round points
  5. Pure RR: clustered standing → Winner/Final/SF/QF/R32/R64 points (D2)
  6. Unit tests for matrix + G+K + RR clusters

Phase F2 — Doubles partnership rankings (D1)
  7. Partnership ranking engine + Rankings UI for MD/WD/XD only
  8. MS/WS remain player rankings; no personal doubles point totals
  9. Seeding: doubles use partnership ranks; singles use player ranks
 10. External: leave per-player + optional partner text (D6)
 11. Tests for A+B vs A+E

Phase F3 — Period, eligibility, profile
 12. Rolling 12-month filter on ranking compute (D3)
 13. U19 eligibility DOB ≥ 2008-01-01 on register/create (D5)
 14. Player profile screen (history, partnerships list, rankings summary)

Phase F4 — PDF
 15. Rankings PDF export (rolling period label, partnerships on doubles tabs)
 16. Player profile PDF export

Phase F5 — SSL branding (assets on disk)
 17. Rename app + theme from poster palette + ssl_logo.png + splash + PDF chrome
```

**Parallelism:** F5 can run anytime (logo already saved). F4 depends on F2+F3.

---

## Checklist — “feedback document done”

- [x] MD/WD/XD rankings list **partnerships** with combined points; A+B ≠ A+E; **no** personal doubles point totals (D1)  
- [x] MS/WS remain player rankings; career stats remain on player  
- [x] Tier dropdown = Premier / Major / Open / Challenge / Development + full point matrix incl. R32/R64 (D4)  
- [x] Pure RR uses clustered standing bands (D2)  
- [x] G+K group exits earn **preceding KO round** points once  
- [x] Rankings use **rolling 12 months** (D3)  
- [x] U19 eligibility: DOB on/after 2008-01-01 (D5)  
- [x] External results unchanged: per-player points, optional partner free text (D6)  
- [x] Rankings PDF + Player Profile PDF export  
- [x] App name **Super Smash League Manager** + SSL logo/colours  
- [x] TEAM competition module untouched  
- [ ] Release APK rebuilt and smoke-tested on device  

*Implementation landed 2026-08-26 (schema v11).*

---

## File / module touch map (for implementers)

| Area | Primary files (current tree under `Badminton mobile app/`) |
|------|-------------------------------------------------------------|
| Tiers schema/seed | `lib/data/database/tables/tier_point_values_table.dart`, `database.dart` |
| Points engine | `lib/data/repositories/ranking_repository.dart` |
| Seeding | `lib/data/repositories/fixture_repository.dart` (`seedParticipants`) |
| Rankings UI | `lib/features/rankings/` |
| Tournament tier UI | `create_tournament_screen.dart`, `tournament_detail_screen.dart` |
| Pairs | `individual_team_repository.dart`, Doubles UI |
| Eligibility | `player_repository.dart`, registration flows |
| PDF (new) | e.g. `lib/features/publishing/` |
| Branding | `lib/app/app_theme.dart`, `landing_home_screen.dart`, `AndroidManifest.xml`, `assets/branding/ssl_logo.png` |
| External | leave `external_result_*` behaviour as-is (D6) |

---

*Document type: gap analysis + fix guide against SSL feedback. Decisions locked 2026-08-26. No implementation in this pass.*
