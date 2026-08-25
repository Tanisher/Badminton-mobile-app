import 'package:flutter/material.dart';

/// Confirm clearing fixtures. Returns true to clear, [force] if completed results
/// may be wiped.
Future<({bool confirmed, bool force})?> confirmClearFixtures(
  BuildContext context, {
  required String title,
  required String body,
  bool mayHaveCompleted = true,
}) async {
  var force = false;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(body),
                if (mayHaveCompleted) ...[
                  const SizedBox(height: 12),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Also delete recorded results'),
                    value: force,
                    onChanged: (v) => setState(() => force = v ?? false),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Clear'),
              ),
            ],
          );
        },
      );
    },
  );
  if (result != true) return null;
  return (confirmed: true, force: force);
}
