import 'package:backup_sqlite_database_app/database/database.dart';
import 'package:backup_sqlite_database_app/models/base.dart';
import 'package:sqflite/sqflite.dart';

class BaseDao {
  static const String tableSql =
      'CREATE TABLE IF NOT EXISTS $tableName($id INTEGER PRIMARY KEY, $nome TEXT, $caminho TEXT)';

  // static const String alterTable =
  //     'ALTER TABLE $tableName ADD COLUMN $mensalidade REAL';

  static const String dropTable = 'DROP TABLE IF EXISTS $tableName';

  static const String tableName = 'base';

  static const String id = 'id';
  static const String nome = 'nome';
  static const String caminho = 'caminho';

  Future<int> inclui(Base base) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contaMap = toMap(base);

    final int retorno = await db.insert(tableName, contaMap);
    return retorno;
  }

  Future<int> exclui(int baseId) async {
    final Database db = await getDatabase();
    return await db.delete(tableName, where: '$id = ?', whereArgs: [baseId]);
  }

  Future<int> altera(Base base) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contaMap = toMap(base);

    return await db
        .update(tableName, contaMap, where: '$id = ?', whereArgs: [base.id]);
  }

  Future<List<Base>> lista() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    final List<Base> bases = toList(maps);
    return bases;
  }

  Future<List<Map<String, dynamic>>> consulta(
      String where, List<dynamic> whereArgs) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query(tableName, where: where, whereArgs: whereArgs);
    return maps;
  }

  static Map<String, dynamic> toMap(Base base) {
    final Map<String, dynamic> baseMap = {};
    baseMap[nome] = base.nome;
    baseMap[caminho] = base.caminho;

    return baseMap;
  }

  static List<Base> toList(List<Map<String, dynamic>> maps) {
    final List<Base> bases = [];

    for (Map<String, dynamic> map in maps) {
      final Base base = Base(map[id], map[nome], map[caminho]);
      bases.add(base);
    }

    return bases;
  }
}
