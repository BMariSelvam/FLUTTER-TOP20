import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:top_20/Const/approute.dart';
import 'package:top_20/Const/colors.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Const/size.dart';
import '../../Const/assets.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentIndex < 2) {
        currentIndex++;
        _controller.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        currentIndex = 2;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.mainTheme,
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: [
                Container(
                  alignment: Alignment.center,
                  color: MyColors.yellow,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          Assets.introImage1,
                          scale: 2,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: width(context) / 1.5,
                        child: Text(
                          "Morbi Vulputate Amet Consec",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: MyColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: MyColors.pink,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          Assets.introImage2,
                          scale: 2,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: width(context) / 1.5,
                        child: Text(
                          "Morbi Vulputate Amet Consec",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: MyColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: MyColors.blue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          Assets.introImage3,
                          scale: 2,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: width(context) / 1.5,
                        child: Text(
                          "Morbi Vulputate Amet Consec",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: MyColors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
                alignment: const Alignment(0, 0.7),
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: MyColors.grey,
                    activeDotColor: MyColors.white,
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(bottom: 25, left: 15, right: 15),
              padding: const EdgeInsets.all(10),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: MyColors.white,
                      ),
                    ),
                    onPressed: () {
                      Get.offAllNamed(Routes.userDashBoardScreen);
                    },
                  ),
                  (currentIndex == 2)
                      ? InkWell(
                          onTap: () {
                            Get.offAllNamed(Routes.userDashBoardScreen);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 30,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors
                                  .introButton, // border: Border.all(color: MyColors.mainTheme, width: 2),
                            ),
                            child: Center(
                                child: Text(
                              'Done',
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: MyColors.white,
                              ),
                            )),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 30,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors
                                  .introButton, // border: Border.all(color: MyColors.mainTheme, width: 2),
                            ),
                            child: Center(
                                child: Text(
                              'Next',
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: MyColors.white,
                              ),
                            )),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ));
  }
}
