import 'package:intl/intl.dart';

String formatRupiah(int number) {
  final currenyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);
  return currenyFormatter.format(number);
}