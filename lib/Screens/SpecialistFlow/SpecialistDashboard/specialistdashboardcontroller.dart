import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../Helper/api.dart';
import '../../../Helper/networkmanager.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/appointmentmodel.dart';

class SpecialistDashboardController extends GetxController with StateMixin {
  RxList<Appointment> appointmentList = <Appointment>[].obs;
  Rx<bool> isLoading = false.obs;
  List<Appointment> appointmentOpen = [];



  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    getAllAppointments();
  }

  getAllAppointments() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getAppointmentList,
      //todo: following lines are hardcoded
      params: {
        "SpecialistId": await PreferenceHelper.getSpecialistData()
            .then((value) => value?.specialistId)
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          //logic for api call success
          appointmentList.value = (apiResponse.apiResponseModel!.result as List)
              .map((e) => Appointment.fromJson(e))
              .toList();
          appointmentOpen = appointmentList
              .where((element) => (element.status == 1))
              .toList();

          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
      change(null, status: RxStatus.success());
    });
  }
}
