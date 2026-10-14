
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/chat_model.dart';
import 'warga_page.dart';

class TanyaPetugasPage extends StatefulWidget {
  const TanyaPetugasPage({super.key});

  @override
  State<TanyaPetugasPage> createState() => _TanyaPetugasPageState();
}

class _TanyaPetugasPageState extends State<TanyaPetugasPage> {
  final pesan = TextEditingController();

  @override
  void dispose() {
    pesan.dispose();
    super.dispose();
  }

  
void kirim() {
  final teks = pesan.text.trim();
  if (teks.isEmpty) return;

  context.read<ChatModel>().kirim(
    teks,
    dariWarga: true,
  );
  pesan.clear();

  Future.delayed(const Duration(milliseconds: 700), () {
    if (!mounted) return;

    context.read<ChatModel>().kirim(
      'Terima kasih, pesan kamu sudah kami terima. '
      'Petugas akan membantu kamu.',
      dariWarga: false,
    );
  });
}


  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Petugas'),
        backgroundColor: hijau,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFFE8F5EE),
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: const Text(
              'Layanan bantuan warga • Kirim pertanyaan kamu di sini.',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: chat.pesan.length,
              itemBuilder: (context, i) {
                final p = chat.pesan[i];
                return Align(
                  alignment: p.dariWarga
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: p.dariWarga ? hijau : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      p.teks,
                      style: TextStyle(
                        color: p.dariWarga ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: pesan,
                    decoration: const InputDecoration(
                      hintText: 'Tulis pesan...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => kirim(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  style: IconButton.styleFrom(backgroundColor: hijau),
                  onPressed: kirim,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
