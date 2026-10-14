
import 'package:flutter/material.dart';

class Pesan {
  final String teks;
  final bool dariWarga;
  final DateTime waktu;

  Pesan({
    required this.teks,
    required this.dariWarga,
    required this.waktu,
  });
}

class ChatModel extends ChangeNotifier {
  final List<Pesan> _pesan = [
    Pesan(
      teks: 'Selamat datang. Ada yang bisa kami bantu?',
      dariWarga: false,
      waktu: DateTime.now(),
    ),
  ];

  List<Pesan> get pesan => List.unmodifiable(_pesan);

  void kirim(String teks, {required bool dariWarga}) {
    if (teks.trim().isEmpty) return;

    _pesan.add(
      Pesan(
        teks: teks.trim(),
        dariWarga: dariWarga,
        waktu: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
