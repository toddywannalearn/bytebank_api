import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:http/http.dart';

class TransacaoWebClient {
  final String url = 'http://192.168.0.4:8080/transactions';

  Future<List<Transacao>> findAll() async {
    final Response response =
        await client.get(url).timeout(Duration(seconds: 5));

    List<Transacao> transacoes = _toTransacoes(response);
    return transacoes;
  }

  Future<Transacao> insertTransacao(Transacao transacao) async {
    Map<String, dynamic> transacaoMap = _toMap(transacao);

    final String transacaoJson = jsonEncode(transacaoMap);

    final Response response = await client.post(url,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transacaoJson);

    return _toTransacao(response);
  }

  List<Transacao> _toTransacoes(Response response) {
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

  Transacao _toTransacao(Response response) {
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

  Map<String, dynamic> _toMap(Transacao transacao) {
    final Map<String, dynamic> transacaoMap = {
      'value': transacao.valor,
      'contact': {
        'name': transacao.contato.name,
        'accountNumber': transacao.contato.accountNumber,
      },
    };
    return transacaoMap;
  }
}
