import 'package:bytebank/http/webclients/transacao_webclient.dart';
import 'package:bytebank/repositories/database/dao/contato_dao.dart';
import 'package:flutter/material.dart';
import 'screens/dashboard.dart';
import 'widgets/app_dependencies.dart';

void main() {
  runApp(MyApp(
    contatoDao: ContatoDao(),
    transacaoWebClient: TransacaoWebClient(),
  ));
}

class MyApp extends StatelessWidget {
  final ContatoDao contatoDao;
  final TransacaoWebClient transacaoWebClient;

  MyApp({@required this.contatoDao, @required this.transacaoWebClient});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      transacaoWebClient: transacaoWebClient,
      contatoDao: contatoDao,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.greenAccent,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        //home: AuthDialog(),
        home: Dashboard(),
      ),
    );
  }
}
