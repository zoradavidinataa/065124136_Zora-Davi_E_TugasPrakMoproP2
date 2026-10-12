String rupiah(int v) {
  final s = v.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (m) => '.',
      );
  return 'Rp $s';
}

String formatWaktu(DateTime w) {
  String dua(int n) => n.toString().padLeft(2, '0');
  return '${dua(w.day)}/${dua(w.month)}/${w.year}  ${dua(w.hour)}:${dua(w.minute)}';
}
