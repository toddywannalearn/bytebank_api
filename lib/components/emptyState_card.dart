import 'package:flutter/material.dart';

class EmptyStateCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.close),
        title: Text('Nenhum contato adicionado!'),
      ),
    );
  }
}
