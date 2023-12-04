import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:top_20/Model/businesslistmodel.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Const/font.dart';
import '../../../Const/size.dart';
import '../../../Helper/extension.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Widget/dottedline.dart';
import '../../../Widget/submitbutton.dart';
import '../../Login/loginscreen.dart';
import 'aboutbusinesscontroller.dart';

class AboutBusiness extends StatefulWidget {
  const AboutBusiness({Key? key}) : super(key: key);

  @override
  State<AboutBusiness> createState() => _AboutBusinessState();
}

class _AboutBusinessState extends State<AboutBusiness> {
  BusinessListUserViewModel? businessListUserViewModel;
  var memberId;
  late AboutBusinessController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(AboutBusinessController());
    businessListUserViewModel = Get.arguments as BusinessListUserViewModel;
    initializeData();
  }

  initializeData() async {
    await PreferenceHelper.getMemberData().then((value) => setState(() {
          memberId = value?.memberId;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutBusinessController>(builder: (logic) {
      if (logic.status == RxStatus.loading()) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                "ABOUT BUSINESS",
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                ),
              ),
              centerTitle: true,
              expandedHeight: 300,
              pinned: true,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.asset(
                              Assets.profile,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  capitalizeFirstLetter(
                                    businessListUserViewModel?.displayName ??
                                        "",
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: MyColors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Row(
                                //   children: [
                                //     const Icon(
                                //       Icons.star_rounded,
                                //       color: Colors.amber,
                                //     ),
                                //     Text(
                                //       "4.3 1.23k(reviews)",
                                //       overflow: TextOverflow.ellipsis,
                                //       style: TextStyle(
                                //         fontFamily: MyFont.myFont,
                                //         fontWeight: FontWeight.w500,
                                //         fontSize: 20,
                                //         color: MyColors.white,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                RatingBarIndicator(
                                  rating: controller.businessListUserViewModel
                                          ?.ratingValue ??
                                      3.0,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: MyColors.yellow,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      DottedHorizontalLine(
                        color: MyColors.white,
                        dotWidth: 15,
                        dotSpacing: 20,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        capitalizeFirstLetter(
                            businessListUserViewModel?.businessCategoryName ??
                                ""),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: MyColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Business",
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () {
                        if (controller.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  MyColors.primaryCustom),
                            ),
                          );
                        } else if (controller
                            .specialistOverAllList.isNotEmpty) {
                          return SizedBox(
                            child: aboutBusinessSpecialistList(),
                          );
                        } else {
                          // If the list is empty, show a message
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 200),
                              child: Text(
                                "This Business has not  \n added any Specialist",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: MyColors.darkGrey,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SubmitButton(
                  isLoading: false,
                  onTap: () {
                    (memberId != null)
                        ? Get.toNamed(Routes.userAppointmentBusiness,
                            arguments: businessListUserViewModel)
                        : _showPopUp(context);
                  },
                  title: "Book Appointment"),
              const SizedBox(height: 10),
              SubmitButton(
                  isLoading: false,
                  onTap: () {
                    Get.toNamed(Routes.businessRatingScreen,
                        arguments: businessListUserViewModel?.businessId);
                  },
                  title: "Rating")
            ],
          ),
        ),
      );
    });
  }

  void _showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(
            'Continue with us',
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Please Signup or Signin',
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.loginScreen);
                  },
                  child: Text(
                    'Signin',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  aboutBusinessSpecialistList() {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.specialistOverAllList.length,
        itemBuilder: (context, index) {
          return Card(
            color: MyColors.scaffold,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.regColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: SizedBox(
                              height: 60,
                              width: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: webImage(
                                  imageUrl: controller
                                          .specialistOverAllList[index]
                                          .filePath ??
                                      "",
                                  fit: BoxFit.fill,
                                ),
                              )),
                        )),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                capitalizeFirstLetter(controller
                                        .specialistOverAllList[index]
                                        .specilistName ??
                                    ""),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            RatingBarIndicator(
                              rating: controller.specialistOverAllList[index]
                                      .ratingValue ??
                                  3.75,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: MyColors.primaryCustom,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                controller.specialistOverAllList[index]
                                        .specialistId ??
                                    "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          );
        });
  }
}
