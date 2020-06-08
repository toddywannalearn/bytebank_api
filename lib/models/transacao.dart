import 'contato.dart';

class Transacao {
  final double valor;
  final Contato contato;
  final String id;

  Transacao(
    this.valor,
    this.contato,
    this.id,
  ) : assert(valor > 0);

  Transacao.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        valor = json['value'],
        contato = Contato.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': valor,
        'contact': contato.toJson(),
      };

  @override
  String toString() {
    return 'Transação{valor: $valor, contato: $contato}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transacao &&
          runtimeType == other.runtimeType &&
          valor == other.valor &&
          contato == other.contato;

  @override
  int get hashCode => valor.hashCode ^ contato.hashCode;
}
