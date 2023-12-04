import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../Const/approute.dart';
import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Helper/extension.dart';
import '../../../../Model/FeaturedServicesModel.dart';
import 'featuredservicesbusinesscontroller.dart';

class FeaBusSplScreen extends StatefulWidget {
  const FeaBusSplScreen({super.key});

  @override
  State<FeaBusSplScreen> createState() => _FeaBusSplScreenState();
}

class _FeaBusSplScreenState extends State<FeaBusSplScreen> {
  late FeaturedBusSplController controller;
  FeaturedServicesModel? featureServiceList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(FeaturedBusSplController());
    featureServiceList = Get.arguments as FeaturedServicesModel;
    function();
  }

  function() async {
    await controller.getFeaturedServices(featureServiceList?.serviceId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeaturedBusSplController>(builder: (logic) {
      if (logic.isLoading == true) {
        return Scaffold(
          body: Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                  color: MyColors.primaryCustom, size: 20)),
        );
      }

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                "FEATURED SERVICES",
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
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    (controller.isBusinessClick.value)
                        ? businessListView()
                        : (controller.isSpecialistClick.value)
                            ? specialistListView()
                            : Container()
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  ///Specialist List View
  specialistListView() {
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
              return GestureDetector(
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
                                        Assets.profile,
                                    fit: BoxFit.fill,
                                  )),
                            )),
                          ),
                        ),
                        const SizedBox(width: 15),
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
                                                .specilistName ??
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
                                        3.5,
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
                ),
              );
            }),
      ],
    );
  }

  ///Business List View
  businessListView() {
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
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.aboutBusiness,
                      arguments: controller.businessList[index]);
                  // );
                },
                child: Card(
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
                                            .businessList[index].filePath ??
                                        Assets.profile,
                                    fit: BoxFit.fill,
                                  )),
                            )),
                          ),
                        ),
                        const SizedBox(width: 15),
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
                                        controller.businessList[index]
                                                .businessName ??
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
                                        3.5,
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
                                      controller
                                              .businessList[index].businessId ??
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
                ),
              );
            }),
      ],
    );
  }
}
