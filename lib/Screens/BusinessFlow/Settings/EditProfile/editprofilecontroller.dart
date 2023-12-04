import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_20/Model/memberupdatemodel.dart';

import '../../../../Const/approute.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';

class BusinessEditProfileController extends GetxController with StateMixin {
  RxBool isLoading = true.obs;

  DateTime? closeTime;
  DateTime? openTime;

  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessDisplayNameController = TextEditingController();
  TextEditingController businessMobileNoController = TextEditingController();
  TextEditingController businessDialCodeNoController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessAddressLine1Controller =
      TextEditingController();
  TextEditingController businessAddressLine2Controller =
      TextEditingController();
  TextEditingController businessAddressLine3Controller =
      TextEditingController();
  TextEditingController businessCityController = TextEditingController();
  TextEditingController businessCountryController = TextEditingController();
  TextEditingController businessPostalController = TextEditingController();
  TextEditingController businessOpenTimeController = TextEditingController();
  TextEditingController businessCloseTimeController = TextEditingController();

  BusinessUpdateParams businessUpdateParams = BusinessUpdateParams();

  updatedBusinessProfile() async {
    isLoading.value = true;
    ApiService.updateBusiness(params: businessUpdateParams)
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          String? message = apiResponse.apiResponseModel!.message;
          print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
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
    print("KKKKKKKKKKKKKKKKKKKKKKKKKKKK");
    isLoading.value = true;
    print(await PreferenceHelper.getBusinessData()
        .then((value) => value?.emailId));
    print(await PreferenceHelper.getBusinessData()
        .then((value) => value?.appPin));
    await NetworkManager.post(
      url: HttpUrl.businessLogin,
      params: {
        "OrganizationId": 1,
        "EmailId": await PreferenceHelper.getBusinessData()
            .then((value) => value?.emailId),
        "Password": await PreferenceHelper.getBusinessData()
            .then((value) => value?.appPin),
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
              if (PreferenceHelper.isBusiness) {
                Get.offAllNamed(Routes.businessBottomNavBar);
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
