import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Const/font.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/businesslistmodel.dart';
import '../../../../Model/specialistmodel.dart';

class UserFavController extends GetxController with StateMixin {
  RxList<SpecialistListModel> favSpecialistList = RxList();
  RxList<BusinessListUserViewModel> favBusinessList = RxList();
  Rx<bool> isLoading = false.obs;

  changeSpecialistFavourite({
    required SpecialistListModel specialistListModel,
    required String? memberId,
    required bool isFav,
  }) async {
    isLoading.value = true;
    await NetworkManager.post(
      url: isFav ? HttpUrl.userFavSpecialist : HttpUrl.removeFavSpecialist,
      params: {
        "OrgId": 1,
        "MemberId": memberId,
        "FavSpecialistId": specialistListModel.specialistId,
        "CreatedBy": memberId,
      },
    ).then((apiResponse) async {
      isLoading.value = true;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.status) {
          showPopUp(
              Get.context!,
              const Duration(seconds: 1),
              isFav ? "Add Favourite" : "Removed Favourite",
              isFav
                  ? "This Specialist \n Add to your Favourite"
                  : "This Specialist \n Removed from your Favourite");
          // PreferenceHelper.showSnackBar(
          //   context: Get.context!,
          //   msg: isFav ? "Add To Favorite!" : "Removed from Favorite!",
          // );
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

  changeBusinessFavourite(
      businessListUserViewModel, String? memberId, bool isFav) async {
    isLoading.value = true;
    await NetworkManager.post(
      url: isFav ? HttpUrl.userFavBusiness : HttpUrl.removeFavBusiness,
      params: {
        "OrgId": 1,
        "MemberId": memberId,
        "FavBusinessId": businessListUserViewModel.businessId,
        "CreatedBy": memberId,
      },
    ).then((apiResponse) async {
      isLoading.value = true;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.status) {
          showPopUp(
              Get.context!,
              const Duration(seconds: 1),
              isFav ? "Add Favourite" : "Removed Favourite",
              isFav
                  ? "This Business \n Add to your Favourite"
                  : "This Business \n Removed from your Favourite");
          // PreferenceHelper.showSnackBar(
          //   context: Get.context!,
          //   msg: isFav ? "Add To Favourite!" : "Removed from Favourite!",
          // );
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

  getFavouriteSpecialistList() async {
    isLoading.value = true;
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
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<SpecialistListModel> list =
                resJson.map<SpecialistListModel>((value) {
              return SpecialistListModel.fromJson(value);
            }).toList();
            favSpecialistList.value = list;
            change(null, status: RxStatus.success());
            return;
          }
        } else {
          Get.showSnackbar(
            GetSnackBar(
              title: "Note",
              message: "No Data's found",
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
          change(null, status: RxStatus.error());
          return;
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

  getFavouriteBusinessList() async {
    isLoading.value = true;
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
            favBusinessList.value = list;
            return;
          }
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              title: "Note",
              message: "No Data's found",
              icon: Icon(Icons.error),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {}
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
}

void showPopUp(BuildContext context, Duration displayDuration, String text,
    String command) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Timer(displayDuration, () {
        Navigator.of(context)
            .pop(); // Close the dialog after the displayDuration
      });

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: Text(
          command,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    },
  );
}
