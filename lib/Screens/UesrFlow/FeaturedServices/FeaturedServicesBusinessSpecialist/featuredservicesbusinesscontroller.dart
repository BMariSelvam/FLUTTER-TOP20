import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Const/colors.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Model/FeaturedServicesModel.dart';
import '../../../../Model/businesslistmodel.dart';
import '../../../../Model/specialistmodel.dart';

class FeaturedBusSplController extends GetxController with StateMixin {
  RxBool isBusinessClick = true.obs;
  RxBool isSpecialistClick = false.obs;

  RxBool isLoading = false.obs;
  List<FeaturedServicesModel> featuredServices = [];
  RxList<BusinessListUserViewModel> businessList =
      <BusinessListUserViewModel>[].obs;
  RxList<SpecialistListModel> specialistList = <SpecialistListModel>[].obs;

  getFeaturedServices(String? serviceId) async {
    print("ENTER INTO FEATURED SERVICES");
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getFeaturedServices,
      params: {
        "OrganizationId": 1,
        "TransNo": "",
        "ServiceId": serviceId,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          featuredServices = (apiResponse.apiResponseModel!.result as List)
              .map((e) => FeaturedServicesModel.fromJson(e))
              .toList();

          if (featuredServices.first.businessDetail!.isNotEmpty &&
              featuredServices.first.businessDetail != null) {
            List<String?> businessIds = featuredServices.first.businessDetail!
                .map((element) => element.businessId)
                .toList();

            for (String? businessId in businessIds) {
              isLoading.value = true;
              try {
                await getBusinessList(businessId!);
              } catch (error) {
                handleApiError(error);
              }
              // isLoading.value = false;
            }
          }

          if (featuredServices.first.specialistDetail!.isNotEmpty &&
              featuredServices.first.specialistDetail != null) {
            List<String?> specialistIds = featuredServices
                .first.specialistDetail!
                .map((element) => element.specialistId)
                .toList();

            for (String? specialistId in specialistIds) {
              // isLoading.value = true;
              try {
                await getSpecialistList(specialistId!);
              } catch (error) {
                handleApiError(error);
              }
              isLoading.value = false;
            }
          }

          print("::::::Success:::::");
          print("featuredServices.first.businessDetail?.length");
          print(featuredServices.first.specialistDetail?.length);
          print(featuredServices.first.businessDetail?.length);

          change(null, status: RxStatus.success());
        } else {
          // change(null, status: RxStatus.error());
          // String? message = apiResponse.apiResponseModel?.message;
          // Get.showSnackbar(GetSnackBar(
          //   message: message,
          //   backgroundColor: Colors.red,
          //   margin: const EdgeInsets.all(18.0),
          //   icon: const Icon(Icons.error),
          //   snackPosition: SnackPosition.TOP,
          // ));
        }
      } else {
        change(null, status: RxStatus.error());

        // Get.showSnackbar(GetSnackBar(
        //   message: apiResponse.error,
        //   backgroundColor: Colors.red,
        //   margin: const EdgeInsets.all(18.0),
        //   icon: const Icon(Icons.error, color: MyColors.white),
        //   snackPosition: SnackPosition.TOP,
        //   duration: const Duration(seconds: 1),
        // ));
      }
    });
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
              if (!businessList
                  .any((b) => b.businessId == business.businessId)) {
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
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<SpecialistListModel> list =
                resJson.map<SpecialistListModel>((value) {
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
