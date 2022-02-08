import 'package:backup_sqlite_database_app/database/dao/base_dao.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

String get databaseName => 'backup-sqlite-database.db';

Future<String> getPath() {
  return getDatabasesPath();
}

Future<Database> getDatabase() async {
  final String path = join(await getPath(), databaseName);

  //await excluirBaseDeDados(path);

  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      debugPrint('Creating Tables...');
      await createTables(db);
    },
    // onUpgrade: (db, oldVersion, newVersion) async =>
    //     await alterTables(db, oldVersion, newVersion),
  );
}

Future excluirBaseDeDados(String path) async {
  debugPrint('deleteDatabase() - Start');
  await deleteDatabase(path);
  debugPrint('deleteDatabase() - End');
}

Future<void> createTables(Database db) async {
  debugPrint('Creating table Base');
  await db.execute(BaseDao.tableSql);
}

// Future<void> alterTables(Database db, int oldVersion, int newVersion) async {
//   debugPrint('oldVersion: $oldVersion | newVersion: $newVersion');
//   for (var i = oldVersion + 1; i <= newVersion; i++) {
//     debugPrint('Alterando Tabela versão $i');
//     await db.execute(BaseDao.alterTable);
//   }
// }
