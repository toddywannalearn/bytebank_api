import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/contatoXtransacao.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:bytebank/repositories/database/dao/contato_dao.dart';
import 'package:http/http.dart';

class TransacaoWebClient {
  final String url = 'http://192.168.0.17:8080/transactions';

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

  Future<List<ContatoxTransacao>> contatoxtransacao() async {
    List<Transacao> transacoes = await findAll();
    List<Contato> contatos = await ContatoDao().findAll();

    List<ContatoxTransacao> contatoTransacoes = List();

    _totalPorContato(contatos, transacoes, contatoTransacoes);
    return contatoTransacoes;
  }

  void _totalPorContato(List<Contato> contatos, List<Transacao> transacoes, List<ContatoxTransacao> contatoTransacoes) {
    for (var c in contatos) {
      double valor = 0.0;
      for (var t in transacoes) {
        if (c.name == t.contato.name) {
          valor = valor + t.valor;
        }
      }
      contatoTransacoes.add(ContatoxTransacao(c.name, valor));
    }
  }
}
