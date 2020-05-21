class Contato {
  final int id;
  final String name;
  final int accountNumber;

  Contato(this.id, this.name, this.accountNumber);

  @override
  String toString() {
    return 'Contatos{id: $id, name: $name, accountNumber: $accountNumber}';
  }

  Contato.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'accountNumber': accountNumber,
      };
}
