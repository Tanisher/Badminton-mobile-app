import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/database.dart';
import '../../../data/repositories/fixture_logic.dart';
import '../../../data/repositories/fixture_repository.dart';
import '../fixture_providers.dart';
import '../participant_providers.dart';
import '../widgets/clear_fixtures_dialog.dart';
import 'score_entry_screen.dart';
import 'standings_screen.dart';

/// Two-phase UI for format = group_knockout: groups → knockout.
/// Uses a single top TabBar; group pickers are chips (no nested TabControllers).
class GroupKnockoutOverviewScreen extends ConsumerWidget {
  const GroupKnockoutOverviewScreen({
    super.key,
    required this.tournamentId,
    required this.eventType,
  });

  final int tournamentId;
  final String eventType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventKey = TournamentEventKey(tournamentId, eventType);
    final groupsAsync = ref.watch(groupsForEventProvider(eventKey));
    final hasGroupFx = ref.watch(hasGroupStageFixturesProvider(eventKey));
    final hasKo = ref.watch(hasKnockoutFixturesProvider(eventKey));
    final groupComplete = ref.watch(groupStageCompleteProvider(eventKey));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Group + Knockout · $eventType'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Groups'),
              Tab(text: 'Knockout'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _GroupsPhase(
              tournamentId: tournamentId,
              eventType: eventType,
              groupsAsync: groupsAsync,
              hasGroupFixtures: hasGroupFx,
            ),
            _KnockoutPhase(
              tournamentId: tournamentId,
              eventType: eventType,
              groupStageComplete: groupComplete,
              hasKnockout: hasKo,
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupsPhase extends ConsumerStatefulWidget {
  const _GroupsPhase({
    required this.tournamentId,
    required this.eventType,
    required this.groupsAsync,
    required this.hasGroupFixtures,
  });

  final int tournamentId;
  final String eventType;
  final AsyncValue<List<Group>> groupsAsync;
  final AsyncValue<bool> hasGroupFixtures;

  @override
  ConsumerState<_GroupsPhase> createState() => _GroupsPhaseState();
}

class _GroupsPhaseState extends ConsumerState<_GroupsPhase> {
  int _selectedGroupIndex = 0;
  int _pane = 0; // 0 fixtures, 1 standings

  @override
  Widget build(BuildContext context) {
    final eventKey =
        TournamentEventKey(widget.tournamentId, widget.eventType);

    return widget.groupsAsync.when(
      data: (groups) {
        final selected = groups.isEmpty
            ? 0
            : _selectedGroupIndex.clamp(0, groups.length - 1);
        if (selected != _selectedGroupIndex) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _selectedGroupIndex = selected);
          });
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton(
                    onPressed: groups.isNotEmpty
                        ? null
                        : () async {
                            try {
                              await ref
                                  .read(fixtureRepositoryProvider)
                                  .assignGroups(
                                    tournamentId: widget.tournamentId,
                                    eventType: widget.eventType,
                                  );
                              ref.invalidate(groupsForEventProvider(eventKey));
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('$e')),
                                );
                              }
                            }
                          },
                    child: const Text('Generate Groups'),
                  ),
                  if (groups.isNotEmpty)
                    TextButton(
                      onPressed: () async {
                        final hasFx =
                            widget.hasGroupFixtures.asData?.value ?? false;
                        if (hasFx) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Clear group fixtures (and knockout if any) first.',
                              ),
                            ),
                          );
                          return;
                        }
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Clear groups?'),
                            content: const Text(
                              'Remove group assignments so you can reassign.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Clear'),
                              ),
                            ],
                          ),
                        );
                        if (ok != true || !context.mounted) return;
                        try {
                          await ref.read(fixtureRepositoryProvider).clearGroups(
                                tournamentId: widget.tournamentId,
                                eventType: widget.eventType,
                              );
                          ref.invalidate(groupsForEventProvider(eventKey));
                          setState(() => _selectedGroupIndex = 0);
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$e')),
                            );
                          }
                        }
                      },
                      child: const Text('Clear Groups'),
                    ),
                  FilledButton.tonal(
                    onPressed: groups.isEmpty ||
                            (widget.hasGroupFixtures.asData?.value ?? false)
                        ? null
                        : () async {
                            try {
                              await ref
                                  .read(fixtureRepositoryProvider)
                                  .generateGroupStageFixtures(
                                    tournamentId: widget.tournamentId,
                                    eventType: widget.eventType,
                                  );
                              ref.invalidate(
                                fixturesForEventProvider(eventKey),
                              );
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('$e')),
                                );
                              }
                            }
                          },
                    child: const Text('Generate Group Fixtures'),
                  ),
                  if (widget.hasGroupFixtures.asData?.value ?? false)
                    TextButton(
                      onPressed: () async {
                        final choice = await confirmClearFixtures(
                          context,
                          title: 'Clear group fixtures?',
                          body:
                              'Remove group-stage matches. Clear knockout first if it exists.',
                        );
                        if (choice == null || !context.mounted) return;
                        try {
                          await ref
                              .read(fixtureRepositoryProvider)
                              .clearGroupStageFixtures(
                                tournamentId: widget.tournamentId,
                                eventType: widget.eventType,
                                allowCompleted: choice.force,
                              );
                          ref.invalidate(fixturesForEventProvider(eventKey));
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$e')),
                            );
                          }
                        }
                      },
                      child: const Text('Clear Group Fixtures'),
                    ),
                ],
              ),
            ),
            if (groups.isEmpty)
              const Expanded(
                child: Center(
                  child: Text('No groups yet. Generate groups to start.'),
                ),
              )
            else ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    for (var i = 0; i < groups.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text('Group ${groups[i].groupNumber}'),
                          selected: selected == i,
                          onSelected: (_) =>
                              setState(() => _selectedGroupIndex = i),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(value: 0, label: Text('Fixtures')),
                    ButtonSegment(value: 1, label: Text('Standings')),
                  ],
                  selected: {_pane},
                  onSelectionChanged: (s) => setState(() => _pane = s.first),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: KeyedSubtree(
                    key: ValueKey('${selected}_$_pane'),
                    child: _pane == 0
                        ? _GroupFixturesList(
                            tournamentId: widget.tournamentId,
                            eventType: widget.eventType,
                            group: groups[selected],
                          )
                        : StandingsScreen(
                            tournamentId: widget.tournamentId,
                            eventType: widget.eventType,
                            groupId: groups[selected].id,
                          ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
    );
  }
}

