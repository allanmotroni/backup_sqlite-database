import 'package:backup_sqlite_database_app/screens/formulario.dart';
import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final String _nomeTela = "Backup SQLite Database";

  final TextEditingController _databaseController = TextEditingController();

  void backup() {
    debugPrint('Backup...');
  }

  void restore() {
    debugPrint('Restore...');
  }

  void openForm() async {
    debugPrint('Open Form...');
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Formulario(),
      ),
    );

    //carregar Databases
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
                  child: SizedBox(
                    width: 256.0,
                    child: TextFormField(
                      controller: _databaseController,
                      decoration: const InputDecoration(
                        labelText: 'Database',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) => {},
                    ),
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
