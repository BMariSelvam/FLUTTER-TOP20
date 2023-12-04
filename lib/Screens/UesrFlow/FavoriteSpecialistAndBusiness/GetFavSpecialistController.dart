import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/api.dart';
import '../../../Helper/networkmanager.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/businesslistmodel.dart';
import '../../../Model/specialistmodel.dart';

class GetFavSpecialistController extends GetxController with StateMixin {
  Rx<bool> isLoading = false.obs;
  List<SpecialistListModel> favSpecialistList = [];
  RxList<SpecialistListModel> specialistList = <SpecialistListModel>[].obs;


  getFavouriteSpeicialistList() async {
    specialistList.length = 0;
    isLoading.value = true;
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
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<SpecialistListModel> list =
                resJson.map<SpecialistListModel>((value) {
              return SpecialistListModel.fromJson(value);
            }).toList();
            favSpecialistList = list;
            print("favSpecialistList.value.length");
            print(favSpecialistList.length);
            change(null, status: RxStatus.success());
            List<String?> specialistIds = favSpecialistList.map((element) => element.favSpecialistId).toList();
            for (String? specialistId in specialistIds) {
              isLoading.value = true;
              try {
                await getSpecialistList(specialistId!);
              } catch (error) {
                handleApiError(error);
              }
              isLoading.value = false;
            }
            return;
          }
        }
      } else {
        favSpecialistList.clear();
        change(null, status: RxStatus.success());
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
    change(null, status: RxStatus.success());
  }



  getSpecialistList(String specialistId) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse = await NetworkManager.get(
        url: HttpUrl.specialistGetBy,
        params: {
          "SpecialistId": specialistId,
        },
      );
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null && apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<SpecialistListModel> list = resJson.map<SpecialistListModel>((value) {
              return SpecialistListModel.fromJson(value);
            }).toList();
            specialistList.addAll(list);
          }
        }
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }


  changeSpecialistFavourite({
    required SpecialistListModel specialistListModel,
    required String? memberId,
    required bool isFav,
  }) async {
    await NetworkManager.post(
      url: isFav ? HttpUrl.userFavSpecialist : HttpUrl.removeFavSpecialist,
      params: {
        "OrgId": 1,
        "MemberId": memberId,
        "FavSpecialistId": specialistListModel.specialistId,
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
          await getFavouriteSpeicialistList();
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
