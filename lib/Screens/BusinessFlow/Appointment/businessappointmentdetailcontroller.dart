import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/api.dart';
import '../../../Helper/networkmanager.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/appointmentmodel.dart';

class BusinessAppointmentDetailController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  List<Appointment> appointmentList = [];

  String? businessId;
  String? specialistId;


  intialfunc() async {
    await PreferenceHelper.getSpecialistData()
        .then((value) =>
    specialistId = value?.specialistId
    );
    await PreferenceHelper.getBusinessData()
        .then((value) =>
    businessId = value?.businessId
    );
    getAllAppointments();
  }


  getAllAppointments() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getAppointmentList,
      params: {
        //todo hardcoded for business id
        if (businessId != null)
          "BusinessId": await PreferenceHelper.getBusinessData()
              .then((value) => value?.businessId),
        if (specialistId != null)
          "SpecialistId": await PreferenceHelper.getSpecialistData()
              .then((value) => value?.specialistId),
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          //logic for api call success
          appointmentList = (apiResponse.apiResponseModel!.result as List)
              .map((e) => Appointment.fromJson(e))
              .toList();
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          // PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
          Get.snackbar("No Data Found", message!,
              duration: 3.seconds, snackPosition: SnackPosition.TOP);
        }
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.error;
        Get.snackbar("Response Error", message!,
            duration: 3.seconds, snackPosition: SnackPosition.TOP);
      }
    });
  }
}
