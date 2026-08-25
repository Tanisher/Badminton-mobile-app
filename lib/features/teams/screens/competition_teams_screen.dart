import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../widgets/create_competition_team_sheet.dart';
import 'competition_team_detail_screen.dart';

class CompetitionTeamsScreen extends ConsumerWidget {
  const CompetitionTeamsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTeams = ref.watch(competitionTeamsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Competition teams')),
      body: asyncTeams.when(
        data: (teams) {
          if (teams.isEmpty) {
            return const Center(
              child: Text(
                'No competition teams yet.\nTap + to create one.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.separated(
            itemCount: teams.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = teams[index];
              final club = item.team.clubOrSchool;
              final countLabel =
                  '${item.memberCount} ${item.memberCount == 1 ? 'member' : 'members'}';
              return ListTile(
                title: Text(item.team.teamName),
                subtitle: Text(
                  club == null || club.isEmpty ? countLabel : '$club · $countLabel',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => CompetitionTeamDetailScreen(
                        teamId: item.team.id,
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
        onPressed: () => showCreateCompetitionTeamSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
