import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Const/approute.dart';
import '../../../../Const/font.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/specialistmodel.dart';
import '../../../Success/successscreen.dart';

class SpecialistInviteController extends GetxController with StateMixin {
  late SpecialistListModel specialistListModel;
  RxBool isLoading = false.obs;
  double? specialistRatingValue;
  double? aboutSpecialistRating;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // fixme mari i will add for flow checking

    specialistListModel = Get.arguments != null
        ? Get.arguments as SpecialistListModel
        : SpecialistListModel.fromJson({});
  }

  callInviteSpecialist() async {
    isLoading.value = true;

    await NetworkManager.post(url: HttpUrl.inviteSpecialist, params: {
      'OrgId': 1,
      //todo this is hardcoded
      'RequestId': "TOP54AAB",
      'BusinessId': await PreferenceHelper.getBusinessData()
          .then((value) => value?.businessId),
      'SpecialistId': specialistListModel.specialistId,
      'Status': 0,
      'CreatedBy': 'admin'
    }).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          Get.to(() => SuccessfulScreen(
                text: 'Specialist Invitation sent \n  Successfully',
                isLoading: false,
                title: 'Go to DashBoard',
                onTap: () {
                  Get.offAllNamed(Routes.businessBottomNavBar);
                },
              ));
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          Get.snackbar("Invalid Data", message!,
              duration: 3.seconds, snackPosition: SnackPosition.TOP);
        }
      } else {
        String? message = apiResponse.error;
        Get.snackbar("Response Error", message!,
            duration: 3.seconds, snackPosition: SnackPosition.TOP);
        // PreferenceHelper.showSnackBar(
        //     context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  void showPopUp(BuildContext context, Duration displayDuration) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Timer(displayDuration, () {
          Navigator.of(context)
              .pop(); // Close the dialog after the displayDuration
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Center(
            child: Text(
              'Request Exist',
              style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Text(
            'You are already Requested \n this Specialist',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
