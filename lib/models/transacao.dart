import 'contato.dart';

class Transacao {
  final double valor;
  final Contato contato;

  Transacao(
    this.valor,
    this.contato,
  );

  @override
  String toString() {
    return 'Transação{valor: $valor, contato: $contato}';
  }
}
