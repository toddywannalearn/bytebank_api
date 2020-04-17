class Contato {
  final int id;
  final String name;
  final int accountNumber;

  Contato(this.id, this.name, this.accountNumber);

  @override
  String toString() {
    return 'Contatos{id: $id, name: $name, accountNumber: $accountNumber}';
  }
}
