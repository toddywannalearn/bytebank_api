import 'package:bytebank/components/emptyState_card.dart';
import 'package:bytebank/components/loading.dart';
import 'package:bytebank/http/webclients/transacao_webclient.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:flutter/material.dart';

class ListaTransacoes extends StatefulWidget {
  @override
  _ListaTransacoesState createState() => _ListaTransacoesState();
}

class _ListaTransacoesState extends State<ListaTransacoes> {
  Future<List<Transacao>> _future;

  static const String _appBarTitle = 'Transações';
  static const String _emptyList = 'Nenhuma transação encontrada';
  static const String _notFoundCard = '404 - Not Found';
  static const String _errorCard = 'Unknown error!';

  @override
  void initState() {
    _future = TransacaoWebClient().findAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: FutureBuilder<List<Transacao>>(
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
              if (snapshot.hasData) {
                final List<Transacao> transacoes = snapshot.data;
                return transacoes.isEmpty
                    ? EmptyStateCard(_emptyList)
                    : listaTransacoes(transacoes);
              }
              return EmptyStateCard(_notFoundCard);
              break;
          }
          return EmptyStateCard(_errorCard);
        },
      ),
    );
  }

  ListView listaTransacoes(List<Transacao> transacoes) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final Transacao transacao = transacoes[index];
        return _CardTransacao(transacao: transacao);
      },
      itemCount: transacoes.length,
    );
  }
}

class _CardTransacao extends StatelessWidget {
  const _CardTransacao({
    Key key,
    @required this.transacao,
  }) : super(key: key);

  final Transacao transacao;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(
          transacao.valor.toString(),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          transacao.contato.accountNumber.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
