import 'package:backup_sqlite_database_app/database/dao/base_dao.dart';
import 'package:backup_sqlite_database_app/models/base.dart';
import 'package:backup_sqlite_database_app/screens/formulario.dart';
import 'package:backup_sqlite_database_app/services/backup_service.dart';
import 'package:backup_sqlite_database_app/services/restore_service.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final String _nomeTela = "Backup SQLite Database";
  final BaseDao _baseDao = BaseDao();

  List<Base> _bases = [];
  Base? _selectedBase;

  @override
  void initState() {
    refreshView();
    super.initState();
  }

  void refreshView() async {
    _baseDao
        .lista()
        .then((bases) => {
              setState(() {
                _bases = bases;
              })
            })
        .catchError((onError) {
      aviso('Erro ao realizar a consulta', Colors.red);
    });
  }

  void aviso(String texto, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto),
        backgroundColor: cor,
      ),
    );
  }

  void backup() {
    try {
      debugPrint('Backup...${_selectedBase?.nome}');
      final BackupService backupService = BackupService(_selectedBase!.caminho);
      backupService.execute();
    } catch (e) {
      aviso(e.toString(), Colors.red);
    }
  }

  void restore() {
    try {
      debugPrint('Restore...${_selectedBase?.nome}');
      final RestoreService restoreService =
          RestoreService(_selectedBase!.caminho);
      restoreService.execute();
    } catch (e) {
      aviso(e.toString(), Colors.red);
    }
  }

  void openForm() async {
    await Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => const Formulario(),
          ),
        )
        .then((value) => refreshView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_nomeTela),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 16.0),
                  child: DropdownButton<Base>(
                    icon: const Icon(Icons.arrow_downward),
                    value: _bases.isEmpty ? null : _bases[0],
                    onChanged: (Base? base) {
                      debugPrint('${base?.nome}');
                      setState(() {
                        _selectedBase = base;
                      });
                    },
                    items: _bases.map<DropdownMenuItem<Base>>((Base base) {
                      return DropdownMenuItem<Base>(
                        value: base,
                        child: Text(base.nome),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, right: 24.0),
                  child: IconButton(
                    onPressed: openForm,
                    icon: const Icon(Icons.add_circle),
                    iconSize: 40.0,
                    tooltip: 'Add Database',
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 32.0),
                  child: ElevatedButton(
                    onPressed: backup,
                    child: const Text('Backup'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, right: 24.0),
                  child: ElevatedButton(
                    onPressed: restore,
                    child: const Text('Restore'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
