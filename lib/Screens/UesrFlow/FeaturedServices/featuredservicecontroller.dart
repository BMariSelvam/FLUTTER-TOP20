import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_20/Const/colors.dart';

import '../../../Helper/api.dart';
import '../../../Helper/networkmanager.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/FeaturedServicesModel.dart';

class FeaturedServicesController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  List<FeaturedServicesModel> featuredServices = [];

  getFeaturedServices() async {
    print("ENTER INTO FEATURED SERVICES");
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getFeaturedServices,
      params: {
        "OrganizationId": 1,
        "TransNo": "",
        "ServiceId": "",
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          featuredServices = (apiResponse.apiResponseModel!.result as List)
              .map((e) => FeaturedServicesModel.fromJson(e))
              .toList();
          print("::::::Success:::::");
        } else {
          // change(null, status: RxStatus.error());
          // String? message = apiResponse.apiResponseModel?.message;
          // Get.showSnackbar(GetSnackBar(
          //   message: message,
          //   backgroundColor: Colors.red,
          //   margin: const EdgeInsets.all(18.0),
          //   icon: const Icon(Icons.error),
          //   snackPosition: SnackPosition.TOP,
          // ));
        }
      } else {
        change(null, status: RxStatus.error());

        // Get.showSnackbar(GetSnackBar(
        //   message: apiResponse.error,
        //   backgroundColor: Colors.red,
        //   margin: const EdgeInsets.all(18.0),
        //   icon: const Icon(Icons.error, color: MyColors.white),
        //   snackPosition: SnackPosition.TOP,
        //   duration: const Duration(seconds: 1),
        // ));
      }
    });
  }
}
