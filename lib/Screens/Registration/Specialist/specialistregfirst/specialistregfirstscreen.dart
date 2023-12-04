import 'dart:convert';
import 'dart:io' show File, Platform;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_20/Helper/extension.dart';
import 'package:top_20/Screens/Registration/Specialist/specialistregfirst/specialistregfirstcontroller.dart';
import 'package:top_20/Widget/submitbutton.dart';
import 'package:top_20/Widget/textformfield.dart';

import '../../../../Const/approute.dart';
import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Model/specialistregmodel.dart';
import '../../../../Widget/togglebutton.dart';

class SpecialistRegFirstScreen extends StatefulWidget {
  const SpecialistRegFirstScreen({Key? key}) : super(key: key);

  @override
  State<SpecialistRegFirstScreen> createState() =>
      _SpecialistRegFirstScreenState();
}

class _SpecialistRegFirstScreenState extends State<SpecialistRegFirstScreen> {
  late SpecialistRegModel _specialistRegModel = SpecialistRegModel();

  late SpecialistRegFirstController controller;

  XFile? pickedSpecialistFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(SpecialistRegFirstController());
    _specialistRegModel = Get.arguments as SpecialistRegModel;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistRegFirstController>(builder: (logic) {
      if (logic.status == RxStatus.loading()) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Form(
        key: controller.specialistRegFirstKey,
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
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
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
                          child: (pickedSpecialistFile != null)
                              ? Image.file(
                                  File(pickedSpecialistFile!.path),
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
                  // const SizedBox(height: 10),
                  // if (pickedSpecialistFile == null) ...[
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
                    controller: controller.specialistNameController,
                    hintText: "Specialist Name",
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    labelText: "*",
                    labelTextStyle:
                        TextStyle(color: MyColors.mainTheme, fontSize: 20),
                    inputFormatters: [],
                    maxLength: 50,
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
                    maxLength: 50,
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
                    controller: controller.transactionPinController,
                    hintText: "Transaction Pin",
                    labelText: "*",
                    labelTextStyle:
                        TextStyle(color: MyColors.mainTheme, fontSize: 20),
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [NumericInputFormatter()],
                    keyboardType: TextInputType.number,
                    obscureText:
                        controller.isTransactionPin.value ? false : true,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            controller.isTransactionPin.value =
                                !controller.isTransactionPin.value;
                          });
                        },
                        icon: Icon(controller.isTransactionPin.value
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    maxLength: 50,
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
                    maxLength: 50,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Register As Freelancer',
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      ToggleButton(
                        onTap: (bool isClick) {
                          setState(() {
                            controller.isRegAsFreelancer.value =
                                !controller.isRegAsFreelancer.value;
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                  if (controller.specialistRegFirstKey.currentState!
                      .validate()) {
                    controller.specialistRegModel.orgId = 1;
                    _specialistRegModel.specilistName =
                        controller.specialistNameController.text;
                    _specialistRegModel.displayName =
                        controller.displayNameController.text;
                    _specialistRegModel.tranPin =
                        controller.transactionPinController.text;
                    _specialistRegModel.appPin =
                        controller.passwordController.text;
                    _specialistRegModel.haveFreelance =
                        controller.isRegAsFreelancer.value;
                    _specialistRegModel.allowOnlineApp =
                        controller.isOnlineAppointment.value;
                    _specialistRegModel.serviceatCustomerPlace =
                        controller.isCustomerPlace.value;
                    _specialistRegModel.serviceatSpecialistPlace =
                        controller.isBusinessPlace.value;

                    if (controller.isCustomerPlace.value ||
                        controller.isBusinessPlace.value == true) {
                      Get.toNamed(Routes.specialistRegSecondScreen,
                          arguments: _specialistRegModel);
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
                title: "Next"),
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
    pickedSpecialistFile = await picker.pickImage(
        imageQuality: Platform.isAndroid ? 40 : 30,
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedSpecialistFile != null) {
      List<int> imageBytes = await pickedSpecialistFile!.readAsBytes();
      setState(() {
        _specialistRegModel.FileName = pickedSpecialistFile!.name;
      });
      _specialistRegModel.logoImgBase64String = base64Encode(imageBytes);
    } else {
      debugPrint('No image selected.');
    }
  }
}
