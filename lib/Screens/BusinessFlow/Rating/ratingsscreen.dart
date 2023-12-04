import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Model/userdetailmodel.dart';
import 'package:top_20/Screens/BusinessFlow/Rating/ratingcontroller.dart';
import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Helper/extension.dart';
import '../../../Helper/preferenceHelper.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  var businessId;
  BusinessDetailsModel? businessDetailsModel;

  initialiseData() async {
    businessDetailsModel = await PreferenceHelper.getBusinessData();
    setState(() {
      businessId = businessDetailsModel?.businessId;
    });
  }

  late RatingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiseData();
    controller = Get.put(RatingController());
    controller.intialfunc();
  }

  String text = lorem(paragraphs: 1, words: 60);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingController>(builder: (logic) {
      if (logic.isLoading == true) {
        return Scaffold(
          body: Center(
            child: LoadingAnimationWidget.threeRotatingDots(
                color: MyColors.primaryCustom, size: 20),
          ),
        );
      }

      return DefaultTabController(
        length: 2,
        child: Scaffold(
            body: (controller.appointmentRating.isNotEmpty)
                ? CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        expandedHeight: 300,
                        pinned: true,
                        leading: IconButton(
                            onPressed: () {
                              if (PreferenceHelper.isSpecialist) {
                                Get.offAllNamed(Routes.specialistBottomNavBar);
                              } else {
                                Get.offAllNamed(Routes.businessBottomNavBar);
                              }
                            },
                            icon:
                                const Icon(Icons.arrow_back_ios_new_outlined)),
                        title: Text(
                          "MY RATINGS",
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                          ),
                        ),
                        centerTitle: true,
                        flexibleSpace: FlexibleSpaceBar(
                            background: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: webImage(
                                    imageUrl:
                                        businessDetailsModel?.logoFilePath ??
                                            '',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Flexible(
                                child: Text(
                                  capitalizeFirstLetter(
                                      businessDetailsModel?.displayName ?? ""),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: MyColors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Flexible(
                                child: Text(
                                  businessDetailsModel?.emailId ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: MyColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ),
                      SliverToBoxAdapter(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ratings & Reviews",
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: _SliverAppBarDelegate(
                          TabBar(
                            tabs: [
                              Tab(
                                child: Text(
                                  "OPEN",
                                  style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.primaryCustom),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "APPOINTMENT",
                                  style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.primaryCustom),
                                ),
                              ),
                            ],
                          ),
                        ),
                        pinned: true,
                      ),
                      SliverFillRemaining(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
                          child: TabBarView(
                            children: [
                              SizedBox(
                                  child: (controller.userBusinessRatingList !=
                                          null)
                                      ? businessOpenReview()
                                      : Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 50),
                                            child: Text(
                                              "No Reviews",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: MyFont.myFont,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: MyColors.darkGrey,
                                              ),
                                            ),
                                          ),
                                        )),
                              SizedBox(
                                  child: (controller
                                          .appointmentRating.isNotEmpty)
                                      ? businessReview()
                                      : Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 50),
                                            child: Text(
                                              "No Reviews",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: MyFont.myFont,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: MyColors.darkGrey,
                                              ),
                                            ),
                                          ),
                                        )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Assets.noData),
                      const SizedBox(height: 20),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Back To Home",
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ))
                    ],
                  ))),
      );
    });
  }

  businessReview() {
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
                                  fit: BoxFit.fill)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            controller.appointmentRating[index].memberData
                                    ?.first.displayName ??
                                "",
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
                          rating:
                              controller.appointmentRating[index].ratingValue ??
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
                          .appointmentRating[index].reviewDescription),
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

  ///Business Open Review List
  businessOpenReview() {
    return ListView.builder(
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.userBusinessRatingList?.length,
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
                                    .userBusinessRatingList?[index]
                                    .displayName ??
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
                          rating: controller
                                  .userBusinessRatingList?[index].ratingValue ??
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
                              .userBusinessRatingList?[index]
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
        });
  }
}

///TabBar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
