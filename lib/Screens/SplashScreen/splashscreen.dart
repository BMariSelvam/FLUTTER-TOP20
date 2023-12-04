import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Helper/preferenceHelper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var memberId;
  var specilaistId;
  var businessId;

  void initState() {
    super.initState();
    _initialiseData();
  }

  _initialiseData() async {
    await PreferenceHelper.getMemberData()
        .then((value) => memberId = value?.memberId);
    await PreferenceHelper.getSpecialistData()
        .then((value) => specilaistId = value?.specialistId);
    await PreferenceHelper.getBusinessData()
        .then((value) => businessId = value?.businessId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(
          const Duration(seconds: 3),
          () => (memberId != null)
              ? Get.offAllNamed(Routes.userDashBoardScreen)
              : (specilaistId != null)
                  ? Get.offAllNamed(Routes.specialistBottomNavBar)
                  : (businessId != null)
                      ? Get.offAllNamed(Routes.businessBottomNavBar)
                      : Get.offAllNamed(Routes.userBottomNavBar));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(Assets.logo),
      ),
    );
  }
}
