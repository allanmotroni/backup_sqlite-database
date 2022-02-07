import 'package:backup_sqlite_database_app/services/file_base_service.dart';
import 'package:sqflite/sqflite.dart';

class RestoreService {
  final String to;

  RestoreService(this.to);

  Future<String> getFromPath() async => await getDatabasesPath();

  void execute() async {
    final FileBaseService fileBaseService =
        FileBaseService(await getFromPath(), to);
    fileBaseService.copy();
  }
}
