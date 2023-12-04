import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Const/approute.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/businesscstegorymodel.dart';
import '../../../../Model/businessregmodel.dart';
import '../../../../Model/businessservicemodel.dart';
import '../../../Success/successscreen.dart';

class BusinessThirdController extends GetxController with StateMixin {
  TextEditingController bioController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController requestCategoryController = TextEditingController();
  TextEditingController requestServiceController = TextEditingController();

  Rx<BusinessCategoryModel?> selectedBusinessCategory =
      (null as BusinessCategoryModel?).obs;
  Rx<List<BusinessCategoryModel>?> businessCategoryList =
      (null as List<BusinessCategoryModel>?).obs;
  Rx<List<BusinessCategoryModel>?> businessTrueCategoryList = (null as List<BusinessCategoryModel>?).obs;

  Rx<List<BusinessServicesModel>?> businessServiceList =
      (null as List<BusinessServicesModel>?).obs;
  Rx<List<BusinessServicesModel>?> businessTrueServiceList = (null as List<BusinessServicesModel>?).obs;

  Rx<BusinessServicesModel?> selectedBusinessService =
      (null as BusinessServicesModel?).obs;

  RxBool isLoading = false.obs;
  late BusinessRegModel businessRegModel;
  final businessRegThirdKey = GlobalKey<FormState>();

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
            businessTrueCategoryList.value = businessCategoryList.value?.where((element) => element.isActive == true).toList();
            return;
          }
        }
      } else {
        change(null, status: RxStatus.error());
        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            message: "Something went wrong",
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

  getBusinessServicesList(String? businessCategoryId) async {
    change(null, status: RxStatus.loading());
    selectedBusinessService.value = null;
    try {
      final apiResponse = await NetworkManager.get(
        url: HttpUrl.businessService,
        // todo: This is hardcoded so far. Need to change in future
        params: {"BusinessCategoryId": businessCategoryId},
        // params: {"BusinessCategoryId": businessRegModel?.businessCategory},
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
            return;
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
            title: "Error",
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

  addNewCategoryRequest(CategoryName, EmailId) async {
    isLoading.value = true;
    final apiResponse = await NetworkManager.post(
      url: HttpUrl.newCategoryAdded,
      // todo: This is hardcoded so far. Need to change in future
      params: {
        "OrgId": 1,
        "RequestedBusinessCategoryId": "",
        "RequestedBusinessCategoryName": CategoryName,
        "RequestedByEmailId": EmailId,
        "IsActive": true,
        "CreatedBy": "admin",
        "CreatedOn": "2023-05-17T19:03:38.685Z",
        "ChangedBy": EmailId,
        "ChangedOn": "2023-05-17T19:03:38.685Z",
        "IsApproved": false,
        "ApprovedBy": "",
        "ApprovedOn": "2023-05-17T19:03:38.685Z"
      },
    );
    isLoading.value = false;
    if (apiResponse.apiResponseModel != null) {
      if (apiResponse.apiResponseModel!.status) {
        // Get.offAllNamed(NewRequestCategorySucess.routeName);
        // Navigator.pop(context);
        Get.to(SuccessfulScreen(
          text: "Your Category \n Request has been Sent",
          isLoading: false,
          title: "Thank You",
          onTap: () {
            Get.offAllNamed(Routes.loginScreen);
          },
        ));
        // Get.back();
      } else {
        String? message = apiResponse.apiResponseModel?.message;
        PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
      }
    } else {
      PreferenceHelper.showSnackBar(
          context: Get.context!, msg: apiResponse.error);
    }
  }

  callBusinessRegistration() async {
    isLoading.value = true;
    ApiService.registerBusiness(businessRegModel: businessRegModel!)
        .then((apiResponse) async {
      isLoading.value = false;

      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          // Get.offAllNamed();
          Get.to(() => SuccessfulScreen(
              text: "Business Registration \n Successfully",
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

  callAddService(String serviceName,
      String serviceToken,String serviceTime,String? fileName,String? filePath,String? base64) async {
    isLoading.value = true;
    BusinessServicesModel businessServicesModel = BusinessServicesModel(
        orgId: 1,
        businessServiceId: '',
        businessServiceName: serviceName,
        emailId: businessRegModel.emailId,
        userType: "S",
        businessCategoryId: businessRegModel.businessCategory,
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
          //Get.offAllNamed(NewRequestServiceSucess.routeName);

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
