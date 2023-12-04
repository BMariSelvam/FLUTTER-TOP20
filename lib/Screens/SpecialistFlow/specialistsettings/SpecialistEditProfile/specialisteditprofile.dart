import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_20/Screens/SpecialistFlow/specialistsettings/SpecialistEditProfile/specialisteditprofilecontroller.dart';

import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/extension.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/specialistdetailmodel.dart';
import '../../../../Widget/submitbutton.dart';
import '../../../../Widget/textformfield.dart';
import '../../../../Widget/togglebutton.dart';

class SpecialistEditProfileScreen extends StatefulWidget {
  const SpecialistEditProfileScreen({Key? key}) : super(key: key);

  @override
  State<SpecialistEditProfileScreen> createState() =>
      _SpecialistEditProfileScreenState();
}

class _SpecialistEditProfileScreenState
    extends State<SpecialistEditProfileScreen> {
  late SpecialistEditProfileController controller;

  initialFunction() async {
    await PreferenceHelper.getSpecialistData().then((value) => setState(() {
          displayName = "${value?.displayName}";
          categoryName = "${value?.businessCategoryName}";
          controller.specialistNameController.text = "${value?.specilistName}";
          // DateTime openDateTime =
          //     DateFormat("HH:mm").parse(value?.openTime ?? '');
          // String formattedOpenTime = DateFormat("hh:mm a").format(openDateTime);
          // controller.businessOpenTimeController.text = formattedOpenTime;
          // // _closeTimeController.text = userDetailsModel.closeTiime ?? '';
          // DateTime closeDateTime =
          //     DateFormat("HH:mm").parse(value?.closeTiime ?? '');
          // String formattedCloseTime =
          //     DateFormat("hh:mm a").format(closeDateTime);
          // controller.businessCloseTimeController.text = formattedCloseTime;
          controller.specialistAddressLine1Controller.text =
              "${value?.addressLine1}";
          controller.specialistAddressLine2Controller.text =
              "${value?.addressLine2}";
          controller.specialistAddressLine3Controller.text =
              "${value?.addressLine3}";
          controller.specialistMobileNoController.text = "${value?.mobileNo}";
          controller.specialistCountryController.text = "${value?.country}";
          controller.specialistCityController.text = "${value?.city}";
          controller.specialistDialCodeNoController.text = "${value?.dialCode}";
          controller.specialistPostalController.text = "${value?.postalCode}";
          filePath = "${value?.FilePath}";

          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              controller.isAllowOnlineAppointment.value =
                  value?.allowOnlineApp ?? false;
              controller.isBusinessPlace.value =
                  value?.serviceatSpecialistPlace ?? false;
              controller.isCustomerPlace.value =
                  value?.serviceatCustomerPlace ?? false;
            });
          });

          controller.specialistUpdateParams.specialistId =
              "${value?.specialistId}";
        }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFunction();
    controller = Get.put(SpecialistEditProfileController());
  }

  XFile? pickedFile;
  String filePath = "";
  String displayName = "";
  String categoryName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "EDIT PROFILE",
              style: TextStyle(
                fontFamily: MyFont.myFont,
              ),
            ),
            centerTitle: true,
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            flexibleSpace: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: FlexibleSpaceBar(
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 90,
                            width: 90,
                            clipBehavior: Clip.hardEdge,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: (pickedFile == null)
                                ? webImage(
                                    imageUrl: filePath ?? '',
                                    height: 60,
                                    width: 60)
                                : pickedFile != null
                                    ? Image.file(
                                        File(pickedFile!.path),
                                        fit: BoxFit.fill,
                                      )
                                    : Container(
                                        color: Colors.grey,
                                        child: const Icon(
                                          Icons.person,
                                          size: 70,
                                        )),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 15,
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
                    const SizedBox(height: 20),
                    Flexible(
                      child: Text(
                        capitalizeFirstLetter(displayName),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                      child: Text(
                        categoryName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: controller.specialistNameController,
                    hintText: "Specialist Name",
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    readOnly: true,
                    maxLength: 100,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Valid UserName";
                      } else if (value.length < 3) {
                        return "Enter Minimum 3 long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.specialistAddressLine1Controller,
                    hintText: "AddressLine1",
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    maxLength: 100,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Valid Address";
                      } else if (value.length < 3) {
                        return "Enter Minimum 3 long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.specialistAddressLine2Controller,
                    hintText: "AddressLine2",
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    maxLength: 100,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Valid Address";
                      } else if (value.length < 3) {
                        return "Enter Minimum 3 long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.specialistAddressLine3Controller,
                    hintText: "AddressLine3",
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    maxLength: 100,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Valid Address";
                      } else if (value.length < 3) {
                        return "Enter Minimum 3 long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 60,
                        child: CustomTextFormField(
                          controller: controller.specialistDialCodeNoController,
                          hintText: "DC",
                          hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                          textStyle: TextStyle(fontFamily: MyFont.myFont),
                          inputFormatters: [],
                          readOnly: true,
                          maxLength: 100,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Valid DialCode";
                            }
                            // else if (value.length < 3) {
                            //   return "Enter Minimum 3 long";
                            // }
                            else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: width(context) / 1.4,
                        child: CustomTextFormField(
                          controller: controller.specialistMobileNoController,
                          hintText: "Mobile Number",
                          hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                          textStyle: TextStyle(fontFamily: MyFont.myFont),
                          inputFormatters: [],
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          maxLength: 100,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Valid Mobile Number";
                            } else if (value.length < 5) {
                              return "Enter Minimum 5 long";
                            } else {
                              return null;
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.specialistCityController,
                    hintText: "City",
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    maxLength: 100,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Valid City";
                      } else if (value.length < 3) {
                        return "Enter Minimum 3 long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.specialistCountryController,
                    hintText: "Country",
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    maxLength: 100,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Valid Country";
                      } else if (value.length < 3) {
                        return "Enter Minimum 3 long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: controller.specialistPostalController,
                    hintText: "Postal Code",
                    hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    textStyle: TextStyle(fontFamily: MyFont.myFont),
                    inputFormatters: [],
                    maxLength: 100,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Valid PostalCode";
                      } else if (value.length < 3) {
                        return "Enter Minimum 3 long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  // const SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Is Specialist',
                  //       style: TextStyle(
                  //         fontFamily: MyFont.myFont,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           controller.isSpecialistStatus.value =
                  //           !controller.isSpecialistStatus.value;
                  //         });
                  //       },
                  //       child: Stack(
                  //         children: [
                  //           Container(
                  //             height: 26,
                  //             width: 50,
                  //             padding: EdgeInsets.only(
                  //                 left: controller.isSpecialistStatus.value ? 10 : 40,
                  //                 top: 9),
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(15),
                  //               color: controller.isSpecialistStatus.value
                  //                   ? Colors.green
                  //                   : Colors.red,
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: EdgeInsets.only(
                  //                 left: controller.isSpecialistStatus.value ? 30 : 5,
                  //                 top: 5),
                  //             child: Container(
                  //               height: 16,
                  //               width: 16,
                  //               decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius: BorderRadius.circular(10)),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Allow Individual Tip',
                  //       style: TextStyle(
                  //         fontFamily: MyFont.myFont,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           controller.isAllowIndividualTip.value =
                  //           !controller.isAllowIndividualTip.value;
                  //         });
                  //       },
                  //       child: Stack(
                  //         children: [
                  //           Container(
                  //             height: 26,
                  //             width: 50,
                  //             padding: EdgeInsets.only(
                  //                 left: controller.isAllowIndividualTip.value ? 10 : 40,
                  //                 top: 9),
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(15),
                  //               color: controller.isAllowIndividualTip.value
                  //                   ? Colors.green
                  //                   : Colors.red,
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: EdgeInsets.only(
                  //                 left: controller.isAllowIndividualTip.value ? 30 : 5,
                  //                 top: 5),
                  //             child: Container(
                  //               height: 16,
                  //               width: 16,
                  //               decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   borderRadius: BorderRadius.circular(10)),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            controller.isAllowOnlineAppointment.value =
                                !controller.isAllowOnlineAppointment.value;
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 26,
                              width: 50,
                              padding: EdgeInsets.only(
                                  left:
                                      controller.isAllowOnlineAppointment.value
                                          ? 10
                                          : 40,
                                  top: 9),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: controller.isAllowOnlineAppointment.value
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      controller.isAllowOnlineAppointment.value
                                          ? 30
                                          : 5,
                                  top: 5),
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  controller.isAllowOnlineAppointment.value == true
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
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.isCustomerPlace.value =
                                              !controller.isCustomerPlace.value;
                                        });
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 26,
                                            width: 50,
                                            padding: EdgeInsets.only(
                                                left: controller
                                                        .isCustomerPlace.value
                                                    ? 10
                                                    : 40,
                                                top: 9),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: controller
                                                      .isCustomerPlace.value
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: controller
                                                        .isCustomerPlace.value
                                                    ? 30
                                                    : 5,
                                                top: 5),
                                            child: Container(
                                              height: 16,
                                              width: 16,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          )
                                        ],
                                      ),
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
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.isBusinessPlace.value =
                                              !controller.isBusinessPlace.value;
                                        });
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 26,
                                            width: 50,
                                            padding: EdgeInsets.only(
                                                left: controller
                                                        .isBusinessPlace.value
                                                    ? 10
                                                    : 40,
                                                top: 9),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: controller
                                                      .isBusinessPlace.value
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: controller
                                                        .isBusinessPlace.value
                                                    ? 30
                                                    : 5,
                                                top: 5),
                                            child: Container(
                                              height: 16,
                                              width: 16,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          )
                                        ],
                                      ),
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
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: SubmitButton(
            isLoading: false,
            onTap: () {
              controller.specialistUpdateParams.specilistName =
                  controller.specialistNameController.text;
              // controller.businessUpdateParams.openTime =
              //     controller.businessOpenTimeController.text;
              // controller.businessUpdateParams.closeTiime =
              //     controller.businessCloseTimeController.text;
              controller.specialistUpdateParams.addressLine1 =
                  controller.specialistAddressLine1Controller.text;
              controller.specialistUpdateParams.addressLine2 =
                  controller.specialistAddressLine2Controller.text;
              controller.specialistUpdateParams.addressLine3 =
                  controller.specialistAddressLine3Controller.text;
              controller.specialistUpdateParams.dialCode =
                  controller.specialistDialCodeNoController.text;
              controller.specialistUpdateParams.mobileNo =
                  controller.specialistMobileNoController.text;
              controller.specialistUpdateParams.city =
                  controller.specialistCityController.text;
              controller.specialistUpdateParams.country =
                  controller.specialistCountryController.text;
              controller.specialistUpdateParams.postalCode =
                  controller.specialistPostalController.text;
              controller.specialistUpdateParams.isActive =
                  controller.isSpecialistStatus.value;
              controller.specialistUpdateParams.allowOnlineApp =
                  controller.isAllowOnlineAppointment.value;
              controller.specialistUpdateParams.serviceatCustomerPlace =
                  controller.isCustomerPlace.value;
              controller.specialistUpdateParams.serviceatSpecialistPlace =
                  controller.isBusinessPlace.value;
              controller.updatedSpecialistProfile();
            },
            title: "Update"),
      ),
    );
  }

  //ImagePicker
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
        controller.specialistUpdateParams.FilePath = pickedFile!.path;
        controller.specialistUpdateParams.FileName = pickedFile!.name;
      });
      controller.specialistUpdateParams.logoImgBase64String =
          base64Encode(imageBytes);
    } else {
      debugPrint('No image selected.');
    }
  }
}
