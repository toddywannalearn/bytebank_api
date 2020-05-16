import 'package:bytebank/components/common_field.dart';
import 'package:bytebank/components/dialog.dart';
import 'package:bytebank/http/webclients/transacao_webclient.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Contato contato;

  TransactionForm(this.contato);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransacaoWebClient _webClient = TransacaoWebClient();

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
                      final transacaoCriada = Transacao(value, widget.contato);

                      if (value != null) {
                        showDialog(
                          builder: (BuildContext context) {
                            return AuthDialog(
                              onConfirm: (String password) {
                                _webClient
                                    .insertTransacao(transacaoCriada, password)
                                    .then(
                                  (transacao) {
                                    if (transacao != null) {
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              },
                            );
                          },
                          useRootNavigator: true,
                          context: context,
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return simpleDialog(
                                'O campo valor deve ser preenchido!',
                                () => Navigator.pop(context));
                          },
                        );
                      }
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

  Widget simpleDialog(String text, Function onClick) {
    return SimpleDialog(
      title: Text(text),
      children: <Widget>[
        SimpleDialogOption(
          child: Center(
            child: Text(
              'OK!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onPressed: onClick,
        ),
      ],
    );
  }
}
