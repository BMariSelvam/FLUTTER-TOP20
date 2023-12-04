import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../Const/approute.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Helper/constant.dart';
import '../../../../Helper/extension.dart';
import '../../../../Model/businessregmodel.dart';
import '../../../../Widget/submitbutton.dart';
import '../../../../Widget/textformfield.dart';
import '../../../../Widget/togglebutton.dart';
import 'businesssecondcontroller.dart';

class BusinessRegSecondScreen extends StatefulWidget {
  const BusinessRegSecondScreen({Key? key}) : super(key: key);

  @override
  State<BusinessRegSecondScreen> createState() =>
      _BusinessRegSecondScreenState();
}

class _BusinessRegSecondScreenState extends State<BusinessRegSecondScreen> {
  late BusinessSecondController controller;
  late final BusinessRegModel _businessRegModel;
  TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(BusinessSecondController());
    _businessRegModel = Get.arguments as BusinessRegModel;
    _fetchCurrentLocation(context);
    controller.loadCountryList();
    countryController.text = _businessRegModel.country!;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.businessSecondRegKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.scaffold,
          elevation: 0,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: MyColors.black),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Register as a Business",
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
                hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                labelText: "*",
                labelTextStyle:
                    TextStyle(color: MyColors.mainTheme, fontSize: 20),
                readOnly: false,
                textStyle: TextStyle(fontFamily: MyFont.myFont),
                suffixIcon: IconButton(
                    onPressed: () async {
                      await _fetchCurrentLocation(context);
                    },
                    icon: const Icon(Icons.location_on_outlined)),
                inputFormatters: [],
                obscureText: false,
                maxLength: 50,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return "Enter Your Location";
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.addressLine1Controller,
                hintText: "AddressLine1",
                hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                labelText: "*",
                labelTextStyle:
                    TextStyle(color: MyColors.mainTheme, fontSize: 20),
                readOnly: false,
                textStyle: TextStyle(fontFamily: MyFont.myFont),
                inputFormatters: [],
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Your Address";
                  }
                  return null;
                },
                maxLength: 50,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.addressLine2Controller,
                hintText: "AddressLine2",
                hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                readOnly: false,
                textStyle: TextStyle(fontFamily: MyFont.myFont),
                inputFormatters: [],
                obscureText: false,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return "Enter Your Address";
                //   }
                //   return null;
                // },
                maxLength: 50,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.addressLine3Controller,
                hintText: "AddressLine3",
                hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                readOnly: false,
                textStyle: TextStyle(fontFamily: MyFont.myFont),
                inputFormatters: [],
                obscureText: false,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return "Enter Your Address";
                //   }
                //   return null;
                // },
                maxLength: 50,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.cityController,
                hintText: "City",
                hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                readOnly: false,
                labelText: "*",
                labelTextStyle:
                    TextStyle(color: MyColors.mainTheme, fontSize: 20),
                textStyle: TextStyle(fontFamily: MyFont.myFont),
                inputFormatters: [],
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter City";
                  }
                  return null;
                },
                maxLength: 50,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: countryController,
                hintText: "Country",
                hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                labelText: "*",
                labelTextStyle:
                    TextStyle(color: MyColors.mainTheme, fontSize: 20),
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
                controller: controller.pinCodeController,
                hintText: "Postal Code",
                hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                labelText: "*",
                labelTextStyle:
                    TextStyle(color: MyColors.mainTheme, fontSize: 20),
                readOnly: false,
                textStyle: TextStyle(fontFamily: MyFont.myFont),
                inputFormatters: [AlphanumericInputFormatter()],
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Your Pincode";
                  }
                  return null;
                },
                maxLength: 15,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Business Status',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  ToggleButton(
                    onTap: (bool isClick) {
                      setState(() {
                        controller.isBusinessStatus.value =
                            !controller.isBusinessStatus.value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Allow Individual Tip',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  ToggleButton(
                    onTap: (bool isClick) {
                      setState(() {
                        controller.isAllowIndividualTip.value =
                            !controller.isAllowIndividualTip.value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Allow Online Appointment',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  ToggleButton(
                    onTap: (bool isClick) {
                      setState(() {
                        controller.isOnlineAppointment.value =
                            !controller.isOnlineAppointment.value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              controller.isOnlineAppointment.value
                  ? Container(
                      decoration: BoxDecoration(
                        color: MyColors.tabBar,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Customer Place',
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                ToggleButton(
                                  onTap: (bool isClick) {
                                    setState(() {
                                      controller.isCustomerPlace.value =
                                          !controller.isCustomerPlace.value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Business Place',
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                ToggleButton(
                                  onTap: (bool isClick) {
                                    setState(() {
                                      controller.isBusinessPlace.value =
                                          !controller.isBusinessPlace.value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                  : const Text(""),
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
              if (controller.businessSecondRegKey.currentState!.validate()) {
                _businessRegModel.addressLine1 =
                    controller.addressLine1Controller.text;
                _businessRegModel.addressLine2 =
                    controller.addressLine2Controller.text;
                _businessRegModel.addressLine3 =
                    controller.addressLine3Controller.text;
                _businessRegModel.city = controller.cityController.text;
                _businessRegModel.country = countryController.text;
                _businessRegModel.postalCode =
                    controller.pinCodeController.text;

                _businessRegModel.businessStatus =
                    controller.isBusinessStatus.value;
                _businessRegModel.allowIndividualTip =
                    controller.isAllowIndividualTip.value;
                _businessRegModel.allowOnlineApp =
                    controller.isOnlineAppointment.value;
                _businessRegModel.allowBusinessPlace =
                    controller.isBusinessPlace.value;
                _businessRegModel.allowCustomerPlace =
                    controller.isCustomerPlace.value;

                if (controller.isBusinessPlace.value ||
                    controller.isCustomerPlace.value == true) {
                  Get.toNamed(Routes.businessRegThirdScreen,
                      arguments: _businessRegModel);
                } else {
                  Get.snackbar(
                    "Attention",
                    "Please Select Atleast One Place",
                    backgroundColor: MyColors.primaryCustom,
                    colorText: MyColors.white,
                  );
                }
              }
            },
            title: 'Next',
          ),
        ),
      ),
    );
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
              _businessRegModel.latitude = result.geometry?.location.lat;
              _businessRegModel.longitude = result.geometry?.location.lng;
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
