import 'package:bytebank/models/contatos.dart';
import 'package:flutter/material.dart';

class ContatoCard extends StatelessWidget {

  final Contato contato;

  ContatoCard(this.contato);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(contato.name),
        subtitle: Text(contato.accountNumber.toString()),
      ),
    );
  }
}