class _GroupFixturesList extends ConsumerWidget {
  const _GroupFixturesList({
    required this.tournamentId,
    required this.eventType,
    required this.group,
  });

  final int tournamentId;
  final String eventType;
  final Group group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventKey = TournamentEventKey(tournamentId, eventType);
    final fixturesAsync = ref.watch(fixturesForEventProvider(eventKey));

    return fixturesAsync.when(
      data: (all) {
        final fixtures =
            all.where((f) => f.fixture.groupId == group.id).toList();
        if (fixtures.isEmpty) {
          return const Center(
            child: Text('No fixtures yet. Generate group fixtures.'),
          );
        }
        final byRound = <int, List<FixtureRowView>>{};
        for (final f in fixtures) {
          byRound.putIfAbsent(f.fixture.roundNumber, () => []).add(f);
        }
        final rounds = byRound.keys.toList()..sort();
        return ListView.builder(
          itemCount: rounds.length,
          itemBuilder: (context, idx) {
            final round = rounds[idx];
            final items = byRound[round]!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Text(
                    'Round $round',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                for (final item in items)
                  ListTile(
                    title: Text(
                      '${item.participant1DisplayName} vs '
                      '${item.participant2DisplayName}',
                    ),
                    subtitle: Text(
                      'Court ${item.fixture.courtNumber ?? '—'} · '
                      '${item.fixture.status}',
                    ),
                    trailing: item.fixture.status == 'completed'
                        ? const Icon(Icons.edit)
                        : const Icon(Icons.edit_outlined),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => ScoreEntryScreen(
                            fixtureId: item.fixture.id,
                            isCompleted: item.fixture.status == 'completed',
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
    );
  }
}

class _KnockoutPhase extends ConsumerWidget {
  const _KnockoutPhase({
    required this.tournamentId,
    required this.eventType,
    required this.groupStageComplete,
    required this.hasKnockout,
  });

  final int tournamentId;
  final String eventType;
  final AsyncValue<bool> groupStageComplete;
  final AsyncValue<bool> hasKnockout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventKey = TournamentEventKey(tournamentId, eventType);
    final complete = groupStageComplete.asData?.value ?? false;
    final koExists = hasKnockout.asData?.value ?? false;
    final fixturesAsync = ref.watch(fixturesForEventProvider(eventKey));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 8,
            alignment: WrapAlignment.end,
            children: [
              if (koExists)
                TextButton(
                  onPressed: () async {
                    final choice = await confirmClearFixtures(
                      context,
                      title: 'Clear knockout bracket?',
                      body:
                          'Removes knockout fixtures only. Group-stage results stay.',
                    );
                    if (choice == null || !context.mounted) return;
                    try {
                      await ref
                          .read(fixtureRepositoryProvider)
                          .clearKnockoutFixtures(
                            tournamentId: tournamentId,
                            eventType: eventType,
                            allowCompleted: choice.force,
                          );
                      ref.invalidate(fixturesForEventProvider(eventKey));
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$e')),
                        );
                      }
                    }
                  },
                  child: const Text('Clear Bracket'),
                ),
              FilledButton(
                onPressed: (!complete || koExists)
                    ? null
                    : () async {
                        try {
                          await ref
                              .read(fixtureRepositoryProvider)
                              .generateKnockoutFromGroups(
                                tournamentId: tournamentId,
                                eventType: eventType,
                              );
                          ref.invalidate(fixturesForEventProvider(eventKey));
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$e')),
                            );
                          }
                        }
                      },
                child: const Text('Generate Knockout Bracket'),
              ),
            ],
          ),
        ),
        if (!complete)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Finish all group-stage fixtures before generating the knockout bracket.',
            ),
          ),
        Expanded(
          child: fixturesAsync.when(
            data: (all) {
              final fixtures =
                  all.where((f) => f.fixture.bracketRound != null).toList();
              if (fixtures.isEmpty) {
                return const Center(child: Text('No knockout bracket yet.'));
              }

              final byRound = <String, List<FixtureRowView>>{};
              for (final f in fixtures) {
                final key = f.fixture.bracketRound ?? 'unknown';
                byRound.putIfAbsent(key, () => []).add(f);
              }
              final rounds = byRound.keys.toList()
                ..sort(
                  (a, b) => BracketRound.sortKey(a)
                      .compareTo(BracketRound.sortKey(b)),
                );

              return ListView.builder(
                itemCount: rounds.length,
                itemBuilder: (context, idx) {
                  final round = rounds[idx];
                  final items = byRound[round]!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                        child: Text(
                          BracketRound.label(round),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      for (final item in items) _KnockoutTile(item: item),
                    ],
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('$e')),
          ),
        ),
      ],
    );
  }
}

class _KnockoutTile extends StatelessWidget {
  const _KnockoutTile({required this.item});

  final FixtureRowView item;

  @override
  Widget build(BuildContext context) {
    final f = item.fixture;
    final locked = !f.isBye &&
        (f.participant1Id == null || f.participant2Id == null);

    if (f.isBye) {
      final advancer = f.participant1Id != null
          ? item.participant1DisplayName
          : item.participant2DisplayName;
      return ListTile(
        title: Text('BYE — $advancer advances'),
        enabled: false,
      );
    }

    return ListTile(
      title: Text(
        '${item.participant1DisplayName} vs ${item.participant2DisplayName}',
      ),
      subtitle: Text(locked ? 'Waiting on earlier rounds' : f.status),
      trailing: locked
          ? null
          : (f.status == 'completed'
              ? const Icon(Icons.edit)
              : const Icon(Icons.edit_outlined)),
      onTap: locked
          ? null
          : () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ScoreEntryScreen(
                    fixtureId: f.id,
                    isCompleted: f.status == 'completed',
                  ),
                ),
              );
            },
    );
  }
}
