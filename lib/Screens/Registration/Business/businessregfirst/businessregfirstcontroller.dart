import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Model/businesscstegorymodel.dart';
import '../../../../Model/businessregmodel.dart';

class BusinessRegFirstController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  RxBool isTransactionPin = false.obs;
  RxBool isPasswordPin = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController businessRegPinController = TextEditingController();
  TextEditingController transactionPinController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController openTimeController = TextEditingController();
  TextEditingController closeTimeController = TextEditingController();
  DateTime? closeTime;
  DateTime? openTime;
  late final BusinessRegModel businessRegModel;

  final businessRegFirstKey = GlobalKey<FormState>();
}
