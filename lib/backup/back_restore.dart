import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future<void> backupDatabase() async {
  // Get the current database directory
  final dbDirectory = await getApplicationDocumentsDirectory();

  // Create a backup directory inside the app's documents directory
  final backupDirectoryPath = path.join(dbDirectory.path, 'backup');
  final backupDirectory = Directory(backupDirectoryPath);
  if (!await backupDirectory.exists()) {
    await backupDirectory.create();
  }

  // Copy the current database file to the backup directory with a timestamp suffix
  final currentDbFile = File(path.join(dbDirectory.path, 'hive.box'));
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  final backupDbFileName = 'hive_$timestamp.box';
  final backupDbFilePath = path.join(backupDirectoryPath, backupDbFileName);
  await currentDbFile.copy(backupDbFilePath);

  print('%%%%%%%Database backup created at: $backupDbFilePath');
}
