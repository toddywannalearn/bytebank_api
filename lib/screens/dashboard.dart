import 'package:flutter/material.dart';
import 'package:bytebank/screens/contatos_list.dart';

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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _cardContatos(),
          ),
        ],
      ),
    );
  }

  Widget _cardContatos() {
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ListaContatos(),
            ),
          );
        },
        child: _contatoContainer(),
      ),
    );
  }

  Widget _contatoContainer() {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 100,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.people,
            color: Colors.white,
          ),
          Text(
            'Contatos',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
