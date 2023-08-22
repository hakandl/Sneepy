import 'package:intl/intl.dart';
import 'package:sneepy/product/constants/strings.dart';

extension DateParse on String? {
  String convertDateString() {
    final DateFormat dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    final date = DateTime.tryParse(this ?? AppStrings.empty);
    if (date == null) {
      return AppStrings.empty;
    }
    final String stringDate = dateFormat.format(date);
    return stringDate;
  }
}
