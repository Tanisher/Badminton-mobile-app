import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/participant_repository.dart';
import '../../../data/repositories/player_repository.dart';
import '../../../data/repositories/tournament_repository.dart';
import '../../teams/providers.dart';
import '../participant_providers.dart';
import '../providers.dart';
import '../screens/fixture_list_screen.dart';
import '../screens/group_knockout_overview_screen.dart';
import '../screens/team_event_assignment_screen.dart';

class EventParticipantsPanel extends ConsumerWidget {
  const EventParticipantsPanel({
    super.key,
    required this.tournamentId,
    required this.eventType,
  });

  final int tournamentId;
  final String eventType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncParticipants = ref.watch(
      participantsForEventProvider(
        TournamentEventKey(tournamentId, eventType),
      ),
    );

    final tournamentDetails = ref.watch(tournamentDetailProvider(tournamentId));
    final format = tournamentDetails.asData?.value?.tournament.format;
    final showFixtures = format == TournamentFormat.roundRobin ||
        format == TournamentFormat.knockout ||
        format == TournamentFormat.groupKnockout;

    return asyncParticipants.when(
      data: (participants) {
        return Column(
          children: [
            if (showFixtures)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) {
                            if (format == TournamentFormat.groupKnockout) {
                              return GroupKnockoutOverviewScreen(
                                tournamentId: tournamentId,
                                eventType: eventType,
                              );
                            }
                            return FixtureListScreen(
                              tournamentId: tournamentId,
                              eventType: eventType,
                            );
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.schedule),
                    label: const Text('Manage fixtures'),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: () => _onRegister(context, participants),
                  icon: const Icon(Icons.person_add),
                  label: Text(_registerLabel),
                ),
              ),
            ),
            Expanded(
              child: participants.isEmpty
                  ? const Center(child: Text('No participants registered yet.'))
                  : ListView.separated(
                      itemCount: participants.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = participants[index];
                        final subtitleParts = <String>[
                          if (item.participant.withdrawn) 'Withdrawn',
                          if (item.participant.seed != null)
                            'Seed ${item.participant.seed}',
                        ];
                        return ListTile(
                          title: Text(item.displayName),
                          subtitle: Text(
                            subtitleParts.isEmpty
                                ? 'Tap menu for actions'
                                : subtitleParts.join(' · '),
                          ),
                          onTap: item.participant.participantType ==
                                      ParticipantType.competitionTeam &&
                                  item.participant.competitionTeamId != null
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => TeamEventAssignmentScreen(
                                        tournamentParticipantId:
                                            item.participant.id,
                                        competitionTeamId: item
                                            .participant.competitionTeamId!,
                                        teamName: item.displayName,
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) async {
                              final repo =
                                  ref.read(participantRepositoryProvider);
                              try {
                                switch (value) {
                                  case 'withdraw':
                                    await _withdraw(context, ref, item);
                                  case 'reinstate':
                                    await repo.reinstateParticipant(
                                      item.participant.id,
                                    );
                                  case 'seed':
                                    await _editSeed(context, ref, item);
                                  case 'assign':
                                    if (item.participant.competitionTeamId ==
                                        null) {
                                      return;
                                    }
                                    if (!context.mounted) return;
                                    await Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                        builder: (_) =>
                                            TeamEventAssignmentScreen(
                                          tournamentParticipantId:
                                              item.participant.id,
                                          competitionTeamId: item
                                              .participant.competitionTeamId!,
                                          teamName: item.displayName,
                                        ),
                                      ),
                                    );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('$e')),
                                  );
                                }
                              }
                            },
                            itemBuilder: (context) => [
                              if (!item.participant.withdrawn)
                                const PopupMenuItem(
                                  value: 'withdraw',
                                  child: Text('Withdraw'),
                                ),
                              if (item.participant.withdrawn)
                                const PopupMenuItem(
                                  value: 'reinstate',
                                  child: Text('Reinstate'),
                                ),
                              const PopupMenuItem(
                                value: 'seed',
                                child: Text('Set seed'),
                              ),
                              if (item.participant.participantType ==
                                      ParticipantType.competitionTeam &&
                                  item.participant.competitionTeamId != null)
                                const PopupMenuItem(
                                  value: 'assign',
                                  child: Text('Assign events'),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }

  String get _registerLabel {
    switch (eventType) {
      case TournamentEventType.md:
      case TournamentEventType.wd:
      case TournamentEventType.xd:
        return 'Register pair';
      case TournamentEventType.team:
        return 'Register team';
      default:
        return 'Register player';
    }
  }

  Future<void> _onRegister(
    BuildContext context,
    List<RegisteredParticipant> current,
  ) async {
    switch (eventType) {
      case TournamentEventType.md:
      case TournamentEventType.wd:
      case TournamentEventType.xd:
        await showRegisterPairSheet(
          context,
          tournamentId: tournamentId,
          eventType: eventType,
          registeredPairIds: current
              .map((p) => p.participant.individualTeamId)
              .whereType<int>()
              .toSet(),
        );
      case TournamentEventType.team:
        await showRegisterTeamSheet(
          context,
          tournamentId: tournamentId,
          registeredTeamIds: current
              .map((p) => p.participant.competitionTeamId)
              .whereType<int>()
              .toSet(),
        );
      default:
        await showRegisterPlayerSheet(
          context,
          tournamentId: tournamentId,
          eventType: eventType,
          registeredPlayerIds: current
              .map((p) => p.participant.playerId)
              .whereType<int>()
              .toSet(),
        );
    }
  }

  Future<void> _withdraw(
    BuildContext context,
    WidgetRef ref,
    RegisteredParticipant item,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Withdraw participant?'),
        content: Text(
          'Mark ${item.displayName} as withdrawn? They stay on the list, '
          'but ranking points will not be awarded later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref
          .read(participantRepositoryProvider)
          .withdrawParticipant(item.participant.id);
    }
  }

  Future<void> _editSeed(
    BuildContext context,
    WidgetRef ref,
    RegisteredParticipant item,
  ) async {
    final controller = TextEditingController(
      text: item.participant.seed?.toString() ?? '',
    );
    final result = await showDialog<int?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Seed · ${item.displayName}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Seed (blank to clear)',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final raw = controller.text.trim();
              if (raw.isEmpty) {
                Navigator.pop(context, -1);
                return;
              }
              final n = int.tryParse(raw);
              if (n == null || n < 1) return;
              Navigator.pop(context, n);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (result == null) return;
    try {
      await ref.read(participantRepositoryProvider).setParticipantSeed(
            participantId: item.participant.id,
            seed: result == -1 ? null : result,
          );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }
}

Future<void> showRegisterPlayerSheet(
  BuildContext context, {
  required int tournamentId,
  required String eventType,
  required Set<int> registeredPlayerIds,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _RegisterPlayerSheet(
      tournamentId: tournamentId,
      eventType: eventType,
      registeredPlayerIds: registeredPlayerIds,
    ),
  );
}

class _RegisterPlayerSheet extends ConsumerWidget {
  const _RegisterPlayerSheet({
    required this.tournamentId,
    required this.eventType,
    required this.registeredPlayerIds,
  });

  final int tournamentId;
  final String eventType;
  final Set<int> registeredPlayerIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gender = eventType == TournamentEventType.ms
        ? PlayerGender.male
        : PlayerGender.female;
    final asyncPlayers = ref.watch(playersByGenderProvider(gender));

    return SafeArea(
      child: asyncPlayers.when(
        data: (players) {
          final available =
              players.where((p) => !registeredPlayerIds.contains(p.id)).toList();
          if (available.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Text('No eligible players left to register.'),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            itemCount: available.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final player = available[index];
              return ListTile(
                title: Text(player.fullName),
                subtitle: Text(player.clubOrSchool ?? ''),
                onTap: () async {
                  try {
                    await ref.read(participantRepositoryProvider).registerPlayer(
                          tournamentId: tournamentId,
                          eventType: eventType,
                          playerId: player.id,
                        );
                    if (context.mounted) Navigator.pop(context);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$e')),
                      );
                    }
                  }
                },
              );
            },
          );
        },
        loading: () => const Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(24),
          child: Text('$error'),
        ),
      ),
    );
  }
}

