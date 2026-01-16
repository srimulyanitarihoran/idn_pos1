import 'package:flutter/material.dart';
import 'package:idn_pos1/screens/home/components/home_header.dart';
import 'package:idn_pos1/screens/home/components/menu_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          HomeHeader(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MenuCard(
                    title: 'mode kasir',
                    subtitle: 'buat pesanan dan cetak struk',
                    icon: Icons.point_of_sale_rounded,
                    colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Placeholder())),
                  ),
                  SizedBox(height: 20),

                  MenuCard(
                    title: 'menu pelanggan',
                    subtitle: 'scan QR dan lakukan pembayaran',
                    icon: Icons.qr_code_scanner_rounded,
                    colors: [Color(0xFFfa709a), Color(0xFFfee140)],
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Placeholder())),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'v1.0.0 - IDN Cafe POS',
              style: TextStyle(
                color: Colors.grey
              ),
            ),
          )
        ],
      ),
    );
  }
}