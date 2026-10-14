
import 'package:flutter/material.dart';

class Pengajuan {
  final int id;
  final String nama;
  final String email;
  final String sesi;
  final String bidang;
  final DateTime tanggal;
  bool selesai;

  Pengajuan({
    required this.id,
    required this.nama,
    required this.email,
    required this.sesi,
    required this.bidang,
    required this.tanggal,
    this.selesai = false,
  });
}

class PengajuanModel extends ChangeNotifier {
  final List<Pengajuan> _daftar = [];
  int _idBerikutnya = 1;

  List<Pengajuan> get daftar =>
      List.unmodifiable(_daftar);

  int jumlahBidang(String bidang) {
    return _daftar.where((p) => p.bidang == bidang).length;
  }

  void tambahPengajuan({
    required String nama,
    required String email,
    required String sesi,
    required String bidang,
  }) {
    _daftar.add(
      Pengajuan(
        id: _idBerikutnya++,
        nama: nama,
        email: email,
        sesi: sesi,
        bidang: bidang,
        tanggal: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Pengajuan? cariById(int id) {
    for (final pengajuan in _daftar) {
      if (pengajuan.id == id) return pengajuan;
    }
    return null;
  }

  void tandaiSelesai(int id) {
    final pengajuan = cariById(id);
    if (pengajuan != null && !pengajuan.selesai) {
      pengajuan.selesai = true;
      notifyListeners();
    }
  }
}
