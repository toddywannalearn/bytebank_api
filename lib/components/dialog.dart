import 'package:flutter/material.dart';

const Key transacaoAuthDialogTextFieldPasswordKey =
    Key('transacaoAuthDialogTextFieldPassword');

class AuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  AuthDialog({@required this.onConfirm});

  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: transacaoAuthDialogTextFieldPasswordKey,
      title: Text('Autenticação'),
      content: TextField(
        controller: _passwordController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        style: TextStyle(
          letterSpacing: 24.0,
          fontSize: 48.0,
        ),
        maxLength: 4,
        keyboardType: TextInputType.number,
        obscureText: true,
      ),
      actions: <Widget>[
        OutlineButton(
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        RaisedButton(
          child: Text(
            'Confirmar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            widget.onConfirm(_passwordController.text);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
