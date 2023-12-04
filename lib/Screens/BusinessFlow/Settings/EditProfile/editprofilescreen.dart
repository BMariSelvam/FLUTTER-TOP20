import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_20/Widget/submitbutton.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/extension.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Widget/textformfield.dart';
import '../../../../Widget/togglebutton.dart';
import 'editprofilecontroller.dart';

class BusinessEditProfileScreen extends StatefulWidget {
  const BusinessEditProfileScreen({Key? key}) : super(key: key);

  @override
  State<BusinessEditProfileScreen> createState() =>
      _BusinessEditProfileScreenState();
}

class _BusinessEditProfileScreenState extends State<BusinessEditProfileScreen> {
  XFile? pickedFile;

  late BusinessEditProfileController controller;

  String filePath = "";
  String displayName = "";
  String categoryName = "";

  bool isBusinessStatus = false;
  bool isAllowOnlineAppointment = false;
  bool isAllowIndividualTip = false;
  bool isBusinessPlace = false;
  bool isCustomerPlace = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(BusinessEditProfileController());
    initialFunction();
  }

  initialFunction() async {
    await PreferenceHelper.getBusinessData().then((value) => setState(() {
          displayName = "${value?.displayName}";
          categoryName = "${value?.businessCategoryName}";
          controller.businessNameController.text = "${value?.businessName}";
          controller.businessAddressLine1Controller.text =
              "${value?.addressLine1}";
          controller.businessAddressLine2Controller.text =
              "${value?.addressLine2}";
          controller.businessAddressLine3Controller.text =
              "${value?.addressLine3}";
          controller.businessMobileNoController.text = "${value?.mobileNo}";
          controller.businessCountryController.text = "${value?.country}";
          controller.businessCityController.text = "${value?.city}";
          controller.businessPostalController.text = "${value?.postalCode}";
          controller.businessDialCodeNoController.text =
              "${value?.countryDialCode}";
          filePath = "${value?.logoFilePath}";
          print("value?.allowIndividualTip");
          print(value?.businessStatus);
          print(value?.allowOnlineApp);
          print(value?.businessPlace);
          print(value?.customerPlace);
          print(value?.allowIndividualTip);


          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              isBusinessStatus = value?.isActive ?? false;
              isAllowOnlineAppointment = value?.allowOnlineApp ?? false;
              isBusinessPlace = value?.businessPlace ?? false;
              isCustomerPlace = value?.customerPlace ?? false;
              isAllowIndividualTip = value?.allowIndividualTip ?? false;

            });
          });
          print("after");
          print(isBusinessStatus);
          print(isAllowOnlineAppointment);
          print(isBusinessPlace);
          print(isCustomerPlace);
          print(isAllowIndividualTip);
          controller.businessUpdateParams.businessId = "${value?.businessId}";
        }));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessEditProfileController>(builder: (logic)
    {
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
                      controller: controller.businessNameController,
                      hintText: "BusinessName",
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
                    // const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     SizedBox(
                    //       width: width(context) / 2.3,
                    //       child: CustomTextFormField(
                    //         controller: controller.businessOpenTimeController,
                    //         hintText: "Open Time",
                    //         hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    //         readOnly: true,
                    //         textStyle: TextStyle(fontFamily: MyFont.myFont),
                    //         inputFormatters: [],
                    //         obscureText: false,
                    //         suffixIcon: IconButton(
                    //             onPressed: () async {
                    //               FocusScope.of(context).unfocus();
                    //               DateTime? selectedTime =
                    //                   await PreferenceHelper.showTimePopup(
                    //                       context, null);
                    //               if (selectedTime != null) {
                    //                 controller.openTime = selectedTime;
                    //                 controller.businessOpenTimeController.text =
                    //                     PreferenceHelper.dateToString(
                    //                         date: selectedTime,
                    //                         dateFormat: 'HH:mm');
                    //               }
                    //             },
                    //             icon: const Icon(Icons.access_time_outlined)),
                    //         onTap: () async {
                    //           FocusScope.of(context).unfocus();
                    //           DateTime? selectedTime =
                    //               await PreferenceHelper.showTimePopup(
                    //                   context, null);
                    //           if (selectedTime != null) {
                    //             controller.openTime = selectedTime;
                    //             controller.businessOpenTimeController.text =
                    //                 PreferenceHelper.dateToString(
                    //                     date: selectedTime, dateFormat: 'HH:mm');
                    //           }
                    //         },
                    //         validator: (value) {
                    //           if (value == null || value.isEmpty) {
                    //             return "Enter Open Time";
                    //           }
                    //           return null;
                    //         },
                    //         maxLength: 50,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: width(context) / 2.3,
                    //       child: CustomTextFormField(
                    //         controller: controller.businessCloseTimeController,
                    //         hintText: "Close Time",
                    //         hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    //         readOnly: true,
                    //         textStyle: TextStyle(fontFamily: MyFont.myFont),
                    //         inputFormatters: [],
                    //         obscureText: false,
                    //         suffixIcon: IconButton(
                    //             onPressed: () async {
                    //               FocusScope.of(context).unfocus();
                    //               if (controller.openTime != null) {
                    //                 DateTime? selectedTime =
                    //                     await PreferenceHelper.showTimePopup(
                    //                         context, controller.openTime);
                    //                 if (selectedTime != null) {
                    //                   controller.closeTime = selectedTime;
                    //                   if (controller.openTime!
                    //                       .isBefore(controller.closeTime!)) {
                    //                     controller.businessCloseTimeController
                    //                             .text =
                    //                         PreferenceHelper.dateToString(
                    //                             date: selectedTime,
                    //                             dateFormat: 'HH:mm');
                    //                   } else {
                    //                     // _controller.closeTime = DateTime.tryParse("2023-01-01 00:00");
                    //                     controller.businessCloseTimeController
                    //                         .clear();
                    //                     Fluttertoast.showToast(
                    //                       msg: "Please choose after Open Time",
                    //                       toastLength: Toast.LENGTH_SHORT,
                    //                       gravity: ToastGravity.CENTER,
                    //                     );
                    //                   }
                    //                 }
                    //               } else {
                    //                 Fluttertoast.showToast(
                    //                   msg: "Please Select Open Time",
                    //                   toastLength: Toast.LENGTH_SHORT,
                    //                   gravity: ToastGravity.CENTER,
                    //                 );
                    //               }
                    //             },
                    //             icon: const Icon(Icons.access_time_outlined)),
                    //         onTap: () async {
                    //           FocusScope.of(context).unfocus();
                    //           if (controller.openTime != null) {
                    //             DateTime? selectedTime =
                    //                 await PreferenceHelper.showTimePopup(
                    //                     context, controller.openTime);
                    //             if (selectedTime != null) {
                    //               controller.closeTime = selectedTime;
                    //               if (controller.openTime!
                    //                   .isBefore(controller.closeTime!)) {
                    //                 controller.businessCloseTimeController.text =
                    //                     PreferenceHelper.dateToString(
                    //                         date: selectedTime,
                    //                         dateFormat: 'HH:mm');
                    //               } else {
                    //                 // _controller.closeTime = DateTime.tryParse("2023-01-01 00:00");
                    //                 controller.businessCloseTimeController
                    //                     .clear();
                    //                 Fluttertoast.showToast(
                    //                   msg: "Please choose after Open Time",
                    //                   toastLength: Toast.LENGTH_SHORT,
                    //                   gravity: ToastGravity.CENTER,
                    //                 );
                    //               }
                    //             }
                    //           } else {
                    //             Fluttertoast.showToast(
                    //               msg: "Please Select Open Time",
                    //               toastLength: Toast.LENGTH_SHORT,
                    //               gravity: ToastGravity.CENTER,
                    //             );
                    //           }
                    //         },
                    //         maxLength: 10,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.businessAddressLine1Controller,
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
                      controller: controller.businessAddressLine2Controller,
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
                      controller: controller.businessAddressLine3Controller,
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
                            controller: controller.businessDialCodeNoController,
                            hintText: "DC",
                            hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                            textStyle: TextStyle(fontFamily: MyFont.myFont),
                            inputFormatters: [],
                            readOnly: true,
                            maxLength: 100,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Valid DialCode";
                              } else if (value.length < 3) {
                                return "Enter Minimum 3 long";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: width(context) / 1.4,
                          child: CustomTextFormField(
                            controller: controller.businessMobileNoController,
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
                      controller: controller.businessCityController,
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
                      controller: controller.businessCountryController,
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
                      controller: controller.businessPostalController,
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
                        // ToggleButton(
                        //   initialIsClick: isBusinessStatus,
                        //   onTap: (bool isClick) {
                        //     setState(() {
                        //       isBusinessStatus =
                        //       !isBusinessStatus;
                        //     });
                        //   },
                        // ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isBusinessStatus =
                              !isBusinessStatus;
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 26,
                                width: 50,
                                padding: EdgeInsets.only(
                                    left: isBusinessStatus ? 10 : 40,
                                    top: 9),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: isBusinessStatus
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: isBusinessStatus ? 30 : 5,
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
                        // ToggleButton(
                        //   initialIsClick: isAllowIndividualTip,
                        //   onTap: (bool isClick) {
                        //     setState(() {
                        //       isAllowIndividualTip =
                        //       !isAllowIndividualTip;
                        //     });
                        //     print(isAllowIndividualTip);
                        //   },
                        // ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isAllowIndividualTip =
                              !isAllowIndividualTip;
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 26,
                                width: 50,
                                padding: EdgeInsets.only(
                                    left: isAllowIndividualTip ? 10 : 40,
                                    top: 9),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: isAllowIndividualTip
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: isAllowIndividualTip ? 30 : 5,
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
                        // ToggleButton(
                        //   initialIsClick: isAllowOnlineAppointment,
                        //   onTap: (bool isClick) {
                        //     setState(() {
                        //       isAllowOnlineAppointment =
                        //       !isAllowOnlineAppointment;
                        //     });
                        //     print(isAllowOnlineAppointment);
                        //   },
                        // ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isAllowOnlineAppointment =
                              !isAllowOnlineAppointment;
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 26,
                                width: 50,
                                padding: EdgeInsets.only(
                                    left: isAllowOnlineAppointment ? 10 : 40,
                                    top: 9),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: isAllowOnlineAppointment
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: isAllowOnlineAppointment ? 30 : 5,
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
                    isAllowOnlineAppointment == true
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
                                  // ToggleButton(
                                  //   initialIsClick: isCustomerPlace,
                                  //   onTap: (bool isClick) {
                                  //     setState(() {
                                  //       isCustomerPlace =
                                  //       !isCustomerPlace;
                                  //     });
                                  //   },
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isCustomerPlace =
                                        !isCustomerPlace;
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 26,
                                          width: 50,
                                          padding: EdgeInsets.only(
                                              left: isCustomerPlace ? 10 : 40,
                                              top: 9),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: isCustomerPlace
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: isCustomerPlace ? 30 : 5,
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
                                  // ToggleButton(
                                  //   initialIsClick: isBusinessPlace,
                                  //   onTap: (bool isClick) {
                                  //     setState(() {
                                  //       isBusinessPlace =
                                  //       !isBusinessPlace;
                                  //     });
                                  //   },
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isBusinessPlace =
                                        !isBusinessPlace;
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 26,
                                          width: 50,
                                          padding: EdgeInsets.only(
                                              left: isBusinessPlace ? 10 : 40,
                                              top: 9),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: isBusinessPlace
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: isBusinessPlace ? 30 : 5,
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
                            ],
                          ),
                        )) :  const Text(""),
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
                controller.businessUpdateParams.businessName =
                    controller.businessNameController.text;
                controller.businessUpdateParams.addressLine1 =
                    controller.businessAddressLine1Controller.text;
                controller.businessUpdateParams.addressLine2 =
                    controller.businessAddressLine2Controller.text;
                controller.businessUpdateParams.addressLine3 =
                    controller.businessAddressLine3Controller.text;
                controller.businessUpdateParams.countryDialCode =
                    controller.businessDialCodeNoController.text;
                controller.businessUpdateParams.mobileNo =
                    controller.businessMobileNoController.text;
                controller.businessUpdateParams.city =
                    controller.businessCityController.text;
                controller.businessUpdateParams.country =
                    controller.businessCountryController.text;
                controller.businessUpdateParams.postalCode =
                    controller.businessPostalController.text;
                controller.businessUpdateParams.isActive = isBusinessStatus;
                controller.businessUpdateParams.allowIndividualTip = isAllowIndividualTip;
                controller.businessUpdateParams.allowOnlineApp = isAllowOnlineAppointment;
                controller.businessUpdateParams.allowBusinessPlace = isBusinessPlace;
                controller.businessUpdateParams.allowCustomerPlace = isCustomerPlace;
                controller.updatedBusinessProfile();
              },
              title: "Update"),
        ),
      );
    });
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
        controller.businessUpdateParams.logoFilePath = pickedFile!.path;
        controller.businessUpdateParams.logoFileName = pickedFile!.name;
      });
      controller.businessUpdateParams.logoImgBase64String =
          base64Encode(imageBytes);
    } else {
      debugPrint('No image selected.');
    }
  }
}
