import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_20/Helper/extension.dart';
import 'package:top_20/Screens/UesrFlow/UserProfile/ResetPassword/resetpasswordcontroller.dart';
import 'package:top_20/Widget/submitbutton.dart';
import 'package:top_20/Widget/textformfield.dart';

import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Helper/preferenceHelper.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late ResetPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ResetPasswordController());
    controller. intialfunc();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.currentPasswordController.clear();
    controller.newPasswordController.clear();
    controller.confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          title: Text(
            "RESET PASSWORD",
            style: TextStyle(
              fontFamily: MyFont.myFont,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.reset),
                const SizedBox(height: 50),
                Text(
                  "Create a New Password",
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.bold,
                    color: MyColors.black,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: MyColors.scaffold,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: controller.currentPasswordController,
                          labelText: "",
                          hintText: "Current Password",
                          hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                          textStyle: TextStyle(fontFamily: MyFont.myFont),
                          filled: true,
                          filledColor: MyColors.white,
                          inputFormatters: [NumericInputFormatter()],
                          keyboardType: TextInputType.number,
                          maxLength: 100,
                          obscureText: controller.isCurrentPassword.value ? true : false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                controller.isCurrentPassword.value = !controller.isCurrentPassword.value;
                              });
                            },
                            icon: Icon(controller.isCurrentPassword.value ? Icons.visibility_off : Icons.visibility),
                          ),
                          validator: (value) {
                            if (!controller.passwordChanged.value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Valid Password";
                              } else if (value.length < 6) {
                                return "Password Should be 6 Character";
                              }
                            }
                            return null; // No error message when passwordChanged is true.
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: controller.newPasswordController,
                          labelText: "",
                          hintText: "New Password",
                          hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                          textStyle: TextStyle(fontFamily: MyFont.myFont),
                          filled: true,
                          filledColor: MyColors.white,
                          inputFormatters: [NumericInputFormatter()],
                          keyboardType: TextInputType.number,
                          maxLength: 100,
                          obscureText: controller.isNewPassword.value ? true : false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                controller.isNewPassword.value = !controller.isNewPassword.value;
                              });
                            },
                            icon: Icon(controller.isNewPassword.value ? Icons.visibility_off : Icons.visibility),
                          ),
                          validator: (value) {
                            if (!controller.passwordChanged.value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Valid Password";
                              } else if (value.length < 6) {
                                return "Password Should be 6 Character";
                              }
                            }
                            return null; // No error message when passwordChanged is true.
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: controller.confirmPasswordController,
                          labelText: "",
                          hintText: "Confirm Password",
                          hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                          textStyle: TextStyle(fontFamily: MyFont.myFont),
                          filled: true,
                          filledColor: MyColors.white,
                          inputFormatters: [NumericInputFormatter()],
                          keyboardType: TextInputType.number,
                          maxLength: 100,
                          obscureText: controller.isConfirmPassword.value ? true : false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                controller.isConfirmPassword.value = !controller.isConfirmPassword.value;
                              });
                            },
                            icon: Icon(controller.isConfirmPassword.value ? Icons.visibility_off : Icons.visibility),
                          ),
                          validator: (value) {
                            if (!controller.passwordChanged.value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Valid Password";
                              } else if (value.length < 6) {
                                return "Password Should be 6 Character";
                              }
                            }
                            return null; // No error message when passwordChanged is true.
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SubmitButton(
            isLoading: false,
            onTap: () async {
                if (controller.newPasswordController.text == controller.confirmPasswordController.text) {

              await controller.changePassword();

                } else {
                  PreferenceHelper.showSnackBar(
                    context: Get.context!,
                    msg: "New Password And Confirm Password Does not Match",
                  );
                }
            },
            title: "Reset",
          ),
        ),
      ),
    );
  }
}