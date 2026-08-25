import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/database.dart';
import '../../players/screens/player_list_screen.dart';

/// Searchable player picker — same pattern as Teams roster add, with a filter.
Future<Player?> showPlayerPickerSheet(BuildContext context) {
  return showModalBottomSheet<Player>(
    context: context,
    isScrollControlled: true,
    builder: (context) => const _PlayerPickerSheet(),
  );
}

class _PlayerPickerSheet extends ConsumerStatefulWidget {
  const _PlayerPickerSheet();

  @override
  ConsumerState<_PlayerPickerSheet> createState() => _PlayerPickerSheetState();
}

class _PlayerPickerSheetState extends ConsumerState<_PlayerPickerSheet> {
  final _filter = TextEditingController();

  @override
  void dispose() {
    _filter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menAsync = ref.watch(menPlayersProvider);
    final womenAsync = ref.watch(womenPlayersProvider);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            children: [
              Text('Select player', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              TextField(
                controller: _filter,
                decoration: const InputDecoration(
                  hintText: 'Search by name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: menAsync.when(
                  data: (men) => womenAsync.when(
                    data: (women) {
                      final q = _filter.text.trim().toLowerCase();
                      final all = [...men, ...women]
                        ..sort((a, b) => a.fullName.compareTo(b.fullName));
                      final filtered = q.isEmpty
                          ? all
                          : all
                              .where(
                                (p) => p.fullName.toLowerCase().contains(q),
                              )
                              .toList();
                      if (filtered.isEmpty) {
                        return const Center(child: Text('No players found'));
                      }
                      return ListView.separated(
                        controller: scrollController,
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final player = filtered[index];
                          return ListTile(
                            title: Text(player.fullName),
                            subtitle: Text(player.gender),
                            onTap: () => Navigator.pop(context, player),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('$e')),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('$e')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
