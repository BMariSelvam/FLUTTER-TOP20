import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Const/approute.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/businessservicemodel.dart';
import '../../../Success/successscreen.dart';

class RequestServiceController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  RxBool isServiceStatus = false.obs;

  final businessRequestServicesKey = GlobalKey<FormState>();

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceChargeController = TextEditingController();
  TextEditingController serviceDurationController = TextEditingController();

  late BusinessServicesModel businessServicesModel;
  String? businessId;
  String? specialistId;



  intialfunc() async {
    await PreferenceHelper.getSpecialistData()
        .then((value) =>
    specialistId = value?.specialistId
    );
    await PreferenceHelper.getBusinessData()
        .then((value) =>
    businessId = value?.businessId
    );
  }


  businessRequestServices() async {
    isLoading.value = true;
    ApiService.addNewServices(businessServicesModel: businessServicesModel)
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          if (PreferenceHelper.isBusiness) {
            Get.to(() => SuccessfulScreen(
                text: "Service Request Sent \nSuccessfully",
                isLoading: false,
                title: "Thank You",
                onTap: () {
                  print("-----------------------------Business");
                  Get.offAllNamed(Routes.servicesScreen);
                }));

          } else {
            Get.to(() => SuccessfulScreen(
                text: "Service Request Sent \nSuccessfully",
                isLoading: false,
                title: "Thank You",
                onTap: () {
                  print("----------------------SpecialList");
                  Get.offAllNamed(Routes.servicesScreen,arguments: "Requested");
                }));
          }
        } else {
          print("================");
          String? message = apiResponse.apiResponseModel?.message;
          Get.snackbar(message!,"Requested Services Name Already Exists",
              duration: 3.seconds, snackPosition: SnackPosition.TOP);
        }
      } else {
        print("--------------------");
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }
}
