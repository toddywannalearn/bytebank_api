import 'package:bytebank/components/emptyState_card.dart';
import 'package:bytebank/components/loading.dart';
import 'package:bytebank/http/webclients/transacao_webclient.dart';
import 'package:bytebank/models/contatoXtransacao.dart';
import 'package:flutter/material.dart';

class ContatoTransacoesDashboard extends StatefulWidget {
  @override
  _ContatoTransacoesDashboardState createState() =>
      _ContatoTransacoesDashboardState();
}

class _ContatoTransacoesDashboardState
    extends State<ContatoTransacoesDashboard> {
  Future<List<ContatoxTransacao>> _future;

  static const String _appBarTitle = 'Transações por contato';
  static const String _emptyList = 'Nenhuma transação encontrada';
  static const String _notFoundCard = '404 - Not Found';
  static const String _errorCard = 'Unknown Error';

  @override
  void initState() {
    _future = TransacaoWebClient().contatoxtransacao();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: FutureBuilder<List<ContatoxTransacao>>(
        initialData: List(),
        future: _future,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.waiting:
              return Loading();
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<ContatoxTransacao> contatosXtransacoes =
                    snapshot.data;
                return contatosXtransacoes.isEmpty
                    ? EmptyStateCard(_emptyList)
                    : Table(contatosXtransacoes);
              }
              return EmptyStateCard(_notFoundCard);
              break;
          }
          return EmptyStateCard(_errorCard);
        },
      ),
    );
  }
}

class Table extends StatelessWidget {
  final List<ContatoxTransacao> contatosXtransacoes;

  Table(this.contatosXtransacoes);

  static const String _columnName = 'Nome';
  static const String _columnTotal = 'Total R\$';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text(_columnName),
          ),
          DataColumn(
            label: Text(_columnTotal),
          )
        ],
        rows: contatosXtransacoes
            .map(
              ((element) => DataRow(
                    cells: <DataCell>[
                      DataCell(
                        Text(element.name),
                      ),
                      DataCell(
                        Text(element.valor.toString()),
                      ),
                    ],
                  )),
            )
            .toList(),
      ),
    );
  }
}
