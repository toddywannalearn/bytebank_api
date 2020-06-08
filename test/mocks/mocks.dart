
import 'package:bytebank/http/webclients/transacao_webclient.dart';
import 'package:bytebank/repositories/database/dao/contato_dao.dart';
import 'package:mockito/mockito.dart';

class MockContatoDao extends Mock implements ContatoDao{}

class MockTransacaoWebClient extends Mock implements TransacaoWebClient{}