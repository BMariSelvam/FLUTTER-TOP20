import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_20/Screens/Success/successscreen.dart';

import '../../../../Const/approute.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/businesscstegorymodel.dart';
import '../../../../Model/businessregmodel.dart';
import '../../../../Model/businessservicemodel.dart';
import '../../../../Model/specialistregmodel.dart';

class BeofreServiceController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  // late SpecialistRegModel specialistRegModel = SpecialistRegModel();
  // late BusinessRegModel businessRegModel = BusinessRegModel();

  final serviceRequest = GlobalKey<FormState>();
  RxBool isServiceStatus = false.obs;
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceChargeController = TextEditingController();
  TextEditingController serviceDurationController = TextEditingController();



  callSplAddService(String? fileName,String? filePath,String? base64,SpecialistRegModel? specialistRegModel) async {
    isLoading.value = true;
    BusinessServicesModel businessServicesModel = BusinessServicesModel(
        orgId: 1,
        businessServiceId: '',
        businessServiceName: serviceNameController.text,
        emailId: specialistRegModel?.emailId,
        userType: "S",
        businessCategoryId: specialistRegModel?.businessCategory,
        durationMinutes: int.parse(serviceDurationController.text),
        tokens: int.parse(serviceChargeController.text),
        isActive: true,
        fileName: fileName,
        filePath: filePath,
        service_Img_Base64String: base64,
        createdBy: "admin",
        createdOn: "2023-01-22T15:29:24.200Z");
    ApiService.addBusinessServices(params: businessServicesModel.toJson(true))
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          Get.to(() => SuccessfulScreen(
              text: "Your Service Request has been Sent \nSuccessfully",
              isLoading: false,
              title: "Thank You",
              onTap: () {
                Get.offAllNamed(Routes.specialistRegThirdScreen,arguments: specialistRegModel);
              }));
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


  callAddService(String? fileName,String? filePath,String? base64,BusinessRegModel? businessRegModel) async {
    isLoading.value = true;
    BusinessServicesModel businessServicesModel = BusinessServicesModel(
        orgId: 1,
        businessServiceId: '',
        businessServiceName: serviceNameController.text,
        emailId: businessRegModel?.emailId,
        userType: "B",
        businessCategoryId: businessRegModel?.businessCategory,
        durationMinutes: int.parse(serviceDurationController.text),
        tokens: int.parse(serviceChargeController.text),
        isActive: true,
        fileName: fileName,
        filePath: filePath,
        service_Img_Base64String: base64,
        createdBy: "admin",
        createdOn: "2023-01-22T15:29:24.200Z");
    ApiService.addBusinessServices(params: businessServicesModel.toJson(true))
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          //Get.offAllNamed(NewRequestServiceSucess.routeName);
          Get.to(() => SuccessfulScreen(
              text: "Service Request Sent \nSuccessfully",
              isLoading: false,
              title: "Thank You",
              onTap: () {
                Get.offAllNamed(Routes.businessRegThirdScreen,arguments: businessRegModel);
              }));
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
