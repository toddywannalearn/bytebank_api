import 'package:bytebank/models/contato.dart';
import 'package:bytebank/repositories/database/dao/contato_dao.dart';
import 'package:bytebank/screens/contatos_form.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/components/contato_card.dart';
import 'package:bytebank/components/emptyState_card.dart';
import 'package:bytebank/components/loading.dart';

class ListaContatos extends StatefulWidget {
  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  final ContatoDao _contatoDao = ContatoDao();

  static const _appBarTitle = 'Contatos';
  static const _snackLabel = 'Desfazer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: _futureBuilder(),
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

  Widget _futureBuilder() {
    return FutureBuilder<List<Contato>>(
      initialData: List(),
      future: _contatoDao.findAll(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            return Loading();
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            final List<Contato> contatos = snapshot.data;
            return contatos.isEmpty
                ? EmptyStateCard('Nenhum contato adicionado!')
                : listaContatos(contatos);
            break;
        }
        return EmptyStateCard('Unknown error');
      },
    );
  }

  Widget listaContatos(List<Contato> contatos) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final Contato contato = contatos[index];
        return _dismissible(context, contatos, contato, index);
      },
      itemCount: contatos.length,
    );
  }

  Widget _dismissible(BuildContext context, List<Contato> contatos,
      Contato contato, int index) {
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
          _contatoDao.findAll();
        });
        Scaffold.of(context).showSnackBar(
          _snackBar(contato),
        );
      },
    );
  }

  Widget _snackBar(Contato contato) {
    return SnackBar(
      content: Text('${contato.name} foi removido'),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: _snackLabel,
        onPressed: () {
          _contatoDao.save(contato);
          setState(() {
            _contatoDao.findAll();
          });
        },
      ),
    );
  }
}
