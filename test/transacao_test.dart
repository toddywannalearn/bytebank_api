import 'package:bytebank/models/transacao.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve retornar valor quando a transacao é criada', () {
    final Transacao transacao = Transacao(200, null, null);

    expect(transacao.valor, 200);
  });

  test('Deve retornar erro ao inserir valor menor que 0 ao criar a transacao',
      () {
    expect(() => Transacao(0, null, null), throwsAssertionError);
  });
}
