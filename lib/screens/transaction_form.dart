import 'package:bytebank/components/common_field.dart';
import 'package:bytebank/components/dialog.dart';
import 'package:bytebank/components/loading.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/http/webclients/transacao_webclient.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/models/http_interceptor_exception.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contato contato;

  TransactionForm(this.contato);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransacaoWebClient _webClient = TransacaoWebClient();
  final String _transacaoId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _sending,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Loading(),
                ),
              ),
              Text(
                widget.contato.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contato.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CommonField(
                  controller: _valueController,
                  label: 'Valor',
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transacaoCriada =
                          Transacao(value, widget.contato, _transacaoId);
                      showDialog(
                        context: context,
                        builder: (BuildContext contextDialog) {
                          return AuthDialog(
                            onConfirm: (String password) {
                              _save(transacaoCriada, password, context);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
      Transacao transacaoCriada, String password, BuildContext context) async {
    setState(() {
      _sending = true;
    });
    Transacao transacao = await _send(transacaoCriada, password, context);

    await _showMensagemSucesso(transacao, context);
  }

  Future _showMensagemSucesso(Transacao transacao, BuildContext context) async {
    if (transacao != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Transferência efetuada com sucesso');
          });
      Navigator.pop(context);
    }
  }

  Future<Transacao> _send(
      Transacao transacaoCriada, String password, BuildContext context) async {
    final Transacao transacao = await _webClient
        .insertTransacao(transacaoCriada, password)
        .catchError((e) {
      _showDialog(
        context,
        FailureDialog(e.message),
      );
    }, test: (e) => e is HttpException).catchError((e) {
      _showDialog(
        context,
        FailureDialog('Tempo esgotado ao enviar a transação'),
      );
    }, test: (e) => e is HttpInterceptorException).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });
    return transacao;
  }

  void _showDialog(BuildContext context, Widget alertDialog) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return alertDialog;
        });
  }
}
