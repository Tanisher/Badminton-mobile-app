import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/database/database.dart';
import '../../../data/repositories/player_repository.dart';
import '../screens/player_list_screen.dart';

Future<void> showAddPlayerSheet(BuildContext context, {Player? existing}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => AddPlayerSheet(existing: existing),
  );
}

class AddPlayerSheet extends ConsumerStatefulWidget {
  const AddPlayerSheet({super.key, this.existing});

  final Player? existing;

  @override
  ConsumerState<AddPlayerSheet> createState() => _AddPlayerSheetState();
}

class _AddPlayerSheetState extends ConsumerState<AddPlayerSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _clubController = TextEditingController();
  final _phoneController = TextEditingController();

  late String _gender;
  DateTime? _dateOfBirth;
  bool _saving = false;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    if (e != null) {
      _nameController.text = e.fullName;
      _clubController.text = e.clubOrSchool ?? '';
      _phoneController.text = e.phoneNumber ?? '';
      _gender = e.gender;
      _dateOfBirth = e.dateOfBirth;
    } else {
      _gender = PlayerGender.male;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _clubController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isEdit ? 'Edit player' : 'Add player',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full name *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                key: ValueKey(_gender),
                initialValue: _gender,
                decoration: const InputDecoration(
                  labelText: 'Gender *',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: PlayerGender.male,
                    child: Text('Male'),
                  ),
                  DropdownMenuItem(
                    value: PlayerGender.female,
                    child: Text('Female'),
                  ),
                ],
                onChanged: (v) {
                  if (v != null) setState(() => _gender = v);
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Date of birth *'),
                subtitle: Text(
                  _dateOfBirth == null
                      ? 'Tap to pick'
                      : DateFormat.yMMMd().format(_dateOfBirth!),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final now = DateTime.now();
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _dateOfBirth ?? DateTime(now.year - 16),
                    firstDate: DateTime(1950),
                    lastDate: now,
                  );
                  if (picked != null) setState(() => _dateOfBirth = picked);
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _clubController,
                decoration: const InputDecoration(
                  labelText: 'Club / school',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
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
                    : Text(_isEdit ? 'Save changes' : 'Add player'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false) || _dateOfBirth == null) {
      if (_dateOfBirth == null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pick a date of birth')),
        );
      }
      return;
    }
    setState(() => _saving = true);
    try {
      final repo = ref.read(playerRepositoryProvider);
      if (_isEdit) {
        await repo.updatePlayer(
          id: widget.existing!.id,
          fullName: _nameController.text,
          gender: _gender,
          dateOfBirth: _dateOfBirth!,
          clubOrSchool: _clubController.text,
          phoneNumber: _phoneController.text,
        );
      } else {
        await repo.addPlayer(
          fullName: _nameController.text,
          gender: _gender,
          dateOfBirth: _dateOfBirth!,
          clubOrSchool: _clubController.text,
          phoneNumber: _phoneController.text,
        );
      }
      if (mounted) Navigator.pop(context);
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
