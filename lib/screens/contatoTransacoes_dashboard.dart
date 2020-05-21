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

  @override
  void initState() {
    _future = TransacaoWebClient().contatoxtransacao();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transações por contato'),
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
                    ? EmptyStateCard('Nenhuma transação encontrada')
                    : Table(contatosXtransacoes);
              }
              return EmptyStateCard('404 - Not Found');
              break;
          }
          return EmptyStateCard('404 - Not Found');
        },
      ),
    );
  }
}

class Table extends StatelessWidget {
  final List<ContatoxTransacao> contatosXtransacoes;

  Table(this.contatosXtransacoes);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Text('Nome'),
          ),
          DataColumn(
            label: Text('Total R\$'),
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
