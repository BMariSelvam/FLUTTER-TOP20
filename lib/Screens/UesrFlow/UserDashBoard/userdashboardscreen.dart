import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Const/size.dart';
import 'package:top_20/Screens/UesrFlow/UserDashBoard/userdashboardcontroller.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Helper/extension.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/Member_details_model.dart';
import '../../../Model/appointmentmodel.dart';
import '../../../Model/bannermodel.dart';
import '../FavoriteSpecialistAndBusiness/favbusiness.dart';
import '../UserProfile/ResetPassword/resetpasswordscreen.dart';
import '../UserRatingsandReview/userratingsandreviewcontroller.dart';

class UserDashBoardScreen extends StatefulWidget {
  const UserDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<UserDashBoardScreen> createState() => _UserDashBoardScreenState();
}

class _UserDashBoardScreenState extends State<UserDashBoardScreen> {
  final image = [
    Assets.userSpecialist,
    Assets.userBusiness,
  ];

  final heading = [
    "Top Twenty",
    "Top Twenty",
  ];

  final head = [
    "SPECIALIST",
    "BUSINESS",
  ];

  final featureImage = [
    Assets.img1,
    Assets.img2,
    Assets.img3,
    Assets.img4,
    Assets.img5,
    Assets.img6,
  ];

  final featureServices = [
    "SALON & LASER CLINIC",
    "AC SERVICE & REPAIR",
    "CLEANING PEST CONTROL",
    "FURNITURE & REPAIR",
    "ELECTRICIAN & PLUMBER",
    "WALL & PAINTING",
  ];

  var memberId;
  MemberDetails? memberDetails;

  late UserDashboardController controller;
  late UserRatingAndReviewController userRatingAndReviewController;
  List<BannerModel> bannerImage = [];

  @override
  void initState() {
    print("===============3");
    // TODO: implement initState
    super.initState();
    _initialiseData();
    controller = Get.put(UserDashboardController());
    controller.userBannerGet();
    controller.userAdvertisementGet();
    controller.getUserAllAppointments();
    controller.getFeaturedServices();
    // appointmentOpen = controller.appointmentList
    //     .where((element) => (element.status != 5 && element.status != 6))
    //     .toList();
  }

