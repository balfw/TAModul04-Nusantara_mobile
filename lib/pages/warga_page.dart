
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';

const hijau = Color(0xFF16845B);

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<PengajuanModel>().daftar;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F6),
      appBar: AppBar(
        backgroundColor: hijau,
        foregroundColor: Colors.white,
        title: const Text('Nusantara Cerdas Mobile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: hijau,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_city, color: Colors.white, size: 42),
                SizedBox(height: 12),
                Text(
                  'Layanan Publik dalam Genggaman',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Nusantara Cerdas Mobile membantu warga '
                  'mengajukan layanan, menghubungi petugas, '
                  'menemukan lokasi kantor, dan memantau '
                  'pengajuan secara praktis melalui ponsel.',
                  style: TextStyle(color: Colors.white, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Ringkasan Pengajuan',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _kartu('Total', data.length, Icons.assignment),
              _kartu(
                'Diproses',
                data.where((p) => !p.selesai).length,
                Icons.pending_actions,
              ),
              _kartu(
                'Selesai',
                data.where((p) => p.selesai).length,
                Icons.check_circle_outline,
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Pengajuan Saya',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (data.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(22),
                child: Column(
                  children: [
                    Icon(Icons.inbox_outlined, size: 40, color: hijau),
                    SizedBox(height: 8),
                    Text('Belum ada pengajuan layanan.'),
                    Text('Tekan tombol di bawah untuk memulai.'),
                  ],
                ),
              ),
            ),
          ...data.map(
            (p) => Card(
              child: ListTile(
                leading: const Icon(Icons.assignment, color: hijau),
                title: Text(p.nama),
                subtitle: Text('${p.bidang} • Sesi ${p.sesi}'),
                trailing: Text(p.selesai ? 'Selesai' : 'Diproses'),
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.detail,
                  arguments: p.id,
                ),
                onLongPress: () {
                  context.read<PengajuanModel>().tandaiSelesai(p.id);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: hijau,
        foregroundColor: Colors.white,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.form),
        icon: const Icon(Icons.add),
        label: const Text('Ajukan Layanan'),
      ),
    );
  }

  Widget _kartu(String judul, int jumlah, IconData ikon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 3),
          child: Column(
            children: [
              Icon(ikon, color: hijau),
              const SizedBox(height: 8),
              Text(
                '$jumlah',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: hijau,
                ),
              ),
              Text(judul, style: const TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
