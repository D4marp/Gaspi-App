import 'package:intl/intl.dart';

/// Utility untuk formatting currency (Rupiah)
class CurrencyFormatter {
  /// Format ke format Rupiah (Rp 1.000.000)
  static String format(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// Format dengan desimal (Rp 1.000.000,50)
  static String formatWithDecimal(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  /// Format angka dengan thousand separator (1.000.000)
  static String formatNumber(num number) {
    final formatter = NumberFormat('#,###', 'id_ID');
    return formatter.format(number);
  }
}
