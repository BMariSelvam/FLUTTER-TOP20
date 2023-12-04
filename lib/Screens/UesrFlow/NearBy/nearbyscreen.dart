import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Const/size.dart';

import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Const/font.dart';
import '../../../Helper/extension.dart';
import 'nearbycontroller.dart';

class NearByScreen extends StatefulWidget {
  const NearByScreen({Key? key}) : super(key: key);

  @override
  State<NearByScreen> createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  late NearByController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(NearByController())
      ..getSpecialistList()
      ..getBusinessList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NearByController>(builder: (logic) {
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
                "NEARBY LOCATION",
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
                    child: GridView(
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
                            setState(() {
                              if (controller.isBusinessClick.value = true) {
                                controller.isSpecialistClick.value = false;
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: controller.isBusinessClick.value
                                  ? MyColors.fav1
                                  : MyColors.primaryCustom,
                              shape: RoundedRectangleBorder(
                                  side: controller.isBusinessClick.value
                                      ? BorderSide.none
                                      : const BorderSide(color: MyColors.white),
                                  borderRadius: BorderRadius.circular(20.0)),
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
                                        color: controller.isBusinessClick.value
                                            ? MyColors.black
                                            : MyColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (controller.isSpecialistClick.value = true) {
                                controller.isBusinessClick.value = false;
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation:
                                  controller.isBusinessClick.value ? 0 : 10,
                              color: controller.isSpecialistClick.value
                                  ? MyColors.fav2
                                  : MyColors.primaryCustom,
                              shape: RoundedRectangleBorder(
                                  side: controller.isSpecialistClick.value
                                      ? BorderSide.none
                                      : const BorderSide(color: MyColors.white),
                                  borderRadius: BorderRadius.circular(20.0)),
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
                                        color:
                                            controller.isSpecialistClick.value
                                                ? MyColors.black
                                                : MyColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    controller.isBusinessClick.value
                        ? nearbyLocationBusinessListView()
                        : nearbyLocationSpecialistListView()
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  nearbyLocationSpecialistListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Specialist",
          style: TextStyle(
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.specialistList.length,
            itemBuilder: (context, index) {
              return Card(
                color: MyColors.scaffold,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                      const SizedBox(width: 15),
                      Flexible(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  rating: controller
                                          .specialistList[index].ratingValue ??
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                // IconButton(
                                //     onPressed: () {
                                //       setState(() {
                                //         // controller.specialistList.isfavourite =
                                //         //     !widget.specialistListModel.isfavourite;
                                //         // _userFavController.changeSpecialistFavourite(
                                //         //   specialistListModel:
                                //         //       widget.specialistListModel,
                                //         //   memberId: memberId,
                                //         //   isFav: widget.specialistListModel.isfavourite,
                                //         //);
                                //       });
                                //     },
                                //     icon: Icon(
                                //       Icons.favorite_outline_rounded,
                                //       color: MyColors.primaryCustom,
                                //     )),
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
            }),
      ],
    );
  }

  nearbyLocationBusinessListView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Business",
          style: TextStyle(
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 20),
        ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.businessList.length,
            itemBuilder: (context, index) {
              return Card(
                color: MyColors.scaffold,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                  imageUrl:
                                      controller.businessList[index].filePath ??
                                          "",
                                )),
                          )),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Flexible(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    capitalizeFirstLetter(
                                      controller.businessList[index]
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
                                  rating: controller
                                          .businessList[index].ratingValue ??
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    controller.businessList[index]
                                            .businessCategoryName ??
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
                                // IconButton(
                                //     onPressed: () {
                                //       setState(() {
                                //         // controller.specialistList.isfavourite =
                                //         //     !widget.specialistListModel.isfavourite;
                                //         // _userFavController.changeSpecialistFavourite(
                                //         //   specialistListModel:
                                //         //       widget.specialistListModel,
                                //         //   memberId: memberId,
                                //         //   isFav: widget.specialistListModel.isfavourite,
                                //         //);
                                //       });
                                //     },
                                //     icon: Icon(
                                //       Icons.favorite_outline_rounded,
                                //       color: MyColors.primaryCustom,
                                //     )),
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
            }),
      ],
    );
  }
}
