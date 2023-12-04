import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';

import '../../Const/approute.dart';
import '../../Const/colors.dart';
import '../../Const/font.dart';
import '../../Helper/preferencehelper.dart';
import '../../Widget/submitbutton.dart';
import 'contactscreencontroller.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late ContactDetailsController controller;

  String? otp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.find<ContactDetailsController>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  //OTPFieldDecoration
  final defaultTheme = PinTheme(
      height: 50,
      width: 45,
      textStyle: TextStyle(
        fontFamily: MyFont.myFont,
        fontSize: 20,
        color: MyColors.black,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: MyColors.scaffold,
          border: Border.all(color: MyColors.grey)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verify Mobile ',
              style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                // _controller.update();
                // _callSendOtp(true);
              },
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text:
                        "Code sent to ${controller?.phoneNumberController.text}",
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  )),
            ),
            const SizedBox(height: 20),
            Center(
              child: Pinput(
                controller: controller.otpController,
                length: 6,
                obscureText: true,
                obscuringCharacter: "*",
                keyboardType: TextInputType.number,
                enabled: true,
                cursor: const SizedBox(height: 0),
                defaultPinTheme: defaultTheme,
                focusedPinTheme: defaultTheme.copyWith(
                    decoration: BoxDecoration(
                        color: MyColors.tabBar,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: MyColors.primaryCustom))),
                onChanged: (pin) {},
                onCompleted: (pin) {
                  otp = pin;
                },
              ),
            ),
            const SizedBox(height: 20),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "Didn't receive Code?",
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const WidgetSpan(
                  child: SizedBox(
                width: 10,
                height: 30,
              )),
              TextSpan(
                  text: "Request Again",
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: MyColors.black,
                  )),
            ])),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: SubmitButton(
            isLoading: false,
            onTap: () {
              if (otp == "111111") {
                controller.callVerifyOtp(otp!, context);
              } else {
                PreferenceHelper.showSnackBar(
                    context: context, msg: "Invalid OTP");
              }
              // _callVerifyOtp(otp);
            },
            title: 'Verify and create account'),
      ),
    );
  }
}
