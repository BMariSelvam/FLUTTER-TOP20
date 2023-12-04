import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Const/approute.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/CreateServiceModel.dart';
import '../../../../Model/businessregmodel.dart';
import '../../../../Model/businessservicemodel.dart';
import '../../../../Model/businessspecialistmodel.dart';
import '../../BusinessBottomNavBar/businessbottomnavbar.dart';


class BusinessServiceController extends GetxController with StateMixin {
  Rx<bool> isLoading = false.obs;

  // selected service
  Rx<List<CreateServiceModel>?> selectedServiceList =
      (null as List<CreateServiceModel>?).obs;
  List<String?> selectedServiceIds = [];

  Rx<List<CreateServiceModel>?> businessServiceList =
      (null as List<CreateServiceModel>?).obs;

  //addExisting Service
  late CreateNewServiceModel createNewServiceModel;
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
  }


  //Get Category wise All Service Api
  getAllServicesList() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: (specialistId != null)
          ? HttpUrl.specialistandbussinessGetServices
          : HttpUrl.businessServices,
      params: {
        //todo hardcoded for business id
        if (specialistId != null)
          "SpecialistId": await PreferenceHelper.getSpecialistData()
              .then((value) => value?.specialistId),
        if (businessId != null)
          "BusinessId": await PreferenceHelper.getBusinessData()
              .then((value) => value?.businessId),
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<CreateServiceModel> list =
            resJson.map<CreateServiceModel>((value) {
              return CreateServiceModel.fromJson(value);
            }).toList();
            selectedServiceList.value = list;
            selectedServiceIds = list.map((e) => e.businessServiceId).toList();
            return;
          }
        }
      }
    });

    isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse = await NetworkManager.get(
        url: HttpUrl.allbusinessServices,
        // todo: This is hardcoded so far. Need to change in future
        params: {
          if (businessId != null)
            "BusinessCategoryId": await PreferenceHelper.getBusinessData()
                .then((value) => value?.businessCategory),
          if (specialistId != null)
            "BusinessCategoryId":
            await PreferenceHelper.getSpecialistData()
                .then((value) => value?.businessCategory),
        },
      );
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<CreateServiceModel> entireServiceList =
            resJson.map<CreateServiceModel>((value) {
              return CreateServiceModel.fromJson(value);
            }).toList();

            entireServiceList.forEach((element) {
              if (businessId != null) {
                if (selectedServiceList.value!.any((selectedService) =>
                selectedService.businessServiceId ==
                    element.businessServiceId)) {
                  element.isSelected = true;
                } else {
                  element.isSelected = false;
                }
              } else {
                if (selectedServiceList.value!.any((selectedService) =>
                selectedService.serviceId == element.businessServiceId)) {
                  element.isSelected = true;
                } else {
                  element.isSelected = false;
                }
              }
            });
            businessServiceList.value = entireServiceList;
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


  //Create service Specilaist
  createSpecilaistService() async {
    isLoading.value = true;
    // CreateNewServiceModel? createNewServiceModel;
    // String? specialistId, specialistName;
    //
    // await PreferenceHelper.getSpecialistData().then((value) {
    //   specialistId = value?.specialistId;
    //   specialistName = value?.specilistName;
    // });
    //
    // // here setting the isActive value based on selection
    // businessServiceList.value?.forEach((element) async {
    //   element.isActive = element.isSelected;
    // });
    //
    // createNewServiceModel = CreateNewServiceModel(
    //   orgId: 1,
    //   specialistId: specialistId,
    //   businessId: "",
    //   createdby: specialistName,
    //   addservicesList: businessServiceList.value,);

    ApiService.CreateSerivceSpecialist(
        createNewServiceModel: createNewServiceModel)
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          // Get.offAllNamed(Routes.specialistDashBoardScreen);
          Navigator.pop(Get.context!);
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

  //Create service Business
  AddExistingServiceBusiness() async {
    isLoading.value = true;
    ApiService.AddExistingServicesbusiness(
        createNewServiceModel: createNewServiceModel)
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          // Get.offAllNamed(Routes.businessBottomNavBar);
          Navigator.pop(Get.context!);
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
