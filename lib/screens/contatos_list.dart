import 'package:bytebank/models/contatos.dart';
import 'package:bytebank/repositories/database/app_database.dart';
import 'package:bytebank/screens/contatos_form.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/components/contato_card.dart';

class ListaContatos extends StatelessWidget {
  //final List<Contato> contatos = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
      ),
      body: futureBuilder(),
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

  Widget futureBuilder() {
    return FutureBuilder<List<Contato>>(
      initialData: List(),
      future: Future.delayed(Duration(seconds: 1)).then((value) => findAll()),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            // TODO: Handle this case.
            break;
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.active:
            // TODO: Handle this case.
            break;
          case ConnectionState.done:
            // TODO: Handle this case.
            break;
        }
        return listaContatos(snapshot.data);
      },
    );
  }

  Widget listaContatos(List<Contato> contatos) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final Contato contato = contatos[index];
        return ContatoCard(contato);
      },
      itemCount: contatos.length,
    );
  }

  Widget loading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text('Loading'),
        ],
      ),
    );
  }
}
