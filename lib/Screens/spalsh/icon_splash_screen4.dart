import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:top_20/Const/approute.dart';
import 'package:top_20/Const/colors.dart';
import 'package:top_20/Const/size.dart';

import '../../Const/assets.dart';

class IconSplashScreen4 extends StatefulWidget {
  const IconSplashScreen4({Key? key}) : super(key: key);

  @override
  State<IconSplashScreen4> createState() => _IconSplashScreen4State();
}

class _IconSplashScreen4State extends State<IconSplashScreen4> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(
        const Duration(milliseconds: 400),
        () => Get.toNamed(Routes.splash5Gif),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainTheme,
      body: Center(
        child: Image.asset(
          Assets.splash4Gif,
          scale: 4,
        ),
      ),
    );
  }
}
