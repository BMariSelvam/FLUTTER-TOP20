import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Screens/BusinessFlow/Specialist/SpecialistDetail/specialistdetailcontroller.dart';

import '../../../../Const/approute.dart';
import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/extension.dart';
import '../../../../Model/MySpecilaistModel.dart';
import '../../../../Model/specialistmodel.dart';
import '../../../../Widget/submitbutton.dart';
import '../../../Success/successscreen.dart';

class BusinessSpecialistDetailScreen extends StatefulWidget {
  const BusinessSpecialistDetailScreen({Key? key}) : super(key: key);

  @override
  State<BusinessSpecialistDetailScreen> createState() =>
      _BusinessSpecialistDetailScreenState();
}

class _BusinessSpecialistDetailScreenState
    extends State<BusinessSpecialistDetailScreen> {
  late BusinessSpecialistController controller;

  MySpecilaistModel? specialistView;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    specialistView = Get.arguments as MySpecilaistModel;
    controller = Get.put(BusinessSpecialistController());
    controller.getSpecialistDetails(specialistView?.specialistId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessSpecialistController>(builder: (logic) {
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
                automaticallyImplyLeading: false,
                expandedHeight: 300,
                pinned: true,
                leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_outlined)),
                title: Text(
                  capitalizeFirstLetter(
                      controller.specialistDetails.first.displayName ?? ""),
                  overflow: TextOverflow.ellipsis,
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
                                  controller.specialistDetails.first.filePath ??
                                      "",
                              fit: BoxFit.fill,
                            )),
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        child: Text(
                          capitalizeFirstLetter(controller.specialistDetails
                                  .first.businessCategoryname ??
                              ""),
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
                      RatingBarIndicator(
                        rating:
                            controller.specialistDetails.first.ratingValue ??
                                2.75,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
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
                        "Services",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      (controller.specialistDetails.first.servicesList != null)
                          ? SpecialistDetailServiceList(
                              specialistServiceModel:
                                  controller.specialistDetails.first)
                          : Center(
                              child: Text(
                              "No Services Found",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: MyColors.darkGrey,
                              ),
                            )),
                      const SizedBox(height: 20),
                      Text(
                        "About",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                            controller.specialistDetails.first.bioInfo ?? "",
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Contact Details",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "  Mobile Number : ",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              controller.specialistDetails.first.mobileNo ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "  Email Id : ",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              controller.specialistDetails.first.emailId ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: width(context) / 3,
                    child: SubmitButton(
                        isLoading: false,
                        onTap: () {
                          _showPopUp(context);
                        },
                        title: "Remove")),
                SizedBox(
                    width: width(context) / 3,
                    child: SubmitButton(
                        isLoading: false,
                        onTap: () {
                          Get.back();
                        },
                        title: "Back")),
              ],
            ),
          ));
    });
  }

  void _showPopUp(BuildContext context) {
    showDialog(
      //barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Center(
            child: Text(
              'Remove Specialist',
              style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Text(
            'Do you want to Remove this \n Specialist',
            textAlign: TextAlign.center,
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
                    //Get.toNamed(Routes.businessRescheduleScreen);
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

class SpecialistDetailServiceList extends StatefulWidget {
  final specialistServiceModel;
  const SpecialistDetailServiceList({super.key, this.specialistServiceModel});

  // const SpecialistDetailServiceList({Key? key}) : super(key: key);

  @override
  State<SpecialistDetailServiceList> createState() =>
      _SpecialistDetailServiceListState();
}

class _SpecialistDetailServiceListState
    extends State<SpecialistDetailServiceList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: widget.specialistServiceModel.servicesList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 8),
                const SizedBox(width: 20),
                Text(
                  capitalizeFirstLetter(
                    '${widget.specialistServiceModel.servicesList[index].businessServiceName ?? ""}',
                  ),
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
