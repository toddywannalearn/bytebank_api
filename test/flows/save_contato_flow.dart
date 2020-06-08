import 'package:bytebank/components/common_field.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/contatos_form.dart';
import 'package:bytebank/screens/contatos/contatos_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bytebank/main.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mocks.dart';

void main() {

  MockContatoDao mockContatoDao;

  /// Inicializa a configuração dos testes
  setUp(() async{
    mockContatoDao = MockContatoDao();
  });

  /// Configuração pós execução de cada teste
  tearDown((){
    debugPrint('Teste finalizado');
  });

  testWidgets('Deve salvar o contato', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(
      contatoDao: mockContatoDao,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final btnTransferir = find.widgetWithText(DashboardButton, 'Transferir');
    expect(btnTransferir, findsOneWidget);

    await tester.tap(btnTransferir);
    await tester.pumpAndSettle();

    final listContatos = find.byType(ListaContatos);
    expect(listContatos, findsOneWidget);

    verify(mockContatoDao.findAll()).called(1);

    final floatAddContato =
        find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(floatAddContato, findsOneWidget);

    await tester.tap(floatAddContato);
    await tester.pumpAndSettle();

    final formContato = find.byType(ContatosForm);
    expect(formContato, findsOneWidget);

    final fieldFullName =
        find.byWidgetPredicate((widget) => _fieldMatcher(widget, 'Full name'));
    expect(fieldFullName, findsOneWidget);
    await tester.enterText(fieldFullName, 'doug');

    final fieldAccountNumber = find
        .byWidgetPredicate((widget) => _fieldMatcher(widget, 'Account number'));
    expect(fieldAccountNumber, findsOneWidget);
    await tester.enterText(fieldAccountNumber, '1000');

    final btnCreate = find.byType(RaisedButton);
    expect(btnCreate, findsOneWidget);

    await tester.tap(btnCreate);
    await tester.pumpAndSettle();

    verify(mockContatoDao.save(Contato(0, 'doug', 1000)));

    final listContatosBack = find.byType(ListaContatos);
    expect(listContatosBack, findsOneWidget);
  });
}

bool _fieldMatcher(Widget widget, String label) {
  if (widget is CommonField) {
    return widget.label == label;
  }
  return false;
}
