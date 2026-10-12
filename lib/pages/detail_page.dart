import 'package:flutter/material.dart';

import '../models/menu_makanan.dart';
import '../state/app_state.dart';
import '../utils/format.dart';

// ---------------------------------------------------------------------
//  HALAMAN 2: DETAIL MENU
//  Widget: AppBar, Container, Wrap+Chip, Text, TextField, IconButton,
//          FilledButton, Divider, SafeArea
// ---------------------------------------------------------------------
class DetailPage extends StatefulWidget {
  final MenuMakanan menu;
  const DetailPage({super.key, required this.menu});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _qty = 1;
  bool _fav = false;
  final _catatan = TextEditingController();

  @override
  void dispose() {
    _catatan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.menu;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Menu'),
        actions: [
          IconButton(
            icon: Icon(_fav ? Icons.favorite : Icons.favorite_border,
                color: _fav ? Colors.red : null),
            onPressed: () => setState(() => _fav = !_fav),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [cs.primaryContainer, cs.tertiaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(m.emoji, style: const TextStyle(fontSize: 96)),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(m.nama,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w800)),
              ),
              Text(rupiah(m.harga),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: cs.primary)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              Chip(
                avatar: const Icon(Icons.category, size: 16),
                label: Text(m.kategori),
              ),
              Chip(
                avatar: const Icon(Icons.star_rounded,
                    size: 18, color: Colors.amber),
                label: Text('${m.rating}'),
              ),
              Chip(
                avatar: const Icon(Icons.local_fire_department,
                    size: 18, color: Colors.deepOrange),
                label: Text('${m.terjual}x terjual'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(m.deskripsi,
              style: TextStyle(height: 1.5, color: cs.onSurfaceVariant)),
          const Divider(height: 32),
          const Text('Catatan untuk penjual',
              style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          TextField(
            controller: _catatan,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Contoh: tidak pedas, es dipisah...',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(
                child: Text('Jumlah',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              IconButton.outlined(
                icon: const Icon(Icons.remove),
                onPressed: _qty > 1 ? () => setState(() => _qty--) : null,
              ),
              SizedBox(
                width: 48,
                child: Text('$_qty',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800)),
              ),
              IconButton.outlined(
                icon: const Icon(Icons.add),
                onPressed: () => setState(() => _qty++),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            icon: const Icon(Icons.add_shopping_cart),
            label: Text('Tambah  •  ${rupiah(m.harga * _qty)}'),
            onPressed: () {
              keranjang.tambah(m, _qty);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$_qty × ${m.nama} masuk keranjang'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