  _initialiseData() async {
    memberDetails = await PreferenceHelper.getMemberData();
    setState(() {
      memberId = memberDetails?.memberId;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserDashboardController>(builder: (logic) {
      if (logic.isLoading == true) {
        return Scaffold(
          body: Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                  color: MyColors.primaryCustom, size: 20)),
        );
      }
      return Scaffold(
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: MyColors.primaryCustom,
              expandedHeight: 300,
              pinned: true,
              leading: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer(); // Open the drawer
                  },
                  icon: Image.asset(Assets.menu)),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_outlined)),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      (memberId != null)
                          ? Get.toNamed(Routes.userProfileScreen)
                          : Get.toNamed(Routes.loginScreen);
                    },
                    child: Center(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: SizedBox(
                          height: 35,
                          width: 35,
                          child: webImage(
                            imageUrl: memberDetails?.FilePath ?? '',
                          )),
                    )),
                  ),
                ),
              ],

              flexibleSpace: FlexibleSpaceBar(
                background: (controller.bannerImageListfiltter.value != null)
                    ? Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              print(controller.currentIndex);
                            },
                            child: CarouselSlider(
                              items: controller.bannerImageListfiltter.value
                                  ?.map(
                                    (item) => CachedNetworkImage(
                                      imageUrl: item.bannerImageFilePath ?? '',
                                      fit: BoxFit.cover,
                                      width: double.maxFinite,
                                    ),
                                  )
                                  .toList(),
                              carouselController: controller.carouselController,
                              options: CarouselOptions(
                                scrollPhysics: const BouncingScrollPhysics(),
                                autoPlay: true,
                                aspectRatio: 0.6,
                                height: double.infinity,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    controller.currentIndex = index;
                                  });
                                },
                              ),
                            ),
                          ),
                          // Positioned(
                          //   bottom: 10,
                          //   left: 0,
                          //   right: 0,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: controller.bannerImageList.value!
                          //         .asMap()
                          //         .entries
                          //         .map((entry) {
                          //       return GestureDetector(
                          //         onTap: () => controller.carouselController
                          //             .animateToPage(entry.key),
                          //         child: Container(
                          //           width: controller.currentIndex == entry.key
                          //               ? 17
                          //               : 7,
                          //           height: 7.0,
                          //           margin: const EdgeInsets.symmetric(
                          //             horizontal: 3.0,
                          //           ),
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(10),
                          //               color:
                          //                   controller.currentIndex == entry.key
                          //                       ? MyColors.mainTheme
                          //                       : Colors.white),
                          //         ),
                          //       );
                          //     }).toList(),
                          //   ),
                          // ),
                        ],
                      )
                    : Container(),
                // background: Image.asset(
                //   Assets.banner,
                //   fit: BoxFit.fill,
                // ),
              ),
              // bottom: PreferredSize(
              //   preferredSize: Size.fromHeight(20),
              //   child: Container(
              //     width: double.maxFinite,
              //     padding: EdgeInsets.only(top: 5, bottom: 10),
              //     decoration: BoxDecoration(
              //       color: MyColors
              //           .white, // Set your desired background color here
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(30),
              //         topRight: Radius.circular(30),
              //       ),
              //     ),
              //     child: Center(
              //       child: Text(" "),
              //     ),
              //   ),
              // ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView(
                      padding: const EdgeInsets.all(0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // childAspectRatio: 1.3,
                        mainAxisExtent: 150.0,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.userBusinessListScreen);
                          },
                          child: Card(
                            color: MyColors.card2,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(5.0),
                            )),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(Assets.userBusiness),
                                  const SizedBox(height: 10),
                                  Text("Top Twenty",
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.black,
                                      )),
                                  const SizedBox(height: 10),
                                  Text('BUSINESS',
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: MyColors.black,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.userSpecialistScreen);
                          },
                          child: Card(
                            color: MyColors.card1,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                              bottomLeft: Radius.circular(5.0),
                              bottomRight: Radius.circular(30.0),
                            )),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(Assets.userSpecialist),
                                  const SizedBox(height: 10),
                                  Text("Top Twenty",
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.black,
                                      )),
                                  const SizedBox(height: 10),
                                  Text('SPECIALIST',
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: MyColors.black,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.nearByScreen);
                      },
                      child: Card(
                        color: MyColors.card3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Image.asset(Assets.nearby),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Top Twenty",
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "NEARBY LOCATION",
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    (memberId != null)
                        ? const SizedBox(height: 20)
                        : const SizedBox(),
                    (memberId != null)
                        ? Text(
                            "My Favourite",
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        : Container(),
                    (memberId != null)
                        ? const SizedBox(height: 20)
                        : const SizedBox(),
                    (memberId != null)
                        ? GridView(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2,
                            ),
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              const GetUserFavBusiness()));
                                },
                                child: Card(
                                  elevation: 0,
                                  color: MyColors.fav1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(Assets.fav1),
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
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.getUserFavSpecialList);
                                },
                                child: Card(
                                  elevation: 0,
                                  color: MyColors.fav2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(Assets.fav2),
                                        Text(
                                          "Specialist",
                                          style: TextStyle(
                                            fontFamily: MyFont.myFont,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Container(),
                    (memberId != null)
                        ? const SizedBox(height: 20)
                        : const SizedBox(),
                    (memberId != null && controller.appointmentOpen.isNotEmpty)
                        ? Text(
                            "Recent Booking",
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        : const SizedBox(),
                    (memberId != null && controller.appointmentOpen.isNotEmpty)
                        ? const SizedBox(height: 20)
                        : const SizedBox(),
                    (memberId != null && controller.appointmentOpen.isNotEmpty)
                        ? SizedBox(
                            height: height(context) / 4,
                            child: recentBooking(),
                          )
                        : const SizedBox(),
                    (memberId != null)
                        ? const SizedBox(height: 20)
                        : const SizedBox(),
                    (controller.featuredServices.isNotEmpty)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Featured Services",
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.featuredServicesScreen);
                                  },
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                    ),
                                  ))
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: 10),
                    GridView.builder(
                        itemCount: (controller.featuredServices.length >= 6)
                            ? 6
                            : controller.featuredServices.length,
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 170.0,
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: 300,
                                  child: Image.asset(
                                    Assets.card,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: webSerImage(
                                              imageUrl: controller
                                                      .featuredServices[index]
                                                      .filePath ??
                                                  Assets.service,
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        controller.featuredServices[index]
                                                .serviceName
                                                ?.toUpperCase() ??
                                            " ",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(height: 20),
                    (controller.advertisementFiltter.isNotEmpty)
                        ? Text(
                            "Offer",
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    (controller.advertisementFiltter.isNotEmpty)
                        ? SizedBox(height: 150, child: OffersListView())
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: MyColors.fav1,
                ),
                child: Center(
                  child: SizedBox(height: 100, child: Image.asset(Assets.logo)),
                ),
              ),
              memberId != null
                  ? ListTile(
                      onTap: () {
                        Get.toNamed(Routes.editProfileScreen);
                      },
                      leading: Icon(
                        Icons.person,
                        color: MyColors.primaryCustom,
                      ),
                      title: Text(
                        "Profile Update",
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontSize: 18,
                        ),
                      ),
                    )
                  : Container(),
              memberId != null
                  ? ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const ResetPassword()));
                      },
                      leading: Icon(
                        Icons.lock,
                        color: MyColors.primaryCustom,
                      ),
                      title: Text(
                        "Change Password",
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontSize: 18,
                        ),
                      ),
                    )
                  : Container(),
              ListTile(
                onTap: () async {
                  await PreferenceHelper.clearUserData();
                  Get.offAllNamed(Routes.loginScreen);
                },
                leading: Icon(
                  memberId != null ? Icons.logout : Icons.login,
                  color: MyColors.primaryCustom,
                ),
                title: Text(
                  memberId != null ? "Logout" : "Login",
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget OffersListView() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.advertisementFiltter.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                SizedBox(
                  height: 150,
                  width: 125,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: webImage(
                          imageUrl: controller
                                  .advertisementFiltter[index].imageFilePath ??
                              '')

                      //Image.asset(Assets.coffee
                      // imageList[index],
                      ),
                ),
              ],
            ),
          );
        });
  }

  recentBooking() {
    return ListView.builder(
        shrinkWrap: false,
        padding: const EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
        itemCount: controller.appointmentOpen.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print('Tapped on item $index');
              Get.toNamed(Routes.userAppointmentDetailScreen,
                  arguments: controller.appointmentOpen[index]);
            },
            child: SizedBox(
              width: width(context) / 2.5,
              child: Card(
                elevation: 0,
                color: MyColors.lightGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SizedBox(
                              height: 80,
                              width: 80,
                              child: (controller.appointmentOpen[index]
                                          .businessData !=
                                      null)
                                  ? webImage(
                                      imageUrl: controller
                                              .appointmentOpen[index]
                                              .businessData
                                              ?.first
                                              .logoFilePath ??
                                          '',
                                      fit: BoxFit.fill,
                                    )
                                  : webImage(
                                      imageUrl: controller
                                              .appointmentOpen[index]
                                              .specialistData
                                              ?.first
                                              .filePath ??
                                          '',
                                      fit: BoxFit.fill,
                                    )),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // RatingBarIndicator(
                      //   rating: (appointmentOpen[index].businessData != null)
                      //       ? '${
                      //           appointmentOpen[index]
                      //                   .businessData
                      //                   ?.first
                      //                   .ratingValue ??
                      //               "4.2"
                      //         }'
                      //       : '${
                      //           appointmentOpen[index]
                      //                   .specialistData
                      //                   ?.first
                      //                   .ratingValue ??
                      //               "4.2"
                      //         }',
                      //   itemBuilder: (context, index) => Icon(
                      //     Icons.star,
                      //     color: MyColors.primaryCustom,
                      //   ),
                      //   itemCount: 5,
                      //   itemSize: 20.0,
                      // ),
                      const SizedBox(height: 10),
                      Text(
                        capitalizeFirstLetter(
                            (controller.appointmentOpen[index].businessData !=
                                    null)
                                ? controller.appointmentOpen[index].businessData
                                        ?.first.businessName ??
                                    ""
                                : controller.appointmentOpen[index]
                                        .specialistData?.first.displayName ??
                                    ""),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        (controller.appointmentOpen[index].businessData != null)
                            ? controller.appointmentOpen[index].businessData
                                    ?.first.businessId ??
                                ""
                            : controller.appointmentOpen[index].specialistData
                                    ?.first.specialistId ??
                                "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
