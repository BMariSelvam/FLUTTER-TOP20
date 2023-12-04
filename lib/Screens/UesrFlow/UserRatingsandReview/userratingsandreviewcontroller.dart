import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/api.dart';
import '../../../Helper/apiservice.dart';
import '../../../Helper/networkmanager.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/appointmentmodel.dart';

class UserRatingAndReviewController extends GetxController with StateMixin {
  RxBool isAppointmentClick = true.obs;
  RxBool isCompletedClick = false.obs;
  RxBool isLoading = false.obs;
  List<Appointment> appointmentList = [];
  late Appointment appointment;
  TextEditingController reviewController = TextEditingController();
  double? ratingValue;
  List<Appointment> appointmentCompleted = [];
  List<Appointment> appointmentOpen = [];

  getUserAllAppointments() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getAppointmentList,
      params: {
        //todo hardcoded for business id
        "OrganizationId": 1,
        "MemberId": await PreferenceHelper.getMemberData()
            .then((value) => value?.memberId)
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
          appointmentOpen = appointmentList
              .where((element) => (element.status != 5 && element.status != 6))
              .toList();
          appointmentCompleted = appointmentList
              .where((element) => element.status == 5 || element.status == 6)
              .toList();
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
    });
  }

  postRating({required Appointment appointment}) async {
    isLoading.value = true;
    await ApiService.postRating(data: {
      "OrgId": 1,
      "AppoinmentNo": appointment.appoinmentNo,
      "MemberId": appointment.memberData?.first.memberId,
      "ReviewDescription": reviewController.text.trim(),
      "RatingValue": ratingValue.toString(),
      "IsReviewReceived": true,
      "CreatedBy": "admin"
    }).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          Get.back();
          getUserAllAppointments();
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }
}
