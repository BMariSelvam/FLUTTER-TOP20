import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/api.dart';
import '../../../Helper/networkmanager.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/UserBusinessReviewModel.dart';
import '../../../Model/appointmentmodel.dart';

class RatingController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  List<Appointment> appointmentList = [];
  List<Appointment> appointmentRating = [];
  String? businessId;
  String? specialistId;

  List<UserBusinessReviewModel>? userBusinessRatingList = [];

  intialfunc() async {
    await PreferenceHelper.getSpecialistData()
        .then((value) => specialistId = value?.specialistId);
    await PreferenceHelper.getBusinessData()
        .then((value) => businessId = value?.businessId);
    getAllAppointments();
    getBusinessReview();
    print("::::::::::::::::${businessId}:::::::::::::::");
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
          appointmentRating = appointmentList
              .where((element) => element.isReviewReceived == true)
              .toList();
          print("appointmentRating.first.ratingValue");
          print(appointmentRating.first.ratingValue);
          change(null, status: RxStatus.success());
        } else {
          appointmentList.length == 0;
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        // change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  ///Get Open Controller
  getBusinessReview() async {
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getUserBusinessRate,
      params: {
        "OrganizationId": 1,
        "ReviewId": "",
        "ReviewDate": "",
        "MemberId": "",
        if (businessId != null)
          "BusinessId": await PreferenceHelper.getBusinessData()
              .then((value) => value?.businessId),
        if (specialistId != null)
          "SpecialistId": await PreferenceHelper.getSpecialistData()
              .then((value) => value?.specialistId),
      },
    ).then((apiResponse) async {
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          print("Success");
          userBusinessRatingList =
              (apiResponse.apiResponseModel!.result as List)
                  .map((e) => UserBusinessReviewModel.fromJson(e))
                  .toList();
        } else {
          Get.snackbar("Invalid Data", "Invalid Data",
              duration: 10.seconds, snackPosition: SnackPosition.TOP);
        }
      } else {
        String? message = apiResponse.apiResponseModel?.message;
        Get.snackbar("Invalid Data", message!,
            duration: 10.seconds, snackPosition: SnackPosition.TOP);
      }
    });
  }
}
