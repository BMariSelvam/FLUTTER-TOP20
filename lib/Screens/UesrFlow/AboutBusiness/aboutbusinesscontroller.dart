import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_20/Model/businesslistmodel.dart';

import '../../../Helper/networkmanager.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/specialistmodel.dart';
import '../../../helper/api.dart';

class AboutBusinessController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;

  late final BusinessListUserViewModel businessListUserViewModel;

  List<SpecialistListModel> specialistOverAllList = [];

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    businessListUserViewModel = Get.arguments as BusinessListUserViewModel;
    getBusinessSpecialist();
  }

  getBusinessSpecialist() async {
    print("businessListUserViewModel.businessId");
    print(businessListUserViewModel.businessId);
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse =
          await NetworkManager.get(url: HttpUrl.businessGetSpecialist, params: {
        //todo: this line is hardcodes
        "BusinessId": businessListUserViewModel.businessId,
      });
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            specialistOverAllList =
                (apiResponse.apiResponseModel!.result as List)
                    .map((e) => SpecialistListModel.fromJson(e))
                    .toList();
            print("specialistOverAllList.length");
            print(specialistOverAllList.length);
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
