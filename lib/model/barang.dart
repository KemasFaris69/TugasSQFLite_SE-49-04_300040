import 'dart:convert';

class Barang {
  final int? id;
  final String nama;
  final int stok;
  const Barang({this.id, required this.nama, required this.stok});
  Barang copyWith({int? id, String? nama, int? stok}) => Barang(id: id ?? this.id, nama: nama ?? this.nama, stok: stok ?? this.stok);
  Map<String, dynamic> toMap() => {'id': id, 'nama': nama, 'stok': stok};
  factory Barang.fromMap(Map<String, dynamic> map) => Barang(id: map['id'] as int?, nama: map['nama'] as String, stok: map['stok'] as int);
  String toJson() => json.encode(toMap());
  factory Barang.fromJson(String source) => Barang.fromMap(json.decode(source) as Map<String, dynamic>);
}
