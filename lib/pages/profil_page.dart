import 'package:flutter/material.dart';

import '../constants.dart';
import '../state/app_state.dart';

// ---------------------------------------------------------------------
//  HALAMAN 5: PROFIL
//  Widget: CircleAvatar, Card, SwitchListTile, ListTile, Divider,
//          showModalBottomSheet, showAboutDialog, Row/Column
// ---------------------------------------------------------------------
class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool _notif = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil',
            style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFFC2410C), Color(0xFFF59E0B)],
              ),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 44, color: kPrimary),
                ),
                const SizedBox(height: 12),
                const Text('Pelanggan Setia',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800)),
                const Text('Member Kantin Bu Sari',
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 16),
                ListenableBuilder(
                  listenable: keranjang,
                  builder: (_, __) => Row(
                    children: [
                      _stat('Pesanan', '${keranjang.riwayat.length}'),
                      _stat('Di keranjang', '${keranjang.totalItem}'),
                      _stat('Poin', '${keranjang.riwayat.length * 10}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode_outlined),
                  title: const Text('Mode gelap'),
                  value: themeMode.value == ThemeMode.dark,
                  onChanged: (v) {
                    themeMode.value = v ? ThemeMode.dark : ThemeMode.light;
                    setState(() {});
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.notifications_active_outlined),
                  title: const Text('Notifikasi pesanan'),
                  value: _notif,
                  onChanged: (v) => setState(() => _notif = v),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Bantuan'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (_) => const Padding(
                      padding: EdgeInsets.fromLTRB(24, 0, 24, 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Butuh bantuan?',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800)),
                          SizedBox(height: 12),
                          ListTile(
                            leading: Icon(Icons.access_time),
                            title: Text('Jam buka'),
                            subtitle: Text('Senin - Jumat, 07.00 - 16.00'),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text('Hubungi Bu Sari'),
                            subtitle: Text('0812-3456-7890'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Tentang aplikasi'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => showAboutDialog(
                    context: context,
                    applicationName: 'Kantin Bu Sari',
                    applicationVersion: '1.0.0',
                    applicationIcon: const Text('🍛',
                        style: TextStyle(fontSize: 32)),
                    children: const [
                      Text('Aplikasi pemesanan kantin - Praktikum Mobile Programming.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String label, String nilai) {
    return Expanded(
      child: Column(
        children: [
          Text(nilai,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800)),
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}
