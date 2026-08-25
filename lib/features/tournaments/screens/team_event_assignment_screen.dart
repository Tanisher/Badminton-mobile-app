import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/database.dart';
import '../../../data/repositories/tournament_repository.dart';
import '../../teams/providers.dart';
import '../participant_providers.dart';

class TeamEventAssignmentScreen extends ConsumerStatefulWidget {
  const TeamEventAssignmentScreen({
    super.key,
    required this.tournamentParticipantId,
    required this.competitionTeamId,
    required this.teamName,
  });

  final int tournamentParticipantId;
  final int competitionTeamId;
  final String teamName;

  @override
  ConsumerState<TeamEventAssignmentScreen> createState() =>
      _TeamEventAssignmentScreenState();
}

class _TeamEventAssignmentScreenState
    extends ConsumerState<TeamEventAssignmentScreen> {
  final Map<int, String?> _overrides = {};
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final rosterAsync =
        ref.watch(competitionTeamDetailProvider(widget.competitionTeamId));
    final assignmentsAsync =
        ref.watch(teamAssignmentsProvider(widget.tournamentParticipantId));

    return Scaffold(
      appBar: AppBar(title: Text(widget.teamName)),
      body: rosterAsync.when(
        data: (roster) {
          if (roster == null) {
            return const Center(child: Text('Team not found'));
          }
          return assignmentsAsync.when(
            data: (assignments) {
              final saved = {
                for (final a in assignments)
                  a.player.id: a.assignment.assignedEvent,
              };
              if (roster.members.isEmpty) {
                return const Center(
                  child: Text('This team has no roster members yet.'),
                );
              }

              // Effective assigned events for each roster member, combining
              // persisted values with in-progress overrides from dropdowns.
              String? effectiveEventFor(int playerId) {
                if (_overrides.containsKey(playerId)) {
                  return _overrides[playerId];
                }
                return saved[playerId];
              }

              final assignmentByPlayerId = {
                for (final a in assignments) a.player.id: a,
              };
              final partnerNameByPlayerId = <int, String>{};
              for (final a in assignments) {
                final partnerId = a.assignment.partnerAssignmentId;
                if (partnerId == null) continue;
                for (final other in assignments) {
                  if (other.assignment.id == partnerId) {
                    partnerNameByPlayerId[a.player.id] = other.player.fullName;
                    break;
                  }
                }
              }

              final mdMembers = roster.members
                  .where(
                    (m) => effectiveEventFor(m.id) == TournamentEventType.md,
                  )
                  .toList();
              final wdMembers = roster.members
                  .where(
                    (m) => effectiveEventFor(m.id) == TournamentEventType.wd,
                  )
                  .toList();
              final xdMembers = roster.members
                  .where(
                    (m) => effectiveEventFor(m.id) == TournamentEventType.xd,
                  )
                  .toList();
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'Assign each member to the event they will play '
                      'for this tournament.',
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: roster.members.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final player = roster.members[index];
                        final value = _overrides.containsKey(player.id)
                            ? _overrides[player.id]
                            : saved[player.id];
                        final partner = partnerNameByPlayerId[player.id];
                        final assignment = assignmentByPlayerId[player.id];
                        return ListTile(
                          title: Text(player.fullName),
                          subtitle: Text(
                            [
                              player.gender,
                              if (partner != null) 'Paired with $partner',
                            ].join(' · '),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (assignment?.assignment.partnerAssignmentId !=
                                  null)
                                IconButton(
                                  tooltip: 'Unpair',
                                  icon: const Icon(Icons.link_off),
                                  onPressed: () async {
                                    try {
                                      await ref
                                          .read(participantRepositoryProvider)
                                          .unpairTeamMembers(
                                            assignment!.assignment.id,
                                          );
                                    } catch (e) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text('$e')),
                                        );
                                      }
                                    }
                                  },
                                ),
                              DropdownButton<String?>(
                                value: value,
                                hint: const Text('Event'),
                                items: [
                                  const DropdownMenuItem<String?>(
                                    value: null,
                                    child: Text('Unassigned'),
                                  ),
                                  ...TournamentEventType.individualEvents.map(
                                    (event) => DropdownMenuItem<String?>(
                                      value: event,
                                      child: Text(event),
                                    ),
                                  ),
                                ],
                                onChanged: (next) {
                                  setState(() => _overrides[player.id] = next);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                if (mdMembers.length >= 2 ||
                    wdMembers.length >= 2 ||
                    xdMembers.length >= 2)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.end,
                      children: [
                        if (mdMembers.length >= 2)
                          FilledButton.tonal(
                            onPressed: () => _pairDoublesEvent(
                              context,
                              ref,
                              mdMembers,
                              TournamentEventType.md,
                            ),
                            child: const Text('Pair MD'),
                          ),
                        if (wdMembers.length >= 2)
                          FilledButton.tonal(
                            onPressed: () => _pairDoublesEvent(
                              context,
                              ref,
                              wdMembers,
                              TournamentEventType.wd,
                            ),
                            child: const Text('Pair WD'),
                          ),
                        if (xdMembers.length >= 2)
                          FilledButton.tonal(
                            onPressed: () => _pairDoublesEvent(
                              context,
                              ref,
                              xdMembers,
                              TournamentEventType.xd,
                            ),
                            child: const Text('Pair XD'),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FilledButton(
                      onPressed: _saving
                          ? null
                          : () => _save(roster.members, saved),
                      child: _saving
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Save assignments'),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('$error')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
      ),
    );
  }

  Future<void> _pairDoublesEvent(
    BuildContext context,
    WidgetRef ref,
    List<Player> eligibleMembers,
    String eventType,
  ) async {
    if (eligibleMembers.length < 2) return;

    final selection = await showDialog<({int aId, int bId})>(
      context: context,
      builder: (dialogContext) {
        int? aId = eligibleMembers.first.id;
        int? bId =
            eligibleMembers.length > 1 ? eligibleMembers[1].id : null;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Pick a pair for $eventType'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<int>(
                    value: aId,
                    isExpanded: true,
                    items: eligibleMembers
                        .map(
                          (m) => DropdownMenuItem<int>(
                            value: m.id,
                            child: Text(m.fullName),
                          ),
                        )
                        .toList(),
                    onChanged: (next) {
                      setState(() {
                        aId = next;
                        if (bId == next) {
                          bId = null;
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButton<int>(
                    value: bId,
                    isExpanded: true,
                    items: eligibleMembers
                        .where((m) => m.id != aId)
                        .map(
                          (m) => DropdownMenuItem<int>(
                            value: m.id,
                            child: Text(m.fullName),
                          ),
                        )
                        .toList(),
                    hint: const Text('Select partner'),
                    onChanged: (next) => setState(() => bId = next),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, null),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: (aId != null && bId != null)
                      ? () => Navigator.pop(
                            dialogContext,
                            (aId: aId!, bId: bId!),
                          )
                      : null,
                  child: const Text('Pair'),
                ),
              ],
            );
          },
        );
      },
    );

    if (selection == null) return;

    try {
      final repo = ref.read(participantRepositoryProvider);

      final assignmentId1 = await repo.assignTeamMember(
        tournamentParticipantId: widget.tournamentParticipantId,
        playerId: selection.aId,
        assignedEvent: eventType,
      );
      final assignmentId2 = await repo.assignTeamMember(
        tournamentParticipantId: widget.tournamentParticipantId,
        playerId: selection.bId,
        assignedEvent: eventType,
      );

      await repo.pairTeamMembers(assignmentId1, assignmentId2);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pair saved')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }

  Future<void> _save(List<Player> members, Map<int, String> saved) async {
    setState(() => _saving = true);
    try {
      final repo = ref.read(participantRepositoryProvider);
      for (final member in members) {
        final event = _overrides.containsKey(member.id)
            ? _overrides[member.id]
            : saved[member.id];
        if (event == null) continue;
        await repo.assignTeamMember(
          tournamentParticipantId: widget.tournamentParticipantId,
          playerId: member.id,
          assignedEvent: event,
        );
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assignments saved')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
