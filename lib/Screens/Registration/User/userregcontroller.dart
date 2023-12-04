import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:top_20/Screens/Success/successscreen.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/size.dart';
import '../../../Helper/apiservice.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/conunrymodel.dart';
import '../../../Model/countrylistmodel.dart';
import '../../../Model/memberregmodel.dart';
import '../../../Model/userregmodel.dart';
import '../../../Widget/searchdropdowntextfield.dart';

class UserRegController extends GetxController with StateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController transactionController = TextEditingController();
  TextEditingController getLocationController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine3Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  RxBool isTransactionPin = false.obs;
  RxBool isPasswordPin = false.obs;

  Rx<bool> isLoading = false.obs;
  late final MemberRegModel memberRegModel = MemberRegModel();
  final userRegKey = GlobalKey<FormState>();

  List<CountryListModel> countryList = [];
  final Rx<CountryListModel?> selectedCountry = (null as CountryListModel?).obs;
  final Rx<CountryModel?> selectCountryOnly = (null as CountryModel?).obs;

  @override
  void onInit() {
    super.onInit();
    // Set the initial value of the countryController here
    // Perform initialization tasks here, like loading data from API or shared preferences.
    loadCountryList();
  }

  @override
  void onReady() {
    super.onReady();
    // Set the initial value of the countryController here after the form field is created.
    countryController.text = selectedCountry.value?.country ?? '';
  }

  memberRegApi() async {
    isLoading.value = true;
    ApiService.registerMember(memberRegModel: memberRegModel)
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          Get.to(() => SuccessfulScreen(
              text: 'User Registration Successfully \n Completed',
              isLoading: false,
              title: "Go To Login",
              onTap: () {
                Get.offAllNamed(Routes.loginScreen);
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
}
