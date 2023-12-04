import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Const/font.dart';
import '../../Const/size.dart';
import '../../Helper/api.dart';
import '../../Helper/enum.dart';
import '../../Helper/networkmanager.dart';
import '../../Helper/preferenceHelper.dart';
import '../../Widget/submitbutton.dart';
import '../Registration/contactdetailsscreen.dart';
import 'logincontroller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
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
                            const SizedBox(height: 20),
                            Text(
                              'Let\'s Sign You In',
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.emailController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  labelText: 'Email',
                                  labelStyle:
                                      TextStyle(fontFamily: MyFont.myFont),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                    child: Icon(Icons.mail_outline_rounded),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter the user email';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: controller.passwordController,
                              obscureText: controller.passwordVisibility,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    fontFamily: MyFont.myFont,
                                  ),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                    child: Icon(Icons.lock_outline),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.passwordVisibility =
                                            !controller.passwordVisibility;
                                      });
                                    },
                                    icon: controller.passwordVisibility
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter the password';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            // const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 150,
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.forgetPasswordScreen);
                                  },
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      color: MyColors.black,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SubmitButton(
                                isLoading: controller.isLoading.value,
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  if (controller.formKey.currentState!
                                      .validate()) {}
                                  GeneralLogin();
                                },
                                title: "Login"),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const ContactDetailsScreen());
                              },
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Don't have an account?",
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.black,
                                    )),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(
                                    text: "SIGN UP",
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.mainTheme,
                                    ))
                              ])),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                                onPressed: () {
                                  Get.offAllNamed(Routes.userDashBoardScreen);
                                },
                                child: Text(
                                  "View as Guest",
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Or sign in using Social media",
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
  }

  GeneralLogin() async {
    await NetworkManager.post(
      url: HttpUrl.generalLogin,
      params: {
        "OrganizationId": 1,
        "EmailId": controller.emailController.text.trim(),
        "Password": controller.passwordController.text.trim(),
      },
    ).then((apiResponse) async {
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel?.result == "S") {
          controller.userType = UserType.specialist;
        } else if (apiResponse.apiResponseModel?.result == "B") {
          controller.userType = UserType.business;
        } else if (apiResponse.apiResponseModel?.result == "M") {
          controller.userType = UserType.user;
        } else {
          PreferenceHelper.showSnackBar(
              context: Get.context!, msg: "User not Match please Check");
        }
        controller.login();
      } else {
        String? message = apiResponse.apiResponseModel?.message;
        Get.snackbar("Invalid Username or Password", message!,
            duration: 3.seconds, snackPosition: SnackPosition.TOP);
      }
    });
  }
}
