import 'package:flutter/material.dart';

import '../state/app_state.dart';
import 'home_page.dart';
import 'keranjang_page.dart';
import 'profil_page.dart';
import 'riwayat_page.dart';

// ---------------------------------------------------------------------
//  SHELL: Bottom Navigation
// ---------------------------------------------------------------------
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final List<Widget> _pages = const [
    HomePage(),
    KeranjangPage(),
    RiwayatPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: ListenableBuilder(
        listenable: keranjang,
        builder: (_, __) => NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.storefront_outlined),
              selectedIcon: Icon(Icons.storefront),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: keranjang.totalItem > 0,
                label: Text('${keranjang.totalItem}'),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              selectedIcon: Badge(
                isLabelVisible: keranjang.totalItem > 0,
                label: Text('${keranjang.totalItem}'),
                child: const Icon(Icons.shopping_cart),
              ),
              label: 'Keranjang',
            ),
            const NavigationDestination(
              icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long),
              label: 'Riwayat',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
