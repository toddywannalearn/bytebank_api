import 'package:flutter/material.dart';

class EmptyStateCard extends StatelessWidget {
  final String cardMessage;

  EmptyStateCard(this.cardMessage);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.close),
        title: Text(cardMessage),
      ),
    );
  }
}
