import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/repositories/ranking_repository.dart';
import '../../../data/repositories/tournament_repository.dart';
import '../providers.dart';
import '../widgets/event_participants_panel.dart';

class TournamentDetailScreen extends ConsumerWidget {
  const TournamentDetailScreen({super.key, required this.tournamentId});

  final int tournamentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDetails = ref.watch(tournamentDetailProvider(tournamentId));

    return asyncDetails.when(
      data: (details) {
        if (details == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Tournament')),
            body: const Center(child: Text('Tournament not found')),
          );
        }

        final t = details.tournament;
        final settings = details.groupKnockoutSettings;
        final events = [...details.events]..sort(
            (a, b) => TournamentEventType.all
                .indexOf(a.eventType)
                .compareTo(TournamentEventType.all.indexOf(b.eventType)),
          );

        final scaffold = Scaffold(
            appBar: AppBar(
              title: Text(t.name),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Edit tournament',
                  onPressed: () => _editBasics(context, ref, details),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Delete tournament',
                  onPressed: () => _confirmDelete(context, ref, t.name),
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _row('Date', DateFormat.yMMMd().format(t.date)),
                      _row(
                        'Venue',
                        t.venue?.isNotEmpty == true ? t.venue! : '—',
                      ),
                      _row('Tier', t.tier),
                      _row(
                        'Category',
                        TournamentCategory.label(t.category),
                      ),
                      _row('Format', TournamentFormat.label(t.format)),
                      _row('Courts', '${t.numberOfCourts}'),
                      _row(
                        'Bronze medal match',
                        t.format == TournamentFormat.roundRobin
                            ? '${t.hasBronzeMedalMatch ? 'Yes' : 'No'} (ignored for Round Robin)'
                            : (t.hasBronzeMedalMatch ? 'Yes' : 'No'),
                      ),
                      if (settings != null) ...[
                        _row('Groups', '${settings.numberOfGroups}'),
                        _row(
                          'Qualifiers per group',
                          '${settings.qualifiersPerGroup}',
                        ),
                        _row(
                          'Knockout starts at',
                          KnockoutStartStage.label(settings.knockoutStartStage),
                        ),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Text(
                    'Participants',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (events.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('This tournament has no selected events.'),
                  )
                else ...[
                  TabBar(
                    isScrollable: true,
                    tabs: [
                      for (final event in events) Tab(text: event.eventType),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        for (final event in events)
                          EventParticipantsPanel(
                            tournamentId: tournamentId,
                            eventType: event.eventType,
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );

        if (events.isEmpty) return scaffold;
        return DefaultTabController(length: events.length, child: scaffold);
      },
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Tournament')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Tournament')),
        body: Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    String name,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete tournament?'),
        content: Text(
          'Remove $name?\n\n'
          'This deletes the tournament and cascades to events, participants, '
          'groups, fixtures, and related rows.',
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
      await ref.read(tournamentRepositoryProvider).deleteTournament(tournamentId);
      if (context.mounted) Navigator.of(context).pop();
    }
  }

  Future<void> _editBasics(
    BuildContext context,
    WidgetRef ref,
    TournamentDetails details,
  ) async {
    final t = details.tournament;
    final nameCtrl = TextEditingController(text: t.name);
    final venueCtrl = TextEditingController(text: t.venue ?? '');
    final courtsCtrl = TextEditingController(text: '${t.numberOfCourts}');
    var bronze = t.hasBronzeMedalMatch;
    var date = t.date;
    var tier = SslTiers.all.contains(t.tier) ? t.tier : SslTiers.open;

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit tournament'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: venueCtrl,
                      decoration: const InputDecoration(labelText: 'Venue'),
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: tier,
                      decoration: const InputDecoration(labelText: 'Tier'),
                      items: [
                        for (final label in SslTiers.all)
                          DropdownMenuItem(value: label, child: Text(label)),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => tier = v);
                      },
                    ),
                    TextField(
                      controller: courtsCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Courts'),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Date: ${DateFormat.yMMMd().format(date)}',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(date.year - 2),
                          lastDate: DateTime(date.year + 5),
                        );
                        if (picked != null) setState(() => date = picked);
                      },
                    ),
                    if (t.format != TournamentFormat.roundRobin)
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Bronze medal match'),
                        value: bronze,
                        onChanged: (v) => setState(() => bronze = v),
                      ),
                  ],
                ),
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
            );
          },
        );
      },
    );

    if (saved != true) {
      nameCtrl.dispose();
      venueCtrl.dispose();
      courtsCtrl.dispose();
      return;
    }

    try {
      final settings = details.groupKnockoutSettings;
      await ref.read(tournamentRepositoryProvider).updateTournament(
            id: tournamentId,
            name: nameCtrl.text,
            date: date,
            venue: venueCtrl.text,
            tier: tier,
            category: t.category,
            format: t.format,
            numberOfCourts: int.parse(courtsCtrl.text),
            hasBronzeMedalMatch: bronze,
            selectedEvents: details.events.map((e) => e.eventType).toList(),
            groupKnockoutSettings: settings == null
                ? null
                : GroupKnockoutSettingsInput(
                    numberOfGroups: settings.numberOfGroups,
                    knockoutStartStage: settings.knockoutStartStage,
                    qualifiersPerGroup: settings.qualifiersPerGroup,
                  ),
          );
      ref.invalidate(tournamentDetailProvider(tournamentId));
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    } finally {
      nameCtrl.dispose();
      venueCtrl.dispose();
      courtsCtrl.dispose();
    }
  }
}
