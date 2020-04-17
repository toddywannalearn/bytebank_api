import 'package:bytebank/models/contatos.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'byteBank.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contatos('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
    }, version: 1);
  });
}

Future<int> save(Contato contato) {
  return createDatabase().then((db) {
    final Map<String, dynamic> mapContatos = Map();
    mapContatos['id'] = contato.id;
    mapContatos['name'] = contato.name;
    mapContatos['account_number'] = contato.accountNumber;

    return db.insert('contatos', mapContatos);
  });
}

Future<List<Contato>> findAll() {
  return createDatabase().then((db) {
    return db.query('contatos').then((maps) {
      final List<Contato> contatos = List();
      for (Map<String, dynamic> map in maps) {
        final Contato contato = Contato(
          map['id'],
          map['name'],
          map['account_number'],
        );
        contatos.add(contato);
      }
      return contatos;
    });
  });
}

Future<int> deleteAll(){
  return createDatabase().then((db){
    return db.delete('contatos');
  });
}
