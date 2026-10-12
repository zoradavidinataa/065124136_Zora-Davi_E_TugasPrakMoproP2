import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../utils/format.dart';

// ---------------------------------------------------------------------
//  HALAMAN 4: RIWAYAT
//  Widget: ListView.builder, Card, ExpansionTile, CircleAvatar, Chip,
//          ListTile, Divider
// ---------------------------------------------------------------------
class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ListenableBuilder(
        listenable: keranjang,
        builder: (context, _) {
          final data = keranjang.riwayat;
          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.receipt_long_outlined,
                      size: 72, color: cs.outline),
                  const SizedBox(height: 12),
                  const Text('Belum ada riwayat pesanan',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: data.length,
            itemBuilder: (_, i) {
              final p = data[i];
              return Card(
                elevation: 0,
                color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
                margin: const EdgeInsets.only(bottom: 12),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: ExpansionTile(
                  shape: const Border(),
                  collapsedShape: const Border(),
                  leading: CircleAvatar(
                    backgroundColor: cs.primaryContainer,
                    child: Icon(Icons.fastfood, color: cs.primary),
                  ),
                  title: Text('Pesanan #${p.no.toString().padLeft(3, '0')}',
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text(
                      '${formatWaktu(p.waktu)}\n${p.mode}${p.meja != null ? ' • ${p.meja}' : ''} • ${p.metode}'),
                  trailing: Chip(
                    visualDensity: VisualDensity.compact,
                    label: Text(p.status),
                    avatar: const Icon(Icons.timelapse, size: 16),
                  ),
                  children: [
                    ...p.items.map((e) => ListTile(
                          dense: true,
                          leading: Text(e.key.emoji,
                              style: const TextStyle(fontSize: 22)),
                          title: Text(e.key.nama),
                          trailing: Text(
                              '${e.value} × ${rupiah(e.key.harga)}'),
                        )),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total',
                              style:
                                  TextStyle(fontWeight: FontWeight.w700)),
                          Text(rupiah(p.total),
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: cs.primary)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
