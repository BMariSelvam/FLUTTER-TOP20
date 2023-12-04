import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/appointmentmodel.dart';
import '../../../../Model/specialistmodel.dart';

class BusinessSpecialistController extends GetxController with StateMixin {
  Rx<bool> isLoading = false.obs;

  List<SpecialistListModel> specialistDetails = [];

  getSpecialistDetails(String? specialistId) async {
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    change(null, status: RxStatus.loading());
    isLoading.value = true;
    try {
      final apiResponse =
          await NetworkManager.get(url: HttpUrl.specialistGetBy, params: {
        "OrganizationId": 1,
        "SpecialistId": specialistId,
      });
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            specialistDetails = (apiResponse.apiResponseModel!.result as List)
                .map((e) => SpecialistListModel.fromJson(e))
                .toList();
            return;
          }
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
    } catch (e) {
      change(null, status: RxStatus.error());
      PreferenceHelper.showSnackBar(
          context: Get.context!, msg: "Something went wrong");
    }
  }
}
