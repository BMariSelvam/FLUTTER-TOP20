import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/businesscstegorymodel.dart';
import '../../../../Model/businesslistmodel.dart';
import '../../../../Model/businessservicemodel.dart';
import '../../../../Model/specialistmodel.dart';

class UserBusinessSpecialistListController extends GetxController
    with StateMixin {
  RxBool isFav = false.obs;
  RxBool isLoading = false.obs;
  List<SpecialistListModel> specialistList = [];
  String selectedBusinessCategoryId = "";
  RxList<BusinessCategoryModel> businessCategoryList = <BusinessCategoryModel>[].obs;
  RxList<BusinessCategoryModel> businessTrueCategoryList = <BusinessCategoryModel>[].obs;

  BusinessCategoryModel? selectedBusinessCategory;

  RxList<BusinessServicesModel> businessServicesList = <BusinessServicesModel>[].obs;
  RxList<BusinessServicesModel> businessTrueServicesList = <BusinessServicesModel>[].obs;
  BusinessServicesModel? selectedCategoryService;

  List<SpecialistListModel> favouriteSpecialistList = [];

  getBusinessCategory() async {
    change(null, status: RxStatus.loading());
    selectedBusinessCategory = null;
    try {
      final apiResponse =
          await NetworkManager.get(url: HttpUrl.businessCategory, params: {
        "OrganizationId": 1,
        //todo: this line is hardcodes
      });
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            businessCategoryList.value =
                resJson.map<BusinessCategoryModel>((value) {
              return BusinessCategoryModel.fromJson(value);
            }).toList();
            businessTrueCategoryList.value = businessCategoryList.value.where((element) => element.isActive == true).toList();
            return;
          }
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
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());
      PreferenceHelper.showSnackBar(
          context: Get.context!, msg: "Something went wrong");
    }
  }

  getBusinessServices(businessCategoryId) async {
    change(null, status: RxStatus.loading());
    selectedCategoryService = null;
    try {
      final apiResponse =
          await NetworkManager.get(url: HttpUrl.businessService, params: {
        "OrganizationId": 1,
        "BusinessCategoryId": businessCategoryId
        //todo: this line is hardcodes
      });
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            businessServicesList.value =
                resJson.map<BusinessServicesModel>((value) {
              return BusinessServicesModel.fromJson(value);
            }).toList();
            businessTrueServicesList.value = businessServicesList.value.where((element) => element.isActive == true).toList();
            return;
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        businessServicesList.value.clear();
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());
      PreferenceHelper.showSnackBar(
          context: Get.context!, msg: "Something went wrong");
    }
  }

  getSpecialistList() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await userGetFavoriteSpecialist();
    try {
      final apiResponse = await NetworkManager.get(
        url: HttpUrl.getAllSpecialist,
        params: {
          "OrganizationId": 1,
          "BusinessCategoryId": selectedBusinessCategoryId,
        },
      );
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null && apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            specialistList = resJson.map<SpecialistListModel>((value) {
              SpecialistListModel _model = SpecialistListModel.fromJson(value);
              _model.isfavourite = favouriteSpecialistList.any((element) => element.favSpecialistId == _model.specialistId);
              return _model;
            }).toList();
            change(null, status: RxStatus.success());
            return;
          }
        }
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  userGetFavoriteSpecialist() async {
    change(null, status: RxStatus.loading());
    try {
      final apiResponse = await NetworkManager.get(
        url: HttpUrl.userGetFavSpecialist,
        // todo: This is hardcoded so far. Need to change in future
        params: {
          "MemberId": await PreferenceHelper.getMemberData()
              .then((value) => value?.memberId)
        },
      );
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<SpecialistListModel> list =
                resJson.map<SpecialistListModel>((value) {
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
