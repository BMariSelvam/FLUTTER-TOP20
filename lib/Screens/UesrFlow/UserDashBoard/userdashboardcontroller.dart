import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Const/colors.dart';
import '../../../Helper/api.dart';
import '../../../Helper/networkmanager.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/FeaturedServicesModel.dart';
import '../../../Model/advertisementmodel.dart';
import '../../../Model/appointmentmodel.dart';
import '../../../Model/bannermodel.dart';
import '../../../Model/businesslistmodel.dart';
import '../../../Model/specialistmodel.dart';

class UserDashboardController extends GetxController with StateMixin {
  List<AdvertisementModel> advertisementImageList = [];
  List<AdvertisementModel> advertisementFiltter = [];
  Rx<List<BannerModel>?> bannerImageList = (null as List<BannerModel>?).obs;
  Rx<List<BannerModel>?> bannerImageListfiltter =
      (null as List<BannerModel>?).obs;
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  Rx<bool> isLoading = false.obs;
  List<Appointment> appointmentOpen = [];

  List<Appointment> appointmentList = [];
  late Appointment appointment;

  ///Featured Services
  List<FeaturedServicesModel> featuredServices = [];

  userBannerGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.bannerGetAll,
      params: {},
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          // logic for api call success
          bannerImageList.value = (apiResponse.apiResponseModel!.result as List)
              .map((e) => BannerModel.fromJson(e))
              .toList();
          bannerImageListfiltter.value = bannerImageList.value
              ?.where((element) => (element.isActive == true))
              .toList();
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
    });
  }

  userAdvertisementGet() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.advertisementGetAll,
      params: {},
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          // logic for api call success
          advertisementImageList =
              (apiResponse.apiResponseModel!.result as List)
                  .map((e) => AdvertisementModel.fromJson(e))
                  .toList();
          print("advertisementImageList.length");
          print(advertisementImageList.length);
          advertisementFiltter = advertisementImageList!
              .where((element) => (element.isActive == true))
              .toList();
          print("advertisementImageList.length");
          print(advertisementFiltter.length);
          print("advertisementFiltter.first.imageFilePath");
          print(advertisementFiltter.first.advId);
          print(advertisementFiltter.first.branchCode);
          print(advertisementFiltter.last.imageFilePath);
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
    });
  }

  getUserAllAppointments() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getAppointmentList,
      params: {
        //todo hardcoded for business id
        "OrganizationId": 1,
        "MemberId": await PreferenceHelper.getMemberData()
            .then((value) => value?.memberId)
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          //logic for api call success
          appointmentList = (apiResponse.apiResponseModel!.result as List)
              .map((e) => Appointment.fromJson(e))
              .toList();
          appointmentOpen = appointmentList
              .where((element) => (element.status != 5 && element.status != 6))
              .toList();
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
    });
  }

  getFeaturedServices() async {
    print("ENTER INTO FEATURED SERVICES");
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getFeaturedServices,
      params: {
        "OrganizationId": 1,
        "TransNo": "",
        "ServiceId": "",
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          featuredServices = (apiResponse.apiResponseModel!.result as List)
              .map((e) => FeaturedServicesModel.fromJson(e))
              .toList();
          print("::::::Success:::::");
        } else {
          // change(null, status: RxStatus.error());
          // String? message = apiResponse.apiResponseModel?.message;
          // Get.showSnackbar(GetSnackBar(
          //   message: message,
          //   backgroundColor: Colors.red,
          //   margin: const EdgeInsets.all(18.0),
          //   icon: const Icon(Icons.error, color: MyColors.white),
          //   snackPosition: SnackPosition.TOP,
          //   duration: const Duration(seconds: 1),
          // ));
        }
      } else {
        change(null, status: RxStatus.error());

        Get.showSnackbar(GetSnackBar(
          message: apiResponse.error,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.all(18.0),
          icon: const Icon(Icons.error, color: MyColors.white),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 1),
        ));
      }
    });
  }
}
