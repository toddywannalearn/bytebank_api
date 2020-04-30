import 'package:bytebank/screens/transacoes_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/screens/contatos_list.dart';
import 'package:flutter/rendering.dart';

import 'contatos_list.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dashboard'),
      ),
      body: _bodyWidgets(),
    );
  }

  Widget _bodyWidgets() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/bytebank_logo.png'),
                ),
                Container(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _DashboardButton(
                        'Transfer',
                        Icons.monetization_on,
                        onClick: () => _showListaContatos(context),
                      ),
                      _DashboardButton(
                        'Transaction feed',
                        Icons.description,
                        onClick: () => _showListaTransacoes(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showListaContatos(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ListaContatos(),
    ));
  }

  _showListaTransacoes(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ListaTransacoes(),
    ));
  }


}

class _DashboardButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onClick;

  _DashboardButton(this.text, this.icon, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return _buttonMaterial(context);
  }

  Widget _buttonMaterial(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: _buttonContainer(),
        ),
      ),
    );
  }

  Widget _buttonContainer() {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
