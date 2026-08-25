import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/fixture_repository.dart';
import '../fixture_providers.dart';

class ScoreEntryScreen extends ConsumerStatefulWidget {
  const ScoreEntryScreen({
    super.key,
    required this.fixtureId,
    required this.isCompleted,
  });

  final int fixtureId;
  final bool isCompleted;

  @override
  ConsumerState<ScoreEntryScreen> createState() => _ScoreEntryScreenState();
}

class _ScoreEntryScreenState extends ConsumerState<ScoreEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<_SetRow> _rows = [
    _SetRow(),
    _SetRow(),
  ];
  bool _saving = false;
  bool _hydrated = false;

  @override
  void dispose() {
    for (final row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncEntry = ref.watch(fixtureScoreEntryProvider(widget.fixtureId));

    return asyncEntry.when(
      data: (entry) {
        if (entry == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Score entry')),
            body: const Center(child: Text('Fixture not found')),
          );
        }

        _hydrateIfNeeded(entry);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.isCompleted ? 'Edit result' : 'Enter result',
            ),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  '${entry.participant1DisplayName} vs ${entry.participant2DisplayName}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                for (int i = 0; i < _rows.length; i++) ...[
                  Text(
                    'Set ${i + 1}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _rows[i].p1Controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'P1 score',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Required';
                            }
                            final a = int.tryParse(_rows[i].p1Controller.text);
                            final b = int.tryParse(_rows[i].p2Controller.text);
                            if (a != null && b != null && a == b) {
                              return 'No draws';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _rows[i].p2Controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'P2 score',
                            border: OutlineInputBorder(),
                            helperText: 'Typical badminton: 21, win by 2',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Required';
                            }
                            final a = int.tryParse(_rows[i].p1Controller.text);
                            final b = int.tryParse(value);
                            if (a != null && b != null && a == b) {
                              return 'No draws';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
                if (_rows.length < 3)
                  OutlinedButton.icon(
                    onPressed: () => setState(() => _rows.add(_SetRow())),
                    icon: const Icon(Icons.add),
                    label: const Text('Add set'),
                  ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _saving ? null : () => _save(entry),
                  child: _saving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          widget.isCompleted ? 'Save changes' : 'Save result',
                        ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Score entry')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Score entry')),
        body: Center(child: Text('Error: $error')),
      ),
    );
  }

  void _hydrateIfNeeded(FixtureScoreEntry entry) {
    if (_hydrated) return;
    if (entry.sets.isNotEmpty) {
      for (final row in _rows) {
        row.dispose();
      }
      _rows
        ..clear()
        ..addAll(
          entry.sets.map((s) {
            final row = _SetRow();
            row.p1Controller.text = '${s.participant1Score}';
            row.p2Controller.text = '${s.participant2Score}';
            return row;
          }),
        );
      while (_rows.length < 2) {
        _rows.add(_SetRow());
      }
    }
    _hydrated = true;
  }

  Future<void> _save(FixtureScoreEntry entry) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final sets = <SetScore>[];
    for (final row in _rows) {
      final p1Text = row.p1Controller.text.trim();
      final p2Text = row.p2Controller.text.trim();
      if (p1Text.isEmpty && p2Text.isEmpty) continue;

      final p1 = int.tryParse(p1Text);
      final p2 = int.tryParse(p2Text);
      if (p1 == null || p2 == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter valid scores for each set')),
        );
        return;
      }
      if (p1 == p2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Set scores cannot be tied')),
        );
        return;
      }
      sets.add(SetScore(participant1Score: p1, participant2Score: p2));
    }

    if (sets.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter at least one set score')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      final repo = ref.read(fixtureRepositoryProvider);
      if (widget.isCompleted || entry.status == 'completed') {
        await repo.editResult(fixtureId: widget.fixtureId, sets: sets);
      } else {
        await repo.recordResult(fixtureId: widget.fixtureId, sets: sets);
      }
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

class _SetRow {
  final TextEditingController p1Controller = TextEditingController();
  final TextEditingController p2Controller = TextEditingController();

  void dispose() {
    p1Controller.dispose();
    p2Controller.dispose();
  }
}
