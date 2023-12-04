import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../Const/approute.dart';
import '../../../Const/colors.dart';
import '../../../Const/font.dart';
import '../../../Const/size.dart';
import '../../../Helper/extension.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/Member_details_model.dart';
import 'GetFavBusinessController.dart';

class GetUserFavBusiness extends StatefulWidget {
  const GetUserFavBusiness({Key? key}) : super(key: key);

  @override
  State<GetUserFavBusiness> createState() => _GetUserFavBusinessState();
}

class _GetUserFavBusinessState extends State<GetUserFavBusiness> {
  var memberId;
  MemberDetails? memberDetails;
  late GetFavBusinessController controller;

  _initialiseData() async {
    memberDetails = await PreferenceHelper.getMemberData();
    setState(() {
      memberId = memberDetails?.memberId;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = Get.put(GetFavBusinessController())
      ..getFavouriteBusinessList();
    _initialiseData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetFavBusinessController>(
      builder: (logic) {
        if (logic.isLoading == true) {
          return Scaffold(
            body: Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: MyColors.primaryCustom,
                size: 20,
              ),
            ),
          );
        }
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  "MY FAVOURITE BUSINESS",
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
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 100, 20, 10),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: webImage(
                              imageUrl: memberDetails?.FilePath ?? '',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                capitalizeFirstLetter(memberDetails?.memberName ?? ""),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: MyColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      favBusinessListView(),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget favBusinessListView() {
    return (controller.businessList.isNotEmpty)
        ? ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.businessList.length,
      itemBuilder: (BuildContext context, index) {
        return InkWell(
          onTap: () {
            Get.toNamed(Routes.aboutBusiness, arguments: controller.businessList[index]);
          },
          child: Card(
            color: MyColors.scaffold,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: webImage(imageUrl: controller.businessList[index].filePath ?? ''),
                          ),
                        ),
                      ),
                    ),
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
                                capitalizeFirstLetter(controller.businessList[index].displayName ?? ""),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            RatingBarIndicator(
                              rating: controller.businessList[index].ratingValue ?? 3.0,
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
                                controller.businessList[index].businessCategoryName ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            if (memberDetails != null)
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    controller.businessList[index].isFavourite =
                                    !controller.businessList[index].isFavourite;
                                    controller.changeBusinessFavourite(
                                      businessListUserViewModel: controller.businessList[index],
                                      memberId: memberId,
                                      isFav: !controller.businessList[index].isFavourite,
                                    );
                                  });
                                },
                                icon: Icon(
                                  controller.businessList[index].isFavourite
                                      ? Icons.favorite_outline_rounded
                                      : Icons.favorite_outlined,
                                  color: MyColors.primaryCustom,
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
          ),
        );
      },
    )
        : Padding(
      padding: const EdgeInsets.symmetric(vertical: 250),
      child: Text(
        "No Favourite Business",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: MyFont.myFont,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: MyColors.darkGrey,
        ),
      ),
    );
  }
}
