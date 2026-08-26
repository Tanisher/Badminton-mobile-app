import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../data/backup/database_backup_service.dart';
import '../external_results/screens/external_result_list_screen.dart';
import '../players/screens/player_list_screen.dart';
import '../rankings/screens/rankings_screen.dart';
import '../teams/screens/competition_teams_screen.dart';
import '../teams/screens/individual_teams_screen.dart';
import '../tournaments/screens/tournament_list_screen.dart';
import 'landing_home_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  /// Space reserved so AppBar [actions] sit left of the floating ⋯ control.
  static const double _shellMenuClearance = 52;

  int _index = 0;
  final _backup = DatabaseBackupService();

  void _go(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final pages = [
      LandingHomeScreen(
        onOpenPlayers: () => _go(1),
        onOpenTournaments: () => _go(4),
      ),
      const PlayerListScreen(),
      const IndividualTeamsScreen(),
      const CompetitionTeamsScreen(),
      const TournamentListScreen(),
      const RankingsScreen(),
      const ExternalResultListScreen(),
    ];

    final onLanding = _index == 0;

    return CourtBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        endDrawer: Drawer(
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Super Smash League Manager',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Offline data tools',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primary.withValues(alpha: 0.65),
                      ),
                ),
                const SizedBox(height: 24),
                ListTile(
                  leading: const Icon(Icons.upload_file_outlined),
                  title: const Text('Export SQLite backup'),
                  onTap: () {
                    Navigator.pop(context);
                    _export();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.download_outlined),
                  title: const Text('Restore from backup'),
                  onTap: () {
                    Navigator.pop(context);
                    _restore();
                  },
                ),
              ],
            ),
          ),
        ),
        // Floating backup control sits over the top-right of tab roots.
        // Reserve AppBar action space so PDF/edit icons stay clickable.
        body: Stack(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                appBarTheme: Theme.of(context).appBarTheme.copyWith(
                  actionsPadding: const EdgeInsets.only(right: _shellMenuClearance),
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: KeyedSubtree(
                  key: ValueKey(_index),
                  child: pages[_index],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.paddingOf(context).top + 4,
              right: 8,
              child: Builder(
                builder: (context) => IconButton(
                  tooltip: 'Data & backup',
                  style: IconButton.styleFrom(
                    backgroundColor: onLanding
                        ? Colors.white.withValues(alpha: 0.35)
                        : Colors.white.withValues(alpha: 0.85),
                    foregroundColor: AppTheme.ink,
                  ),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: const Icon(Icons.more_horiz),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: _go,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people),
              label: 'Players',
            ),
            NavigationDestination(
              icon: Icon(Icons.sports_tennis_outlined),
              selectedIcon: Icon(Icons.sports_tennis),
              label: 'Doubles',
            ),
            NavigationDestination(
              icon: Icon(Icons.groups_outlined),
              selectedIcon: Icon(Icons.groups),
              label: 'Teams',
            ),
            NavigationDestination(
              icon: Icon(Icons.emoji_events_outlined),
              selectedIcon: Icon(Icons.emoji_events),
              label: 'Events',
            ),
            NavigationDestination(
              icon: Icon(Icons.leaderboard_outlined),
              selectedIcon: Icon(Icons.leaderboard),
              label: 'Ranks',
            ),
            NavigationDestination(
              icon: Icon(Icons.history_edu_outlined),
              selectedIcon: Icon(Icons.history_edu),
              label: 'Ext',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _export() async {
    try {
      await _backup.exportBackup();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup ready to share')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  Future<void> _restore() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore backup?'),
        content: const Text(
          'This replaces the current database. Restart the app after restore.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Restore'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await _backup.restoreBackup();
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Restore complete'),
          content: const Text(
            'Force-close and reopen the app so it loads the restored database.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      final msg = '$e';
      if (msg.contains('cancelled') || msg.contains('Cancel')) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }
}
