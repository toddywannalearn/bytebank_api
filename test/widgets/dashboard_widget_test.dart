import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('When Dashboard is opened', () {
    testWidgets('Deve exibir imagem principal na tela',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final image = find.byType(Image);
      expect(image, findsOneWidget);
    });

    testWidgets('Deve exibir o botão Transferir no dashboard', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final btnTransferir = find.byWidgetPredicate((widget) {
        if (widget is DashboardButton) {
          return widget.text == 'Transferir' &&
              widget.icon == Icons.monetization_on;
        }
        return false;
      });
      expect(btnTransferir, findsOneWidget);
    });

    testWidgets('Deve exibir o botão Transações no dashboard', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final btnTransacoes = find.byWidgetPredicate((widget) {
        if (widget is DashboardButton) {
          return widget.text == 'Transações' &&
              widget.icon == Icons.description;
        }
        return false;
      });
      expect(btnTransacoes, findsOneWidget);
    });

    testWidgets('Deve exibir o botão Total operações no dashboard',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final btnTotalOpText =
          find.widgetWithText(DashboardButton, 'Total operações');
      expect(btnTotalOpText, findsOneWidget);

      final btnTotalOpIcon =
          find.widgetWithIcon(DashboardButton, Icons.description);
      expect(btnTotalOpIcon, findsOneWidget);
    });
  });
}
