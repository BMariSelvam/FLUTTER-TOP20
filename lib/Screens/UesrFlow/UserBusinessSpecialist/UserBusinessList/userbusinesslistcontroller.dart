import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/businesscstegorymodel.dart';
import '../../../../Model/businesslistmodel.dart';
import '../../../../Model/businessservicemodel.dart';

class UserBusinessListController extends GetxController with StateMixin {
  RxBool isFav = false.obs;

  List<BusinessListUserViewModel> businessList = [];

  List<BusinessListUserViewModel> favBusinessList = [];

  String selectedBusinessCategoryId = "";

  RxList<BusinessCategoryModel> businessCategoryList =
      <BusinessCategoryModel>[].obs;
  BusinessCategoryModel? selectedBusinessCategory;

  RxList<BusinessServicesModel> businessServicesList =
      <BusinessServicesModel>[].obs;
  BusinessServicesModel? selectedCategoryService;

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
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            businessServicesList.value =
                resJson.map<BusinessServicesModel>((value) {
              return BusinessServicesModel.fromJson(value);
            }).toList();
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

  getBusinessList(selectedBusinessCategoryId) async {
    change(null, status: RxStatus.loading());
    await getFavoriteBusinessList();
    try {
      final apiResponse =
          await NetworkManager.get(url: HttpUrl.getBusinessByCategory, params: {
        "OrganizationId": 1,
        "BusinessCategoryId": selectedBusinessCategoryId,
      });
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            businessList = resJson.map<BusinessListUserViewModel>((value) {
              BusinessListUserViewModel _model =
                  BusinessListUserViewModel.fromJson(value);
              _model.isFavourite = favBusinessList
                  .any((element) => element.FavBusinessId == _model.businessId);
              return _model;
            }).toList();
            change(null, status: RxStatus.success());
            return;
          }
        }
      }
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  getFavoriteBusinessList() async {
    change(null, status: RxStatus.loading());
    try {
      final apiResponse = await NetworkManager.get(
        url: HttpUrl.userGetFavBusiness,
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
            List<BusinessListUserViewModel> list =
                resJson.map<BusinessListUserViewModel>((value) {
              return BusinessListUserViewModel.fromJson(value);
            }).toList();
            favBusinessList = list;
            change(null, status: RxStatus.success());
            return;
          }
        } else {
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: apiResponse.apiResponseModel!.message ??
                  'Something went wrong',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
          change(null, status: RxStatus.error());
        }
      } else {
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "No Data's found",
          message: e.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
      change(null, status: RxStatus.error());
    }
  }
}
