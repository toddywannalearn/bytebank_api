import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String message;

  Loading({this.message = 'Carregando...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(message),
        ],
      ),
    );
  }
}
