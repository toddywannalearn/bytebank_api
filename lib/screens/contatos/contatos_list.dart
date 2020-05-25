import 'package:bytebank/models/contato.dart';
import 'package:bytebank/repositories/database/dao/contato_dao.dart';
import 'package:bytebank/screens/contatos/contatos_form.dart';
import 'package:bytebank/screens/transacoes/transacao_form.dart';
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
  Future<List<Contato>> _future;

  static const _appBarTitle = 'Contatos';
  static const _snackLabel = 'Desfazer';
  static const _emptyList = 'Nenhum contato adicionado!';
  static const _errorCard = 'Unknown error';

  @override
  void initState() {
    _future = _contatoDao.findAll();
    super.initState();
  }

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
      future: _future,
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
                ? EmptyStateCard(_emptyList)
                : listaContatos(contatos);
            break;
        }
        return EmptyStateCard(_errorCard);
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
      child: ContatoCard(
        contato,
        onClick: () => _showTransacaoForm(context, contato),
      ),
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

  void _showTransacaoForm(BuildContext context, Contato contato) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TransactionForm(contato)));
  }

  Widget _snackBar(Contato contato) {
    return SnackBar(
      content: Text(
        '${contato.name} foi removido',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        textColor: Colors.yellow,
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
