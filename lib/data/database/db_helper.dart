import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const dbName = 'barang.db';
  static const tableName = 'barang';
  Database? _db;
  Future<Database> get database async => _db ??= await _open();
  Future<Database> _open() async => openDatabase(
    join(await getDatabasesPath(), dbName), version: 1,
    onCreate: (db, version) async {
      await db.execute('CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT NOT NULL, stok INTEGER NOT NULL CHECK(stok >= 0))');
    },
  );
}
