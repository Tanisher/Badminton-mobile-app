import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/repositories/tournament_repository.dart';
import '../providers.dart';
import 'external_result_form_screen.dart';

class ExternalResultListScreen extends ConsumerWidget {
  const ExternalResultListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncResults = ref.watch(allExternalResultsProvider);
    final dateFormat = DateFormat.yMMMd();

    return Scaffold(
      appBar: AppBar(title: const Text('External Results')),
      body: asyncResults.when(
        data: (results) {
          if (results.isEmpty) {
            return const Center(
              child: Text(
                'No external results yet.\nTap + to record points from an outside tournament.',
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.separated(
            itemCount: results.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = results[index];
              final r = item.result;
              return ListTile(
                title: Text('${item.playerName} · ${r.tournamentName}'),
                subtitle: Text(
                  '${TournamentEventType.label(r.eventType)} · '
                  '${r.stageReached} · ${r.rankingPointsAwarded} pts\n'
                  '${dateFormat.format(r.date)}'
                  '${r.partnerName != null ? ' · with ${r.partnerName}' : ''}',
                ),
                isThreeLine: true,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          ExternalResultFormScreen(existing: item),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const ExternalResultFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
