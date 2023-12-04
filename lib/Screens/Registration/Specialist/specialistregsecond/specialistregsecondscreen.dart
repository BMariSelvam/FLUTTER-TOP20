import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_20/Helper/extension.dart';
import 'package:top_20/Screens/Registration/Specialist/specialistregsecond/specialistregsecondcontroller.dart';
import 'package:top_20/Widget/submitbutton.dart';
import 'package:top_20/Widget/textformfield.dart';

import '../../../../Const/approute.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Helper/constant.dart';
import '../../../../Model/specialistregmodel.dart';

class SpecialistRegSecondScreen extends StatefulWidget {
  const SpecialistRegSecondScreen({Key? key}) : super(key: key);

  @override
  State<SpecialistRegSecondScreen> createState() =>
      _SpecialistRegSecondScreenState();
}

class _SpecialistRegSecondScreenState extends State<SpecialistRegSecondScreen> {
  late SpecialistRegModel _specialistRegModel = SpecialistRegModel();

  late SpecialistRegSecondController controller;
  TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(SpecialistRegSecondController());
    _specialistRegModel = Get.arguments as SpecialistRegModel;
    _fetchCurrentLocation(context);
    controller.loadCountryList();
    countryController.text = _specialistRegModel.country!;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistRegSecondController>(builder: (logic) {
      return Form(
        key: controller.specialistRegSecondKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.scaffold,
            elevation: 0,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: MyColors.black),
            title: Text(
              "Register as a Specialist",
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.black),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Signup to continue',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.locationController,
                  hintText: "Location",
                  labelText: "*",
                  labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                  hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  textStyle: TextStyle(fontFamily: MyFont.myFont),
                  inputFormatters: [AlphabeticSpaceDotInputFormatter()],
                  suffixIcon: IconButton(
                      onPressed: () async {
                        await _fetchCurrentLocation(context);
                      },
                      icon: const Icon(Icons.location_on_outlined)),
                  maxLength: 50,
                  readOnly: true,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Enter Your Location";
                  //   } else {
                  //     return null;
                  //   }
                  // }
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                    controller: controller.addressLine1Controller,
                    hintText: "AddressLine 1",
                    labelText: "*",
                    labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    maxLength: 50,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Address";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.addressLine2Controller,
                  hintText: "AddressLine 2",
                  hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  textStyle: TextStyle(fontFamily: MyFont.myFont),
                  inputFormatters: [],
                  maxLength: 50,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Enter Your Address";
                  //   } else {
                  //     return null;
                  //   }
                  // }
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.addressLine3Controller,
                  hintText: "AddressLine 3",
                  hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  textStyle: TextStyle(fontFamily: MyFont.myFont),
                  inputFormatters: [],
                  maxLength: 50,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Enter Your Address";
                  //   } else {
                  //     return null;
                  //   }
                  // }
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                    controller: controller.cityController,
                    hintText: "City",
                    labelText: "*",
                    labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [AlphabeticSpaceDotInputFormatter()],
                    maxLength: 50,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your City";
                      } else {
                        return null;
                      }
                    }
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                      controller: countryController,
                      hintText: "Country",
                  labelText: "*",
                  labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                      hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                      textStyle: TextStyle(fontFamily: MyFont.myFont),
                      inputFormatters: [AlphabeticSpaceDotInputFormatter()],
                      maxLength: 100,
                      onTap: () {
                        // controller.showMaterialDialog(
                        //     context: context,
                        //     countryList: controller.countryList);
                        // if (controller.selectedCountry.value != null) {
                        //   countryController.text = controller.selectedCountry.value.toString();
                        // }
                      },
                      suffixIcon: IconButton(
                          onPressed: () {
                            // controller.showMaterialDialog(
                            //     context: context,
                            //     countryList: controller.countryList);
                            // if (controller.selectedCountry.value != null) {
                            //   countryController.text = controller.selectedCountry.value.toString();
                            // }
                          },
                          icon: Icon(Icons.flag)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Your Country";
                        } else {
                          return null;
                        }
                      },
                    ),
                const SizedBox(height: 20),
                CustomTextFormField(
                    controller: controller.postalCodeController,
                    hintText: "Postal Code",
                    labelText: "*",
                    labelTextStyle: const TextStyle(color: MyColors.mainTheme,fontSize: 20),
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [AlphanumericInputFormatter()],
                    maxLength: 50,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Postal Code";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 20),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: SubmitButton(
                isLoading: false,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (controller.specialistRegSecondKey.currentState!
                      .validate()) {
                    _specialistRegModel.addressLine1 =
                        controller.addressLine1Controller.text;
                    _specialistRegModel.addressLine2 =
                        controller.addressLine2Controller.text;
                    _specialistRegModel.addressLine3 =
                        controller.addressLine3Controller.text;
                    _specialistRegModel.city = controller.cityController.text;
                    _specialistRegModel.country = countryController.text;
                    _specialistRegModel.postalCode =
                        controller.postalCodeController.text;
                    Get.toNamed(Routes.specialistRegThirdScreen,
                        arguments: _specialistRegModel);
                  }
                },
                title: "Next"),
          ),
        ),
      );
    });
  }

  Future<void> _fetchCurrentLocation(BuildContext context) async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlacePicker(
            apiKey: Constant.googleApiKey,
            onPlacePicked: (result) {
              controller.locationController.text =
                  result.formattedAddress ?? '';
              // widget.businessRegModel.location = result.formattedAddress ?? '';
              _specialistRegModel.latitude = result.geometry?.location.lat;
              _specialistRegModel.longitude = result.geometry?.location.lng;
              Navigator.of(context).pop();
            },
            useCurrentLocation: true,
            initialPosition: LatLng(position.latitude, position.longitude),
            selectInitialPosition: true,
            resizeToAvoidBottomInset: false,
          ),
        ),
      );
    } else {
      openAppSettings();
    }
  }
}
