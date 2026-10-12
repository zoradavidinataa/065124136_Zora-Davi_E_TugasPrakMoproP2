import 'package:flutter/material.dart';

import '../data/menu_data.dart';
import '../models/menu_makanan.dart';
import '../models/pesanan.dart';

class KeranjangController extends ChangeNotifier {
  final Map<int, int> _qty = {};
  final List<Pesanan> riwayat = [];
  int _noBerikut = 1;

  List<MapEntry<MenuMakanan, int>> get items => _qty.entries
      .map((e) => MapEntry(daftarMenu.firstWhere((m) => m.id == e.key), e.value))
      .toList();

  int get totalItem => _qty.values.fold(0, (a, b) => a + b);
  int get subtotal => items.fold(0, (s, e) => s + e.key.harga * e.value);

  void tambah(MenuMakanan m, [int n = 1]) {
    _qty[m.id] = (_qty[m.id] ?? 0) + n;
    notifyListeners();
  }

  void kurang(MenuMakanan m) {
    final q = _qty[m.id] ?? 0;
    if (q <= 1) {
      _qty.remove(m.id);
    } else {
      _qty[m.id] = q - 1;
    }
    notifyListeners();
  }

  void hapus(int id) {
    _qty.remove(id);
    notifyListeners();
  }

  void checkout({
    required int total,
    required String metode,
    required String mode,
    String? meja,
  }) {
    riwayat.insert(
      0,
      Pesanan(
        no: _noBerikut++,
        waktu: DateTime.now(),
        items: items,
        total: total,
        metode: metode,
        mode: mode,
        meja: meja,
        status: 'Diproses',
      ),
    );
    _qty.clear();
    notifyListeners();
  }
}

final keranjang = KeranjangController();
final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);
