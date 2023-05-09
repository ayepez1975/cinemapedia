import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number, [decimals = 0]) {
    try {
      final formatNumber = NumberFormat.compactCurrency(
        decimalDigits: decimals,
        symbol: '',
        locale: 'en',
      ).format(number);
          return formatNumber;
    } catch (e) {

      return '';
    }

   
  }
}
