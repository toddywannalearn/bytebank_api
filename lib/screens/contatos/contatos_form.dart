import 'package:bytebank/components/common_field.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/repositories/database/dao/contato_dao.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

class ContatosForm extends StatefulWidget {
  @override
  _ContatosFormState createState() => _ContatosFormState();
}

class _ContatosFormState extends State<ContatosForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

  static const String _appBarTitle = 'Novo contato';
  static const String _fieldName = 'Full name';
  static const String _fieldAccount = 'Account number';
  static const String _buttonText = 'Create';

  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
        ),
        body: _formBody(dependencies));
  }

  Widget _formBody(AppDependencies dependencies) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CommonField(
              label: _fieldName,
              controller: _fullNameController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CommonField(
                label: _fieldAccount,
                controller: _accountNumberController,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: _criarContatoButton(context, dependencies.contatoDao),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _criarContatoButton(BuildContext context, ContatoDao contatoDao) {
    return RaisedButton(
      child: Text(_buttonText),
      onPressed: () {
        final int id = 9;
        final String name = _fullNameController.text.toString();
        final int accountNumber = int.tryParse(_accountNumberController.text);
        final Contato contato = Contato(id, name, accountNumber);

        _save(contatoDao, contato, context);
      },
    );
  }

  void _save(
      ContatoDao contatoDao, Contato contato, BuildContext context) async {
    await contatoDao.save(contato);
    Navigator.pop(context);
  }
}
