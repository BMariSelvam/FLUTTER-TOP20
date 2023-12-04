import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/specialistmodel.dart';


class SpecialistListController extends GetxController with StateMixin {
  List<SpecialistListModel> favouriteSpecialistList = [];
  Rx<bool> isLoading = false.obs;

  userGetFavoriteSpecialist() async {
    change(null, status: RxStatus.loading());
    try {
      final apiResponse = await NetworkManager.get(
        url: HttpUrl.userGetFavSpecialist,
        // todo: This is hardcoded so far. Need to change in future
        params: {"MemberId": await PreferenceHelper.getMemberData().then((value) => value?.memberId)},
      );
      if (apiResponse.apiResponseModel != null && apiResponse.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<SpecialistListModel> list = resJson.map<SpecialistListModel>((value) {
              return SpecialistListModel.fromJson(value);
            }).toList();
            favouriteSpecialistList = list;
            change(null, status: RxStatus.success());
            return;
          }
        } else {
          change(null, status: RxStatus.error());

          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: apiResponse.apiResponseModel!.message ?? '',
              icon: Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        favouriteSpecialistList.clear();
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "No Data's found",
          message: e.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
