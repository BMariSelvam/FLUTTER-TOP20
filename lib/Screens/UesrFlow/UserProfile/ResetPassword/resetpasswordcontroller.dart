import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Const/approute.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';

class ResetPasswordController extends GetxController with StateMixin {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isCurrentPassword = false.obs;
  RxBool isNewPassword = false.obs;
  RxBool isConfirmPassword = false.obs;
  RxBool passwordChanged=false.obs;

  RxBool isLoading = false.obs;

  String? memberId;
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
    await PreferenceHelper.getMemberData()
        .then((value) =>
    memberId = value?.memberId
    );
  }



  changePassword() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    await NetworkManager.post(
      url: (memberId != null)
          ? HttpUrl.memberLogin
          : (specialistId != null)
              ? HttpUrl.specialistLogin
              : HttpUrl.businessLogin,
      params: {
        "OrganizationId": 1,
        "EmailId": (PreferenceHelper.isUser)
            ? await PreferenceHelper.getMemberData()
                .then((value) => value?.emailId)
            : (PreferenceHelper.isSpecialist)
                ? await PreferenceHelper.getSpecialistData()
                    .then((value) => value?.emailId)
                : await PreferenceHelper.getBusinessData()
                    .then((value) => value?.emailId),
        "Password": currentPasswordController.text.trim(),
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null &&
            (apiResponse.apiResponseModel!.result as List).isNotEmpty) {
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.result! as List).first;
          if (customerJson != null) {
            changeConfrimPassword();
          } else {
            PreferenceHelper.showSnackBar(
                context: Get.context!, msg: "Your Current password is worng");
          }
        } else {
          PreferenceHelper.showSnackBar(
              context: Get.context!, msg: "Your Current password is worng");
        }
      } else {
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  changeConfrimPassword() async {
    isLoading.value = true;
    update();
    await NetworkManager.post(
      url: HttpUrl.changepassword,
      params: {
        "OrganizationId": 1,
        "UserId": (PreferenceHelper.isUser)
            ? await PreferenceHelper.getMemberData()
                .then((value) => value?.emailId)
            : (PreferenceHelper.isSpecialist)
                ? await PreferenceHelper.getSpecialistData()
                    .then((value) => value?.emailId)
                : await PreferenceHelper.getBusinessData()
                    .then((value) => value?.emailId),
        "Password": confirmPasswordController.text,
        "UserType": (memberId != null)
            ? "M"
            : (specialistId != null)
            ? "S"
            : "B",
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.status) {
          await PreferenceHelper.clearUserData();
          Get.snackbar(
            "Success",
            "Your Password Changed Successfully",
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.offAllNamed(Routes.loginScreen);
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


}