import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Const/size.dart';
import 'package:top_20/Helper/extension.dart';
import 'package:top_20/Screens/UesrFlow/UserRatingsandReview/userratingsandreviewcontroller.dart';
import 'package:top_20/Widget/dottedline.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Const/font.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/Member_details_model.dart';
import '../../../Model/appointmentmodel.dart';
import '../../../Widget/submitbutton.dart';
import '../UserBottomNavBar/userbottomnavbar.dart';

class UserRatingsAndReviewsScreen extends StatefulWidget {
  const UserRatingsAndReviewsScreen({Key? key}) : super(key: key);

  @override
  State<UserRatingsAndReviewsScreen> createState() =>
      _UserRatingsAndReviewsScreenState();
}

class _UserRatingsAndReviewsScreenState
    extends State<UserRatingsAndReviewsScreen> {
  late UserRatingAndReviewController controller;

  var memberId;

  MemberDetails? memberDetails;

  _initialiseData() async {
    await PreferenceHelper.getMemberData().then((value) {
      setState(() {
        memberDetails = value;
        memberId = memberDetails?.memberId;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialiseData();
    print("===============2");
    controller = Get.put(UserRatingAndReviewController());
    controller.getUserAllAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserRatingAndReviewController>(builder: (logic) {
      if (logic.isLoading == true) {
        return Center(
          child: LoadingAnimationWidget.threeRotatingDots(
              color: MyColors.primaryCustom, size: 20),
        );
      }
      return WillPopScope(
        onWillPop: () async {
          //Get.back();
          controller.dispose();
          return true; // Allow back navigation
        },
        child: Scaffold(
          body: (controller.appointmentList.isNotEmpty)
              ? CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text(
                        "APPOINTMENT",
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                        ),
                      ),
                      centerTitle: true,
                      expandedHeight: 250,
                      pinned: true,
                      leading: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => UserBottomNavBar()));
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
                                        if (controller
                                            .isAppointmentClick.value = true) {
                                          controller.isCompletedClick.value =
                                              false;
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color:
                                            controller.isAppointmentClick.value
                                                ? MyColors.white
                                                : MyColors.textFieldTheme,
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: MyColors.white),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: Center(
                                          child: Text(
                                            "Booking",
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              color: controller
                                                      .isAppointmentClick.value
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
                                        if (controller.isCompletedClick.value =
                                            true) {
                                          controller.isAppointmentClick.value =
                                              false;
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: controller.isCompletedClick.value
                                            ? MyColors.white
                                            : MyColors.textFieldTheme,
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: MyColors.white),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: Center(
                                          child: Text(
                                            "Completed",
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              color: controller
                                                      .isCompletedClick.value
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
                        child: SingleChildScrollView(
                            padding: const EdgeInsets.all(10.0),
                            child: controller.isAppointmentClick.value
                                ? appointmentListView()
                                : completedListView()))
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Appointment Found Here",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: MyColors.darkGrey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.userBottomNavBar);
                          },
                          child: Text(
                            "Back To Home",
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ))
                    ],
                  ),
                ),
        ),
      );
    });
  }

  appointmentListView() {
    return GetBuilder<UserRatingAndReviewController>(builder: (logic) {
      return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.appointmentOpen.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.userAppointmentDetailScreen,
                    arguments: controller.appointmentOpen[index]);
              },
              child: SizedBox(
                child: Column(
                  children: [
                    Card(
                      elevation: 0,
                      color: MyColors.scaffold,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width(context) / 2,
                                      child: Text(
                                          "${(controller.appointmentOpen[index].businessData != null) ? controller.appointmentOpen[index].businessData?.first.displayName : controller.appointmentOpen[index].specialistData?.first.displayName}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: MyFont.myFont,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: MyColors.black,
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // SizedBox(
                                    //     height: 20,
                                    //     child: Image.asset(Assets.coin)),
                                    Text(
                                      '${controller.appointmentOpen[index].totailCoinsPaid}',
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "AED",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: MyColors.darkGrey,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Appointment No : ',
                                                style: TextStyle(
                                                  fontFamily: MyFont.myFont,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: MyColors.black,
                                                )),
                                            TextSpan(
                                                text: controller
                                                    .appointmentOpen[index]
                                                    .appoinmentNo,
                                                style: TextStyle(
                                                  fontFamily: MyFont.myFont,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: MyColors.grey,
                                                ))
                                          ])),
                                      const SizedBox(height: 10),
                                      RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Date : ',
                                                style: TextStyle(
                                                  fontFamily: MyFont.myFont,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: MyColors.black,
                                                )),
                                            TextSpan(
                                              text: DateFormat('dd-MM-yyyy')
                                                  .format(
                                                DateTime.parse(controller
                                                        .appointmentOpen[index]
                                                        .appoinmentDate ??
                                                    ''),
                                              ),
                                              style: TextStyle(
                                                fontFamily: MyFont.myFont,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: MyColors.grey,
                                              ),
                                            )
                                          ])),
                                    ],
                                  ),
                                ),
                                Card(
                                  color: controller
                                              .appointmentOpen[index].status ==
                                          2
                                      ? controller.appointmentOpen[index]
                                                  .status ==
                                              3
                                          ? Colors.yellow
                                          : Colors.green
                                      : controller.appointmentOpen[index]
                                                  .status ==
                                              3
                                          ? Colors.yellow
                                          : MyColors.primaryCustom,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Text(
                                      controller.appointmentOpen[index]
                                                  .status ==
                                              2
                                          ? controller.appointmentOpen[index]
                                                      .status ==
                                                  3
                                              ? "Reschedule"
                                              : "Confirmed"
                                          : controller.appointmentOpen[index]
                                                      .status ==
                                                  3
                                              ? "Reschedule"
                                              : "Requested",
                                      style: const TextStyle(
                                          color: MyColors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    DottedHorizontalLine(
                      color: MyColors.grey,
                      dotWidth: 10,
                      dotSpacing: 10,
                    )
                  ],
                ),
              ),
            );
          });
    });
  }

  completedListView() {
    return GetBuilder<UserRatingAndReviewController>(builder: (logic) {
      return (controller.appointmentCompleted.isNotEmpty)
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemCount: controller.appointmentCompleted.length,
              itemBuilder: (context, index) {
                // controller.appointmentCompleted[index] = controller.appointmentCompleted[index].copyWith(status: 5);
                return Column(
                  children: [
                    Card(
                      elevation: 0,
                      color: MyColors.scaffold,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width(context) / 3,
                                  child: Text(
                                    '${(controller.appointmentCompleted[index].businessData != null) ? controller.appointmentCompleted[index].businessData?.first.displayName : controller.appointmentCompleted[index].specialistData?.first.displayName}',
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: MyColors.black,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    // SizedBox(
                                    //     height: 20,
                                    //     child: Image.asset(Assets.coin)),
                                    Text(
                                      '${controller.appointmentCompleted[index].totailCoinsPaid}',
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "AED",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: MyColors.darkGrey,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Appointment No : ',
                                                style: TextStyle(
                                                  fontFamily: MyFont.myFont,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: MyColors.black,
                                                )),
                                            TextSpan(
                                                text: controller
                                                    .appointmentCompleted[index]
                                                    .appoinmentNo,
                                                style: TextStyle(
                                                  fontFamily: MyFont.myFont,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: MyColors.grey,
                                                ))
                                          ])),
                                      const SizedBox(height: 10),
                                      RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Date : ',
                                                style: TextStyle(
                                                  fontFamily: MyFont.myFont,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: MyColors.black,
                                                )),
                                            TextSpan(
                                                text: formatDate(controller
                                                    .appointmentCompleted[index]
                                                    .appoinmentDate),
                                                style: TextStyle(
                                                  fontFamily: MyFont.myFont,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: MyColors.grey,
                                                ))
                                          ])),
                                    ],
                                  ),
                                ),
                                Card(
                                  color: (controller.appointmentCompleted[index]
                                              .status ==
                                          5)
                                      ? controller.appointmentCompleted[index]
                                                  .status ==
                                              6
                                          ? MyColors.primaryCustom
                                          : Colors.green
                                      : Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Text(
                                      (controller.appointmentCompleted[index]
                                                  .status ==
                                              5)
                                          ? "Completed"
                                          : "Cancelled",
                                      style: const TextStyle(
                                          color: MyColors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            (controller.appointmentCompleted[index].status == 5)
                                ? (controller.appointmentCompleted[index]
                                            .isReviewReceived ==
                                        false)
                                    ? Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _displayRatingDialog(controller
                                                .appointmentCompleted[index]);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: MyColors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            side: const BorderSide(
                                                color: MyColors.grey),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 8),
                                            child: Text(
                                              'Rate Booking',
                                              style: TextStyle(
                                                  fontFamily: MyFont.myFont,
                                                  color:
                                                      MyColors.primaryCustom),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Your Rating',
                                              style: TextStyle(
                                                fontFamily: MyFont.myFont,
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.black,
                                              )),
                                          AbsorbPointer(
                                            absorbing: true,
                                            child: RatingBar(
                                                initialRating: controller
                                                        .appointmentCompleted[
                                                            index]
                                                        .ratingValue ??
                                                    2,
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
                                                onRatingUpdate: (value) {}),
                                          ),
                                        ],
                                      )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                    DottedHorizontalLine(
                      color: MyColors.grey,
                      dotSpacing: 10,
                      dotWidth: 10,
                    )
                  ],
                );
              })
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Appointment Found Here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: MyColors.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.userBottomNavBar);
                      },
                      child: Text(
                        "Back To Home",
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ))
                ],
              ),
            );
    });
  }

  Future<void> _displayRatingDialog(Appointment appointment) async {
    controller.reviewController.clear();
    controller.ratingValue = null;
    var _key = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: const Text("Rate And Review"),
            content: Form(
              key: _key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RatingBar(
                      initialRating: 0,
                      itemSize: 25,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                          full: const Icon(Icons.star, color: Colors.orange),
                          half: const Icon(
                            Icons.star_half,
                            color: Colors.orange,
                          ),
                          empty: const Icon(
                            Icons.star_outline,
                            color: Colors.orange,
                          )),
                      onRatingUpdate: (value) {
                        controller.ratingValue = value;
                      }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 2, 20),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      controller: controller.reviewController,
                      inputFormatters: [NoInitialSpaceFormatter()],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: "Write review",
                      ),
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "Review can't be empty";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: SubmitButton(
                        isLoading: false,
                        onTap: () async {
                          if (controller.ratingValue == null) {
                            Get.snackbar(
                              "Error",
                              "Please give star rating",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else if (controller.reviewController.text.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Please write review",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else {
                            await controller.postRating(
                                appointment: appointment);
                          }
                        },
                        title: 'Submit'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
