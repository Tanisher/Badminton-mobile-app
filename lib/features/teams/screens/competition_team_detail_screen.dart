import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/database.dart';
import '../providers.dart';

class CompetitionTeamDetailScreen extends ConsumerWidget {
  const CompetitionTeamDetailScreen({super.key, required this.teamId});

  final int teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTeam = ref.watch(competitionTeamDetailProvider(teamId));

    return asyncTeam.when(
      data: (data) {
        if (data == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Team')),
            body: const Center(child: Text('Team not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(data.team.teamName),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'Rename team',
                onPressed: () => _renameTeam(context, ref, data.team),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Delete team',
                onPressed: () =>
                    _confirmDeleteTeam(context, ref, data.team.teamName),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (data.team.clubOrSchool != null &&
                  data.team.clubOrSchool!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text(
                    data.team.clubOrSchool!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  'Roster',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: data.members.isEmpty
                    ? const Center(
                        child: Text('No members yet. Tap + to add a player.'),
                      )
                    : ListView.separated(
                        itemCount: data.members.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final player = data.members[index];
                          final club = player.clubOrSchool;
                          return ListTile(
                            title: Text(player.fullName),
                            subtitle: Text(
                              [
                                player.gender,
                                if (club != null && club.isNotEmpty) club,
                              ].join(' · '),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              tooltip: 'Remove from team',
                              onPressed: () => ref
                                  .read(competitionTeamRepositoryProvider)
                                  .removeMember(
                                    teamId: teamId,
                                    playerId: player.id,
                                  ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _pickPlayerToAdd(context, ref, data.members),
            child: const Icon(Icons.person_add),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Team')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Team')),
        body: Center(child: Text('Error: $error')),
      ),
    );
  }

  Future<void> _pickPlayerToAdd(
    BuildContext context,
    WidgetRef ref,
    List<Player> currentMembers,
  ) async {
    final memberIds = currentMembers.map((p) => p.id).toSet();
    final players = await ref.read(allPlayersProvider.future);
    final available = players.where((p) => !memberIds.contains(p.id)).toList();

    if (!context.mounted) return;

    if (available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Every player in the pool is already on this team'),
        ),
      );
      return;
    }

    final selected = await showModalBottomSheet<Player>(
      context: context,
      builder: (context) {
        return ListView.separated(
          itemCount: available.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final player = available[index];
            return ListTile(
              title: Text(player.fullName),
              subtitle: Text(player.gender),
              onTap: () => Navigator.pop(context, player),
            );
          },
        );
      },
    );

    if (selected == null) return;

    try {
      await ref.read(competitionTeamRepositoryProvider).addMember(
            teamId: teamId,
            playerId: selected.id,
          );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }

  Future<void> _confirmDeleteTeam(
    BuildContext context,
    WidgetRef ref,
    String teamName,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete team?'),
        content: Text('Remove $teamName and its roster?'),
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
      await ref.read(competitionTeamRepositoryProvider).deleteTeam(teamId);
      if (context.mounted) Navigator.of(context).pop();
    }
  }

  Future<void> _renameTeam(
    BuildContext context,
    WidgetRef ref,
    CompetitionTeam team,
  ) async {
    final nameCtrl = TextEditingController(text: team.teamName);
    final clubCtrl = TextEditingController(text: team.clubOrSchool ?? '');
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit team'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Team name'),
            ),
            TextField(
              controller: clubCtrl,
              decoration: const InputDecoration(labelText: 'Club / school'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (ok != true) {
      nameCtrl.dispose();
      clubCtrl.dispose();
      return;
    }
    try {
      await ref.read(competitionTeamRepositoryProvider).updateTeam(
            id: team.id,
            teamName: nameCtrl.text,
            clubOrSchool: clubCtrl.text,
          );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    } finally {
      nameCtrl.dispose();
      clubCtrl.dispose();
    }
  }
}
