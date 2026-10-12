import 'menu_makanan.dart';

class Pesanan {
  final int no;
  final DateTime waktu;
  final List<MapEntry<MenuMakanan, int>> items;
  final int total;
  final String metode;
  final String mode;
  final String? meja;
  final String status;

  const Pesanan({
    required this.no,
    required this.waktu,
    required this.items,
    required this.total,
    required this.metode,
    required this.mode,
    required this.meja,
    required this.status,
  });
}
