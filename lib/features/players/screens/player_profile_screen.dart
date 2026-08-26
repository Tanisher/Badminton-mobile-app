import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/database/database.dart';
import '../../../data/repositories/ranking_repository.dart';
import '../../../data/repositories/tournament_repository.dart';
import '../../publishing/player_profile_pdf.dart';
import '../../rankings/providers.dart';
import '../../teams/providers.dart';
import '../screens/player_list_screen.dart';
import '../widgets/add_player_sheet.dart';

class PlayerProfileScreen extends ConsumerWidget {
  const PlayerProfileScreen({super.key, required this.playerId});

  final int playerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<Player?>(
      future: ref.read(playerRepositoryProvider).getPlayerById(playerId),
      builder: (context, snap) {
        final player = snap.data;
        if (snap.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (player == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Player')),
            body: const Center(child: Text('Player not found')),
          );
        }

        final eligible = SslEligibility.isU19Eligible(player.dateOfBirth);
        final pairsAsync = ref.watch(pairsForPlayerProvider(playerId));
        final msAsync = ref.watch(playerRankingsForEventProvider(TournamentEventType.ms));
        final wsAsync = ref.watch(playerRankingsForEventProvider(TournamentEventType.ws));

        return Scaffold(
          appBar: AppBar(
            title: Text(player.fullName),
            actions: [
              IconButton(
                tooltip: 'Edit',
                icon: const Icon(Icons.edit_outlined),
                onPressed: () =>
                    showAddPlayerSheet(context, existing: player),
              ),
              IconButton(
                tooltip: 'Export PDF',
                icon: const Icon(Icons.picture_as_pdf_outlined),
                onPressed: () async {
                  try {
                    final singles = <PlayerRankingRow>[];
                    final ms = msAsync.asData?.value ?? [];
                    final ws = wsAsync.asData?.value ?? [];
                    for (final r in ms) {
                      if (r.playerId == player.id) singles.add(r);
                    }
                    for (final r in ws) {
                      if (r.playerId == player.id) singles.add(r);
                    }
                    final pairs = pairsAsync.asData?.value ?? [];
                    final lines = pairs
                        .map(
                          (p) =>
                              '${p.pair.eventType}: ${p.player1.fullName} + ${p.player2.fullName}',
                        )
                        .toList();
                    await exportPlayerProfilePdf(
                      player: player,
                      singlesRanks: singles,
                      partnershipLines: lines,
                      matchesPlayed: player.matchesPlayed,
                      matchesWon: player.matchesWon,
                      matchesLost: player.matchesLost,
                      titlesWon: player.titlesWon,
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
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                eligible ? 'U19 eligible' : 'Not U19 eligible',
                style: TextStyle(
                  color: eligible ? Colors.green.shade800 : Colors.red.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text('DOB: ${DateFormat.yMMMd().format(player.dateOfBirth)}'),
              Text('Gender: ${player.gender}'),
              Text('Club: ${player.clubOrSchool ?? '—'}'),
              const SizedBox(height: 16),
              Text('Career', style: Theme.of(context).textTheme.titleMedium),
              Text(
                'P ${player.matchesPlayed} · W ${player.matchesWon} · '
                'L ${player.matchesLost} · Titles ${player.titlesWon}',
              ),
              const SizedBox(height: 16),
              Text(
                'Singles rankings (12 months)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ..._rankLines(player.id, msAsync.asData?.value, 'MS'),
              ..._rankLines(player.id, wsAsync.asData?.value, 'WS'),
              const SizedBox(height: 16),
              Text(
                'Doubles partnerships',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              pairsAsync.when(
                data: (pairs) {
                  if (pairs.isEmpty) {
                    return const Text('No pairs yet.');
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final p in pairs)
                        Text(
                          '${p.pair.eventType}: ${p.player1.fullName} + ${p.player2.fullName}',
                        ),
                    ],
                  );
                },
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text('$e'),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _rankLines(
    int playerId,
    List<PlayerRankingRow>? rows,
    String label,
  ) {
    if (rows == null) return [Text('$label: …')];
    final mine = rows.where((r) => r.playerId == playerId);
    if (mine.isEmpty) return [Text('$label: —')];
    return [
      for (final r in mine) Text('$label: #${r.rank} · ${r.totalPoints} pts'),
    ];
  }
}
