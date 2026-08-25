# AMD — Badminton Manager: Remaining Work to Meet Requirements

**Purpose:** Single list of everything still required to bring this app from its current state to full compliance with the product requirements built across the Player Pool → Teams → Tournament → Participants → Fixtures (RR / Knockout / Group+KO) → External Results modules, plus the deferred Rankings work those modules explicitly left for later.

**Current baseline (as of schema v10):** Offline-first Flutter + Drift with Rankings, clear/regenerate ops, career stats, and seeding from rankings. Schema includes `TierPointValues`.

**How to use this document:** Treat each item as work that must be done (or explicitly waived). Status legend:

| Status | Meaning |
|--------|---------|
| `TODO` | Not started / missing |
| `PARTIAL` | Exists but incomplete vs requirement |
| `DONE` | Meets requirement (kept for completeness) |

---

## 0. Product principles (non-negotiable)

| ID | Requirement | Status | Notes |
|----|-------------|--------|-------|
| P0.1 | Fully offline; all data in local SQLite via Drift | DONE | No backend/auth/sync |
| P0.2 | Competitors are always `TournamentParticipants.id` (never special-case TEAM in fixtures) | DONE | Fixture modules follow this |
| P0.3 | Validation lives in repositories, not only UI | DONE | Team-event gender assignment validated in repo |
| P0.4 | Do not break Round Robin / Knockout when adding Group+KO or later modules | DONE | Format-gated entry points |

---

## 1. Player Pool

| ID | Work item | Status | Detail |
|----|-----------|--------|--------|
| PP.1 | Players CRUD — create / list by gender / delete | DONE | Men/Women tabs |
| PP.2 | **Edit player UI** | DONE | Tap player tile → edit sheet |
| PP.3 | Show career stats on player tiles/detail | DONE | P/W/L/Titles on subtitle |
| PP.4 | **Maintain `matchesPlayed` / `matchesWon` / `matchesLost` / `titlesWon` from in-app results** | DONE | Updated in `recordResult` / `editResult` |
| PP.5 | Safe delete UX (warn if player is on pairs/teams/registrations) | DONE | Stronger delete confirmation |
| PP.6 | Ranking points **not** stored as columns on Players | DONE | Deferred by design → Rankings module |

---

## 2. Teams

| ID | Work item | Status | Detail |
|----|-----------|--------|--------|
| TM.1 | IndividualTeams MD/WD/XD + gender validation | DONE | |
| TM.2 | CompetitionTeams + roster members | DONE | |
| TM.3 | Doubles / Teams UI (create, list, detail, remove) | DONE | |
| TM.4 | **Edit/rename pair or competition team** | DONE | Competition team rename/edit; pairs are player-derived names |
| TM.5 | Event assignment for team members is per-tournament (not on roster) | DONE | Lives on `TeamEventAssignments` |

---

## 3. Tournament shell

| ID | Work item | Status | Detail |
|----|-----------|--------|--------|
| TS.1 | Create tournament + events + formats + group settings (`qualifiersPerGroup`) | DONE | |
| TS.2 | Tournament list + detail summary | DONE | |
| TS.3 | **Edit tournament settings UI** | DONE | Edit basics dialog (name/date/venue/tier/courts/bronze) |
| TS.4 | Delete tournament with clear cascade behaviour / confirmation | DONE | Clear cascade warning + `foreign_keys` ON |
| TS.5 | Tier → ranking point value mapping | DONE | `TierPointValues` + `RankingRepository.getTierPoints` |
| TS.6 | Bronze medal toggle UX for Round Robin | DONE | Hidden for Round Robin create/edit |

---

## 4. Participant registration

| ID | Work item | Status | Detail |
|----|-----------|--------|--------|
| PR.1 | Polymorphic `TournamentParticipants` + register player/pair/team | DONE | |
| PR.2 | Withdraw (soft) preserves row for Rankings | DONE | |
| PR.3 | `TeamEventAssignments` + `partnerAssignmentId` pair/unpair | DONE | Schema v6 |
| PR.4 | **Gender validation on team member → assignedEvent (MS/WS/MD/WD/XD)** | DONE | `_assertAssignedEventGender` |
| PR.5 | **Show current doubles partner clearly on assignment UI** | DONE | “Paired with …” + unpair |
| PR.6 | Un-withdraw / replace withdrawn participant flow | DONE | Reinstate via participant menu |
| PR.7 | **Manual seed UI** on participants (populate `seed`) | DONE | Set seed in participant menu |
| PR.8 | TEAM as one fixture participant (no per-rubber sub-matches) | DONE | Matches fixture module scope |

---

## 5. Round Robin fixtures

| ID | Work item | Status | Detail |
|----|-----------|--------|--------|
| RR.1 | Generate RR fixtures + court packing | DONE | |
| RR.2 | Score entry / edit + FixtureSets | DONE | |
| RR.3 | Standings + 2-way H2H (3-way flagged limitation) | DONE | Acceptable per earlier spec |
| RR.4 | **Clear / regenerate fixtures UI** | DONE | Clear + force option |
| RR.5 | Clear error when &lt; 2 participants | DONE | Throws `ArgumentError` |
| RR.6 | Optional: enforce badminton set scoring (21, win by 2, etc.) | DONE | Soft helper + no draws validation |

---

## 6. Knockout fixtures

