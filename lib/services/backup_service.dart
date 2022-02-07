import 'package:backup_sqlite_database_app/services/file_base_service.dart';
import 'package:sqflite/sqflite.dart';

class BackupService {
  final String _from;

  BackupService(this._from);

  Future<String> getToPath() async => await getDatabasesPath();

  void execute() async {
    final FileBaseService fileBaseService =
        FileBaseService(_from, await getToPath());
    fileBaseService.copy();
  }
}
