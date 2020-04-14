import 'package:flutter/material.dart';

class ThemesApp{

  ThemeData mainTheme(){
    return ThemeData(
      primaryColor: Colors.brown[700],
      accentColor: Colors.brown[700],
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.brown[700],
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}