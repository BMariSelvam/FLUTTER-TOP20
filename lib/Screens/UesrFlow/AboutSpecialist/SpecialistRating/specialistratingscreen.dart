import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Const/size.dart';
import 'package:top_20/Helper/preferenceHelper.dart';
import 'package:top_20/Screens/UesrFlow/AboutSpecialist/SpecialistRating/specialistratingcontroller.dart';

import '../../../../Const/approute.dart';
import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Helper/extension.dart';
import '../../../../Model/Member_details_model.dart';
import '../../../../Widget/submitbutton.dart';

class SpecialistRatingScreen extends StatefulWidget {
  const SpecialistRatingScreen({super.key});

  @override
  State<SpecialistRatingScreen> createState() => _SpecialistRatingScreenState();
}

class _SpecialistRatingScreenState extends State<SpecialistRatingScreen> {
  String? specialistId;
  String? memberId;

  late SpecialistUserRatingController controller;

  MemberDetails? memberDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    specialistId = Get.arguments as String;
    controller = Get.put(SpecialistUserRatingController());
    print(">>>>>>>>>$specialistId>>>>>>>>>>");
    initialCall();
    controller.getSpecialistReview(specialistId);
    controller.getAllAppointments(specialistId);
  }

  initialCall() async {
    memberDetails = await PreferenceHelper.getMemberData();
    setState(() {
      memberId = memberDetails?.memberId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistUserRatingController>(builder: (logic) {
      if (logic.isLoading == true) {
        return Scaffold(
          body: Center(
            child: LoadingAnimationWidget.threeRotatingDots(
                color: MyColors.primaryCustom, size: 20),
          ),
        );
      }
      return Form(
        key: controller.splRegKey,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  "RATING",
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                  ),
                ),
                centerTitle: true,
                expandedHeight: 250,
                pinned: true,
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                      padding: const EdgeInsets.only(top: 130),
                      child: Center(
                        child: GridView(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.3,
                          ),
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (controller.isOpenRatClick.value = true) {
                                    controller.isAppointmentRatClick.value =
                                        false;
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: controller.isOpenRatClick.value
                                      ? MyColors.white
                                      : MyColors.textFieldTheme,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: MyColors.white),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Center(
                                    child: Text(
                                      "Open",
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        color: controller.isOpenRatClick.value
                                            ? MyColors.primaryCustom
                                            : MyColors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (controller.isAppointmentRatClick.value =
                                      true) {
                                    controller.isOpenRatClick.value = false;
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: controller.isAppointmentRatClick.value
                                      ? MyColors.white
                                      : MyColors.textFieldTheme,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: MyColors.white),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Center(
                                    child: Text(
                                      "Appointment",
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        color: controller
                                                .isAppointmentRatClick.value
                                            ? MyColors.primaryCustom
                                            : MyColors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
              SliverToBoxAdapter(
                child: (controller.userSpecialistRatingList != null)
                    ? SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            (controller.isOpenRatClick.value)
                                ? specialistOpenReview()
                                : (controller.isAppointmentRatClick.value)
                                    ? specialistAppointmentReview()
                                    : Container(),
                            (controller.isOpenRatClick.value)
                                ? Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 8, 20, 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rate And Review",
                                          style: TextStyle(
                                            fontFamily: MyFont.myFont,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RatingBar(
                                                initialRating: 0,
                                                itemSize: 25,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                ratingWidget: RatingWidget(
                                                    full: const Icon(Icons.star,
                                                        color: Colors.orange),
                                                    half: const Icon(
                                                      Icons.star_half,
                                                      color: Colors.orange,
                                                    ),
                                                    empty: const Icon(
                                                      Icons.star_outline,
                                                      color: Colors.orange,
                                                    )),
                                                onRatingUpdate: (value) {
                                                  controller.ratingValue =
                                                      value;
                                                }),
                                            Text(
                                              memberDetails?.displayName ?? "",
                                              style: TextStyle(
                                                fontFamily: MyFont.myFont,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 2, 20),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: 3,
                                            inputFormatters: [
                                              NoInitialSpaceFormatter()
                                            ],
                                            controller:
                                                controller.reviewController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              hintText: "Write review",
                                            ),
                                            validator: (value) {
                                              if (value?.isEmpty == true) {
                                                return "Review can't be empty";
                                              }
                                            },
                                          ),
                                        ),
                                        SubmitButton(
                                          isLoading: false,
                                          title: 'Submit',
                                          onTap: (memberDetails?.memberName !=
                                                  null)
                                              ? () async {
                                                  if (controller
                                                      .splRegKey.currentState!
                                                      .validate()) {
                                                    // if (controller.ratingValue ==
                                                    //     null) {
                                                    //   Get.showSnackbar(
                                                    //     GetBar(
                                                    //       message:
                                                    //           "Please give Star rating",
                                                    //
                                                    //       backgroundColor: Colors.red,
                                                    //       margin:
                                                    //           const EdgeInsets.all(
                                                    //               18.0),
                                                    //       duration: const Duration(
                                                    //           seconds: 2),
                                                    //       borderRadius: 10.0,
                                                    //       // Replace 10.0 with your desired radius
                                                    //       icon: const Icon(
                                                    //         Icons.error,
                                                    //         color: Colors.white,
                                                    //       ),
                                                    //     ),
                                                    //   );
                                                    // }
                                                    if (controller
                                                        .reviewController
                                                        .text
                                                        .isEmpty) {
                                                      GetBar(
                                                        message:
                                                            "Please write a Review",
                                                        backgroundColor:
                                                            Colors.red,
                                                        margin: const EdgeInsets
                                                            .all(18.0),
                                                        duration:
                                                            const Duration(
                                                                seconds: 2),
                                                        borderRadius: 10.0,
                                                        // Replace 10.0 with your desired radius
                                                        icon: const Icon(
                                                          Icons.error,
                                                          color: Colors.white,
                                                        ),
                                                      );
                                                    } else {
                                                      await controller
                                                          .userSplPostRating(
                                                              businessId: "",
                                                              specialistId:
                                                                  specialistId,
                                                              memberId:
                                                                  memberId);
                                                    }
                                                  }
                                                }
                                              : () {
                                                  showPopup();
                                                },
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: 0,
                                  ),
                          ],
                        ))
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Text(
                            "No Review",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: MyColors.darkGrey,
                            ),
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      );
    });
  }

  ///Specialist Open Review List
  specialistOpenReview() {
    return SizedBox(
      height: height(context) / 3,
      child: ListView.builder(
          padding: const EdgeInsets.all(0),
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.userSpecialistRatingList?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Card(
                color: MyColors.regColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: webImage(
                                    imageUrl: Assets.profile ?? "",
                                    fit: BoxFit.fill)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              capitalizeFirstLetter(controller
                                      .userSpecialistRatingList?[index]
                                      .memberName ??
                                  "User"),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          RatingBarIndicator(
                            rating: controller.userSpecialistRatingList?[index]
                                    .ratingValue ??
                                4.5,
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
                      Text(
                        capitalizeFirstLetter(controller
                                .userSpecialistRatingList?[index]
                                .reviewDescription ??
                            ""),
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  ///Business Appointment Review List
  specialistAppointmentReview() {
    return ListView.builder(
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.appointmentRating.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Card(
              color: MyColors.regColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: webImage(
                                imageUrl: controller.appointmentRating[index]
                                        .memberData?.first.filePath ??
                                    "",
                                fit: BoxFit.fill,
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            capitalizeFirstLetter(controller
                                    .appointmentRating[index]
                                    .memberData
                                    ?.first
                                    .displayName ??
                                ""),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        RatingBarIndicator(
                          rating: 4.5,
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
                    Text(
                      capitalizeFirstLetter(controller
                              .appointmentRating[index].reviewDescription ??
                          ""),
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///Before Registration Pop up
  showPopup() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            alignment: Alignment.center,
            title: Text(
              "Continue To Us",
              style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "Please Signup or Signin",
              style: TextStyle(
                fontFamily: MyFont.myFont,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.toNamed(Routes.loginScreen);
                  },
                  child: Text(
                    "Signin",
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                    ),
                  )),
            ],
          );
        });
  }
}
