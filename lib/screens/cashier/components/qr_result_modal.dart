import 'package:flutter/material.dart';

class QrResultModal extends StatefulWidget {
  final String qrData;
  final int total;
  final bool isPrinting;
  final VoidCallback onClose;

  const QrResultModal({super.key, required this.qrData, required this.total, required this.isPrinting, required this.onClose});

  @override
  State<QrResultModal> createState() => _QrResultModalState();
}

class _QrResultModalState extends State<QrResultModal> {
  // variable untuk menyimpan status cetak
  late bool _printFinished;

  //unutk menginisialisasi
  @override
  void initState() {
    super.initState();
    // awalnya anggap proses print blium selesai.
    _printFinished = false;

    // jika mode mencetak atau printer nyala kita buat simulasi loading.
    if (widget.isPrinting) {
      Future.delayed(Duration(seconds: 2), () {
        // cek jika proses delayed sesuai dengan waktu yang dibutuhkan printer ketika mencetak.
        if (mounted) { // kondisi ketika widget nya itu aktif, dia akan menjalankan intruksi jika widgetnya aktif, yaiut intruksi if, kalau engga, ga bakal jalan.
          setState(() {
            _printFinished = true; // ubah status jadi selesai
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // tentukan warna dan teks berdasarkan status.
    Color statusColor;
    Color statusBgColor;
    IconData statusIcon;
    String statusText;

    if (!widget.isPrinting) { // ! artinya not, berarti artinya tanpa printer.
      // kondisi 1: printer mati atau mode tanpa printer.
      statusColor = Colors.orange;
      statusBgColor = Colors.orange.shade50;
      statusIcon = Icons.print_disabled;
      statusText = 'Mode Tanpa Printer';
    } else if (!_printFinished) {
      // kondisi 2: ketika sedang proses mencetak struk.
      statusColor = Colors.blue;
      statusBgColor = Colors.blue.shade50;
      statusIcon = Icons.print;
      statusText = 'Mencetak Struk Fisik...';
    } else {
      // kondisi 3: ketika selesai mencetak struk.
      statusColor = Colors.green;
      statusBgColor = Colors.green.shade50;
      statusIcon = Icons.check_circle;
      statusText = 'Cetak Selesai';
    }

    return Container();
  }
}