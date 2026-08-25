import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/database/database.dart';
import '../../../data/repositories/tournament_repository.dart';
import '../providers.dart';
import 'external_result_form_screen.dart';

class PlayerExternalResultsScreen extends ConsumerWidget {
  const PlayerExternalResultsScreen({
    super.key,
    required this.player,
  });

  final Player player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(externalResultsForPlayerProvider(player.id));
    final dateFormat = DateFormat.yMMMd();

    return Scaffold(
      appBar: AppBar(title: Text('${player.fullName} · External')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => ExternalResultFormScreen(
                initialPlayerId: player.id,
                initialPlayerName: player.fullName,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: async.when(
        data: (results) {
          if (results.isEmpty) {
            return const Center(
              child: Text('No external results for this player yet.'),
            );
          }
          return ListView.separated(
            itemCount: results.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = results[index];
              final r = item.result;
              return ListTile(
                title: Text(r.tournamentName),
                subtitle: Text(
                  '${TournamentEventType.label(r.eventType)} · '
                  '${r.stageReached} · ${r.rankingPointsAwarded} pts\n'
                  '${dateFormat.format(r.date)}',
                ),
                isThreeLine: true,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
      ),
    );
  }
}
