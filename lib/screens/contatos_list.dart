import 'package:bytebank/screens/contatos_form.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: listaContatos(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContatosForm(),
            ),
          );
        },
      ),
    );
  }

  Widget listaContatos() {
    return ListView();
  }
}
