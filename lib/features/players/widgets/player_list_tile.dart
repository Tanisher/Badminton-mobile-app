import 'package:flutter/material.dart';

import '../../../data/database/database.dart';

class PlayerListTile extends StatelessWidget {
  const PlayerListTile({
    super.key,
    required this.player,
    required this.subtitle,
    this.onTap,
    this.onDelete,
    this.onExternal,
  });

  final Player player;
  final String subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onExternal;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(player.fullName),
      subtitle: Text(subtitle),
      onTap: onTap,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onExternal != null)
            IconButton(
              icon: const Icon(Icons.history_edu_outlined),
              onPressed: onExternal,
              tooltip: 'External results',
            ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
              tooltip: 'Delete',
            ),
        ],
      ),
    );
  }
}
