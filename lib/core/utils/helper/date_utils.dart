import 'package:intl/intl.dart';

class AppDateUtils {
  static String parseMMDDYYYY(DateTime date) {
    final formattedDate = DateFormat("MM EE yyyy").format(date);

    return formattedDate;
  }
}
