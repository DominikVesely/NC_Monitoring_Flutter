import 'package:intl/intl.dart';

class DateTimeFormatter
{
  static DateFormat dateFormatter = new DateFormat.yMd();
  static DateFormat timeFormatter = new DateFormat.jm();

  static shortDateTime(DateTime date)
  {
    return date==null ? "" : dateFormatter.format(date) + ' ' + timeFormatter.format(date);
  }

  static shortDate(DateTime date)
  {
    return date==null ? "" : dateFormatter.format(date);
  }

  static shortTime(DateTime date)
  {
    return date==null ? "" : timeFormatter.format(date);
  }
}