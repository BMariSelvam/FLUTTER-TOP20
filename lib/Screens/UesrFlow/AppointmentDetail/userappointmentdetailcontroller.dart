import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/api.dart';
import '../../../Helper/networkmanager.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/appointmentmodel.dart';

class UserAppointmentController extends GetxController with StateMixin {
  late Appointment appointment;
}
