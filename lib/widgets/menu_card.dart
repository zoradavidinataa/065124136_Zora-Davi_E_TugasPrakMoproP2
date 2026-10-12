import 'package:flutter/material.dart';

import '../models/menu_makanan.dart';
import '../pages/detail_page.dart';
import '../state/app_state.dart';
import '../utils/format.dart';

class MenuCard extends StatelessWidget {
  final MenuMakanan menu;
  const MenuCard({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DetailPage(menu: menu)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(menu.emoji, style: const TextStyle(fontSize: 36)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(menu.nama,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(menu.deskripsi,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12, color: cs.onSurfaceVariant)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            size: 16, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text('${menu.rating}',
                            style: const TextStyle(fontSize: 12)),
                        const SizedBox(width: 10),
                        Text(rupiah(menu.harga),
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: cs.primary)),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton.filled(
                tooltip: 'Tambah ke keranjang',
                icon: const Icon(Icons.add),
                onPressed: () {
                  keranjang.tambah(menu);
                  final sm = ScaffoldMessenger.of(context);
                  sm.hideCurrentSnackBar();
                  sm.showSnackBar(
                    SnackBar(
                      content: Text('${menu.nama} ditambahkan ke keranjang'),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
