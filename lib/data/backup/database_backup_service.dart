import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Copy / restore the offline SQLite file used by Drift.
class DatabaseBackupService {
  static const fileName = 'badminton_manager.sqlite';

  Future<File> databaseFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File(p.join(dir.path, fileName));
  }

  /// Shares a timestamped copy of the DB.
  Future<String> exportBackup() async {
    final source = await databaseFile();
    if (!await source.exists()) {
      throw StateError('No database file found to export yet.');
    }

    final stamp = DateTime.now()
        .toIso8601String()
        .replaceAll(':', '-')
        .split('.')
        .first;
    final outName = 'badminton_backup_$stamp.sqlite';
    final tmp = await getTemporaryDirectory();
    final dest = File(p.join(tmp.path, outName));
    await source.copy(dest.path);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(dest.path)],
        subject: 'Badminton Manager backup',
        text: 'Offline SQLite backup ($outName)',
      ),
    );
    return dest.path;
  }

  /// Picks a .sqlite file and overwrites the live DB.
  /// Caller must restart the app after restore.
  Future<void> restoreBackup() async {
    final result = await FilePicker.pickFiles(
      type: FileType.any,
      allowMultiple: false,
      withData: false,
    );
    if (result == null || result.files.isEmpty) {
      throw StateError('Restore cancelled');
    }
    final path = result.files.single.path;
    if (path == null) {
      throw StateError('Could not read the selected file path');
    }
    if (!path.toLowerCase().endsWith('.sqlite') &&
        !path.toLowerCase().endsWith('.db')) {
      throw StateError('Please choose a .sqlite or .db backup file');
    }

    final source = File(path);
    if (!await source.exists()) {
      throw StateError('Selected backup file was not found');
    }

    final target = await databaseFile();
    if (await target.exists()) {
      await target.delete();
    }
    await source.copy(target.path);
  }
}
