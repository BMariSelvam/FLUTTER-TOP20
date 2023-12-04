import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../Helper/api.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/UserBusinessReviewModel.dart';
import '../../../../Model/appointmentmodel.dart';

class BusinessRatingController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  RxBool isOpenRatClick = true.obs;
  RxBool isAppointmentRatClick = false.obs;

  double? ratingValue;

  final ratingKey = GlobalKey<FormState>();

  TextEditingController reviewController = TextEditingController();

  List<UserBusinessReviewModel>? userBusinessRatingList = [];

  ///Appointment Rating
  List<Appointment> appointmentList = [];
  List<Appointment> appointmentRating = [];
  String? businessId;

  ///User - Business Rate Posting
  userBusPostRating(
      {String? businessId, String? specialistId, String? memberId}) async {
    //Getting a List in appointment Appointment Model Class

    isLoading.value = true;
    await ApiService.userSplPostRating(data: {
      "OrgId": 1,
      "ReviewDate": "2023-11-21",
      "MemberId": memberId,
      "BusinessId": businessId,
      "SpecialistId": specialistId,
      "CreatedBy": "admin",
      "ReviewDescription": reviewController.text.trim(),
      "RatingValue": ratingValue.toString(),
      "IsReviewValidated": true
    }).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          Get.back();
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

  getBusinessReview(
    String? businessId,
  ) async {
    change(null, status: RxStatus.loading());

    await NetworkManager.get(
      url: HttpUrl.getUserBusinessRate,
      params: {
        "OrganizationId": 1,
        "ReviewId": "",
        "ReviewDate": "",
        "MemberId": "",
        "BusinessId": businessId,
        "SpecialistId": "",
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

  ///Get Appointment Review
  intialfunc() async {
    await PreferenceHelper.getBusinessData()
        .then((value) => businessId = value?.businessId);
    getAllAppointments(businessId);
  }

  getAllAppointments(String? businessId) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getAppointmentList,
      params: {
        "OrganizationId": 1,
        "AppoinmentNo": "",
        "AppoinmentDate": "",
        "MemberId": "",
        "BusinessId": businessId,
        "SpecialistId": ""
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
}
