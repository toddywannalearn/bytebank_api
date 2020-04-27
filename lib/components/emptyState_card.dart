import 'package:flutter/material.dart';

class EmptyStateCard extends StatelessWidget {

  static const String _cardTitle = 'Nenhum contato adicionado!';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.close),
        title: Text(_cardTitle),
      ),
    );
  }
}
