import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/tournament_repository.dart';
import '../providers.dart';

class RankingsScreen extends ConsumerStatefulWidget {
  const RankingsScreen({super.key});

  @override
  ConsumerState<RankingsScreen> createState() => _RankingsScreenState();
}

class _RankingsScreenState extends ConsumerState<RankingsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const _events = TournamentEventType.individualEvents;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _events.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rankings'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            for (final e in _events) Tab(text: e),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (final e in _events) _RankingsTab(eventType: e),
        ],
      ),
    );
  }
}

class _RankingsTab extends ConsumerWidget {
  const _RankingsTab({required this.eventType});

  final String eventType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRankings = ref.watch(rankingsForEventProvider(eventType));

    return asyncRankings.when(
      data: (rows) {
        if (rows.isEmpty) {
          return Center(
            child: Text(
              'No ${TournamentEventType.label(eventType)} ranking points yet.\n'
              'Complete fixtures or add external results.',
              textAlign: TextAlign.center,
            ),
          );
        }
        return ListView.separated(
          itemCount: rows.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final row = rows[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text('${row.rank}'),
              ),
              title: Text(row.playerName),
              trailing: Text(
                '${row.totalPoints} pts',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
    );
  }
}
