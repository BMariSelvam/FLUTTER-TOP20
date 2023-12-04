import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../Const/approute.dart';
import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/extension.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/businessregmodel.dart';
import '../../../../Widget/submitbutton.dart';
import '../../../../Widget/textformfield.dart';
import 'businessregfirstcontroller.dart';

class BusinessRegFirstScreen extends StatefulWidget {
  const BusinessRegFirstScreen({Key? key}) : super(key: key);

  @override
  State<BusinessRegFirstScreen> createState() => _BusinessRegFirstScreenState();
}

class _BusinessRegFirstScreenState extends State<BusinessRegFirstScreen> {
  late BusinessRegFirstController controller;
  late BusinessRegModel _businessRegModel;
  XFile? pickedFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(BusinessRegFirstController());
    // _businessRegModel = BusinessRegModel();
    _businessRegModel = Get.arguments as BusinessRegModel;
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessRegFirstController>(builder: (logic) {
      if (logic.status == RxStatus.loading()) {
        return Center(
            child: LoadingAnimationWidget.threeRotatingDots(
                color: MyColors.primaryCustom, size: 20));
      }
      return Form(
        key: controller.businessRegFirstKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.scaffold,
            elevation: 0,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: MyColors.black),
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
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: (pickedFile != null)
                            ? Image.file(
                                File(pickedFile!.path),
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
                                  color: Colors.orange, shape: BoxShape.circle),
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
                // if (pickedFile == null) ...[
                //   const SizedBox(height: 10),
                //   Text(
                //     "Please Upload a Logo here",
                //     style: TextStyle(
                //       fontFamily: MyFont.myFont,
                //       color: Colors.red,
                //     ),
                //   ),
                // ],
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.nameController,
                  hintText: "Business Name",
                  hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  labelText: "*",
                  labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                  readOnly: false,
                  textStyle: TextStyle(fontFamily: MyFont.myFont),
                  inputFormatters: [],
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Business Name";
                    }
                    if (value.length < 3) {
                      return "Enter Minimum 3 Character";
                    }
                    return null;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.displayNameController,
                  hintText: "Display Name",
                  hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  labelText: "*",
                  labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                  readOnly: false,
                  textStyle: TextStyle(fontFamily: MyFont.myFont),
                  inputFormatters: [],
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Display Name";
                    }
                    if (value.length < 3) {
                      return "Enter Minimum 3 Character";
                    }
                    return null;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.businessRegPinController,
                  hintText: "Business Registration No",
                  hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  labelText: "*",
                  labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                  readOnly: false,
                  textStyle: TextStyle(fontFamily: MyFont.myFont),
                  inputFormatters: [NumericInputFormatter()],
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Business Registration No";
                    }
                    // if (value.length < 3) {
                    //   return "Enter Minimum 3 Character";
                    // }
                    return null;
                  },
                  maxLength: 100,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.transactionPinController,
                  hintText: "Transaction Pin",
                  hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  labelText: "*",
                  labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                  readOnly: false,
                  textStyle: TextStyle(fontFamily: MyFont.myFont),
                  inputFormatters: [NumericInputFormatter()],
                  keyboardType: TextInputType.number,
                  obscureText: controller.isTransactionPin.value ? false : true,
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
                  maxLength: 50,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.passwordController,
                  hintText: "Password",
                  hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  labelText: "*",
                  labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                  readOnly: false,
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
                  maxLength: 50,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width(context) / 2.3,
                      child: CustomTextFormField(
                        controller: controller.openTimeController,
                        hintText: "Open Time",
                        hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                        labelText: "*",
                        labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                        readOnly: true,
                        textStyle: TextStyle(fontFamily: MyFont.myFont),
                        inputFormatters: [],
                        obscureText: false,
                        suffixIcon: IconButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              DateTime? selectedTime =
                                  await PreferenceHelper.showTimePopup(
                                      context, null);
                              if (selectedTime != null) {
                                controller.openTime = selectedTime;
                                String formattedTime = DateFormat('HH:mm').format(selectedTime); // Use 24-hour format
                                controller.openTimeController.text = formattedTime;
                              }

                            },
                            icon: const Icon(Icons.access_alarm)),
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          DateTime? selectedTime =
                              await PreferenceHelper.showTimePopup(
                                  context, null);
                          if (selectedTime != null) {
                            controller.openTime = selectedTime;
                            controller.openTimeController.text =
                                PreferenceHelper.dateToString(
                                    date: selectedTime, dateFormat: 'HH:mm');
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Open Time";
                          }
                          return null;
                        },
                        maxLength: 50,
                      ),
                    ),
                    SizedBox(
                      width: width(context) / 2.3,
                      child: CustomTextFormField(
                        controller: controller.closeTimeController,
                        hintText: "Close Time",
                        hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                        labelText: "*",
                        labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                        readOnly: true,
                        textStyle: TextStyle(fontFamily: MyFont.myFont),
                        inputFormatters: [],
                        obscureText: false,
                        suffixIcon: IconButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (controller.openTime != null) {
                                DateTime? selectedTime =
                                    await PreferenceHelper.showTimePopup(
                                        context, controller.openTime);
                                if (selectedTime != null) {
                                  controller.closeTime = selectedTime;
                                  if (controller.openTime!
                                      .isBefore(controller.closeTime!)) {
                                    controller.closeTimeController.text =
                                        PreferenceHelper.dateToString(
                                            date: selectedTime,
                                            dateFormat: 'HH:mm');
                                  } else {
                                    // _controller.closeTime = DateTime.tryParse("2023-01-01 00:00");
                                    controller.closeTimeController.clear();
                                    Fluttertoast.showToast(
                                      msg: "Please choose after Open Time",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  }
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please Select Open Time",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                );
                              }
                            },
                            icon: const Icon(Icons.access_alarm)
                        ),
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (controller.openTime != null) {
                            DateTime? selectedTime =
                                await PreferenceHelper.showTimePopup(
                                    context, controller.openTime);
                            if (selectedTime != null) {
                              controller.closeTime = selectedTime;
                              if (controller.openTime!
                                  .isBefore(controller.closeTime!)) {
                                controller.closeTimeController.text =
                                    PreferenceHelper.dateToString(
                                        date: selectedTime,
                                        dateFormat: 'HH:mm');
                              } else {
                                // _controller.closeTime = DateTime.tryParse("2023-01-01 00:00");
                                controller.closeTimeController.clear();
                                Fluttertoast.showToast(
                                  msg: "Please choose after Open Time",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                );
                              }
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please Select Open Time",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                            );
                          }
                        },
                        maxLength: 10,
                      ),
                    )
                  ],
                ),
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
                  if (controller.businessRegFirstKey.currentState!.validate()) {
                    _businessRegModel.businessName =
                        controller.nameController.text;
                    _businessRegModel.displayName =
                        controller.displayNameController.text;
                    _businessRegModel.businessRegNo =
                        controller.businessRegPinController.text;
                    _businessRegModel.tranPin =
                        controller.transactionPinController.text;
                    _businessRegModel.appPin =
                        controller.passwordController.text;
                    _businessRegModel.openTime =
                        controller.openTimeController.text;
                    _businessRegModel.closeTiime =
                        controller.closeTimeController.text;
                    Get.toNamed(Routes.businessRegSecondScreen,
                        arguments: _businessRegModel);
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
    pickedFile = await picker.pickImage(
        imageQuality: Platform.isAndroid ? 40 : 30,
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      List<int> imageBytes = await pickedFile!.readAsBytes();
      setState(() {
        _businessRegModel.logoFileName = pickedFile!.name;
      });
      _businessRegModel.logoImgBase64String = base64Encode(imageBytes);
    } else {
      debugPrint('No image selected.');
    }
  }
}
