
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../model/pengajuan_model.dart';
import 'warga_page.dart';

class StatistikLayananPage extends StatelessWidget {
  const StatistikLayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();
    final bidang = ['Administrasi', 'Kependudukan', 'Infrastruktur'];
    final jumlah = bidang.map(model.jumlahBidang).toList();
    final total = model.daftar.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik Layanan'),
        backgroundColor: hijau,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: const Color(0xFFE8F5EE),
            child: ListTile(
              leading: const Icon(
                Icons.analytics_outlined,
                color: hijau,
                size: 35,
              ),
              title: const Text('Total Pengajuan'),
              subtitle: const Text('Seluruh layanan warga'),
              trailing: Text(
                '$total',
                style: const TextStyle(
                  color: hijau,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Pengajuan per Bidang',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                maxY: (jumlah.reduce((a, b) => a > b ? a : b) + 2)
                    .toDouble(),
                barGroups: List.generate(
                  bidang.length,
                  (i) => BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: jumlah[i].toDouble(),
                        color: hijau,
                        width: 28,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  ),
                ),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();
                        if (i < 0 || i >= bidang.length) {
                          return const SizedBox.shrink();
                        }
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            ['Admin', 'Penduduk', 'Infrastruktur'][i],
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: true),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(
            bidang.length,
            (i) => Card(
              child: ListTile(
                leading: const Icon(Icons.circle, color: hijau, size: 14),
                title: Text(bidang[i]),
                trailing: Text(
                  '${jumlah[i]} pengajuan',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
