import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Const/approute.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/businessregmodel.dart';
import '../../../../Model/businessservicemodel.dart';

class ServiceController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  RxBool isAddServiceClick = false.obs;
  RxBool isRequestedServiceClick = true.obs;
  RxBool isAddServiceButtonServiceClick = true.obs;

  Rx<List<BusinessServicesModel>?> businessServiceList =
      (null as List<BusinessServicesModel>?).obs;

  Rx<List<BusinessServicesModel>?> selectedServiceList = (null as List<BusinessServicesModel>?).obs;
  Rx<List<BusinessServicesModel>?> trueServiceList = (null as List<BusinessServicesModel>?).obs;

  List<String?> selectedServiceIds = [];
  List<String?> selectedspecialistServiceIds = [];

  late AddServicesListModel addServicesListModel;

  late AddServicesListModel removeServicesListModel;

  List<BusinessServicesModel> getBusinessRequestList = [];
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
    getAllServicesList();
    getBusinessRequestServiceList();
  }

  getAllServicesList() async {
    isLoading.value = true;
    await NetworkManager.get(
      url: (specialistId != null)
          ? HttpUrl.getAllServiceSpecialist
          : HttpUrl.getAllServiceBusiness,
      params: {
        //todo hardcoded for business id
        if (specialistId != null)
          "SpecialistId": await PreferenceHelper.getSpecialistData()
              .then((value) => value?.specialistId),
        if (businessId != null)
          "BusinessId": await PreferenceHelper.getBusinessData()
              .then((value) => value?.businessId),
        "Isactive": true
      },
    ).then((apiResponse) async {
      // isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<BusinessServicesModel> list =
                resJson.map<BusinessServicesModel>((value) {
              return BusinessServicesModel.fromJson(value);
            }).toList();
            selectedServiceList.value = list;
            trueServiceList.value = selectedServiceList.value?.where((element) => element.isActive == true).toList();
            print("trueService");
            print(trueServiceList.value?.length);
            selectedServiceIds = list.map((e) => e.businessServiceId).toList();
            selectedspecialistServiceIds = list.map((e) => e.serviceId).toList();
            return;
          }
        }
      }
    });

    isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse = await NetworkManager.get(
        url: (specialistId != null)
            ? HttpUrl.getAllServiceSpecialist
            : HttpUrl.getAllServiceBusiness,
        // todo: This is hardcoded so far. Need to change in future
        params: {
          if (specialistId != null)
            "SpecialistId": await PreferenceHelper.getSpecialistData()
                .then((value) => value?.specialistId),
          if (businessId != null)
            "BusinessId": await PreferenceHelper.getBusinessData()
                .then((value) => value?.businessId),
          "Isactive": true
        },
      );
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<BusinessServicesModel> entireServiceList =
                resJson.map<BusinessServicesModel>((value) {
              return BusinessServicesModel.fromJson(value);
            }).toList();
            entireServiceList.forEach((element) {
              if (businessId != null) {
                if (trueServiceList.value!.any((selectedService) =>
                    (selectedService.businessServiceId) == element.businessServiceId)) {
                  element.isSelected = true;
                } else {
                  element.isSelected = false;
                }
              } else {
                if (trueServiceList.value!.any((selectedService) =>
                    selectedService.serviceId == element.serviceId)) {
                  element.isSelected = true;
                } else {
                  element.isSelected = false;
                }
              }
            });
            businessServiceList.value = entireServiceList;
            change(businessServiceList.value);
            return;
          }
        } else {
          businessServiceList.value = null;
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
        businessServiceList.value = null;
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
      businessServiceList.value = null;
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

  //InActive Service Business
  inActiveServiceBusiness() async {
    // isLoading.value = true;
    removeServicesListModel.addservicesList?.forEach((element) async {
      element.isActive = false;
    });
    ApiService.inActiveRemoveServiceSpecialist(
            removeServicesListModel: removeServicesListModel)
        .then((apiResponse) async {
      // isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          Get.offAllNamed(Routes.businessBottomNavBar);
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

  getBusinessRequestServiceList() async {
    change(null, status: RxStatus.loading());
    try {
      final apiResponse = await NetworkManager.get(
        url: HttpUrl.getNewReqestserviceApi,
        // todo: This is hardcoded so far. Need to change in future
        params: {
          if (specialistId != null)
            "SpecialistId": await PreferenceHelper.getSpecialistData()
                .then((value) => value?.specialistId),
          if (businessId != null)
            "BusinessId": await PreferenceHelper.getBusinessData()
                .then((value) => value?.businessId),
          if (specialistId != null)
            "EmailId": await PreferenceHelper.getBusinessData()
                .then((value) => value?.emailId),
          if (businessId != null)
            "EmailId": await PreferenceHelper.getSpecialistData()
                .then((value) => value?.emailId),
        },
      );
      change(null, status: RxStatus.success());
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            getBusinessRequestList =
                (apiResponse.apiResponseModel!.result as List)
                    .map((e) => BusinessServicesModel.fromJson(e))
                    .toList();
            print("getBusinessRequestList.length");
            print(getBusinessRequestList.length);
            print(getBusinessRequestList.first.businessServiceId);
          }
        } else {
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
        getBusinessRequestList.isEmpty;
        // Get.showSnackbar(
        //   GetSnackBar(
        //     title: "Errorsss",
        //     message: apiResponse.apiResponseModel!.message ?? '',
        //     icon: const Icon(Icons.error),
        //     duration: const Duration(seconds: 3),
        //   ),
        // );
      }
    } catch (e) {
      // getNewServiceReuest.value = null;
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


  activeInActiveBusiness(BusinessServicesModel businesssingleServiceList) async {
    isLoading.value = true;
    AddServicesListModel? addServicesListModel;
    String? businessId, businessName;

    await PreferenceHelper.getBusinessData().then((value) {
      businessId = value?.businessId;
      businessName = value?.businessName;
    });

    // here setting the isActive value based on selection
    // businessServiceList.value?.forEach((element) async {
    //   element.isActive = businesssingleServiceList.isSelected;
    // });

    addServicesListModel = AddServicesListModel(
        orgId: 1,
        //specialistId: businessId,
        businessId: businessId,
        createdby: businessName,
        addservicesList: businessServiceList.value);

    if (addServicesListModel != null) {

      ApiService.inActiveServiceBusiness(
              addServicesListModel: addServicesListModel!)
          .then((apiResponse) async {
        isLoading.value = false;
        if (apiResponse.apiResponseModel != null) {
          if (apiResponse.apiResponseModel!.status) {
            // Get.offAllNamed(Routes.businessBottomNavBar);
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



  activeInActiveSpcialist(BusinessServicesModel businesssingleServiceList) async {
    isLoading.value = true;
    AddServicesListModel? addServicesListModel;
    String? specialistId, specialistName;

    await PreferenceHelper.getSpecialistData().then((value) {
      specialistId = value?.specialistId;
      specialistName = value?.specilistName;
    });

    // here setting the isActive value based on selection
    // businessServiceList.value?.forEach((element) async {
    //   element.isActive = businesssingleServiceList.isSelected;
    // });

    addServicesListModel = AddServicesListModel(
        orgId: 1,
        specialistId: specialistId,
        createdby: specialistName,
        addservicesList: businessServiceList.value);

    if (addServicesListModel != null) {

      ApiService.inActiveServiceSpecialist(
          addServicesListModel: addServicesListModel!)
          .then((apiResponse) async {
        isLoading.value = false;
        if (apiResponse.apiResponseModel != null) {
          if (apiResponse.apiResponseModel!.status) {
            // Get.offAllNamed(Routes.businessBottomNavBar);
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
}
