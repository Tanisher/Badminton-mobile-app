import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/player_repository.dart';
import '../../../data/repositories/individual_team_repository.dart';
import '../providers.dart';

Future<void> showCreatePairSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => const CreatePairSheet(),
  );
}

class CreatePairSheet extends ConsumerStatefulWidget {
  const CreatePairSheet({super.key});

  @override
  ConsumerState<CreatePairSheet> createState() => _CreatePairSheetState();
}

class _CreatePairSheetState extends ConsumerState<CreatePairSheet> {
  String _eventType = DoublesEventType.md;
  int? _player1Id;
  int? _player2Id;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'New doubles pair',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _eventType,
              decoration: const InputDecoration(
                labelText: 'Event type *',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: DoublesEventType.md,
                  child: Text("Men's Doubles (MD)"),
                ),
                DropdownMenuItem(
                  value: DoublesEventType.wd,
                  child: Text("Women's Doubles (WD)"),
                ),
                DropdownMenuItem(
                  value: DoublesEventType.xd,
                  child: Text('Mixed Doubles (XD)'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _eventType = value;
                  _player1Id = null;
                  _player2Id = null;
                });
              },
            ),
            const SizedBox(height: 12),
            _PlayerDropdown(
              key: ValueKey('p1-$_eventType'),
              label: _player1Label,
              genderFilter: _player1Gender,
              selectedId: _player1Id,
              excludeId: _player2Id,
              onChanged: (id) => setState(() => _player1Id = id),
            ),
            const SizedBox(height: 12),
            _PlayerDropdown(
              key: ValueKey('p2-$_eventType'),
              label: _player2Label,
              genderFilter: _player2Gender,
              selectedId: _player2Id,
              excludeId: _player1Id,
              onChanged: (id) => setState(() => _player2Id = id),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save pair'),
            ),
          ],
        ),
      ),
    );
  }

  String get _player1Label {
    switch (_eventType) {
      case DoublesEventType.xd:
        return 'Male player *';
      default:
        return 'Player 1 *';
    }
  }

  String get _player2Label {
    switch (_eventType) {
      case DoublesEventType.xd:
        return 'Female player *';
      default:
        return 'Player 2 *';
    }
  }

  String get _player1Gender {
    switch (_eventType) {
      case DoublesEventType.wd:
        return PlayerGender.female;
      default:
        return PlayerGender.male;
    }
  }

  String get _player2Gender {
    switch (_eventType) {
      case DoublesEventType.md:
        return PlayerGender.male;
      default:
        return PlayerGender.female;
    }
  }

  Future<void> _save() async {
    if (_player1Id == null || _player2Id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick both players')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      await ref.read(individualTeamRepositoryProvider).createPair(
            player1Id: _player1Id!,
            player2Id: _player2Id!,
            eventType: _eventType,
          );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _PlayerDropdown extends ConsumerWidget {
  const _PlayerDropdown({
    super.key,
    required this.label,
    required this.genderFilter,
    required this.selectedId,
    required this.excludeId,
    required this.onChanged,
  });

  final String label;
  final String genderFilter;
  final int? selectedId;
  final int? excludeId;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPlayers = ref.watch(playersByGenderProvider(genderFilter));

    return asyncPlayers.when(
      data: (players) {
        final options = players.where((p) => p.id != excludeId).toList();
        final value =
            options.any((p) => p.id == selectedId) ? selectedId : null;

        return DropdownButtonFormField<int>(
          initialValue: value,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          items: options
              .map(
                (p) => DropdownMenuItem(
                  value: p.id,
                  child: Text(
                    p.clubOrSchool == null || p.clubOrSchool!.isEmpty
                        ? p.fullName
                        : '${p.fullName} (${p.clubOrSchool})',
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        );
      },
      loading: () => const LinearProgressIndicator(),
      error: (error, _) => Text('Could not load players: $error'),
    );
  }
}
