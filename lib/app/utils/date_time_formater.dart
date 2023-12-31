
import 'package:intl/intl.dart';

mixin DateTimeFormater {
  String getFormattedDateString(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  String formatDate(DateTime dateTime) {
    final format = DateFormat('MM/dd/yyyy, hh:mm a');
    return format.format(dateTime);
  }

  bool checkifDateEqualsTodayDate(DateTime dateTime) {
    if (dateTime.difference(DateTime.now()).inDays == 0) {
      return true;
    } else {
      return false;
    }
  }
}
