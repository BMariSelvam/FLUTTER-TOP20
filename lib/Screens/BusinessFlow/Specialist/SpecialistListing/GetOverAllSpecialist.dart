import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/specialistmodel.dart';

class GetAllSpecialistController extends GetxController with StateMixin {
  RxBool isAddClick = false.obs;


  TextEditingController scanByQrController = TextEditingController();
  TextEditingController searchByNameController = TextEditingController();
  RxList<SpecialistListModel> specialistList = <SpecialistListModel>[].obs;
  RxList<SpecialistListModel> displayList = <SpecialistListModel>[].obs;
  List<SpecialistListModel> specialistOverAllList = [];
  Rx<bool> isLoading = false.obs;



  getSearchSpecialistList() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse =
      await NetworkManager.get(url: HttpUrl.unInvitedSpecialist, params: {
        "OrganizationId": 1,
        "BusinessCategoryId": await PreferenceHelper.getBusinessData()
            .then((value) => value?.businessCategory),
        "BusinessId": await PreferenceHelper.getBusinessData()
            .then((value) => value?.businessId)
      });
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          print("apiResponse.apiResponseModel!.result!");
          print(apiResponse.apiResponseModel!.result!);
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            print("resJson");
            print(resJson);
            specialistList.value = resJson.map<SpecialistListModel>((value) {
              return SpecialistListModel.fromJson(value);
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

}
