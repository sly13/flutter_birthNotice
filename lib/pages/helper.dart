import 'package:intl/intl.dart';

class Helper {
  bool isLeapYear(int year) =>
      (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

  int daysInYear(year) {
    return isLeapYear(year) ? 366 : 365;
  }

  int daysToBirthday(birthday) {
    var date = new DateTime(getCurrentYear(birthday), getCurrentMonth(birthday),
        getCurrentDay(birthday));
    var currentYear = getCurrentYear(birthday);
    return daysInYear(currentYear) -
        DateTime.now().difference(DateTime.parse(date.toString())).inDays;
  }

  int getCurrentMonth(birthday) {
    return int.parse(DateFormat('MM').format(birthday.toDate()));
  }

  int getCurrentDay(birthday) {
    return int.parse(DateFormat('dd').format(birthday.toDate()));
  }

  int getCurrentYear(birthday) {
    return int.parse(DateFormat('yyyy').format(DateTime.now()));
  }
}
