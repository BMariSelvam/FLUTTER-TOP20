import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_20/Const/colors.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Helper/extension.dart';
import 'package:top_20/Screens/Registration/User/userregcontroller.dart';
import 'package:top_20/Widget/submitbutton.dart';
import 'package:top_20/Widget/textformfield.dart';

import '../../../Const/assets.dart';
import '../../../Helper/constant.dart';
import '../../../Model/memberregmodel.dart';
import '../../../Model/userregmodel.dart';

class UserRegFirstScreen extends StatefulWidget {
  const UserRegFirstScreen({Key? key}) : super(key: key);

  @override
  State<UserRegFirstScreen> createState() => _UserRegFirstScreenState();
}

class _UserRegFirstScreenState extends State<UserRegFirstScreen> {
  late UserRegController controller;
  late MemberRegModel _memberRegModel = MemberRegModel();
  TextEditingController countryController = TextEditingController();
  XFile? pickedUserFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(UserRegController());
    _memberRegModel = Get.arguments as MemberRegModel;
    _fetchUserCurrentLocation(context);
    controller.loadCountryList();
    countryController.text = _memberRegModel.country!;
  }

  @override
  Widget build(BuildContext context) {
    print("=====================");
    print(_memberRegModel.country!);
    print(controller.countryController.text);
    return GetBuilder<UserRegController>(builder: (logic) {
      if (logic.status == RxStatus.loading()) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Form(
        key: controller.userRegKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.scaffold,
            elevation: 0,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(
              color: MyColors.black,
            ),
            title: Text(
              'Signup',
              style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                color: MyColors.black,
              ),
            ),
            centerTitle: true,
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(18.0),
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
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          height: 120,
                          width: 120,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: (pickedUserFile != null)
                              ? Image.file(
                                  File(pickedUserFile!.path),
                                  fit: BoxFit.fill,
                                )
                              : Container(
                                  color: MyColors.scaffold,
                                  child: Image.asset(
                                    Assets.profile,
                                    fit: BoxFit.fill,
                                  )),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 20,
                          child: GestureDetector(
                            onTap: () {
                              _showDialogToGetImage(context);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.photo_camera,
                                  size: 20,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // if (pickedUserFile == null) ...[
                  //   const SizedBox(height: 10),
                  //   Text(
                  //     "Please upload a profile image",
                  //     style: TextStyle(
                  //       fontFamily: MyFont.myFont,
                  //       color: Colors.red,
                  //     ),
                  //   ),
                  // ],
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.nameController,
                    hintText: "User Name",
                    labelText: "*",
                    labelTextStyle:
                        TextStyle(color: MyColors.mainTheme, fontSize: 20),
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    maxLength: 100,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Name";
                      }
                      if (value.length < 3) {
                        return "Enter Minimum 3 Character";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.displayNameController,
                    hintText: "Display Name",
                    labelText: "*",
                    labelTextStyle:
                        TextStyle(color: MyColors.mainTheme, fontSize: 20),
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    maxLength: 100,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Display Name";
                      }
                      if (value.length < 3) {
                        return "Enter Minimum 3 Character";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.transactionController,
                    hintText: "Transaction Pin",
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    labelText: "*",
                    labelTextStyle:
                        TextStyle(color: MyColors.mainTheme, fontSize: 20),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [NumericInputFormatter()],
                    keyboardType: TextInputType.number,
                    obscureText:
                        controller.isTransactionPin.value ? false : true,
                    maxLength: 100,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          controller.isTransactionPin.value =
                              !controller.isTransactionPin.value;
                        });
                      },
                      icon: Icon(controller.isTransactionPin.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Transaction Pin";
                      }
                      if (value.length < 6) {
                        return "The Transaction Pin should be minimum 6 long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.passwordController,
                    hintText: "Password",
                    labelText: "*",
                    labelTextStyle:
                        TextStyle(color: MyColors.mainTheme, fontSize: 20),
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [NumericInputFormatter()],
                    keyboardType: TextInputType.number,
                    obscureText: controller.isPasswordPin.value ? false : true,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            controller.isPasswordPin.value =
                                !controller.isPasswordPin.value;
                          });
                        },
                        icon: Icon(controller.isPasswordPin.value
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    maxLength: 100,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Password";
                      }
                      if (value.length < 6) {
                        return "The Password should be minimum 6 long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.addressLine1Controller,
                    hintText: "AddressLine 1",
                    labelText: "*",
                    labelTextStyle:
                        TextStyle(color: MyColors.mainTheme, fontSize: 20),
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    maxLength: 100,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return "Enter Your Address";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.addressLine2Controller,
                    hintText: "AddressLine 2",
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    maxLength: 100,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return "Enter Your Address";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.addressLine3Controller,
                    hintText: "AddressLine 3",
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    maxLength: 100,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return "Enter Your Address";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.cityController,
                    hintText: "City",
                    labelText: "*",
                    labelTextStyle:
                        TextStyle(color: MyColors.mainTheme, fontSize: 20),
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [AlphabeticSpaceDotInputFormatter()],
                    maxLength: 100,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return "Enter Your City";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: countryController,
                    labelText: "*",
                    labelTextStyle:
                        TextStyle(color: MyColors.mainTheme, fontSize: 20),
                    hintText: "Country",
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [AlphabeticSpaceDotInputFormatter()],
                    maxLength: 100,
                    onTap: () {
                      // controller.showMaterialDialog(
                      //     context: context,
                      //     countryList: controller.countryList);
                    },
                    // suffixIcon: IconButton(
                    //     onPressed: () {
                    //       // controller.showMaterialDialog(
                    //       //     context: context,
                    //       //     countryList: controller.countryList);
                    //     },
                    //     icon: Icon(Icons.flag)),
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
                    labelTextStyle:
                        TextStyle(color: MyColors.mainTheme, fontSize: 20),
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [AlphanumericInputFormatter()],
                    maxLength: 15,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Postal Code";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.getLocationController,
                    hintText: "Location",
                    labelText: "*",
                    labelTextStyle:
                        TextStyle(color: MyColors.mainTheme, fontSize: 20),
                    readOnly: true,
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [NumericInputFormatter()],
                    keyboardType: TextInputType.number,
                    maxLength: 15,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return "Enter Your Postal Code";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    onTap: () async {
                      _fetchUserCurrentLocation(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: SubmitButton(
                isLoading: false,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (controller.userRegKey.currentState!.validate()) {
                    print(_memberRegModel.emailId.toString());
                    controller.memberRegModel.orgId = 1;
                    controller.memberRegModel.dialCode =
                        _memberRegModel.dialCode;
                    controller.memberRegModel.mobileNo =
                        _memberRegModel.mobileNo;
                    controller.memberRegModel.FileName =
                        _memberRegModel.FileName;
                    controller.memberRegModel.logoImgBase64String =
                        _memberRegModel.logoImgBase64String;
                    controller.memberRegModel.emailId = _memberRegModel.emailId;
                    controller.memberRegModel.memberName =
                        controller.nameController.value.text;
                    controller.memberRegModel.displayName =
                        controller.displayNameController.value.text;
                    controller.memberRegModel.tranPin =
                        controller.transactionController.value.text;
                    controller.memberRegModel.appPin =
                        controller.passwordController.value.text;
                    controller.memberRegModel.addressLine1 =
                        controller.addressLine1Controller.value.text;
                    controller.memberRegModel.addressLine2 =
                        controller.addressLine2Controller.value.text;
                    controller.memberRegModel.addressLine3 =
                        controller.addressLine3Controller.value.text;
                    controller.memberRegModel.city =
                        controller.cityController.value.text;
                    controller.memberRegModel.country = countryController.text;
                    controller.memberRegModel.postalCode =
                        controller.postalCodeController.value.text;
                    print("....................................");
                    print(controller.memberRegModel.memberName.toString());
                    controller.memberRegApi();
                  }
                },
                title: "Register"),
          ),
        ),
      );
    });
  }

  _showDialogToGetImage(BuildContext context) {
    // set up the buttons
    Widget cameraButton = ElevatedButton(
      child: Text("Camera",
          style: TextStyle(fontFamily: MyFont.myFont, color: Colors.white)),
      onPressed: () {
        _getImage(true);
        Navigator.of(context).pop();
      },
    );
    Widget galleryButton = ElevatedButton(
      child: Text(
        "Gallery",
        style: TextStyle(fontFamily: MyFont.myFont, color: Colors.white),
      ),
      onPressed: () {
        _getImage(false);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Choose Image"),
      content: const Text("Select Image from Camera or Gallery?"),
      actions: [cameraButton, galleryButton],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future _getImage(bool isCamera) async {
    final picker = ImagePicker();
    pickedUserFile = await picker.pickImage(
        imageQuality: Platform.isAndroid ? 40 : 30,
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedUserFile != null) {
      List<int> imageBytes = await pickedUserFile!.readAsBytes();
      setState(() {
        _memberRegModel.FileName = pickedUserFile!.name;
      });
      _memberRegModel.logoImgBase64String = base64Encode(imageBytes);
    } else {
      debugPrint('No image selected.');
    }
  }

  Future<void> _fetchUserCurrentLocation(BuildContext context) async {
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
              controller.getLocationController.text =
                  result.formattedAddress ?? '';
              // widget.businessRegModel.location = result.formattedAddress ?? '';
              // _memberRegModel.latitude = result.geometry?.location.lat;
              // _memberRegModel.longitude = result.geometry?.location.lng;
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
