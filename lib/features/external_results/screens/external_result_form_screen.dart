import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/repositories/external_result_repository.dart';
import '../../../data/repositories/tournament_repository.dart';
import '../providers.dart';
import '../widgets/player_picker_sheet.dart';

class ExternalResultFormScreen extends ConsumerStatefulWidget {
  const ExternalResultFormScreen({
    super.key,
    this.existing,
    this.initialPlayerId,
    this.initialPlayerName,
  });

  final ExternalResultView? existing;
  final int? initialPlayerId;
  final String? initialPlayerName;

  @override
  ConsumerState<ExternalResultFormScreen> createState() =>
      _ExternalResultFormScreenState();
}

class _ExternalResultFormScreenState
    extends ConsumerState<ExternalResultFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tournamentName = TextEditingController();
  final _organiser = TextEditingController();
  final _partnerName = TextEditingController();
  final _stageReached = TextEditingController();
  final _points = TextEditingController();

  int? _playerId;
  String? _playerName;
  DateTime? _date;
  String _eventType = TournamentEventType.ms;
  bool _saving = false;
  bool _tried = false;

  bool get _isEdit => widget.existing != null;

  bool get _showPartner {
    return _eventType == TournamentEventType.md ||
        _eventType == TournamentEventType.wd ||
        _eventType == TournamentEventType.xd ||
        _eventType == TournamentEventType.team;
  }

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    if (existing != null) {
      final r = existing.result;
      _tournamentName.text = r.tournamentName;
      _organiser.text = r.tournamentOrganiser ?? '';
      _partnerName.text = r.partnerName ?? '';
      _stageReached.text = r.stageReached;
      _points.text = '${r.rankingPointsAwarded}';
      _date = r.date;
      _eventType = r.eventType;
      _playerId = r.playerId;
      _playerName = existing.playerName;
    } else if (widget.initialPlayerId != null) {
      _playerId = widget.initialPlayerId;
      _playerName = widget.initialPlayerName;
    }
  }

  @override
  void dispose() {
    _tournamentName.dispose();
    _organiser.dispose();
    _partnerName.dispose();
    _stageReached.dispose();
    _points.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd();

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit external result' : 'Add external result'),
        actions: [
          if (_isEdit)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _saving ? null : _delete,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Player *'),
              subtitle: Text(_playerName ?? 'Tap to select'),
              trailing: const Icon(Icons.person_search),
              onTap: () async {
                final picked = await showPlayerPickerSheet(context);
                if (picked != null) {
                  setState(() {
                    _playerId = picked.id;
                    _playerName = picked.fullName;
                  });
                }
              },
            ),
            if (_playerId == null && _tried)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Select a player',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _tournamentName,
              decoration: const InputDecoration(
                labelText: 'Tournament name *',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _organiser,
              decoration: const InputDecoration(
                labelText: 'Tournament organiser',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Date *'),
              subtitle: Text(
                _date == null ? 'Tap to pick' : dateFormat.format(_date!),
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            if (_date == null && _tried)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Pick a date',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              key: ValueKey(_eventType),
              initialValue: _eventType,
              decoration: const InputDecoration(
                labelText: 'Event type *',
                border: OutlineInputBorder(),
              ),
              items: [
                for (final e in TournamentEventType.all)
                  DropdownMenuItem(
                    value: e,
                    child: Text(TournamentEventType.label(e)),
                  ),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _eventType = value);
              },
            ),
            if (_showPartner) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _partnerName,
                decoration: const InputDecoration(
                  labelText: 'Partner name (optional)',
                  helperText:
                      'Display only — not linked to a Player Pool entry',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            const SizedBox(height: 12),
            TextFormField(
              controller: _stageReached,
              decoration: const InputDecoration(
                labelText: 'Stage reached *',
                hintText: 'e.g. Winner, Semifinalist',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _points,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Ranking points awarded *',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (int.tryParse(v) == null) return 'Enter a whole number';
                return null;
              },
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isEdit ? 'Save changes' : 'Save result'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(now.year - 30),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    setState(() => _tried = true);
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid || _playerId == null || _date == null) {
      setState(() {});
      return;
    }

    setState(() => _saving = true);
    try {
      final repo = ref.read(externalResultRepositoryProvider);
      if (_isEdit) {
        await repo.updateExternalResult(
          id: widget.existing!.result.id,
          playerId: _playerId!,
          tournamentName: _tournamentName.text,
          tournamentOrganiser: _organiser.text,
          date: _date!,
          eventType: _eventType,
          partnerName: _showPartner ? _partnerName.text : null,
          stageReached: _stageReached.text,
          rankingPointsAwarded: int.parse(_points.text),
        );
      } else {
        await repo.addExternalResult(
          playerId: _playerId!,
          tournamentName: _tournamentName.text,
          tournamentOrganiser: _organiser.text,
          date: _date!,
          eventType: _eventType,
          partnerName: _showPartner ? _partnerName.text : null,
          stageReached: _stageReached.text,
          rankingPointsAwarded: int.parse(_points.text),
        );
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

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete result?'),
        content: const Text('This cannot be undone.'),
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
    if (confirmed != true) return;

    setState(() => _saving = true);
    try {
      await ref
          .read(externalResultRepositoryProvider)
          .deleteExternalResult(widget.existing!.result.id);
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
