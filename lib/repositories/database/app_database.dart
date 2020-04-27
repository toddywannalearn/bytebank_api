import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/contato_dao.dart';


/// implementacão usando async await
Future<Database> createDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContatoDao.tableSql);
  }, version: 1);
}

/// Implementação utilizando .then
//Future<Database> createDatabase() {
//  return getDatabasesPath().then((dbPath) {
//    final String path = join(dbPath, 'byteBank.db');
//    return openDatabase(path, onCreate: (db, version) {
//      db.execute('CREATE TABLE contatos('
//          'id INTEGER PRIMARY KEY, '
//          'name TEXT, '
//          'account_number INTEGER)');
//    }, version: 1);
//  //  onDowngrade: onDatabaseDowngradeDelete);
//  });
//}

/// implementacão usando async await
Future<int> deleteAll() async {
  final Database db = await createDatabase();
  var delete = await db.delete('contatos');
  return delete;
}

/// Implementação utilizando .then
//Future<int> deleteAll() {
//  return createDatabase().then((db) {
//    return db.delete('contatos');
//  });
//}


