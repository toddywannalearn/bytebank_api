import 'package:bytebank/models/contato.dart';
import 'package:bytebank/repositories/database/dao/contato_dao.dart';
import 'package:bytebank/screens/contatos/contatos_form.dart';
import 'package:bytebank/screens/transacoes/transacao_form.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/components/contato_card.dart';
import 'package:bytebank/components/emptyState_card.dart';
import 'package:bytebank/components/loading.dart';
import 'package:bytebank/widgets/app_dependencies.dart';

class ListaContatos extends StatefulWidget {
  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {

  static const _appBarTitle = 'Contatos';
  static const _snackLabel = 'Desfazer';
  static const _emptyList = 'Nenhum contato adicionado!';
  static const _errorCard = 'Unknown error';

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: _futureBuilder(dependencies),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showContatoForm(context);
        },
      ),
    );
  }

  Widget _futureBuilder(AppDependencies dependencies) {
    return FutureBuilder<List<Contato>>(
      initialData: List(),
      future: dependencies.contatoDao.findAll(),
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
                : listaContatos(contatos, dependencies.contatoDao);
            break;
        }
        return EmptyStateCard(_errorCard);
      },
    );
  }

  Widget listaContatos(List<Contato> contatos, ContatoDao contatoDao) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final Contato contato = contatos[index];
        return _dismissible(context, contatos, contato, contatoDao, index);
      },
      itemCount: contatos.length,
    );
  }

  Widget _dismissible(BuildContext context, List<Contato> contatos,
      Contato contato, ContatoDao contatoDao, int index) {
    return Dismissible(
      key: UniqueKey(),
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
        contatoDao.deleteContato(contato.id);
        setState(() {
          contatoDao.findAll();
        });
        Scaffold.of(context).showSnackBar(
          _snackBar(contato, contatoDao),
        );
      },
    );
  }

  void _showTransacaoForm(BuildContext context, Contato contato) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TransactionForm(contato)));
  }

  void _showContatoForm(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ContatosForm()));
  }

  Widget _snackBar(Contato contato, ContatoDao contatoDao) {
    return SnackBar(
      backgroundColor: Colors.greenAccent,
      content: Text(
        '${contato.name} foi removido',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        textColor: Colors.black,
        label: _snackLabel,
        onPressed: () {
          contatoDao.save(contato);
          setState(() {
            contatoDao.findAll();
          });
        },
      ),
    );
  }
}
