import 'package:backup_sqlite_database_app/database/dao/base_dao.dart';
import 'package:backup_sqlite_database_app/models/base.dart';
import 'package:backup_sqlite_database_app/screens/principal.dart';
import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final String _nomeTela = "Formulário";
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _caminhoController = TextEditingController();
  final BaseDao _baseDao = BaseDao();

  void aviso(String texto, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto),
        backgroundColor: cor,
      ),
    );
  }

  void confirma() async {
    final String nome = _nomeController.text;
    final String caminho = _caminhoController.text;

    if (nome.isEmpty) {
      aviso('Campo nome vazio!', Colors.red);
      return;
    }

    if (caminho.isEmpty) {
      aviso('Campo caminho vazio!', Colors.red);
      return;
    }

    salva(Base(0, nome, caminho));
    openPrincipal();
  }

  void salva(Base base) async {
    _baseDao
        .inclui(base)
        .then((value) => aviso('Salvo com sucesso!', Colors.green))
        .catchError((onError) => aviso('Erro ao salvar!', Colors.red));
  }

  void openPrincipal() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Principal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_nomeTela),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 24.0, top: 16.0, right: 24.0),
              child: SizedBox(
                width: 256.0,
                child: TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) => {},
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 24.0, top: 16.0, right: 24.0),
              child: SizedBox(
                width: 350.0,
                child: TextFormField(
                  controller: _caminhoController,
                  decoration: const InputDecoration(
                    labelText: 'Caminho',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) => {},
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 24.0, top: 32.0, right: 24.0),
              child: ElevatedButton(
                child: const Text('Confirmar'),
                onPressed: confirma,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
