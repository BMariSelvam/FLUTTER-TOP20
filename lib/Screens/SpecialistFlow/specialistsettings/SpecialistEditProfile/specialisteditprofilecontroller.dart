import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_20/Model/memberupdatemodel.dart';

import '../../../../Const/approute.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';

class SpecialistEditProfileController extends GetxController with StateMixin {
  RxBool isLoading = true.obs;
  RxBool isSpecialistStatus = true.obs;
  RxBool isAllowOnlineAppointment = true.obs;
  RxBool isAllowIndividualTip = true.obs;
  RxBool isBusinessPlace = true.obs;
  RxBool isCustomerPlace = true.obs;

  DateTime? closeTime;
  DateTime? openTime;

  TextEditingController specialistNameController = TextEditingController();
  TextEditingController specialistDisplayNameController =
      TextEditingController();
  TextEditingController specialistMobileNoController = TextEditingController();
  TextEditingController specialistDialCodeNoController =
      TextEditingController();
  TextEditingController specialistEmailController = TextEditingController();
  TextEditingController specialistAddressLine1Controller =
      TextEditingController();
  TextEditingController specialistAddressLine2Controller =
      TextEditingController();
  TextEditingController specialistAddressLine3Controller =
      TextEditingController();
  TextEditingController specialistCityController = TextEditingController();
  TextEditingController specialistCountryController = TextEditingController();
  TextEditingController specialistPostalController = TextEditingController();
  TextEditingController specialistOpenTimeController = TextEditingController();
  TextEditingController specialistCloseTimeController = TextEditingController();

  SpecialistUpdateParams specialistUpdateParams = SpecialistUpdateParams();

  updatedSpecialistProfile() async {
    isLoading.value = true;
    ApiService.updateSpecialist(params: specialistUpdateParams)
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
    isLoading.value = true;
    print(await PreferenceHelper.getBusinessData()
        .then((value) => value?.emailId));
    print(await PreferenceHelper.getBusinessData()
        .then((value) => value?.passwoard));
    await NetworkManager.post(
      url: HttpUrl.specialistLogin,
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
              if (PreferenceHelper.isSpecialist) {
                Get.offAllNamed(Routes.specialistBottomNavBar);
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
