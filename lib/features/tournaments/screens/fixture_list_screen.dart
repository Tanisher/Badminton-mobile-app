import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/fixture_logic.dart';
import '../../../data/repositories/fixture_repository.dart';
import '../../../data/repositories/tournament_repository.dart';
import '../fixture_providers.dart';
import '../participant_providers.dart';
import '../providers.dart';
import '../widgets/clear_fixtures_dialog.dart';
import 'score_entry_screen.dart';
import 'standings_screen.dart';

class FixtureListScreen extends ConsumerWidget {
  const FixtureListScreen({
    super.key,
    required this.tournamentId,
    required this.eventType,
  });

  final int tournamentId;
  final String eventType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentAsync = ref.watch(tournamentDetailProvider(tournamentId));
    final eventKey = TournamentEventKey(tournamentId, eventType);

    return tournamentAsync.when(
      data: (details) {
        final tournament = details?.tournament;

        if (tournament == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Fixtures')),
            body: const Center(child: Text('Tournament not found')),
          );
        }

        final isRoundRobin = tournament.format == TournamentFormat.roundRobin;
        final isKnockout = tournament.format == TournamentFormat.knockout;
        final canGenerate = isRoundRobin || isKnockout;

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Fixtures · ${TournamentEventType.label(eventType)}',
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Fixtures'),
                  Tab(text: 'Standings'),
                ],
              ),
              actions: [
                if (canGenerate) ...[
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: _ClearButton(
                      eventKey: eventKey,
                      format: tournament.format,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _GenerateButton(
                      eventKey: eventKey,
                      format: tournament.format,
                    ),
                  ),
                ],
              ],
            ),
            body: TabBarView(
              children: [
                _FixturesTab(
                  tournamentId: tournamentId,
                  eventType: eventType,
                  format: tournament.format,
                ),
                if (isKnockout)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Standings tables apply to round-robin play.\n'
                        'Use the Fixtures tab for the knockout bracket.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  StandingsScreen(
                    tournamentId: tournamentId,
                    eventType: eventType,
                  ),
              ],
            ),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(
          title: const Text('Fixtures'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Fixtures'),
        ),
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _ClearButton extends ConsumerWidget {
  const _ClearButton({
    required this.eventKey,
    required this.format,
  });

  final TournamentEventKey eventKey;
  final String format;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final existsAsync = ref.watch(fixtureExistsProvider(eventKey));
    return existsAsync.when(
      data: (exists) {
        if (!exists) return const SizedBox.shrink();
        return TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          onPressed: () async {
            final choice = await confirmClearFixtures(
              context,
              title: 'Clear fixtures?',
              body: format == TournamentFormat.knockout
                  ? 'Remove the knockout bracket so you can regenerate it.'
                  : 'Remove all fixtures for this event so you can regenerate them.',
            );
            if (choice == null || !context.mounted) return;
            try {
              await ref.read(fixtureRepositoryProvider).clearFixtures(
                    tournamentId: eventKey.tournamentId,
                    eventType: eventKey.eventType,
                    allowCompleted: choice.force,
                  );
              ref.invalidate(fixtureExistsProvider(eventKey));
              ref.invalidate(fixturesForEventProvider(eventKey));
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$e')),
                );
              }
            }
          },
          child: const Text('Clear'),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _GenerateButton extends ConsumerWidget {
  const _GenerateButton({
    required this.eventKey,
    required this.format,
  });

  final TournamentEventKey eventKey;
  final String format;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final existsAsync = ref.watch(fixtureExistsProvider(eventKey));

    return existsAsync.when(
      data: (exists) {
        final isRoundRobin = format == TournamentFormat.roundRobin;
        final isKnockout = format == TournamentFormat.knockout;
        if (!isRoundRobin && !isKnockout) return const SizedBox.shrink();

        return FilledButton(
          onPressed: exists
              ? null
              : () async {
                  try {
                    final repo = ref.read(fixtureRepositoryProvider);
                    if (isKnockout) {
                      await repo.generateKnockoutBracket(
                        tournamentId: eventKey.tournamentId,
                        eventType: eventKey.eventType,
                      );
                    } else {
                      await repo.generateRoundRobinFixtures(
                        tournamentId: eventKey.tournamentId,
                        eventType: eventKey.eventType,
                      );
                    }
                    ref.invalidate(fixtureExistsProvider(eventKey));
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$e')),
                      );
                    }
                  }
                },
          child: Text(isKnockout ? 'Generate Bracket' : 'Generate Fixtures'),
        );
      },
      loading: () => const SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (error, _) => const SizedBox.shrink(),
    );
  }
}

class _FixturesTab extends ConsumerWidget {
  const _FixturesTab({
    required this.tournamentId,
    required this.eventType,
    required this.format,
  });

  final int tournamentId;
  final String eventType;
  final String format;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = TournamentEventKey(tournamentId, eventType);
    final asyncFixtures = ref.watch(fixturesForEventProvider(key));
    final isKnockout = format == TournamentFormat.knockout;

    return asyncFixtures.when(
      data: (fixtures) {
        if (fixtures.isEmpty) {
          return Center(
            child: Text(
              isKnockout
                  ? 'No bracket yet. Generate bracket to start.'
                  : 'No fixtures yet. Generate fixtures to start.',
            ),
          );
        }

        if (isKnockout) {
          return _KnockoutFixtureList(fixtures: fixtures);
        }

        // Round robin: group by roundNumber.
        final byRound = <int, List<FixtureRowView>>{};
        for (final f in fixtures) {
          byRound.putIfAbsent(f.fixture.roundNumber, () => []).add(f);
        }
        final rounds = byRound.keys.toList()..sort();

        return ListView.separated(
          itemCount: rounds.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, idx) {
            final round = rounds[idx];
            return _RoundSection(
              title: 'Round $round',
              fixtures: byRound[round]!,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}

class _KnockoutFixtureList extends StatelessWidget {
  const _KnockoutFixtureList({required this.fixtures});

  final List<FixtureRowView> fixtures;

  @override
  Widget build(BuildContext context) {
    final byRound = <String, List<FixtureRowView>>{};
    for (final f in fixtures) {
      final key = f.fixture.bracketRound ?? 'unknown';
      byRound.putIfAbsent(key, () => []).add(f);
    }

    final rounds = byRound.keys.toList()
      ..sort((a, b) => BracketRound.sortKey(a).compareTo(BracketRound.sortKey(b)));

    return ListView.separated(
      itemCount: rounds.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, idx) {
        final round = rounds[idx];
        return _RoundSection(
          title: BracketRound.label(round),
          fixtures: byRound[round]!,
        );
      },
    );
  }
}

class _RoundSection extends StatelessWidget {
  const _RoundSection({
    required this.title,
    required this.fixtures,
  });

  final String title;
  final List<FixtureRowView> fixtures;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListView.separated(
            itemCount: fixtures.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, idx) {
              final item = fixtures[idx];
              return _FixtureListTile(item: item);
            },
          ),
        ],
      ),
    );
  }
}

class _FixtureListTile extends StatelessWidget {
  const _FixtureListTile({required this.item});

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
        subtitle: Text(f.bracketRound != null
            ? BracketRound.label(f.bracketRound)
            : 'Bye'),
        enabled: false,
      );
    }

    final title =
        '${item.participant1DisplayName} vs ${item.participant2DisplayName}';

    return ListTile(
      title: Text(title),
      subtitle: Text(
        locked
            ? 'Waiting on earlier rounds'
            : 'Court ${f.courtNumber ?? '—'} · ${f.status}',
      ),
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
