import 'package:flutter_test/flutter_test.dart';
import 'package:kantin_bu_sari/main.dart';

void main() {
  testWidgets('Aplikasi menampilkan beranda Kantin Bu Sari', (tester) async {
    await tester.pumpWidget(const KantinApp());
    expect(find.text('Kantin Bu Sari'), findsWidgets);
    expect(find.text('Menu Tersedia'), findsOneWidget);
  });
}
