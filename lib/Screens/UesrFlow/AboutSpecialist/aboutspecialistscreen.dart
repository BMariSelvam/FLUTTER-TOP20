import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:top_20/Const/colors.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Const/size.dart';
import 'package:top_20/Widget/dottedline.dart';
import 'package:top_20/Widget/submitbutton.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Helper/extension.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/Member_details_model.dart';
import '../../../Model/specialistmodel.dart';
import '../../../Model/specialistregmodel.dart';
import '../../Login/loginscreen.dart';
import 'aboutspecialistcontroller.dart';

class AboutSpecialistScreen extends StatefulWidget {
  const AboutSpecialistScreen({Key? key}) : super(key: key);

  @override
  State<AboutSpecialistScreen> createState() => _AboutSpecialistScreenState();
}

class _AboutSpecialistScreenState extends State<AboutSpecialistScreen> {
  var memberId;
  SpecialistListModel? specialistListModel;

  late AboutSpecialistController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(AboutSpecialistController());
    specialistListModel = Get.arguments as SpecialistListModel;
    initializeData();
    controller.getAllBusinessRequest();
  }

  initializeData() async {
    await PreferenceHelper.getMemberData().then((value) => setState(() {
          memberId = value?.memberId;
        }));
  }

  @override
  Widget build(BuildContext context) {
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
    print(specialistListModel?.emailId);
    return GetBuilder<AboutSpecialistController>(builder: (logic) {
      if (logic.status == RxStatus.loading()) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return WillPopScope(
        onWillPop: () async {
          Get.back();
          return true;
        },
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  "ABOUT SPECIALIST",
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: webImage(
                                    imageUrl:
                                        specialistListModel?.filePath ?? '',
                                  )),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    capitalizeFirstLetter(
                                      specialistListModel?.displayName ?? "",
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
                                  //       "",
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
                                    rating: specialistListModel?.ratingValue ??
                                        3.75,
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
                              specialistListModel?.businessCategoryname ?? ""),
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
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () {
                          if (controller.isLoading.value) {
                            // Show a loading indicator
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    MyColors.primaryCustom),
                              ),
                            );
                          } else if (controller.approveInvite.isNotEmpty) {
                            // Data loaded successfully, show the content
                            return SizedBox(
                              child: aboutSpecialistBusinessList(),
                            );
                          } else {
                            // If the list is empty, show a message
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 200),
                                child: Text(
                                  "This Specialist is Freelance and \n not associate with  any Business",
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
                          ? Get.toNamed(Routes.appointmentScreen,
                              arguments: specialistListModel)
                          : _showPopUp(context);
                      // Get.toNamed(Routes.appointmentScreen,
                      //     arguments: specialistListModel);
                    },
                    title: "Book Appointment"),
                const SizedBox(height: 10),
                SubmitButton(
                    isLoading: false,
                    onTap: () {
                      Get.toNamed(Routes.specialistRatingScreen,
                          arguments: specialistListModel?.specialistId);
                    },
                    title: "Rating")
              ],
            ),
          ),
        ),
      );
    });
  }

  aboutSpecialistBusinessList() {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.approveInvite.length,
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
                                          .approveInvite[index].filePath ??
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
                                        .approveInvite[index].businessName ??
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
                              rating:
                                  controller.approveInvite[index].ratingValue ??
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
                                controller.approveInvite[index].businessId ??
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

  void _showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
                    'Ok',
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
}
