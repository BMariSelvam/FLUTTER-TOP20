import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_20/Screens/Success/successscreen.dart';

import '../../../Const/approute.dart';
import '../../../Helper/api.dart';
import '../../../Helper/networkmanager.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/invitebusinesslistmodel.dart';

class SpecialistBusinessInvitationController extends GetxController
    with StateMixin {
  RxBool isLoading = false.obs;

  List<BusinessListModel> businessInvitation = [];
  List<BusinessListModel> businessRequest = [];

  getBusinessRequest() async {
    isLoading.value = true;
    // change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getBusinessRequst,
      params: {
        //todo hardcoded for business id
        "SpecialistId": await PreferenceHelper.getSpecialistData()
            .then((value) => value?.specialistId)
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          businessInvitation = (apiResponse.apiResponseModel!.result as List)
              .map((e) => BusinessListModel.fromJson(e))
              .toList();
          businessRequest = businessInvitation
              .where((element) => element.status == 0)
              .toList();
          print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
          print(businessRequest.length);
          print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
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

  postApproveBusinessRequest(
      {String? requestId, String? businessId, bool isCancel = false}) async {
    isLoading.value = true;
    update();
    await NetworkManager.post(
      url: HttpUrl.approveRequest,
      params: {
        "OrgId": 1,
        "RequestId": requestId ?? '',
        "BusinessId": businessId ?? '',
        "SpecialistId": await PreferenceHelper.getSpecialistData()
            .then((value) => value?.specialistId),
        "Status": isCancel ? 2 : 1,
        "CreatedBy": await PreferenceHelper.getSpecialistData()
            .then((value) => value?.specialistId),
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        //logic for api call success
        if (apiResponse.apiResponseModel!.status) {
          (isCancel == false)
              ? print('Approved Success')
              : print('Rejected Success');
          (isCancel == false)
              ? Get.to(() => SuccessfulScreen(
                  text: "Business Invitation Approved \n SuccessFully",
                  isLoading: false,
                  title: "Go To DashBoard",
                  onTap: () {
                    Get.offAllNamed(Routes.specialistBottomNavBar);
                  }))
              : Get.to(() => SuccessfulScreen(
                  text: "Business Invitation Rejected \n SuccessFully",
                  isLoading: false,
                  title: "Go To DashBoard",
                  onTap: () {
                    Get.offAllNamed(Routes.specialistBottomNavBar);
                  }));
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

  getBusinessDetails() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.businessGetBy,
      params: {
        //todo hardcoded for business id
        "BusinessId": await PreferenceHelper.getSpecialistData()
            .then((value) => value?.specialistId)
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          //logic for api call success
          businessInvitation = (apiResponse.apiResponseModel!.result as List)
              .map((e) => BusinessListModel.fromJson(e))
              .toList();
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
