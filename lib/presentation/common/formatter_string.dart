import 'package:intl/intl.dart';

class FormatterString {
  static String formatterCurrency(num value) {
    var numberFormat =
        NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0);
    return numberFormat.format(value);
  }
}
