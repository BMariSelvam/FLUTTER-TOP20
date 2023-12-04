import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/enum.dart';
import '../../Const/size.dart';
import '../../Helper/api.dart';
import '../../Helper/networkmanager.dart';
import '../../Helper/preferencehelper.dart';
import '../../Model/apiresponsemodel.dart';
import '../../Model/businessregmodel.dart';
import '../../Model/conunrymodel.dart';
import '../../Model/countrylistmodel.dart';
import '../../Model/specialistregmodel.dart';
import '../../Model/userregmodel.dart';
import '../../Widget/searchdropdowntextfield.dart';

class ContactDetailsController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  RegistrationType? registrationType;

  TextEditingController countryNameController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final Rx<CountryListModel?> selectedCountry = (null as CountryListModel?).obs;
  final Rx<CountryModel?> selectCountryOnly = (null as CountryModel?).obs;
  List<CountryListModel> countryList = [];
  final contactDetailsKey = GlobalKey<FormState>();

  RxBool isUserReg = false.obs;
  RxBool isSpecialistReg = false.obs;
  RxBool isBusinessReg = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Perform initialization tasks here, like loading data from API or shared preferences.
    loadCountryList();
  }

  void callVerifyOtp(String otp, BuildContext context) {
    // _controller.isLoading.value = true;
    // VerifyOTPParams params = VerifyOTPParams(
    //   emailId: _emailController.text,
    //   otp: otp,
    // );
    // ApiService.verifyOtp(params: params).then((apiResponse) async {
    //   _controller.isLoading.value = false;
    //   if (apiResponse.apiResponseModel != null) {
    //     if (apiResponse.apiResponseModel!.status) {
    //       print(apiResponse.apiResponseModel?.result);
    //
    //       Navigator.of(context).pop();
    //
    //       SpecialistRegModel _specialistRegModel = SpecialistRegModel();
    //       _specialistRegModel.orgId = 1;
    //       _specialistRegModel.emailId = _emailController.text;
    //       _specialistRegModel.mobileNo =
    //           "${_controller.selectedCountry.value?.code ?? ""}${_phoneNumberController.text}";
    //       _specialistRegModel.dialCode =
    //           _controller.selectedCountry.value?.code ?? "";
    //       _specialistRegModel.country =
    //           _controller.selectedCountry.value?.country ?? '';
    //
    //       // _specialistRegModel.orgId = 1;
    //       // _specialistRegModel.emailId = _emailController.text;
    //       // _specialistRegModel.mobileNo =
    //       //     "${_controller.selectedCountry.value?.code ?? ""}${_phoneNumberController.text}";
    //       // _specialistRegModel.dialCode =
    //       //     _controller.selectedCountry.value?.code ?? "";
    //       // // _specialistRegModel.countryDialCode =
    //       // //     _controller.selectedCountry.value?.code ?? "";
    //       // _specialistRegModel.country =
    //       //     _controller.selectedCountry.value?.iso ?? '';
    //
    //       BusinessRegModel _businessRegModel = BusinessRegModel();
    //       _businessRegModel.orgId = 1;
    //       _businessRegModel.emailId = _emailController.text;
    //       _businessRegModel.mobileNo =
    //           "${_controller.selectedCountry.value?.code ?? ""}${_phoneNumberController.text}";
    //       _businessRegModel.countryDialCode =
    //           _controller.selectedCountry.value?.code ?? "";
    //       _businessRegModel.country =
    //           _controller.selectedCountry.value?.country ?? '';
    //
    //       MemberRegModel _memberRegModel = MemberRegModel();
    //       _memberRegModel.orgId = 1;
    //       _memberRegModel.emailId = _emailController.text;
    //       _memberRegModel.mobileNo =
    //           "${_controller.selectedCountry.value?.code ?? ""}${_phoneNumberController.text}";
    //       _memberRegModel.dialCode =
    //           _controller.selectedCountry.value?.code ?? "";
    //       _memberRegModel.country =
    //           _controller.selectedCountry.value?.country ?? '';
    //
    //       if (widget.registrationType == RegistrationType.specialist) {
    //         Get.toNamed(SpecialistRegistrationScreen.routeName,
    //             arguments: _specialistRegModel);
    //       } else if (widget.registrationType == RegistrationType.business) {
    //         Get.toNamed(BusinessRegistrationScreen.routeName,
    //             arguments: _businessRegModel);
    //       } else {
    //         Get.toNamed(UserRegistrationScreen.routeName,
    //             arguments: _memberRegModel);
    //       }
    //     } else {
    //       String? message = apiResponse.apiResponseModel?.message;
    //       PreferenceHelper.showSnackBar(context: context, msg: message);
    //       _otpController.clear();
    //     }
    //   } else {
    //     _otpController.clear();
    //     PreferenceHelper.showSnackBar(context: context, msg: apiResponse.error);
    //   }
    // });
    if (otp == "111111") {
      SpecialistRegModel _specialistRegModel = SpecialistRegModel();
      _specialistRegModel.orgId = 1;
      _specialistRegModel.emailId = emailController.text;
      _specialistRegModel.mobileNo = phoneNumberController.text;
      _specialistRegModel.dialCode = selectedCountry.value?.code ?? "";
      _specialistRegModel.country = selectedCountry.value?.country ?? '';

      // _specialistRegModel.orgId = 1;
      // _specialistRegModel.emailId = _emailController.text;
      // _specialistRegModel.mobileNo =
      //     "${_controller.selectedCountry.value?.code ?? ""}${_phoneNumberController.text}";
      // _specialistRegModel.dialCode =
      //     _controller.selectedCountry.value?.code ?? "";
      // // _specialistRegModel.countryDialCode =
      // //     _controller.selectedCountry.value?.code ?? "";
      // _specialistRegModel.country =
      //     _controller.selectedCountry.value?.iso ?? '';

      BusinessRegModel _businessRegModel = BusinessRegModel();
      _businessRegModel.orgId = 1;
      _businessRegModel.emailId = emailController.text;
      _businessRegModel.mobileNo = phoneNumberController.text;
      _businessRegModel.countryDialCode = selectedCountry.value?.code ?? "";
      _businessRegModel.country = selectedCountry.value?.country ?? '';

      MemberRegModel _memberRegModel = MemberRegModel();
      _memberRegModel.orgId = 1;
      _memberRegModel.emailId = emailController.text;
      _memberRegModel.mobileNo = phoneNumberController.text;
      _memberRegModel.dialCode = selectedCountry.value?.code ?? "";
      _memberRegModel.country = selectedCountry.value?.country ?? '';

      if (isSpecialistReg.value == true) {
        Get.offAllNamed(Routes.specialistRegFirstScreen,
            arguments: _specialistRegModel);
      } else if (isBusinessReg.value == true) {
        Get.offAllNamed(Routes.businessRegFirstScreen,
            arguments: _businessRegModel);
      } else if (isUserReg.value == true) {
        Get.offAllNamed(Routes.userRegFirstScreen, arguments: _memberRegModel);
      }
    } else {
      otpController.clear();
      PreferenceHelper.showSnackBar(context: context, msg: "Invalid OTP");
    }
  }

  void showMaterialDialog(
      {required BuildContext context,
      required List<CountryListModel> countryList}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: double.maxFinite,
              height: height(context) / 1.9,
              child: SearchDialog<CountryListModel>(
                  items: countryList,
                  onAddPressed: null,
                  onChanged: (value) {
                    selectedCountry.value = value;
                  }),
            ),
          );
        });
  }

  loadCountryList() async {
    try {
      final String response =
          await rootBundle.loadString(Assets.countryListData);
      List<dynamic> data = await json.decode(response);
      countryList = data.map((e) => CountryListModel.fromJson(e)).toList();
      selectedCountry.value =
          countryList.firstWhere((element) => element.code == "+971");
    } catch (e) {
      // if (mounted) {}
    }
    update();
  }

  checkingExistingUser() async {
    print("checkDetail");
    isLoading.value = true;
    await NetworkManager.get(
      url: HttpUrl.checkingEmailExsiting,
      params: {
        //todo hardcoded for business id
        if (isBusinessReg.value == true) "RegistrationType": "B",
        if (isSpecialistReg.value == true) "RegistrationType": "S",
        if (isUserReg.value == true) "RegistrationType": "M",
        "MobileNo": phoneNumberController.text,
        "EmailId": emailController.text
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status == false) {
          // _callSendOtp(false);
          Get.offAllNamed(Routes.oTPScreen);
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          Get.snackbar("Attantion", message!,
              duration: 6.seconds, snackPosition: SnackPosition.BOTTOM);
          // PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        Get.snackbar(
          Get.context! as String,
          apiResponse.error ?? "",
          snackPosition: SnackPosition.BOTTOM,
        );
        // PreferenceHelper.showSnackBar(
        //     context: Get.context!, msg: apiResponse.error);
      }
    });
  }
}
