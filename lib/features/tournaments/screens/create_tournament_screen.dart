import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/repositories/tournament_repository.dart';
import '../providers.dart';
import 'tournament_detail_screen.dart';

class CreateTournamentScreen extends ConsumerStatefulWidget {
  const CreateTournamentScreen({super.key});

  @override
  ConsumerState<CreateTournamentScreen> createState() =>
      _CreateTournamentScreenState();
}

class _CreateTournamentScreenState
    extends ConsumerState<CreateTournamentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _venueController = TextEditingController();
  final _tierController = TextEditingController();
  final _courtsController = TextEditingController(text: '1');
  final _groupsController = TextEditingController(text: '2');
  final _qualifiersController = TextEditingController(text: '2');

  DateTime? _date;
  String _category = TournamentCategory.individual;
  String _format = TournamentFormat.knockout;
  String _knockoutStartStage = KnockoutStartStage.quarterfinal;
  final Set<String> _selectedEvents = {};
  bool _hasBronzeMedalMatch = true;
  bool _saving = false;
  bool _triedSubmit = false;

  @override
  void dispose() {
    _nameController.dispose();
    _venueController.dispose();
    _tierController.dispose();
    _courtsController.dispose();
    _groupsController.dispose();
    _qualifiersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New tournament')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Name *',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            InputDecorator(
              decoration: InputDecoration(
                labelText: 'Date *',
                border: const OutlineInputBorder(),
                errorText: _triedSubmit && _date == null
                    ? 'Date is required'
                    : null,
              ),
              child: InkWell(
                onTap: _pickDate,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    _date == null
                        ? 'Tap to select'
                        : DateFormat.yMMMd().format(_date!),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _venueController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Venue',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _tierController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Tier *',
                hintText: 'e.g. Tier 1',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Tier is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _courtsController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Number of courts *',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                final courts = int.tryParse(value ?? '');
                if (courts == null || courts < 1) {
                  return 'Enter at least 1 court';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text('Category', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: TournamentCategory.individual,
                  label: Text('Individual'),
                ),
                ButtonSegment(
                  value: TournamentCategory.team,
                  label: Text('Team'),
                ),
              ],
              selected: {_category},
              onSelectionChanged: (selected) {
                setState(() {
                  _category = selected.first;
                  _syncEventsForCategory();
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Events', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (_category == TournamentCategory.team)
              const CheckboxListTile(
                value: true,
                onChanged: null,
                title: Text('Team Event'),
                subtitle: Text('Team tournaments run as one TEAM event'),
                contentPadding: EdgeInsets.zero,
              )
            else
              ...TournamentEventType.individualEvents.map((event) {
                return CheckboxListTile(
                  value: _selectedEvents.contains(event),
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    '${TournamentEventType.label(event)} ($event)',
                  ),
                  onChanged: (checked) {
                    setState(() {
                      if (checked == true) {
                        _selectedEvents.add(event);
                      } else {
                        _selectedEvents.remove(event);
                      }
                    });
                  },
                );
              }),
            if (_triedSubmit && _effectiveEvents.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Select at least one event',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Text('Format', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _format,
              decoration: const InputDecoration(
                labelText: 'Format *',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: TournamentFormat.knockout,
                  child: Text('Knockout'),
                ),
                DropdownMenuItem(
                  value: TournamentFormat.roundRobin,
                  child: Text('Round Robin'),
                ),
                DropdownMenuItem(
                  value: TournamentFormat.groupKnockout,
                  child: Text('Group + Knockout'),
                ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _format = value);
              },
            ),
            if (_format == TournamentFormat.groupKnockout) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _groupsController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Number of groups *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (_format != TournamentFormat.groupKnockout) return null;
                  final groups = int.tryParse(value ?? '');
                  if (groups == null || groups < 1) {
                    return 'Enter at least 1 group';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _qualifiersController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Qualifiers per group *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (_format != TournamentFormat.groupKnockout) return null;
                  final q = int.tryParse(value ?? '');
                  if (q == null || q < 1) {
                    return 'Enter at least 1 qualifier per group';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _knockoutStartStage,
                decoration: const InputDecoration(
                  labelText: 'Knockout starting stage *',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: KnockoutStartStage.quarterfinal,
                    child: Text('Quarterfinal'),
                  ),
                  DropdownMenuItem(
                    value: KnockoutStartStage.semifinal,
                    child: Text('Semifinal'),
                  ),
                  DropdownMenuItem(
                    value: KnockoutStartStage.final_,
                    child: Text('Final'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _knockoutStartStage = value);
                  }
                },
              ),
            ],
            const SizedBox(height: 8),
            if (_format != TournamentFormat.roundRobin)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Bronze medal match'),
                subtitle: const Text(
                  'Play a 3rd-place match after the semifinals',
                ),
                value: _hasBronzeMedalMatch,
                onChanged: (value) {
                  setState(() => _hasBronzeMedalMatch = value);
                },
              ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Create tournament'),
            ),
          ],
        ),
      ),
    );
  }

  List<String> get _effectiveEvents {
    if (_category == TournamentCategory.team) {
      return [TournamentEventType.team];
    }
    return _selectedEvents.toList();
  }

  void _syncEventsForCategory() {
    if (_category == TournamentCategory.team) {
      _selectedEvents
        ..clear()
        ..add(TournamentEventType.team);
    } else {
      _selectedEvents.remove(TournamentEventType.team);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    setState(() => _triedSubmit = true);
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid || _date == null || _effectiveEvents.isEmpty) {
      setState(() {});
      return;
    }

    setState(() => _saving = true);
    try {
      final id = await ref.read(tournamentRepositoryProvider).createTournament(
            name: _nameController.text,
            date: _date!,
            venue: _venueController.text,
            tier: _tierController.text,
            category: _category,
            format: _format,
            numberOfCourts: int.parse(_courtsController.text),
            hasBronzeMedalMatch: _hasBronzeMedalMatch,
            selectedEvents: _effectiveEvents,
            groupKnockoutSettings: _format == TournamentFormat.groupKnockout
                ? GroupKnockoutSettingsInput(
                    numberOfGroups: int.parse(_groupsController.text),
                    knockoutStartStage: _knockoutStartStage,
                    qualifiersPerGroup: int.parse(_qualifiersController.text),
                  )
                : null,
          );

      if (!mounted) return;
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => TournamentDetailScreen(tournamentId: id),
        ),
      );
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
