import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/database.dart';
import '../../../data/repositories/player_repository.dart';
import '../../external_results/screens/player_external_results_screen.dart';
import '../widgets/add_player_sheet.dart';
import '../widgets/player_list_tile.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  return PlayerRepository(ref.watch(databaseProvider));
});

final menPlayersProvider = StreamProvider<List<Player>>((ref) {
  final (men, _) = ref.watch(playerRepositoryProvider).getAllPlayers();
  return men;
});

final womenPlayersProvider = StreamProvider<List<Player>>((ref) {
  final (_, women) = ref.watch(playerRepositoryProvider).getAllPlayers();
  return women;
});

class PlayerListScreen extends ConsumerWidget {
  const PlayerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Player Pool'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Men'),
              Tab(text: 'Women'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _PlayerTab(gender: PlayerGender.male),
            _PlayerTab(gender: PlayerGender.female),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showAddPlayerSheet(context),
          child: const Icon(Icons.person_add),
        ),
      ),
    );
  }
}

class _PlayerTab extends ConsumerWidget {
  const _PlayerTab({required this.gender});

  final String gender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPlayers = gender == PlayerGender.male
        ? ref.watch(menPlayersProvider)
        : ref.watch(womenPlayersProvider);

    return asyncPlayers.when(
      data: (players) {
        if (players.isEmpty) {
          return Center(
            child: Text(
              gender == PlayerGender.male
                  ? 'No men in the pool yet.\nTap + to add a player.'
                  : 'No women in the pool yet.\nTap + to add a player.',
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView.separated(
          itemCount: players.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final player = players[index];
            return PlayerListTile(
              player: player,
              subtitle: _subtitle(player),
              onTap: () => showAddPlayerSheet(context, existing: player),
              onDelete: () => _confirmDelete(context, ref, player),
              onExternal: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        PlayerExternalResultsScreen(player: player),
                  ),
                );
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }

  String _subtitle(Player player) {
    final club = player.clubOrSchool;
    final stats =
        'P ${player.matchesPlayed} · W ${player.matchesWon} · '
        'L ${player.matchesLost} · Titles ${player.titlesWon}';
    if (club == null || club.isEmpty) return stats;
    return '$club · $stats';
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Player player,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete player?'),
        content: Text(
          'Remove ${player.fullName} from the pool?\n\n'
          'If they are on doubles pairs, competition teams, or tournament '
          'entries, related rows may be removed or broken by cascade rules.',
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
      try {
        await ref.read(playerRepositoryProvider).deletePlayer(player.id);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$e')),
          );
        }
      }
    }
  }
}
