import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/font.dart';
import '../../Helper/preferenceHelper.dart';
import '../../Widget/submitbutton.dart';

class AppointmentSuccessfullyScreen extends StatefulWidget {
  final String text;
  final bool isLoading;
  final String title;

  const AppointmentSuccessfullyScreen({
    Key? key,
    required this.text,
    required this.isLoading,
    required this.title,
  }) : super(key: key);

  @override
  State<AppointmentSuccessfullyScreen> createState() =>
      _AppointmentSuccessfullyScreenState();
}

class _AppointmentSuccessfullyScreenState
    extends State<AppointmentSuccessfullyScreen> {
  String? businessId;
  String? specialistId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    intialfunc();
  }

  intialfunc() async {
    await PreferenceHelper.getSpecialistData()
        .then((value) => specialistId = value?.specialistId);
    await PreferenceHelper.getBusinessData()
        .then((value) => businessId = value?.businessId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.success),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SubmitButton(
            isLoading: widget.isLoading,
            onTap: () {
              if (specialistId != null) {
                Get.offAllNamed(Routes.specialistDashBoardScreen);
              }
              if (businessId != null) {
                Get.offAllNamed(Routes.businessBottomNavBar);
              }
            },
            title: widget.title),
      ),
    );
  }
}