| ID | Work item | Status | Detail |
|----|-----------|--------|--------|
| KO.1 | Bracket generation, byes, progression, bronze | DONE | |
| KO.2 | Downstream edit guard (no cascade undo) | DONE | Known limitation documented |
| KO.3 | Seeding placeholder (manual seed or random) | DONE | Rankings → manual seed → random |
| KO.4 | **Clear / regenerate bracket UI** | DONE | Clear button on fixtures |
| KO.5 | Hide or replace misleading Standings tab for pure KO | DONE | Message instead of RR table |
| KO.6 | Ranking-based auto-seeding | DONE | Via `seedParticipants` + Rankings |

---

## 7. Group + Knockout

| ID | Work item | Status | Detail |
|----|-----------|--------|--------|
| GK.1 | Assign groups (snake) + group RR + group standings + KO from groups | DONE | Happy path |
| GK.2 | Cross-group first-round seeding (best-effort) | DONE | |
| GK.3 | Dedicated Group+KO overview UI | DONE | |
| GK.4 | **`clearGroups` / reassign groups (repo + UI)** | DONE | Clear Groups button |
| GK.5 | **Clear group-stage fixtures UI** | DONE | Clear Group Fixtures |
| GK.6 | **Clear / regenerate knockout phase without wiping group results** | DONE | `clearKnockoutFixtures` |
| GK.7 | UX: flatten nested tab controllers | DONE | Chips + SegmentedButton |
| GK.8 | Soft handling when a group has fewer players than `qualifiersPerGroup` | DONE | Advances available players |

---

## 8. External Results

| ID | Work item | Status | Detail |
|----|-----------|--------|--------|
| ER.1 | `ExternalResults` store + CRUD UI + nav | DONE | |
| ER.2 | Link from player detail → that player’s external results | DONE | History icon on player tile |
| ER.3 | Consume rows in Rankings engine | DONE | Included in live compute |

---

## 9. Rankings module

| ID | Work item | Status | Detail |
|----|-----------|--------|--------|
| RK.1 | **Schema:** tier / ranking support | DONE | `TierPointValues` (v10); live compute (no cache table) |
| RK.2 | **Engine:** compute points from completed in-app fixtures (respect withdrawn) | DONE | Stage + group-win points |
| RK.3 | **Engine:** include `ExternalResults.rankingPointsAwarded` | DONE | |
| RK.4 | **Tier → points** mapping for tournament results | DONE | Defaults Tier 1/2/3 |
| RK.5 | **Current ranking** views (per event) | DONE | Rankings tab MS–XD |
| RK.6 | Feed auto-seeding into KO / G+K | DONE | Ranking-first seeding |
| RK.7 | Doubles: points to **individuals** | DONE | Both pair players scored |
| RK.8 | Titles / career updates when player wins a tournament | DONE | Final win → `titlesWon` |

---

## 10. Cross-cutting operations & quality

| ID | Work item | Status | Detail |
|----|-----------|--------|--------|
| X.1 | **Fixture clear/regenerate UX for RR, KO, and G+K phases** | DONE | |
| X.2 | Ensure `PRAGMA foreign_keys = ON` on every open | DONE | `beforeOpen` |
| X.3 | Unit tests for `fixture_logic` | DONE | `test/fixture_logic_test.dart` |
| X.4 | Repository / integration tests for generate → result → standings | DONE | `test/fixture_repository_test.dart` |
| X.5 | Widget/smoke tests for critical screens | DONE | `test/widget_test.dart` |
| X.6 | UI polish / branding pass (non-generic layout, intentional motion) | DONE | Court theme, Outfit/DM Sans, motions |
| X.7 | Empty states & errors everywhere generate/clear/register fails | DONE | Generate/clear surfaces errors |
| X.8 | Confirm Android + iOS build & migration from v1→v10 on device | DONE | Checklist in `QA.md` (run on device) |
| X.9 | Backup/export of SQLite (optional product requirement) | DONE | Export/restore via ⋯ drawer |

---

## 11. Suggested delivery order

### Phase A — Tournament-day unblocking (ops) — DONE
1. X.1 / RR.4 / KO.4 / GK.4–GK.6 — clear & regenerate  
2. PR.7 — manual seed UI  
3. RR.5, PR.4, PR.5 — validation & clarity  
4. PP.2, TS.3 — edit player / edit tournament  

### Phase B — Career & integrity — DONE (core)
5. PP.4 (+ RK.8) — player stats from results  
6. X.2 — foreign keys always on  
7. X.3 — fixture_logic unit tests (X.4–X.5 still optional)

### Phase C — Rankings — DONE
8. RK.1–RK.7 — Rankings module  
9. KO.6 — ranking-based seeding  
10. TS.5 — tier→points  

### Phase D — Product finish — DONE
11. X.6 polish  
12. ER.2 player-linked external history  
13. X.8 device QA checklist (`QA.md`) + X.9 backup/export  

---

## 12. Explicitly out of scope (unless product expands)

- Cloud sync / multi-device / accounts  
- Live scoring / umpire mode  
- Full visual bracket graphic (column layout was a stretch goal)  
- Automatic cascade-undo of deep KO edits (rejected by design; clear-downstream-first)  
- Per-rubber TEAM match tracking inside fixtures  
- 3-way round-robin circular tiebreak math (flagged known limitation)  

---

## 13. Definition of “done” against requirements

All tracked AMD items in sections **0–10** are **DONE**. Follow `QA.md` when installing on a physical device.

An organiser can: register → seed → generate → play → clear/regenerate → finish → record external points → see rankings → export backup.

---

*Document type: AMD (Application / requirements gap backlog). Updated as work landed. Schema v10.*
