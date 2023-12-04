import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Const/assets.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/constant.dart';
import '../../../../Model/businessregmodel.dart';
import '../../../../Model/conunrymodel.dart';
import '../../../../Model/countrylistmodel.dart';
import '../../../../Widget/searchdropdowntextfield.dart';

class BusinessSecondController extends GetxController with StateMixin {
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine3Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  RxBool isOnlineAppointment = false.obs;
  RxBool isAllowIndividualTip = false.obs;
  RxBool isBusinessStatus = false.obs;
  RxBool isCustomerPlace = false.obs;
  RxBool isBusinessPlace = false.obs;

  final businessSecondRegKey = GlobalKey<FormState>();
  late final BusinessRegModel _businessRegModel;

  bool isServicesAvailableInCustomerPlace() {
    // Replace this with your actual logic to check if services are available in the customer place
    bool servicesAvailableInCustomerPlace =true;

    // Return true if services are available in customer place and false otherwise
    return servicesAvailableInCustomerPlace;
  }

  bool isServicesAvailableInBusinessPlace() {
    // Replace this with your actual logic to check if services are available in the business place
    bool servicesAvailableInBusinessPlace =true;

    // Return true if services are available in business place and false otherwise
    return servicesAvailableInBusinessPlace;
  }

// In your checkBusinessPlaceAndCustomerPlace function:

  void checkBusinessPlaceAndCustomerPlace() {
    bool servicesInCustomerPlace = isServicesAvailableInCustomerPlace();
    bool servicesInBusinessPlace = isServicesAvailableInBusinessPlace();

    if (servicesInCustomerPlace && !servicesInBusinessPlace) {
      isBusinessPlace.value = false;
      isCustomerPlace.value = true;
    } else if (servicesInBusinessPlace && !servicesInCustomerPlace) {
      isBusinessPlace.value = true;
      isCustomerPlace.value = false;
    } else {
      isBusinessPlace.value = false;
      isCustomerPlace.value = false;
    }
  }



  List<CountryListModel> countryList = [];
  final Rx<CountryListModel?> selectedCountry = (null as CountryListModel?).obs;
  final Rx<CountryModel?> selectCountryOnly = (null as CountryModel?).obs;

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
