import 'package:flutter/material.dart';

class Loading extends StatelessWidget {

  static const String _text = 'Loading...';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(_text),
        ],
      ),
    );
  }
}
