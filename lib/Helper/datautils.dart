import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUtils {
  static String toHHMM({required dateString}) {
    final dateFormatter = DateFormat('hh:mm:ss').parse(dateString);
    return (DateFormat('hh:mm').format(dateFormatter));
  }

  static String toHHMMSS({required dateString}) {
    final dateFormatter = DateFormat('hh:mm').parse(dateString);
    return (DateFormat('hh:mm:ss').format(dateFormatter));
  }

  static String toHHMM24({required String dateString}) {
    final dateFormatter = DateFormat('hh:mm:ss').parse(dateString);
    return DateFormat('HH:mm').format(dateFormatter);
  }

  static String toHHMMSS24({required  dateString}) {
    final dateFormatter = DateFormat('hh:mm').parse(dateString);
    return DateFormat('HH:mm:ss').format(dateFormatter);
  }

  static String toDDMMYYYY({required dateString}) {
    final dateFormatter = DateTime.parse(dateString);
    return (DateFormat('dd/MM/yyyy').format(dateFormatter));
  }

  static String toServerDateFormat({required dateString}) {
    final dateFormatter = DateTime.parse(dateString);
    return (DateFormat('yyyy-MM-dd').format(dateFormatter));
  }

  static String differenceBetweenTimes(
      {required String from, required String to}) {
    DateTime _fromDate = DateFormat('HH:mm:ss').parse(from);
    DateTime _toDate = DateFormat('HH:mm:ss').parse(to);

    print(_fromDate);
    print(_toDate);

    if ((_toDate.difference(_fromDate).inMinutes) > 60) {
      return "${(_toDate.difference(_fromDate).inHours)} Hrs";
    } else {
      return "${(_toDate.difference(_fromDate).inMinutes)} Mins";
    }
  }
}

extension DateTimeExtension on DateTime {
  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}
