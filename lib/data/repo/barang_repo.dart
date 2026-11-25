import '../../model/barang.dart';
import '../dao/barang_dao.dart';

abstract class BarangRepo {
  Future<List<Barang>> getAllBarang();
  Future<int> insertBarang(Barang barang);
  Future<int> updateBarang(Barang barang);
  Future<int> deleteBarang(int id);
}
class BarangRepoImpl implements BarangRepo {
  final BarangDao dao;
  BarangRepoImpl(this.dao);
  @override
  Future<List<Barang>> getAllBarang() => dao.getAllBarang();
  @override
  Future<int> insertBarang(Barang barang) => dao.insert(barang);
  @override
  Future<int> updateBarang(Barang barang) => dao.update(barang);
  @override
  Future<int> deleteBarang(int id) => dao.delete(id);
}
