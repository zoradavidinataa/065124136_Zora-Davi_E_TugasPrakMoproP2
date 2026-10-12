# 🍛 Kantin Bu Sari

Aplikasi pemesanan kantin berbasis Flutter — tugas Praktikum Mobile Programming (Maroon Labkom, P2 Recalling Flutter).

## Fitur
- Beranda: pencarian menu, banner promo, filter kategori, daftar menu
- Detail menu: catatan, pilih jumlah, favorit
- Keranjang: ubah jumlah, geser untuk hapus, mode pesanan (Dine-in / Bungkus / Antar), nomor meja, metode bayar, konfirmasi
- Riwayat pesanan dengan detail item
- Profil: mode gelap, notifikasi, bantuan, tentang aplikasi

## Cara menjalankan
Folder ini hanya berisi kode Dart (`lib/`), `pubspec.yaml`, dan test. Folder platform (android/ios/web) dibuat otomatis oleh Flutter:

```bash
cd kantin_bu_sari
flutter create --project-name kantin_bu_sari .
flutter pub get
flutter run
```

`flutter create .` tidak menimpa file yang sudah ada, jadi kode di `lib/` aman. Butuh Flutter 3.27 atau lebih baru.

## Struktur folder
```
lib/
├── main.dart                  # entry point + tema
├── constants.dart             # warna utama
├── models/                    # MenuMakanan, Pesanan
├── data/menu_data.dart        # daftar menu
├── state/app_state.dart       # keranjang & mode tema
├── utils/format.dart          # format rupiah & waktu
├── widgets/menu_card.dart     # kartu menu
└── pages/                     # main_shell, home, detail, keranjang, riwayat, profil
```

## Widget per halaman
| Halaman | Widget utama |
|---|---|
| Beranda | AppBar, TextField, Container (gradient), ChoiceChip, Card, InkWell, IconButton, SnackBar |
| Detail | Container, Chip, TextField, IconButton, Divider, FilledButton |
| Keranjang | Dismissible, SegmentedButton, DropdownButtonFormField, ChoiceChip, AlertDialog |
| Riwayat | ListView.builder, ExpansionTile, CircleAvatar, Chip, ListTile |
| Profil | CircleAvatar, SwitchListTile, ListTile, BottomSheet, AboutDialog |
