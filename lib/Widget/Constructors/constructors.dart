import 'package:flutter/material.dart';

class BusinessDashBordGrid {
  final String image;
  final String name;
  final Color? color;

  BusinessDashBordGrid({
    required this.image,
    required this.name,
    required this.color,
  });
}

class BusinessAppointmentGrid {
  final String image;
  final String count;
  final String name;

  BusinessAppointmentGrid(
      {required this.image, required this.count, required this.name});
}

class AppointmentDetailsList {
  final String image;
  final String text;

  AppointmentDetailsList({required this.image, required this.text});
}

class SpecialistAppointmentGrid {
  final String image;
  final String count;
  final String name;

  SpecialistAppointmentGrid(
      {required this.image, required this.count, required this.name});
}

class SpecialistAppointmentDetailsList {
  final String image;
  final String text;

  SpecialistAppointmentDetailsList({required this.image, required this.text});
}
