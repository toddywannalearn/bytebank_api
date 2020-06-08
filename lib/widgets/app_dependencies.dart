import 'package:bytebank/http/webclients/transacao_webclient.dart';
import 'package:bytebank/repositories/database/dao/contato_dao.dart';
import 'package:flutter/cupertino.dart';

class AppDependencies extends InheritedWidget {
  final ContatoDao contatoDao;
  final TransacaoWebClient transacaoWebClient;

  AppDependencies(
      {@required this.contatoDao,
      @required this.transacaoWebClient,
      @required Widget child})
      : super(child: child);

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contatoDao != oldWidget.contatoDao ||
        transacaoWebClient != oldWidget.transacaoWebClient;
  }
}
