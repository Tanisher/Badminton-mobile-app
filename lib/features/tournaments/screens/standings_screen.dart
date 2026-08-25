import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../fixture_providers.dart';
import '../participant_providers.dart';

class StandingsScreen extends ConsumerWidget {
  const StandingsScreen({
    super.key,
    required this.tournamentId,
    required this.eventType,
    this.groupId,
  });

  final int tournamentId;
  final String eventType;

  /// When set, standings are scoped to this group (group+knockout phase 1).
  final int? groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStandings = groupId == null
        ? ref.watch(
            standingsForEventProvider(
              TournamentEventKey(tournamentId, eventType),
            ),
          )
        : ref.watch(
            groupStandingsProvider(
              GroupStandingsKey(tournamentId, eventType, groupId!),
            ),
          );

    return asyncStandings.when(
      data: (rows) {
        if (rows.isEmpty) {
          return const Center(child: Text('No standings yet.'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('#')),
              DataColumn(label: Text('Participant')),
              DataColumn(label: Text('Played')),
              DataColumn(label: Text('Won')),
              DataColumn(label: Text('Lost')),
            ],
            rows: rows
                .map(
                  (r) => DataRow(
                    cells: [
                      DataCell(Text('${r.position}')),
                      DataCell(Text(r.participantDisplayName)),
                      DataCell(Text('${r.played}')),
                      DataCell(Text('${r.won}')),
                      DataCell(Text('${r.lost}')),
                    ],
                  ),
                )
                .toList(),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}
