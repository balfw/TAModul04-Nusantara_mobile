
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'warga_page.dart';

class LokasiKantorPage extends StatelessWidget {
  const LokasiKantorPage({super.key});

  static const pusat = LatLng(-6.9147, 107.6098);

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>{
      const Marker(
        markerId: MarkerId('pusat'),
        position: LatLng(-6.9147, 107.6098),
        infoWindow: InfoWindow(title: 'Kantor Layanan Pusat'),
      ),
      const Marker(
        markerId: MarkerId('timur'),
        position: LatLng(-6.9175, 107.6191),
        infoWindow: InfoWindow(title: 'Kantor Layanan Timur'),
      ),
      const Marker(
        markerId: MarkerId('utara'),
        position: LatLng(-6.9039, 107.6049),
        infoWindow: InfoWindow(title: 'Kantor Layanan Utara'),
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lokasi Kantor'),
        backgroundColor: hijau,
        foregroundColor: Colors.white,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: pusat,
          zoom: 13,
        ),
        markers: markers,
        zoomControlsEnabled: true,
        myLocationButtonEnabled: false,
      ),
    );
  }
}
