import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/api.dart';
import '../../../Helper/networkmanager.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/invitebusinesslistmodel.dart';
import '../../../Model/specialistmodel.dart';

class AboutSpecialistController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;

  late final SpecialistListModel specialistListModel;

  List<BusinessListModel> businessInvite = [];
  List<BusinessListModel> approveInvite = [];

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    getAllBusinessRequest();
    specialistListModel = Get.arguments as SpecialistListModel;
  }

  getAllBusinessRequest() async {
    isLoading.value = true;
    // change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getBusinessRequst,
      params: {
        //todo hardcoded for business id
        "SpecialistId": specialistListModel.specialistId,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          businessInvite = (apiResponse.apiResponseModel!.result as List)
              .map((e) => BusinessListModel.fromJson(e))
              .toList();
          approveInvite =
              businessInvite.where((element) => (element.status == 1)).toList();
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
    });
  }
}
