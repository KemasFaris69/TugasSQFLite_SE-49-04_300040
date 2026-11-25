import 'package:get/get.dart';
import '../../data/repo/barang_repo.dart';
import '../../model/barang.dart';

class BarangController extends GetxController {
  final BarangRepo repo;
  BarangController(this.repo);
  final barangList = <Barang>[].obs;
  final loading = false.obs;
  final error = ''.obs;
  @override
  void onInit() { super.onInit(); loadBarang(); }
  Future<void> loadBarang() async {
    loading.value = true;
    error.value = '';
    try { barangList.assignAll(await repo.getAllBarang()); }
    catch (e) { error.value = 'Gagal membaca data: $e'; }
    finally { loading.value = false; }
  }
  Future<void> simpan(Barang barang) async {
    if (barang.id == null) { await repo.insertBarang(barang); }
    else { await repo.updateBarang(barang); }
    await loadBarang();
  }
  Future<void> hapus(int id) async { await repo.deleteBarang(id); await loadBarang(); }
}
