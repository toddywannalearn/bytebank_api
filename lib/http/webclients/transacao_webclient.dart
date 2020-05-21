import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/contatoXtransacao.dart';
import 'package:bytebank/models/transacao.dart';
import 'package:bytebank/repositories/database/dao/contato_dao.dart';
import 'package:http/http.dart';

class TransacaoWebClient {
  Future<List<Transacao>> findAll() async {
    final Response response = await client.get(url);

    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transacao> transacoes =
        decodedJson.map((dynamic json) => Transacao.fromJson(json)).toList();

    return transacoes;
  }

  Future<Transacao> insertTransacao(
      Transacao transacao, String password) async {
    final String transacaoJson = jsonEncode(transacao.toJson());

    final Response response = await client.post(url,
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transacaoJson);

    if (response.statusCode == 200) {
      return Transacao.fromJson(jsonDecode(response.body));
    }

    _throwHttpError(response.statusCode);
  }

  void _throwHttpError(int statusCode) {
    throw HttpException(_getMessage(statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponse.containsKey(statusCode)) {
      return _statusCodeResponse[statusCode];
    }
    return 'Erro Desconhecido';
  }

  static final Map<int, String> _statusCodeResponse = {
    400: 'Erro na validação dos campos',
    401: 'Falha na autenticação',
    409: 'A transação já existe',
  };

  Future<List<ContatoxTransacao>> contatoxtransacao() async {
    List<Transacao> transacoes = await findAll();
    List<Contato> contatos = await ContatoDao().findAll();

    List<ContatoxTransacao> contatoTransacoes = List();

    _totalPorContato(contatos, transacoes, contatoTransacoes);
    return contatoTransacoes;
  }

  void _totalPorContato(List<Contato> contatos, List<Transacao> transacoes,
      List<ContatoxTransacao> contatoTransacoes) {
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

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
