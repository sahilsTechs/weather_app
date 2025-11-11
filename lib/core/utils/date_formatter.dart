// lib/core/utils/date_formatter.dart
import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTimestamp(int seconds) {
    final date = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
    return DateFormat('EEE, d MMM yyyy • h:mm a').format(date);
  }
}
