import 'package:intl/intl.dart';

class DateFormatter {
  static String formatEventDate(String iso) {
    final date = DateTime.parse(iso).toLocal();
    return DateFormat('EEEE   h:mm a').format(date);
  }
}
