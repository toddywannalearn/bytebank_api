import 'package:bytebank/http/webclient.dart';
import 'package:flutter/material.dart';
import 'components/themes.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(MyApp());
  //findAll().then((transacoes) => print('novas transacoes $transacoes'));
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
