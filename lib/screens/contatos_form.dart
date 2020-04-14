import 'package:flutter/material.dart';
import 'package:bytebank/components/common_field.dart';

class ContatosForm extends StatefulWidget {
  @override
  _ContatosFormState createState() => _ContatosFormState();
}

class _ContatosFormState extends State<ContatosForm> {

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo contato'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              CommonField(
                label: 'Full name',
                controller: _fullNameController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CommonField(
                  label: 'Account number',
                  controller: _accountNumberController,
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Create'),
                    onPressed: (){},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
