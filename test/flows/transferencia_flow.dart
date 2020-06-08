import 'package:bytebank/components/common_field.dart';
import 'package:bytebank/components/contato_card.dart';
import 'package:bytebank/components/dialog.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:bytebank/screens/contatos/contatos_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transacoes/transacao_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.dart';

void main() {
  MockContatoDao _mockContatoDao;
  MockTransacaoWebClient _mockTransacaoWebClient;

  /// Inicializa a configuração dos testes
  setUp(() async {
    _mockContatoDao = MockContatoDao();
    _mockTransacaoWebClient = MockTransacaoWebClient();
  });

  /// Configuração pós execução de cada teste
  tearDown(() async {
    debugPrint('Teste finalizado');
  });

  testWidgets('Deve transferir para contato', (tester) async {
    await tester.pumpWidget(MyApp(
      transacaoWebClient: _mockTransacaoWebClient,
      contatoDao: _mockContatoDao,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    var contato = Contato(0, 'Doug', 1234);
    when(_mockContatoDao.findAll())
        .thenAnswer((realInvocation) async => [contato]);

    final btnTransferir = find.widgetWithText(DashboardButton, 'Transferir');
    expect(btnTransferir, findsOneWidget);

    await tester.tap(btnTransferir);
    await tester.pumpAndSettle();

    final listContatos = find.byType(ListaContatos);
    expect(listContatos, findsOneWidget);

    verify(_mockContatoDao.findAll()).called(1);

    final itemContato = find.byWidgetPredicate((widget) {
      if (widget is ContatoCard) {
        return widget.contato.name == 'Doug' &&
            widget.contato.accountNumber == 1234;
      }
      return false;
    });
    expect(itemContato, findsOneWidget);

    await tester.tap(itemContato);
    await tester.pumpAndSettle();

    final formTransacao = find.byType(TransactionForm);
    expect(formTransacao, findsOneWidget);

    final txtName = find.text('Doug');
    expect(txtName, findsOneWidget);

    final txtAccountNumber = find.text('1234');
    expect(txtAccountNumber, findsOneWidget);

    final fieldValor = find.byType(CommonField);
    expect(fieldValor, findsOneWidget);

    await tester.enterText(fieldValor, '500');

    final btnTransf = find.widgetWithText(RaisedButton, 'Transferir');
    expect(btnTransf, findsOneWidget);

    await tester.tap(btnTransf);
    await tester.pumpAndSettle();

    final dialogAutenticacao = find.byType(AlertDialog);
    expect(dialogAutenticacao, findsOneWidget);

    final fieldAutenticacao =
        find.byKey(transacaoAuthDialogTextFieldPasswordKey);
    expect(fieldAutenticacao, findsOneWidget);

    await tester.enterText(fieldAutenticacao, '1000');

    final btnConfirmar = find.widgetWithText(RaisedButton, 'Confirmar');
    expect(btnConfirmar, findsOneWidget);

    when(_mockTransacaoWebClient.insertTransacao(
            Transacao(500, contato, null), '1000'))
        .thenAnswer((_) async => Transacao(500, contato, null));

    await tester.tap(btnConfirmar);
    await tester.pumpAndSettle();

    final dialogSucesso = find.byType(SuccessDialog);
    expect(dialogSucesso, findsOneWidget);

    final btnOk = find.widgetWithText(FlatButton, 'Ok');
    expect(btnOk, findsOneWidget);

    await tester.tap(btnOk);
    await tester.pumpAndSettle();

    final listaContatosBack = find.byType(ListaContatos);
    expect(listaContatosBack, findsOneWidget);
  });
}
