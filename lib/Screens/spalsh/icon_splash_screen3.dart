import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:top_20/Const/approute.dart';
import 'package:top_20/Const/colors.dart';
import 'package:top_20/Const/size.dart';

import '../../Const/assets.dart';

class IconSplashScreen3 extends StatefulWidget {
  const IconSplashScreen3({Key? key}) : super(key: key);

  @override
  State<IconSplashScreen3> createState() => _IconSplashScreen3State();
}

class _IconSplashScreen3State extends State<IconSplashScreen3> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(
        const Duration(milliseconds: 400),
        () => Get.toNamed(Routes.splash4Gif),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mainTheme,
      body: Center(
        child: Image.asset(
          Assets.splash3Gif,
          scale: 4,
        ),
      ),
    );
  }
}
