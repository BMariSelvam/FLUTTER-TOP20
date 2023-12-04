import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../Const/approute.dart';
import '../../../Const/colors.dart';
import '../../../Const/font.dart';

import '../../../Helper/extension.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/Member_details_model.dart';
import 'GetFavSpecialistController.dart';

class GetUserFavSpecialList extends StatefulWidget {
  const GetUserFavSpecialList({Key? key}) : super(key: key);

  @override
  State<GetUserFavSpecialList> createState() => _GetUserFavSpecialListState();
}

class _GetUserFavSpecialListState extends State<GetUserFavSpecialList> {
  var memberId;
  MemberDetails? memberDetails;
  late GetFavSpecialistController controller;

  _initialiseData() async {
    memberDetails = await PreferenceHelper.getMemberData();
    setState(() {
      memberId = memberDetails?.memberId;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialiseData();
    controller = Get.put(GetFavSpecialistController())
      ..getFavouriteSpeicialistList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetFavSpecialistController>(builder: (logic) {
      if (logic.isLoading == true) {
        return Scaffold(
          body: Center(
            child: LoadingAnimationWidget.threeRotatingDots(
                color: MyColors.primaryCustom, size: 20),
          ),
        );
      }
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                "MY FAVOURITE SPECIALIST",
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
                            )),
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              capitalizeFirstLetter(
                                  memberDetails?.memberName ?? ""),
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
                    SizedBox(
                      child: favSpecialistListView(),
                    )
                    // favSpecialistListView(),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  favSpecialistListView() {
    return (controller.specialistList.isNotEmpty)
        ? ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.specialistList.length,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.aboutSpecialistScreen,
                      arguments: controller.specialistList[index]);
                },
                child: Card(
                  color: MyColors.scaffold,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                                  child: webImage(
                                    imageUrl: controller
                                            .specialistList[index].filePath ??
                                        "",
                                  )),
                            )),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      capitalizeFirstLetter(
                                        controller.specialistList[index]
                                                .displayName ??
                                            "",
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  RatingBarIndicator(
                                    rating: controller.specialistList[index]
                                            .ratingValue ??
                                        4,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      controller.specialistList[index]
                                              .businessCategoryname ??
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
                                  (memberDetails != null)
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              controller.specialistList[index]
                                                      .isfavourite =
                                                  !controller
                                                      .specialistList[index]
                                                      .isfavourite;
                                              print("1111111111");
                                              print(controller
                                                  .specialistList[index]
                                                  .isfavourite);
                                              controller
                                                  .changeSpecialistFavourite(
                                                specialistListModel: controller
                                                    .specialistList[index],
                                                memberId: memberId,
                                                isFav: !controller
                                                    .specialistList[index]
                                                    .isfavourite,
                                              );
                                            });
                                          },
                                          icon: Icon(
                                            (controller.specialistList[index]
                                                    .isfavourite)
                                                ? Icons.favorite_outline_rounded
                                                : Icons.favorite_outlined,
                                            color: MyColors.primaryCustom,
                                          ))
                                      : Container(),
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
            })
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 250),
            child: Text(
              "No Favourite Specialist",
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
