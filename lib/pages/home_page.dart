import 'package:flutter/material.dart';

import '../data/menu_data.dart';
import '../models/menu_makanan.dart';
import '../widgets/menu_card.dart';

// ---------------------------------------------------------------------
//  HALAMAN 1: BERANDA
//  Widget: AppBar, TextField, Container(gradient), ChoiceChip, Card,
//          InkWell, IconButton, SnackBar, ListView, Badge
// ---------------------------------------------------------------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _query = '';
  String _kategori = 'Semua';
  final _kategoriList = const ['Semua', 'Makanan', 'Minuman', 'Snack'];

  IconData _ikonKategori(String k) {
    switch (k) {
      case 'Makanan':
        return Icons.rice_bowl;
      case 'Minuman':
        return Icons.local_cafe;
      case 'Snack':
        return Icons.cookie;
      default:
        return Icons.apps;
    }
  }

  List<MenuMakanan> get _hasil => daftarMenu
      .where((m) =>
          (_kategori == 'Semua' || m.kategori == _kategori) &&
          m.nama.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasil = _hasil;

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kantin Bu Sari',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
            Text('Lapar? Pesan dari sini aja 👋',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Notifikasi',
            icon: const Icon(Icons.notifications_none),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Belum ada notifikasi baru'),
                behavior: SnackBarBehavior.floating,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          // Search
          TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Cari menu favoritmu...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Banner promo
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFFC2410C), Color(0xFFF59E0B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Promo Hari Ini',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text('Paket Geprek + Es Teh\nhanya Rp 19.000!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              height: 1.3,
                              fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                const Text('🍗', style: TextStyle(fontSize: 56)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Kategori
          const Text('Kategori',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _kategoriList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final k = _kategoriList[i];
                return ChoiceChip(
                  avatar: Icon(_ikonKategori(k), size: 18),
                  label: Text(k),
                  selected: _kategori == k,
                  onSelected: (_) => setState(() => _kategori = k),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Daftar menu
          Row(
            children: [
              const Expanded(
                child: Text('Menu Tersedia',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
              Text('${hasil.length} item',
                  style: TextStyle(color: cs.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 8),
          if (hasil.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                children: [
                  Icon(Icons.search_off, size: 56, color: cs.outline),
                  const SizedBox(height: 8),
                  const Text('Menu tidak ditemukan'),
                ],
              ),
            )
          else
            ...hasil.map((m) => MenuCard(menu: m)),
        ],
      ),
    );
  }
}
