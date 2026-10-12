import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../utils/format.dart';

// ---------------------------------------------------------------------
//  HALAMAN 3: KERANJANG
//  Widget: Dismissible, Card, SegmentedButton, DropdownButtonFormField,
//          ChoiceChip, AlertDialog, FilledButton, Divider
// ---------------------------------------------------------------------
class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  String _mode = 'Dine-in';
  String _meja = 'Meja 1';
  String _metode = 'Tunai';

  int get _ongkir => _mode == 'Antar' ? 3000 : 0;

  Future<void> _konfirmasi(int total) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.receipt_long),
        title: const Text('Konfirmasi Pesanan'),
        content: Text(
            'Total pembayaran ${rupiah(total)} via $_metode.\nLanjutkan pesan?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Pesan Sekarang')),
        ],
      ),
    );
    if (ok == true && mounted) {
      keranjang.checkout(
        total: total,
        metode: _metode,
        mode: _mode,
        meja: _mode == 'Dine-in' ? _meja : null,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pesanan berhasil! Cek di tab Riwayat 🎉'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ListenableBuilder(
        listenable: keranjang,
        builder: (context, _) {
          final items = keranjang.items;
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 72, color: cs.outline),
                  const SizedBox(height: 12),
                  const Text('Keranjangmu masih kosong',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text('Yuk pilih menu di tab Beranda',
                      style: TextStyle(color: cs.onSurfaceVariant)),
                ],
              ),
            );
          }

          final total = keranjang.subtotal + _ongkir;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              ...items.map((e) {
                final m = e.key;
                final q = e.value;
                return Dismissible(
                  key: ValueKey(m.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => keranjang.hapus(m.id),
                  background: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: cs.error,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(Icons.delete, color: cs.onError),
                  ),
                  child: Card(
                    elevation: 0,
                    color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: cs.primaryContainer,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(m.emoji,
                                style: const TextStyle(fontSize: 28)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(m.nama,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700)),
                                Text(rupiah(m.harga * q),
                                    style: TextStyle(
                                        color: cs.primary,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => keranjang.kurang(m),
                          ),
                          Text('$q',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 16)),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => keranjang.tambah(m),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              const Text('Mode Pesanan',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                        value: 'Dine-in',
                        icon: Icon(Icons.restaurant),
                        label: Text('Dine-in')),
                    ButtonSegment(
                        value: 'Bungkus',
                        icon: Icon(Icons.takeout_dining),
                        label: Text('Bungkus')),
                    ButtonSegment(
                        value: 'Antar',
                        icon: Icon(Icons.delivery_dining),
                        label: Text('Antar')),
                  ],
                  selected: {_mode},
                  onSelectionChanged: (s) => setState(() => _mode = s.first),
                ),
              ),
              if (_mode == 'Dine-in') ...[
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _meja,
                  decoration: InputDecoration(
                    labelText: 'Nomor meja',
                    prefixIcon: const Icon(Icons.table_restaurant),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  items: List.generate(
                    10,
                    (i) => DropdownMenuItem(
                      value: 'Meja ${i + 1}',
                      child: Text('Meja ${i + 1}'),
                    ),
                  ),
                  onChanged: (v) => setState(() => _meja = v ?? _meja),
                ),
              ],
              const SizedBox(height: 16),
              const Text('Metode Pembayaran',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['Tunai', 'QRIS', 'Transfer']
                    .map((x) => ChoiceChip(
                          label: Text(x),
                          selected: _metode == x,
                          onSelected: (_) => setState(() => _metode = x),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 0,
                color: cs.primaryContainer.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _barisHarga('Subtotal', rupiah(keranjang.subtotal)),
                      const SizedBox(height: 6),
                      _barisHarga('Biaya antar', rupiah(_ongkir)),
                      const Divider(height: 24),
                      _barisHarga('Total', rupiah(total), tebal: true),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Pesan Sekarang'),
                onPressed: () => _konfirmasi(total),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _barisHarga(String label, String nilai, {bool tebal = false}) {
    final style = TextStyle(
      fontSize: tebal ? 17 : 14,
      fontWeight: tebal ? FontWeight.w800 : FontWeight.w500,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(label, style: style), Text(nilai, style: style)],
    );
  }
}
