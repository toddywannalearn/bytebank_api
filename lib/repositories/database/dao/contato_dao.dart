import 'package:bytebank/models/contatos.dart';
import 'package:sqflite/sqlite_api.dart';

import '../app_database.dart';

class ContatoDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';
  static const String _tableName = 'contatos';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';


  /// implementacão usando async await
  Future<int> save(Contato contato) async {
    final Database db = await createDatabase();
    Map<String, dynamic> mapContatos = _toMap(contato);

    return db.insert(_tableName, mapContatos);
  }

  Map<String, dynamic> _toMap(Contato contato) {
    final Map<String, dynamic> mapContatos = Map();
    //mapContatos['id'] = contato.id;
    mapContatos[_name] = contato.name;
    mapContatos[_accountNumber] = contato.accountNumber;
    return mapContatos;
  }

  /// Implementação utilizando .then
//Future<int> save(Contato contato) {
//  return createDatabase().then((db) {
//    final Map<String, dynamic> mapContatos = Map();
//    mapContatos['id'] = contato.id;
//    mapContatos['name'] = contato.name;
//    mapContatos['account_number'] = contato.accountNumber;
//
//    return db.insert('contatos', mapContatos);
//  });
//}

  /// implementacão usando async await
  Future<List<Contato>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> resultado = await db.query(_tableName);
    List<Contato> contatos = _toList(resultado);
    return contatos;
  }

  List<Contato> _toList(List<Map<String, dynamic>> resultado) {
    final List<Contato> contatos = List();
    for (Map<String, dynamic> row in resultado) {
      final Contato contato = Contato(
        row[_id],
        row[_name],
        row[_accountNumber],
      );
      contatos.add(contato);
    }
    return contatos;
  }

  /// Implementação utilizando .then
//Future<List<Contato>> findAll() {
//  return createDatabase().then((db) {
//    return db.query('contatos').then((maps) {
//      final List<Contato> contatos = List();
//      for (Map<String, dynamic> map in maps) {
//        final Contato contato = Contato(
//          map['id'],
//          map['name'],
//          map['account_number'],
//        );
//        contatos.add(contato);
//      }
//      return contatos;
//    });
//  });
//}

  Future<int> deleteContato(int registroId) async {
    final Database db = await createDatabase();
    return db.rawDelete('DELETE FROM $_tableName WHERE $_id = $registroId');
  }
}
