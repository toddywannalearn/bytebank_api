import 'package:bytebank/http/webclient.dart';
import 'package:flutter/material.dart';
import 'components/themes.dart';
import 'screens/dashboard.dart';
import 'models/transacao.dart';
import 'models/contato.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemesApp().mainTheme(),
      home: Dashboard(),
    );
  }
}
