import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:top_20/Const/size.dart';
import 'package:top_20/Widget/submitbutton.dart';
import 'package:top_20/Widget/textformfield.dart';

import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Const/font.dart';
import '../../Helper/extension.dart';
import 'forgerpasswordcontroller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late ForgetPasswordController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ForgetPasswordController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(builder: (logic) {
      return Form(
        key: controller.forgotPassKey,
        child: Scaffold(
          backgroundColor: MyColors.primaryCustom,
          body: Container(
            height: height(context) / 1.3,
            decoration: const BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: [
                    SizedBox(height: 120, child: Image.asset(Assets.logo)),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.forgetPasswordController,
                      labelText: "Email",
                      labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                      textStyle: TextStyle(fontFamily: MyFont.myFont),
                      inputFormatters: [EmailInputFormatter()],
                      maxLength: 100,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter email id";
                        } else if (!validateEmail(value)) {
                          return "Invalid Email Id";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 90, 20, 0),
                      child: SubmitButton(
                        isLoading: false,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (controller.forgotPassKey.currentState!
                              .validate()) {
                            controller.forgotPasswordType();
                          }
                        },
                        title: "Submit",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
