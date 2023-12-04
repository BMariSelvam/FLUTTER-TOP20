import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_20/Screens/Success/successscreen.dart';

import '../../../../Const/approute.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/Member_details_model.dart';
import '../../../../Model/specialistmodel.dart';
import '../../../../Model/specialistservicemodel.dart';
import '../../../../Model/userspecialistappointmentmodel.dart';

class AppointmentController extends GetxController with StateMixin {
  RxBool isViewPressed = true.obs;
  bool isBusinessPlace = true;

  RxBool isToggleOn = true.obs;
  RxBool isBusinessOn = true.obs;
  RxBool isCustomerOn = true.obs;
  int serviceLocation = 0;
  RxBool isLoading = false.obs;
  DateTime selectedDate = DateTime.now();
  String? date;
  DateTime? openTime;
  int totalCoinsNeed = 0;
  int totalDurationTime = 0;
  late TimeOfDay fromTime;
  late TimeOfDay addedServiceTime;
  TextEditingController dateController = TextEditingController();
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  final appointmentKey = GlobalKey<FormState>();
  late UserSpecialistAppointmentCreateModel userAppointmentCreateModel;
  MemberDetails? memberDetails;

  Rx<List<SpecialistListModel>?> specilaist = (null as List<SpecialistListModel>?).obs;
  Rx<List<SpecialistServicesModel>?> specialistServiceList = (null as List<SpecialistServicesModel>?).obs;
  Rx<List<SpecialistServicesModel>?> specialistTrueServiceList = (null as List<SpecialistServicesModel>?).obs;

  @override
  void onInit() {
    // TODO: implement initState
    super.onInit();
    _initialiseData();
  }

  _initialiseData() async {
    memberDetails = await PreferenceHelper.getMemberData();
  }


  userAppointmentSpecialist() async {
    isLoading.value = true;
    int sNo = 1;

    for (var elemnet in userAppointmentCreateModel.appoinmentDetail!) {
      elemnet.slNo = sNo++;
    }
    ApiService.userAppointmentSpecialist(
            userAppointmentCreateModel: userAppointmentCreateModel)
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          Get.offAll(SuccessfulScreen(
              text: "Booking Requested.\nPlease check under \nAppointments for confirmation",
              isLoading: false,
              title: "Go To Dashboard",
              onTap: () {
                Get.offAllNamed(Routes.userBottomNavBar);
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


  getSpeciliast(specialistId) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse =
      await NetworkManager.get(url: HttpUrl.specialistGetBy, params: {
        "SpecialistId": specialistId,
      });
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
            specilaist.value = list;
          }
        }
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }



  getBusinessServicesList(String? specialistId) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    final apiResponse = await NetworkManager.get(
      url: HttpUrl.specialistandbussinessGetServices,
      // todo: This is hardcoded so far. Need to change in future
      params: {"SpecialistId": specialistId},
    );
    isLoading.value = false;
    if (apiResponse.apiResponseModel != null &&
        apiResponse.apiResponseModel!.status) {
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel!.result != null) {
        List? resJson = apiResponse.apiResponseModel!.result!;
        if (resJson != null) {
          List<SpecialistServicesModel> list =
              resJson.map<SpecialistServicesModel>((value) {
            return SpecialistServicesModel.fromJson(value);
          }).toList();
          specialistServiceList.value = list;
          specialistTrueServiceList.value = specialistServiceList.value?.where((element) => element.isActive == true).toList();
          return;
        }
      } else {
        specialistServiceList.value = null;
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
      specialistServiceList.value = null;
      Get.showSnackbar(
        GetSnackBar(
          title: "No Serivce Found",
          message: apiResponse.apiResponseModel!.message ?? '',
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
