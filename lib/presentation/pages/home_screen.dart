import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/barang.dart';
import '../controller/barang_controller.dart';

class HomeScreen extends GetView<BarangController> {
  const HomeScreen({super.key});
  Future<void> formBarang(BuildContext context, [Barang? barang]) async {
    final result = await showDialog<Barang>(context: context, builder: (_) => _BarangForm(barang: barang));
    if (result == null) return;
    try { await controller.simpan(result); }
    catch (e) { Get.snackbar('Gagal', '$e'); }
  }
  Future<void> hapusBarang(BuildContext context, Barang barang) async {
    final confirm = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Hapus barang?'), content: Text('Hapus ${barang.nama}?'),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')), FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Hapus'))],
    ));
    if (confirm != true) return;
    try { await controller.hapus(barang.id!); } catch (e) { Get.snackbar('Gagal', '$e'); }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Data Barang')),
    body: Obx(() {
      if (controller.loading.value) return const Center(child: CircularProgressIndicator());
      if (controller.error.value.isNotEmpty) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(controller.error.value), TextButton(onPressed: controller.loadBarang, child: const Text('Coba lagi'))]));
      if (controller.barangList.isEmpty) return const Center(child: Text('Belum ada barang'));
      return ListView.builder(itemCount: controller.barangList.length, itemBuilder: (context, index) {
        final barang = controller.barangList[index];
        return Card(child: ListTile(title: Text(barang.nama), subtitle: Text('Stok: ${barang.stok}'), trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(tooltip: 'Edit', icon: const Icon(Icons.edit), onPressed: () => formBarang(context, barang)), IconButton(tooltip: 'Hapus', icon: const Icon(Icons.delete), onPressed: () => hapusBarang(context, barang))])));
      });
    }),
    floatingActionButton: FloatingActionButton(onPressed: () => formBarang(context), child: const Icon(Icons.add)),
  );
}
class _BarangForm extends StatefulWidget {
  final Barang? barang;
  const _BarangForm({this.barang});
  @override
  State<_BarangForm> createState() => _BarangFormState();
}
class _BarangFormState extends State<_BarangForm> {
  final key = GlobalKey<FormState>();
  late final TextEditingController nama = TextEditingController(text: widget.barang?.nama ?? '');
  late final TextEditingController stok = TextEditingController(text: widget.barang?.stok.toString() ?? '');
  @override
  void dispose() { nama.dispose(); stok.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.barang == null ? 'Tambah Barang' : 'Edit Barang'),
    content: SingleChildScrollView(child: Form(key: key, child: Column(mainAxisSize: MainAxisSize.min, children: [
      TextFormField(controller: nama, decoration: const InputDecoration(labelText: 'Nama barang'), validator: (v) => v == null || v.trim().isEmpty ? 'Nama wajib diisi' : null),
      TextFormField(controller: stok, decoration: const InputDecoration(labelText: 'Stok'), keyboardType: TextInputType.number, validator: (v) { final n = int.tryParse(v ?? ''); return n == null || n < 0 ? 'Masukkan stok yang valid' : null; }),
    ]))),
    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')), FilledButton(onPressed: () { if (key.currentState!.validate()) Navigator.pop(context, Barang(id: widget.barang?.id, nama: nama.text.trim(), stok: int.parse(stok.text))); }, child: const Text('Simpan'))],
  );
}
