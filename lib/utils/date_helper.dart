import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateHelper {
  static String formatRelative(DateTime date) {
    return timeago.format(date);
  }

  static String formatFull(DateTime date) {
    return DateFormat('yyyy-mm-dd').format(date);
  }
}
