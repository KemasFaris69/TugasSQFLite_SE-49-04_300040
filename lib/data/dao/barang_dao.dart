import '../../model/barang.dart';
import '../database/db_helper.dart';

class BarangDao {
  final DbHelper _dbHelper;
  BarangDao(this._dbHelper);
  static const _namaTabel = DbHelper.tableName;
  Future<int> insert(Barang barang) async => (await _dbHelper.database).insert(_namaTabel, barang.toMap());
  Future<List<Barang>> getAllBarang() async {
    final rows = await (await _dbHelper.database).query(_namaTabel, orderBy: 'id DESC');
    return rows.map(Barang.fromMap).toList();
  }
  Future<int> update(Barang barang) async {
    if (barang.id == null) throw ArgumentError('ID wajib diisi');
    return (await _dbHelper.database).update(_namaTabel, {'nama': barang.nama, 'stok': barang.stok}, where: 'id = ?', whereArgs: [barang.id]);
  }
  Future<int> delete(int id) async => (await _dbHelper.database).delete(_namaTabel, where: 'id = ?', whereArgs: [id]);
}