Future<void> showRegisterPairSheet(
  BuildContext context, {
  required int tournamentId,
  required String eventType,
  required Set<int> registeredPairIds,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _RegisterPairSheet(
      tournamentId: tournamentId,
      eventType: eventType,
      registeredPairIds: registeredPairIds,
    ),
  );
}

class _RegisterPairSheet extends ConsumerWidget {
  const _RegisterPairSheet({
    required this.tournamentId,
    required this.eventType,
    required this.registeredPairIds,
  });

  final int tournamentId;
  final String eventType;
  final Set<int> registeredPairIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPairs = ref.watch(pairsByEventTypeProvider(eventType));

    return SafeArea(
      child: asyncPairs.when(
        data: (pairs) {
          final available =
              pairs.where((p) => !registeredPairIds.contains(p.pair.id)).toList();
          if (available.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Text('No matching pairs left to register.'),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            itemCount: available.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = available[index];
              return ListTile(
                title: Text(
                  '${item.player1.fullName} / ${item.player2.fullName}',
                ),
                onTap: () async {
                  try {
                    await ref.read(participantRepositoryProvider).registerPair(
                          tournamentId: tournamentId,
                          eventType: eventType,
                          individualTeamId: item.pair.id,
                        );
                    if (context.mounted) Navigator.pop(context);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$e')),
                      );
                    }
                  }
                },
              );
            },
          );
        },
        loading: () => const Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(24),
          child: Text('$error'),
        ),
      ),
    );
  }
}

Future<void> showRegisterTeamSheet(
  BuildContext context, {
  required int tournamentId,
  required Set<int> registeredTeamIds,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _RegisterTeamSheet(
      tournamentId: tournamentId,
      registeredTeamIds: registeredTeamIds,
    ),
  );
}

class _RegisterTeamSheet extends ConsumerWidget {
  const _RegisterTeamSheet({
    required this.tournamentId,
    required this.registeredTeamIds,
  });

  final int tournamentId;
  final Set<int> registeredTeamIds;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTeams = ref.watch(competitionTeamsProvider);

    return SafeArea(
      child: asyncTeams.when(
        data: (teams) {
          final available =
              teams.where((t) => !registeredTeamIds.contains(t.team.id)).toList();
          if (available.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Text('No competition teams left to register.'),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            itemCount: available.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = available[index];
              return ListTile(
                title: Text(item.team.teamName),
                subtitle: Text(
                  '${item.memberCount} ${item.memberCount == 1 ? 'member' : 'members'}',
                ),
                onTap: () async {
                  try {
                    await ref
                        .read(participantRepositoryProvider)
                        .registerCompetitionTeam(
                          tournamentId: tournamentId,
                          competitionTeamId: item.team.id,
                        );
                    if (context.mounted) Navigator.pop(context);
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$e')),
                      );
                    }
                  }
                },
              );
            },
          );
        },
        loading: () => const Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(24),
          child: Text('$error'),
        ),
      ),
    );
  }
}
