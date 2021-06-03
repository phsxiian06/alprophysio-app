import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const DateTime_Format_1 = 'yyyy-MM-dd HH:mm:ss';
const DateTime_Format_2 = 'dd MMM yyyy hh:mm a';
const DateFormat_1 = 'dd MMM yyyy';
const DateFormat_2 = 'dd/MM/yyyy';
const DateFormat_3 = 'yyyy-MM-dd';
const DateFormat_4 = 'dd MMMM yyyy';
const TimeFormat_1 = 'hh:mm a';

String formatTime(TimeOfDay timeOfDay) {
  // H:m:s
  String hour =
      timeOfDay.hour < 10 ? '0${timeOfDay.hour}' : timeOfDay.hour.toString();
  String minutes = timeOfDay.minute < 10
      ? '0${timeOfDay.minute}'
      : timeOfDay.minute.toString();

  return '$hour:$minutes:00';
}

String formatTimeForDisplay(TimeOfDay timeOfDay) {
  // hh:mm a
  String hour = timeOfDay.hourOfPeriod < 10
      ? '0${timeOfDay.hourOfPeriod}'
      : timeOfDay.hourOfPeriod.toString();
  String minutes = timeOfDay.minute < 10
      ? '0${timeOfDay.minute}'
      : timeOfDay.minute.toString();
  String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

  return '$hour:$minutes $period';
}

String formatDateTime(DateTime dateTime, String format) {
  // yyyy-MM-dd H:m:s
  var newFormat = DateFormat(format);
  return newFormat.format(dateTime);
}

String formatDateTimeFromString(String dateTime, String format) {
  DateTime date = DateTime.parse(dateTime);
  var newFormat = DateFormat(format);
  return newFormat.format(date);
}

String getCurrentDate() {
  // yyyy-MM-dd
  DateTime now = DateTime.now();

  String year = now.year.toString();
  String month = now.month < 10 ? '0${now.month}' : now.month.toString();
  String day = now.day < 10 ? '0${now.day}' : now.day.toString();

  return '$year-$month-$day';
}

String getCurrentDateTime() {
  // yyyy-MM-dd H:m:s
  DateTime now = DateTime.now();

  String year = now.year.toString();
  String month = now.month < 10 ? '0${now.month}' : now.month.toString();
  String day = now.day < 10 ? '0${now.day}' : now.day.toString();
  String hour = now.hour < 10 ? '0${now.hour}' : now.hour.toString();
  String minutes = now.minute < 10 ? '0${now.minute}' : now.minute.toString();

  return '$year-$month-$day $hour:$minutes:00';
}

String getTimeZone() {
  // +08
  DateTime now = DateTime.now();

  return now.timeZoneName;
}
