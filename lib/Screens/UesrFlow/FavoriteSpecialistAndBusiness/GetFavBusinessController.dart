import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/api.dart';
import '../../../Helper/networkmanager.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/businesslistmodel.dart';

class GetFavBusinessController extends GetxController with StateMixin {
  Rx<bool> isLoading = false.obs;
  List<BusinessListUserViewModel> favBusinessList = [];
  RxList<BusinessListUserViewModel> businessList = <BusinessListUserViewModel>[].obs;

  getFavouriteBusinessList() async {
    businessList.length = 0;
    isLoading.value = true;
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
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<BusinessListUserViewModel> list =
                resJson.map<BusinessListUserViewModel>((value) {
              return BusinessListUserViewModel.fromJson(value);
            }).toList();
            favBusinessList = list;
            print("favBusinessList.length");
            print(favBusinessList.length);
            change(null, status: RxStatus.success());
            List<String?> businessIds = favBusinessList
                .map((element) => element.FavBusinessId)
                .toList();
            for (String? businessId in businessIds) {
              isLoading.value = true;
              try {
                await getBusinessList(businessId!);
              } catch (error) {
                handleApiError(error);
              }
              isLoading.value = false;
            }
            return;
          }
        } else {
          favBusinessList.clear();
          change(null, status: RxStatus.success());
        }
      } else {
        // Get.showSnackbar(
        //   GetSnackBar(
        //     title: "Note",
        //     message: "No Data's found",
        //     icon: const Icon(Icons.error),
        //     duration: const Duration(seconds: 3),
        //   ),
        // );
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
    }
    change(null, status: RxStatus.success());
  }

  getBusinessList(String businessId) async {
    // Check if the business is already in the list
    if (businessList.any((business) => business.businessId == businessId)) {
      // Business is already in the list, no need to add it again.
      return;
    }

    isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse =
      await NetworkManager.get(url: HttpUrl.businessGetBy, params: {
        "BusinessId": businessId,
      });
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<BusinessListUserViewModel> list =
            resJson.map<BusinessListUserViewModel>((value) {
              return BusinessListUserViewModel.fromJson(value);
            }).toList();
            // Check again before adding to avoid duplicates
            for (var business in list) {
              if (!businessList.any((b) => b.businessId == business.businessId)) {
                businessList.add(business);
              }
            }
          }
        }
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }


  changeBusinessFavourite(
      {required businessListUserViewModel,
      required String? memberId,
      required bool isFav}) async {
    await NetworkManager.post(
      url: isFav ? HttpUrl.userFavBusiness : HttpUrl.removeFavBusiness,
      params: {
        "OrgId": 1,
        "MemberId": memberId,
        "FavBusinessId": businessListUserViewModel.businessId,
        "CreatedBy": memberId,
      },
    ).then((apiResponse) async {
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.status) {
          PreferenceHelper.showSnackBar(
            context: Get.context!,
            msg: isFav ? "Add To Favorite!" : "Removed from Favorite!",
          );
          await getFavouriteBusinessList();
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
    change(null, status: RxStatus.success());
  }

  void handleApiError(error) {
    change(null, status: RxStatus.error());
    Get.showSnackbar(
      GetSnackBar(
        title: "Error",
        message: error.toString(),
        icon: const Icon(Icons.error),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
