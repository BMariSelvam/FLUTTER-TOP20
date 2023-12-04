import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../Const/assets.dart';
import '../../../../Const/size.dart';
import '../../../../Model/conunrymodel.dart';
import '../../../../Model/countrylistmodel.dart';
import '../../../../Model/specialistregmodel.dart';
import '../../../../Widget/searchdropdowntextfield.dart';

class SpecialistRegSecondController extends GetxController with StateMixin {
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine3Controller = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  final specialistRegSecondKey = GlobalKey<FormState>();
  late SpecialistRegModel specialistRegModel = SpecialistRegModel();

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
