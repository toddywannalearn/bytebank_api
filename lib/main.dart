import 'package:flutter/material.dart';

import 'components/themes.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.greenAccent,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      //home: AuthDialog(),
      home: Dashboard(),
    );
  }
}
