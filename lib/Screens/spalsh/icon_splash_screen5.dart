import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:top_20/Const/approute.dart';
import 'package:top_20/Const/assets.dart';
import 'package:top_20/Const/colors.dart';
import 'package:top_20/Helper/preferencehelper.dart';
import 'package:top_20/Model/Member_details_model.dart';

class IconSplashScreen5 extends StatefulWidget {
  const IconSplashScreen5({super.key});

  @override
  State<IconSplashScreen5> createState() => _IconSplashScreen5State();
}

class _IconSplashScreen5State extends State<IconSplashScreen5> with TickerProviderStateMixin {


  late AnimationController _controller;
  late Animation _animation;

  var memberId;
  var specialistId;
  var businessId;

  _initialiseData() async {
    await PreferenceHelper.getMemberData()
        .then((value) => memberId = value?.memberId);
    await PreferenceHelper.getSpecialistData()
        .then((value) => specialistId = value?.specialistId);
    await PreferenceHelper.getBusinessData()
        .then((value) => businessId = value?.businessId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.white,
        body: Center(
            child: AnimatedBuilder(
          animation: _controller,
          child: Container(
            width: 10.0,
            height: 10.0,
            color: MyColors.white,
            child: Center(
              child: Image.asset(
                Assets.logo,
                fit: BoxFit.contain,
              ),
            ),
          ),
          builder: (BuildContext context, Widget? child) {
            return Transform.scale(
              scale: _animation.value,
              child: child,
            );
          },
        )));
  }

  @override
  void initState() {
    super.initState();
    _initialiseData();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animation = Tween<double>(
      begin: 200,
      end: 20,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    _controller.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(
          const Duration(seconds: 1),
          () => (memberId != null)
              ? Get.offAllNamed(Routes.userBottomNavBar)
              : (specialistId != null)
                  ? Get.offAllNamed(Routes.specialistBottomNavBar)
                  : (businessId != null)
                      ? Get.offAllNamed(Routes.businessBottomNavBar)
                      : Get.offAllNamed(Routes.welcomeScreen));
      //() => Get.offAllNamed(Routes.businessBottomNavBar));
    });
  }
}
