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

class SpecialistRegThirdController extends GetxController with StateMixin {
  TextEditingController requestCategoryController = TextEditingController();
  TextEditingController requestServicesController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  Rx<BusinessCategoryModel?> selectedBusinessCategory =
      (null as BusinessCategoryModel?).obs;

  Rx<List<BusinessCategoryModel>?> businessCategoryList = (null as List<BusinessCategoryModel>?).obs;
  Rx<List<BusinessCategoryModel>?> businessTrueCategoryList = (null as List<BusinessCategoryModel>?).obs;

  Rx<BusinessServicesModel?> selectedBusinessService =
      (null as BusinessServicesModel?).obs;

  Rx<List<BusinessServicesModel>?> businessServiceList = (null as List<BusinessServicesModel>?).obs;
  Rx<List<BusinessServicesModel>?> businessTrueServiceList = (null as List<BusinessServicesModel>?).obs;

  late SpecialistRegModel specialistRegModel = SpecialistRegModel();

  final specialistRegThirdKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  buildBusinessCategoryList() async {
    change(null, status: RxStatus.loading());
    isLoading.value = true;
    selectedBusinessCategory.value = null;
    try {
      final apiResponse =
          await NetworkManager.get(url: HttpUrl.businessCategory, params: {});
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<BusinessCategoryModel> list =
                resJson.map<BusinessCategoryModel>((value) {
              return BusinessCategoryModel.fromJson(value);
            }).toList();
            businessCategoryList.value = list;
            print("businessCategoryList.value?.length");
            print(businessCategoryList.value?.length);
            businessTrueCategoryList.value = businessCategoryList.value?.where((element) => element.isActive == true).toList();
            print("businessCategoryList.value?.length");
            print(businessTrueCategoryList.value?.length);
            return;
          }
        }
      } else {
        change(null, status: RxStatus.error());
        Get.showSnackbar(
          const GetSnackBar(
            title: "Error",
            message: "Something went wrong",
            icon: Icon(Icons.error),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: e.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  getBusinessServicesList(String? businessCategory) async {
    change(null, status: RxStatus.loading());
    try {
      final apiResponse = await NetworkManager.get(
        url: HttpUrl.businessService,
        // todo: This is hardcoded so far. Need to change in future
        // params: {"BusinessCategoryId": "133630563"},
        params: {"BusinessCategoryId": businessCategory},
      );
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<BusinessServicesModel> list =
                resJson.map<BusinessServicesModel>((value) {
              return BusinessServicesModel.fromJson(value);
            }).toList();
            businessServiceList.value = list;
            businessTrueServiceList.value = businessServiceList.value?.where((element) => element.isActive == true).toList();
          }
        } else {
          change(null, status: RxStatus.error());
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: apiResponse.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        change(null, status: RxStatus.error());
        Get.showSnackbar(
          GetSnackBar(
            title: "No service",
            message: apiResponse.apiResponseModel!.message ?? '',
            icon: const Icon(Icons.error),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: e.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  specialistRegApi() async {
    isLoading.value = true;
    ApiService.registerSpecialist(specialistRegModel: specialistRegModel)
        .then((apiResponse) async {
      isLoading.value = false;
      print("apiResponse");
      print(apiResponse.apiResponseModel?.status);
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          Get.to(() => SuccessfulScreen(
              text: "Specialist Registration Completed \n Successfully",
              isLoading: false,
              title: "Go To Login",
              onTap: () {
                Get.offAllNamed(Routes.loginScreen);
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

  callSplAddService(String serviceName,String serviceToken,String serviceTime,String? fileName,String? filePath,String? base64) async {
    isLoading.value = true;
    BusinessServicesModel businessServicesModel = BusinessServicesModel(
        orgId: 1,
        businessServiceId: '',
        businessServiceName: serviceName,
        emailId: specialistRegModel.emailId,
        userType: "S",
        businessCategoryId: specialistRegModel.businessCategory,
        durationMinutes: int.parse(serviceTime),
        tokens:  int.parse(serviceToken),
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
              text: "Service Request Sent \nSuccessfully",
              isLoading: false,
              title: "Thank You",
              onTap: () {
                Get.back();
                Get.back();
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
