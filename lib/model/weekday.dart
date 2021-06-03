import 'package:OEGlobal/model/response.dart';

class WeekDay extends Data {
  final int weekday;
  final String name;
  final String shortName;
  bool selected;

  WeekDay({
    this.weekday,
    this.name,
    this.shortName,
    this.selected = false,
  });

  static List<WeekDay> getFullWorkDays() {
    List<WeekDay> list = [
      WeekDay(
        weekday: 1,
        name: 'Monday',
        shortName: 'Mon',
      ),
      WeekDay(
        weekday: 2,
        name: 'Tuesday',
        shortName: 'Tue',
      ),
      WeekDay(
        weekday: 3,
        name: 'Wednesday',
        shortName: 'Wed',
      ),
      WeekDay(
        weekday: 4,
        name: 'Thursday',
        shortName: 'Thu',
      ),
      WeekDay(
        weekday: 5,
        name: 'Friday',
        shortName: 'Fri',
      ),
      WeekDay(
        weekday: 6,
        name: 'Saturday ',
        shortName: 'Sat',
      ),
      WeekDay(
        weekday: 7,
        name: 'Sunday',
        shortName: 'Sun',
      ),
    ];

    return list;
  }
}
