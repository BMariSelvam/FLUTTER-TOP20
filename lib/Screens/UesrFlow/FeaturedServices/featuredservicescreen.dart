import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Const/font.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Helper/extension.dart';
import 'featuredservicecontroller.dart';

class FeaturedServicesScreen extends StatefulWidget {
  const FeaturedServicesScreen({super.key});

  @override
  State<FeaturedServicesScreen> createState() => _FeaturedServicesScreenState();
}

class _FeaturedServicesScreenState extends State<FeaturedServicesScreen> {
  late FeaturedServicesController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(FeaturedServicesController());
    controller.getFeaturedServices();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeaturedServicesController>(builder: (logic) {
      if (logic.isLoading == true) {
        return Scaffold(
          body: Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                  color: MyColors.primaryCustom, size: 20)),
        );
      }

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: Text(
            "FEATURED SERVICES",
            style: TextStyle(
              fontFamily: MyFont.myFont,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              featuredServices(),
            ],
          ),
        ),
      );
    });
  }

  featuredServices() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.featuredServices.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.feaBusSplScreen,
                  arguments: controller.featuredServices[index]);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                                child: webSerImage(
                                  imageUrl: controller
                                          .featuredServices[index].filePath ??
                                      Assets.service,
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            capitalizeFirstLetter(controller
                                    .featuredServices[index].serviceName ??
                                ""),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            controller.featuredServices[index].serviceId ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
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
