import 'dart:convert';

import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String url = 'http://192.168.0.4:8080/transactions';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('url: ${data.url}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('status code: ${data.statusCode}');
    return data;
  }
}

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);

Future<List<Transacao>> findAll() async {
  final Response response = await client.get(url).timeout(Duration(seconds: 5));

  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transacao> transacoes = List();

  for (Map<String, dynamic> element in decodedJson) {
    final Map<String, dynamic> contatoJson = element['contact'];

    final Transacao transacao = Transacao(
      element['value'],
      Contato(
        0,
        contatoJson['name'],
        contatoJson['accountNumber'],
      ),
    );
    transacoes.add(transacao);
  }
  return transacoes;
}

Future<Transacao> insertTransaction(Transacao transacao) async {
  final Map<String, dynamic> transacaoMap = {
    'value': transacao.valor,
    'contact': {
      'name': transacao.contato.name,
      'accountNumber': transacao.contato.accountNumber,
    },
  };

  final String transacaoJson = jsonEncode(transacaoMap);

  final Response response = await client.post(url,
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transacaoJson);

  Map<String, dynamic> responseJson = jsonDecode(response.body);

  final Map<String, dynamic> contatoJson = responseJson['contact'];

  return Transacao(
    responseJson['value'],
    Contato(
      0,
      contatoJson['name'],
      contatoJson['accountNumber'],
    ),
  );
}
