import 'package:flutter/material.dart';

import 'constants.dart';
import 'pages/main_shell.dart';
import 'state/app_state.dart';

void main() => runApp(const KantinApp());

// ---------------------------------------------------------------------
//  APP ROOT
// ---------------------------------------------------------------------
class KantinApp extends StatelessWidget {
  const KantinApp({super.key});

  ThemeData _tema(Brightness b) => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimary, brightness: b),
        appBarTheme: const AppBarTheme(centerTitle: false),
      );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeMode,
      builder: (_, mode, __) => MaterialApp(
        title: 'Kantin Bu Sari',
        debugShowCheckedModeBanner: false,
        theme: _tema(Brightness.light),
        darkTheme: _tema(Brightness.dark),
        themeMode: mode,
        home: const MainShell(),
      ),
    );
  }
}
