import 'package:flutter/material.dart';

class ThemesApp{

  ThemeData mainTheme(){
    return ThemeData(
      primaryColor: Colors.green[900],
      accentColor: Colors.green[900],
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.green[900],
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}