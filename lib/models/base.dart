class Base {
  final int id;
  final String nome;
  final String caminho;

  Base(this.id, this.nome, this.caminho);

  @override
  String toString() {
    return 'Id: $id - Nome: $nome - Caminho: $caminho';
  }
}
