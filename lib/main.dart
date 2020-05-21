import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'components/themes.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemesApp().mainTheme(),
      //home: AuthDialog(),
      home: Dashboard(),
    );
  }
}
