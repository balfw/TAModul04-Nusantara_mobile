
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pengajuan_model.dart';
import 'warga_page.dart';

class DetailPengajuanPage extends StatelessWidget {
  const DetailPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    final p = context.watch<PengajuanModel>().cariById(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengajuan'),
        backgroundColor: hijau,
        foregroundColor: Colors.white,
      ),
      body: p == null
          ? const Center(child: Text('Pengajuan tidak ditemukan.'))
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Icon(Icons.assignment_turned_in, size: 65, color: hijau),
                const SizedBox(height: 12),
                Text(
                  p.bidang,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _baris('Nama', p.nama),
                _baris('Email', p.email),
                _baris('Sesi', p.sesi),
                _baris(
                  'Tanggal',
                  '${p.tanggal.day}/${p.tanggal.month}/${p.tanggal.year}',
                ),
                _baris('Status', p.selesai ? 'Selesai' : 'Diproses'),
              ],
            ),
    );
  }

  Widget _baris(String label, String nilai) => Card(
        child: ListTile(
          title: Text(label, style: const TextStyle(color: Colors.grey)),
          subtitle: Text(
            nilai,
            style: const TextStyle(fontSize: 16, color: hijau),
          ),
        ),
      );
}
