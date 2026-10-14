
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';
import 'warga_page.dart';

class RincianLayananPage extends StatefulWidget {
  const RincianLayananPage({super.key});

  @override
  State<RincianLayananPage> createState() => _RincianLayananPageState();
}

class _RincianLayananPageState extends State<RincianLayananPage> {
  final nama = TextEditingController();
  final email = TextEditingController();
  String sesi = 'Pagi';
  String bidang = 'Administrasi';
  bool setuju = false;
  bool loading = false;

  bool get valid =>
      nama.text.trim().isNotEmpty &&
      email.text.contains('@') &&
      setuju &&
      !loading;

  @override
  void dispose() {
    nama.dispose();
    email.dispose();
    super.dispose();
  }

  Future<void> kirim() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    context.read<PengajuanModel>().tambahPengajuan(
      nama: nama.text.trim(),
      email: email.text.trim(),
      sesi: sesi,
      bidang: bidang,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pengajuan berhasil dikirim!')),
    );
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.warga,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajukan Layanan'),
        backgroundColor: hijau,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Formulir Pengajuan',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Lengkapi data berikut untuk mengajukan layanan.'),
          const SizedBox(height: 22),
          TextField(
            controller: nama,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: 'Nama lengkap',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email_outlined),
              border: const OutlineInputBorder(),
              errorText: email.text.isNotEmpty && !email.text.contains('@')
                  ? 'Email harus mengandung @'
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: bidang,
            decoration: const InputDecoration(
              labelText: 'Jenis layanan',
              border: OutlineInputBorder(),
            ),
            items: ['Administrasi', 'Kependudukan', 'Infrastruktur']
                .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                .toList(),
            onChanged: (v) => setState(() => bidang = v!),
          ),
          const SizedBox(height: 12),
          const Text('Pilih sesi kunjungan'),
          RadioListTile<String>(
            title: const Text('Pagi'),
            value: 'Pagi',
            groupValue: sesi,
            activeColor: hijau,
            onChanged: (v) => setState(() => sesi = v!),
          ),
          RadioListTile<String>(
            title: const Text('Siang'),
            value: 'Siang',
            groupValue: sesi,
            activeColor: hijau,
            onChanged: (v) => setState(() => sesi = v!),
          ),
          CheckboxListTile(
            value: setuju,
            activeColor: hijau,
            contentPadding: EdgeInsets.zero,
            title: const Text('Saya menyetujui penggunaan data untuk layanan.'),
            onChanged: (v) => setState(() => setuju = v!),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: hijau,
              padding: const EdgeInsets.all(15),
            ),
            onPressed: valid ? kirim : null,
            icon: loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.send),
            label: Text(loading ? 'Mengirim...' : 'Kirim Pengajuan'),
          ),
        ],
      ),
    );
  }
}
