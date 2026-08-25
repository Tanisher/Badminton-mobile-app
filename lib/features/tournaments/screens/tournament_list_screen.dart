import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/repositories/tournament_repository.dart';
import '../providers.dart';
import 'create_tournament_screen.dart';
import 'tournament_detail_screen.dart';

class TournamentListScreen extends ConsumerWidget {
  const TournamentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTournaments = ref.watch(tournamentsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tournaments')),
      body: asyncTournaments.when(
        data: (tournaments) {
          if (tournaments.isEmpty) {
            return const Center(
              child: Text(
                'No tournaments yet.\nTap + to create one.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.separated(
            itemCount: tournaments.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final tournament = tournaments[index];
              return ListTile(
                title: Text(tournament.name),
                subtitle: Text(
                  '${DateFormat.yMMMd().format(tournament.date)} · '
                  '${TournamentCategory.label(tournament.category)} · '
                  '${TournamentFormat.label(tournament.format)}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => TournamentDetailScreen(
                        tournamentId: tournament.id,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const CreateTournamentScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
