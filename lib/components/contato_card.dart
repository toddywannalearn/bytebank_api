import 'package:bytebank/models/contato.dart';
import 'package:flutter/material.dart';

class ContatoCard extends StatelessWidget {

  final Contato contato;
  final Function onClick;

  ContatoCard(this.contato, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onClick,
        title: Text(contato.name),
        subtitle: Text(contato.accountNumber.toString()),
      ),
    );
  }
}
