import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Model/specialistregmodel.dart';

class SpecialistRegFirstController extends GetxController with StateMixin {
  TextEditingController specialistNameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController transactionPinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isTransactionPin = false.obs;
  RxBool isPasswordPin = false.obs;

  RxBool isRegAsFreelancer = false.obs;
  RxBool isOnlineAppointment = false.obs;
  RxBool isBusinessPlace = false.obs;
  RxBool isCustomerPlace = false.obs;

  final specialistRegFirstKey = GlobalKey<FormState>();
  late SpecialistRegModel specialistRegModel = SpecialistRegModel();
}
