import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/tournament_repository.dart';
import '../../publishing/ranking_pdf.dart';
import '../providers.dart';

class RankingsScreen extends ConsumerStatefulWidget {
  const RankingsScreen({super.key});

  @override
  ConsumerState<RankingsScreen> createState() => _RankingsScreenState();
}

class _RankingsScreenState extends ConsumerState<RankingsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  static const _events = TournamentEventType.individualEvents;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: _events.length, vsync: this);
    _tabs.addListener(() {
      if (!_tabs.indexIsChanging) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rankings'),
        actions: [
          IconButton(
            tooltip: 'Export PDF',
            icon: const Icon(Icons.picture_as_pdf_outlined),
            onPressed: () async {
              final event = _events[_tabs.index];
              try {
                await exportRankingsPdf(
                  ref: ref,
                  eventType: event,
                );
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$e')),
                  );
                }
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabs,
          isScrollable: true,
          tabs: [
            for (final e in _events)
              Tab(text: TournamentEventType.label(e)),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text(
              'Rolling 12 months · '
              '${isDoublesEvent(_events[_tabs.index]) ? 'Partnerships' : 'Players'}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                for (final e in _events) _RankingsTab(eventType: e),
              ],
            ),
          ),
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
    if (isDoublesEvent(eventType)) {
      final async = ref.watch(partnershipRankingsForEventProvider(eventType));
      return async.when(
        data: (rows) {
          if (rows.isEmpty) {
            return const Center(
              child: Text(
                'No partnership points yet in the last 12 months.',
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.separated(
            itemCount: rows.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final r = rows[index];
              return ListTile(
                leading: CircleAvatar(child: Text('${r.rank}')),
                title: Text(r.displayName),
                trailing: Text(
                  '${r.totalPoints} pts',
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

    final async = ref.watch(playerRankingsForEventProvider(eventType));
    return async.when(
      data: (rows) {
        if (rows.isEmpty) {
          return const Center(
            child: Text(
              'No ranking points yet in the last 12 months.',
              textAlign: TextAlign.center,
            ),
          );
        }
        return ListView.separated(
          itemCount: rows.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final r = rows[index];
            return ListTile(
              leading: CircleAvatar(child: Text('${r.rank}')),
              title: Text(r.playerName),
              trailing: Text(
                '${r.totalPoints} pts',
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
