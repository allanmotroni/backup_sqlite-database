import 'package:backup_sqlite_database_app/screens/principal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BackupSqliteDatabaseApp());
}

class BackupSqliteDatabaseApp extends StatelessWidget {
  const BackupSqliteDatabaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backup SQLite Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Principal(),
    );
  }
}
