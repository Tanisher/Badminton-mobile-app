import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/individual_team_repository.dart';
import '../providers.dart';
import '../widgets/create_pair_sheet.dart';

class IndividualTeamsScreen extends StatelessWidget {
  const IndividualTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Doubles pairs'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'MD'),
              Tab(text: 'WD'),
              Tab(text: 'XD'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _PairsTab(eventType: DoublesEventType.md),
            _PairsTab(eventType: DoublesEventType.wd),
            _PairsTab(eventType: DoublesEventType.xd),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showCreatePairSheet(context),
          child: const Icon(Icons.group_add),
        ),
      ),
    );
  }
}

class _PairsTab extends ConsumerWidget {
  const _PairsTab({required this.eventType});

  final String eventType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPairs = ref.watch(pairsByEventTypeProvider(eventType));

    return asyncPairs.when(
      data: (pairs) {
        if (pairs.isEmpty) {
          return Center(
            child: Text(
              'No ${DoublesEventType.label(eventType)} pairs yet.\nTap + to create one.',
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView.separated(
          itemCount: pairs.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final item = pairs[index];
            return ListTile(
              title: Text(
                '${item.player1.fullName} / ${item.player2.fullName}',
              ),
              subtitle: Text(_pairSubtitle(item)),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Delete pair',
                onPressed: () => _confirmDelete(context, ref, item),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }

  String _pairSubtitle(IndividualTeamWithPlayers item) {
    final clubs = [
      item.player1.clubOrSchool,
      item.player2.clubOrSchool,
    ].where((c) => c != null && c.isNotEmpty).join(' · ');
    return clubs.isEmpty ? DoublesEventType.label(eventType) : clubs;
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    IndividualTeamWithPlayers item,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete pair?'),
        content: Text(
          'Remove ${item.player1.fullName} / ${item.player2.fullName}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(individualTeamRepositoryProvider).deletePair(item.pair.id);
    }
  }
}
