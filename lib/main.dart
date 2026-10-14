
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/pengajuan_model.dart';
import 'model/chat_model.dart';
import 'navigation/app_routes.dart';
import 'navigation/kerangka_navigasi.dart';

import 'pages/rincian_layanan_page.dart';
import 'pages/detail_pengajuan_page.dart';
import 'pages/tanya_petugas_page.dart';
import 'pages/lokasi_kantor_page.dart';
import 'pages/statistik_layanan_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PengajuanModel()),
        ChangeNotifierProvider(create: (_) => ChatModel()),
      ],
      child: const NusantaraCerdasApp(),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    const hijau = Color(0xFF16845B);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nusantara Cerdas Mobile',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: hijau,
          brightness: Brightness.light,
          primary: hijau,
          surface: Colors.white,
        ),

        scaffoldBackgroundColor: const Color(0xFFF5F9F6),

        appBarTheme: const AppBarTheme(
          backgroundColor: hijau,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: hijau,
              width: 2,
            ),
          ),
        ),

        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Color(0xFFD7F0E0),
          elevation: 4,
        ),

        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(
          backgroundColor: hijau,
          foregroundColor: Colors.white,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: hijau,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      initialRoute: AppRoutes.warga,

      routes: {
        AppRoutes.warga: (_) => const KerangkaNavigasi(),
        AppRoutes.form: (_) => const RincianLayananPage(),
        AppRoutes.detail: (_) => const DetailPengajuanPage(),
        AppRoutes.chat: (_) => const TanyaPetugasPage(),
        AppRoutes.peta: (_) => const LokasiKantorPage(),
        AppRoutes.statistik: (_) => const StatistikLayananPage(),
      },
    );
  }
}
