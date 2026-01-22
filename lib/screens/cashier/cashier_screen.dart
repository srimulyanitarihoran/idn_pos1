import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:idn_pos1/models/products.dart';
import 'package:permission_handler/permission_handler.dart';

class CashierScreen extends StatefulWidget {
  const CashierScreen({super.key});

  @override
  State<CashierScreen> createState() => _CashierScreenState();
}

class _CashierScreenState extends State<CashierScreen> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _device = [];
  BluetoothDevice? _selectedDevice;
  bool _connected = false;
  final Map<Product, int> _cart = {};

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  // LOGIKA BLUETOOTH
  Future<void> _initBluetooth() async {
    // minta ijin lokasi dan bluetooth ke user (WAJIB)
    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location
    ].request();

    List<BluetoothDevice> devices = [
      // list ini akan otomatis ter isi jika bluethooth di handphone menyala dan sudah ada device yang sudah siap di koneksikan
    ];
    try {
      devices = await bluetooth.getBondedDevices(); // jika ada koneksi yang bisa di koneksi kan
    } catch (e) {
      debugPrint('error bluetooth: $e');
    }

    // kalo bener bener udah aktif
    if (mounted) {
      setState(() {
        _device = devices;
      });

      bluetooth.onStateChanged().listen((state) {
        if (mounted) {
          setState(() {
            _connected = state == BlueThermalPrinter.CONNECTED;
          });
        }
      });
    }
  }

  void _connectDevice(BluetoothDevice? device) {
    // if (kondisi) utama, yang memplopori if-if selanjutnya
    if (device != null) { // kalo misal ada
      bluetooth.isConnected.then((isConnected) { // conect ga?
      // if yang merupakan cabang/anak dari if utama
      // if ini yang memiliki sebuah kondisi yang menjawab pertanyaan/statement
        if (isConnected = false) { // kalo misal ga conect padahal ada
          bluetooth.connect(device).catchError((error) { // menampilkan error, yang akan di jalankan ketika if kedua itu true
          // memiliki opini yang sama seperti ig yang ke dua (WAJIB)
            if (mounted) setState(() => _connected = false); // ngikutin yang atas, karna yang di atas juga false, harus satu suara sama yang atas
          });

          // statement di dalam if ini akan di jalankan ketika if-if sebelumnya tidak terpenuhi
          // if ini adalah opsi terakhir yang akan di jalankan ketika if sebelumnya tidak terpenuhi (tidak berjalan)
        if (mounted) setState(() => _selectedDevice = device); // "oh, device itu kepilih", punya opini sendiri, makanya beda, ada perubahan state lagi di line ini, dijalankan ketika device ini ada dan ke connect
        }
      });
    }
  }

  // LOGIKA CART
  void _addToCart(Product product) {
    setState(() {
      // ifAbsent kalo misalnya ga ada yang ditambah ya berarti segitu
      _cart.update(
        // untuk mendefiniskan product yang ada di menu
        product,
        // logika matematis, yang dijalankan ketika satu product sudah berada di keranjang dan klik + yang nantinya jumlahnya akan di tambah 1
       (value) => value + 1,
       // logika yang jika user tidak menambah kan lagi jumlah product (jumlah product hanya 1), maka default jumlah dari barang adalah 1
        ifAbsent: () => 1);
    });
  }

    void _removeFromCart(Product product) {
      setState(() {
        if (_cart.containsKey(product) && _cart[product]! > 1) {
          _cart[product] = _cart[product] ! - 1;
        } else {
          _cart.remove(product);
        }
      });
    }

    int _calculateTotal() {
      int total = 0;
      _cart.forEach((key, value) => total += (key.price * value)); // harga kali jumlah
      return total;
    }

    // LOGIKA PRINTING

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}