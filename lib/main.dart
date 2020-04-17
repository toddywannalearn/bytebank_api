import 'package:bytebank/repositories/database/app_database.dart';
import 'package:flutter/material.dart';
import 'components/themes.dart';
import 'models/contatos.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(MyApp());

  //deleteAll();
 // save(Contato(3, 'brenda', 1001)).then((id) {
  //  findAll().then((contatos) => debugPrint(contatos.toString()));
 // });
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
