import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Const/approute.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/Member_details_model.dart';
import '../../../../Model/memberupdatemodel.dart';

class EditProfileController extends GetxController with StateMixin {
  TextEditingController userNameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine3Controller = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController dialCodeController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  Rx<bool> isLoading = false.obs;
  MemberUpdateParams memberUpdateParams = MemberUpdateParams();

  UpdatedMember() async {
    isLoading.value = true;
    ApiService.updateMember(params: memberUpdateParams)
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          String? message = apiResponse.apiResponseModel!.message;
          print("Updated profile");
          _callRefresh();
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
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

  _callRefresh() async {
    isLoading.value = true;
    print(await PreferenceHelper.getBusinessData()
        .then((value) => value?.emailId));
    print(await PreferenceHelper.getBusinessData()
        .then((value) => value?.passwoard));
    await NetworkManager.post(
      url: HttpUrl.memberLogin,
      params: {
        "OrganizationId": 1,
        "EmailId": await PreferenceHelper.getBusinessData()
            .then((value) => value?.emailId),
        "Password": await PreferenceHelper.getBusinessData()
            .then((value) => value?.passwoard),
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.result! as List).first;
          if (customerJson != null) {
            await PreferenceHelper.saveUserData(customerJson)
                .then((value) async {
              if (PreferenceHelper.isUser) {
                Get.offAllNamed(Routes.userBottomNavBar);
              }
            });
          } else {
            PreferenceHelper.showSnackBar(
                context: Get.context!, msg: "Invalid Data");
          }
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
