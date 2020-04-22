import 'package:bytebank/models/contatos.dart';
import 'package:bytebank/repositories/database/dao/contato_dao.dart';
import 'package:bytebank/screens/contatos_form.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/components/contato_card.dart';
import 'package:bytebank/components/emptyState_card.dart';

class ListaContatos extends StatefulWidget {
  //final List<Contato> contatos = List();

  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  final ContatoDao _contatoDao = ContatoDao();

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
      future: _contatoDao.findAll(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            final List<Contato> contatos = snapshot.data;
            return contatos.length == 0
                ? EmptyStateCard()
                : listaContatos(contatos);
            break;
        }
        return Text('Unknown error');
      },
    );
  }

  Widget listaContatos(List<Contato> contatos) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final Contato contato = contatos[index];
        final String item = contatos[index].id.toString();
        return Dismissible(
          key: Key(item),
          child: ContatoCard(contato),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.redAccent,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 32.0,
            ),
            alignment: Alignment.centerRight,
          ),
          onDismissed: (DismissDirection dir) {
            _contatoDao.deleteContato(contato.id);
            setState(() {
              Scaffold.of(context).reassemble();
            });
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('contato id ${contato.id}'),
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'print on debug',
                  onPressed: () {
                    debugPrint('snackbar clicked');
                  },
                ),
              ),
            );
          },
        );
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
          Text('Loading...'),
        ],
      ),
    );
  }
}
