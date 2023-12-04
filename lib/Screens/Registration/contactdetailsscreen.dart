import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Const/enum.dart';
import '../../Const/font.dart';
import '../../Const/size.dart';
import '../../Helper/extension.dart';
import '../../Helper/vailidation.dart';
import '../../Widget/submitbutton.dart';
import '../../Widget/textformfield.dart';
import 'User/userregfirstscreen.dart';
import 'contactscreencontroller.dart';

class ContactDetailsScreen extends StatefulWidget {
  const ContactDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  late ContactDetailsController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ContactDetailsController());
    controller.loadCountryList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactDetailsController>(builder: (logic) {
      if (controller.countryList.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Form(
        key: controller.contactDetailsKey,
        child: Scaffold(
          backgroundColor: MyColors.mainTheme,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height(context) / 1.2,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0))),
                  child: Stack(
                    children: [
                      SafeArea(
                          child: Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 160,
                                child: Image.asset(Assets.logo),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Signup to Continue',
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 20),
                              GridView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (controller.isUserReg.value = true) {
                                          controller.isSpecialistReg.value =
                                              false;
                                          controller.isBusinessReg.value =
                                              false;
                                        }
                                      });
                                      // Set selected user type and reset other types
                                      controller.isUserReg.value = true;
                                      controller.isSpecialistReg.value = false;
                                      controller.isBusinessReg.value = false;
                                    },
                                    child: Card(
                                      color: controller.isUserReg.value
                                          ? MyColors.tabBar
                                          : MyColors.regColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            Assets.user,
                                            scale: 0.8,
                                            color: controller.isUserReg.value
                                                ? MyColors.primaryCustom
                                                : MyColors.black,
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            "USER",
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: controller.isUserReg.value
                                                  ? MyColors.primaryCustom
                                                  : MyColors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (controller.isSpecialistReg.value =
                                            true) {
                                          controller.isUserReg.value = false;
                                          controller.isBusinessReg.value =
                                              false;
                                        }
                                      });
                                      // Set selected user type and reset other types
                                      controller.isUserReg.value = false;
                                      controller.isSpecialistReg.value = true;
                                      controller.isBusinessReg.value = false;
                                    },
                                    child: Card(
                                      color: controller.isSpecialistReg.value
                                          ? MyColors.tabBar
                                          : MyColors.regColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            Assets.specialist,
                                            scale: 0.8,
                                            color:
                                                controller.isSpecialistReg.value
                                                    ? MyColors.primaryCustom
                                                    : MyColors.black,
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            "SPECIALIST",
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: controller
                                                      .isSpecialistReg.value
                                                  ? MyColors.primaryCustom
                                                  : MyColors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (controller.isBusinessReg.value =
                                            true) {
                                          controller.isUserReg.value = false;
                                          controller.isSpecialistReg.value =
                                              false;
                                        }
                                      });
                                      controller.isUserReg.value = false;
                                      controller.isSpecialistReg.value = false;
                                      controller.isBusinessReg.value = true;
                                    },
                                    child: Card(
                                      color: controller.isBusinessReg.value
                                          ? MyColors.tabBar
                                          : MyColors.regColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            Assets.business,
                                            scale: 0.8,
                                            color:
                                                controller.isBusinessReg.value
                                                    ? MyColors.primaryCustom
                                                    : MyColors.black,
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            "BUSINESS",
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color:
                                                  controller.isBusinessReg.value
                                                      ? MyColors.primaryCustom
                                                      : MyColors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                  // height: 35,
                                  width: width(context) / 2,
                                  child: InkWell(
                                    onTap: () {
                                      controller.showMaterialDialog(
                                          context: context,
                                          countryList: controller.countryList);
                                    },
                                    child: Obx(() {
                                      return Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: MyColors.grey),
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              controller.selectedCountry.value
                                                      ?.country ??
                                                  'Country',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color:
                                                      MyColors.primaryCustom),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                    // TextFormField(
                                    //   readOnly: true,
                                    //   decoration: InputDecoration(
                                    //       contentPadding:
                                    //           EdgeInsets.fromLTRB(10, 10, 10, 5),
                                    //       suffixIcon: Image.asset(Assets.drop),
                                    //       border: OutlineInputBorder(
                                    //           borderRadius:
                                    //               BorderRadius.circular(10.0))),
                                    // ),
                                  )),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width(context) / 6,
                                    child: Obx(() {
                                      return CustomTextFormField(
                                        controller:
                                            controller.countryCodeController,
                                        readOnly: true,
                                        hintText: controller
                                                    .selectedCountry.value !=
                                                null
                                            ? ("${controller.selectedCountry.value?.code}")
                                            : '',
                                        inputFormatters: [
                                          NumericInputFormatter()
                                        ],
                                        obscureText: false,
                                        enabled: false,
                                        textStyle: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontSize: 20,
                                        ),
                                        hintTextStyle: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontSize: 18,
                                          color: MyColors.black,
                                        ),
                                        maxLength: 100,
                                      );
                                    }),
                                  ),
                                  SizedBox(
                                      width: width(context) / 1.4,
                                      child: CustomTextFormField(
                                        controller:
                                            controller.phoneNumberController,
                                        hintText: "PhoneNumber",
                                        textStyle: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontSize: 20,
                                        ),
                                        inputFormatters: [
                                         // NumericInputFormatter()
                                        ],
                                         keyboardType: TextInputType.number,
                                        // readOnly: false,
                                        // autoValidateMode:
                                        //     AutovalidateMode.onUserInteraction,
                                        obscureText: false,
                                        // hintTextStyle: TextStyle(
                                        //   fontFamily: MyFont.myFont,
                                        //   fontSize: 15,
                                        // ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Enter mobile No";
                                          } else if (!validateMobile(value)) {
                                            return "Invalid mobile No";
                                          }
                                          return null;
                                        },
                                        maxLength: 20,
                                      )
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              CustomTextFormField(
                                controller: controller.emailController,
                                hintText: 'Email',
                                hintTextStyle:
                                    TextStyle(fontFamily: MyFont.myFont),
                                readOnly: false,
                                textStyle: TextStyle(fontFamily: MyFont.myFont),
                                inputFormatters: [
                                  EmailInputFormatter(),
                                ],
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter email id";
                                  } else if (!validateEmail(value)) {
                                    return "Invalid Email Id";
                                  }
                                  return null;
                                },
                                maxLength: 50,
                              ),
                              const SizedBox(height: 30),
                              SubmitButton(
                                  isLoading: false,
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                        // Check if any user type is selected
                                    if (!(controller.isUserReg.value ||
                                        controller.isSpecialistReg.value ||
                                        controller.isBusinessReg.value)) {
                                      // Show a message if no user type is selected
                                      Get.snackbar(
                                        "User Type",
                                        "Please choose a user type",
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    } else {
                                      // Proceed with navigating to the next screen
                                      if (controller
                                          .contactDetailsKey.currentState!
                                          .validate()) {
                                        print(">>>>>>>>>>>>>>>>>>>>>>>>>");
                                        print(controller.emailController);
                                        print(">>>>>>>>>>>>>>>>>>>>>>>>>");
                                        controller.checkingExistingUser();
                                        // _callSendOtp(false);
                                      }
                                    }
                                    // if (controller
                                    //     .contactDetailsKey.currentState!
                                    //     .validate()) {
                                    //   print(">>>>>>>>>>>>>>>>>>>>>>>>>");
                                    //   print(controller.emailController);
                                    //   print(">>>>>>>>>>>>>>>>>>>>>>>>>");
                                    //   controller.checkingExistingUser();
                                    //   // _callSendOtp(false);
                                    // }
                                    // Get.toNamed(Routes.oTPScreen);
                                  },
                                  title: "Next")
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Or sign up using Social media",
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontSize: 15,
                    color: MyColors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(child: Image.asset(Assets.facebook, scale: 0.8)),
                    InkWell(child: Image.asset(Assets.instagram, scale: 0.8)),
                    InkWell(child: Image.asset(Assets.google, scale: 0.8)),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
