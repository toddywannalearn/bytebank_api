import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:http/http.dart';

class TransacaoWebClient {
  final String url = 'http://192.168.0.11:8080/transactions';

  Future<List<Transacao>> findAll() async {
    final Response response =
        await client.get(url).timeout(Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transacao> transacoes =
        decodedJson.map((dynamic json) => Transacao.fromJson(json)).toList();

    return transacoes;
  }

  Future<Transacao> insertTransacao(Transacao transacao) async {
    final String transacaoJson = jsonEncode(transacao.toJson());

    final Response response = await client.post(url,
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transacaoJson);

    return Transacao.fromJson(jsonDecode(response.body));
  }
}
