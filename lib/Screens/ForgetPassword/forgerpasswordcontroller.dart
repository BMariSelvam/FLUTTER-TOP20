import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_20/Screens/Success/successscreen.dart';

import '../../Const/approute.dart';
import '../../Helper/api.dart';
import '../../Helper/enum.dart';
import '../../Helper/networkmanager.dart';
import '../../Helper/preferenceHelper.dart';

class ForgetPasswordController extends GetxController with StateMixin {
  TextEditingController forgetPasswordController = TextEditingController();
  final forgotPassKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  int loginType = 1;
  late UserType userType;

  forgotPasswordType() async {
    await NetworkManager.post(
      url: HttpUrl.generalLogin,
      params: {
        "OrganizationId": 1,
        "EmailId": forgetPasswordController.text.trim(),
        "Password": forgetPasswordController.text.trim(),
      },
    ).then((apiResponse) async {
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel?.result == "S") {
          print("................${apiResponse.apiResponseModel?.result}.............");
          forgetPasswordApi("S");
        } else if (apiResponse.apiResponseModel?.result == "B") {
          forgetPasswordApi("B");
          print("................${apiResponse.apiResponseModel?.result}.............");
        } else if (apiResponse.apiResponseModel?.result == "M") {
          forgetPasswordApi("I");
          print("................${apiResponse.apiResponseModel?.result}.............");
        } else {
          PreferenceHelper.showSnackBar(context: Get.context!, msg: "User not Match please Check");
        }
      }
    });
  }

  forgetPasswordApi(userType) async {
    isLoading.value = true;

    await NetworkManager.post(
      url: HttpUrl.forgetPassword,
      params: {
        "OrganizationId": 1,
        "EmailId": forgetPasswordController.text,
        "UserType": userType,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.status) {
          Get.to(SuccessfulScreen(
              text: "Password Sent To Your \n Email",
              isLoading: false,
              title: "Go to Login",
              onTap: () {
                Get.offAllNamed(Routes.loginScreen);
              }));
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
