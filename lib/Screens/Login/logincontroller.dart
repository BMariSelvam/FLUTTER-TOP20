import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Const/approute.dart';
import '../../Helper/api.dart';
import '../../Helper/enum.dart';
import '../../Helper/networkmanager.dart';
import '../../Helper/preferenceHelper.dart';
import '../../Model/Member_details_model.dart';
import '../../Model/specialistdetailmodel.dart';
import '../../Model/userdetailmodel.dart';

class LoginController extends GetxController with StateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool passwordVisibility = true;
  RxBool isLoading = false.obs;
  late UserType userType;

  login() async {
    print(userType);
    isLoading.value = true;
    await NetworkManager.post(
      url: (userType == UserType.user)
          ? HttpUrl.memberLogin
          : userType == UserType.specialist
              ? HttpUrl.specialistLogin
              : HttpUrl.businessLogin,
      params: {
        "OrganizationId": 1,
        "EmailId": emailController.text.trim(),
        "Password": passwordController.text.trim(),
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      print("apiResponse.apiResponseModel");
      print(apiResponse.apiResponseModel);
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        print("apiResponse.apiResponseModel");
        print(apiResponse.apiResponseModel);
        if (apiResponse.apiResponseModel!.result != null &&
            (apiResponse.apiResponseModel!.result as List).isNotEmpty) {
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.result! as List).first;
          if (customerJson != null) {
            if (userType == UserType.business) {
              BusinessDetailsModel userDetailsModel =
                  BusinessDetailsModel.fromJson(customerJson);
            } else if (userType == UserType.specialist) {
              SpecialistDetails specialistDetails =
                  SpecialistDetails.fromJson(customerJson);
            } else {
              MemberDetails memberDetails =
                  MemberDetails.fromJson(customerJson);
            }
            await PreferenceHelper.saveUserData(customerJson)
                .then((value) async {
              if (userType == UserType.business) {
                print("BUSINESS Ready");
                Get.offAllNamed(Routes.businessBottomNavBar);
              } else if (userType == UserType.specialist) {
                print("specialist Ready");
                Get.offAllNamed(Routes.specialistBottomNavBar);
              } else if (userType == UserType.user) {
                print("user Ready");
                Get.offAllNamed(Routes.userBottomNavBar);
                //     arguments: PreferenceHelper.isUser);
              }
            });
          } else {
            String? message = apiResponse.apiResponseModel?.message;
            Get.snackbar("Invalid Username or Password", message!,
                duration: 3.seconds, snackPosition: SnackPosition.TOP);
          }
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          Get.snackbar("Invalid Username or Password", message!,
              duration: 3.seconds, snackPosition: SnackPosition.TOP);
        }
      } else {
        String? message = apiResponse.apiResponseModel?.message;
        Get.snackbar("Invalid Username or Password", message!,
            duration: 3.seconds, snackPosition: SnackPosition.TOP);
      }
      isLoading.value = false;
      update();
    });
  }
}
