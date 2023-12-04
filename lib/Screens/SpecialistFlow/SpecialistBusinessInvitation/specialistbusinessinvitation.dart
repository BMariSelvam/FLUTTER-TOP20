import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Screens/SpecialistFlow/SpecialistBusinessInvitation/specialistbusinessinvitationcontroller.dart';
import '../../../Const/approute.dart';
import '../../../Const/colors.dart';
import '../../../Const/size.dart';
import '../../../Helper/extension.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/invitebusinesslistmodel.dart';
import '../../../Widget/dottedline.dart';

class SpecialistBusinessInvitationScreen extends StatefulWidget {
  const SpecialistBusinessInvitationScreen({super.key});

  @override
  State<SpecialistBusinessInvitationScreen> createState() =>
      _SpecialistBusinessInvitationScreenState();
}

class _SpecialistBusinessInvitationScreenState
    extends State<SpecialistBusinessInvitationScreen> {
  late SpecialistBusinessInvitationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(SpecialistBusinessInvitationController());
    controller.getBusinessRequest();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistBusinessInvitationController>(builder: (logic) {
      if (logic.status == RxStatus.loading()) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              leading: IconButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.specialistBottomNavBar);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
              title: Text(
                "BUSINESS INVITATION",
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                ),
              ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: businessInvitationList(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  businessInvitationList() {
    return (controller.businessRequest.isNotEmpty)
        ? GetBuilder<SpecialistBusinessInvitationController>(builder: (logic) {
            if (logic.status == RxStatus.loading()) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemCount: controller.businessRequest.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Card(
                          elevation: 0,
                          color: MyColors.scaffold,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width(context) / 2,
                                    child: Text(
                                        capitalizeFirstLetter(controller
                                                .businessRequest
                                                .first
                                                .businessName ??
                                            ""),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: MyColors.black,
                                        )),
                                  ),
                                  RatingBarIndicator(
                                    rating: controller.businessRequest.first
                                            .ratingValue ??
                                        4.0,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: MyColors.primaryCustom,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: width(context) / 2,
                                child: Text(
                                    capitalizeFirstLetter(controller
                                            .businessRequest.first.businessId ??
                                        ""),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: MyColors.black,
                                    )),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.postApproveBusinessRequest(
                                          requestId: controller
                                              .businessRequest[index].reuestId,
                                          businessId: controller
                                              .businessRequest[index]
                                              .businessId,
                                          isCancel: true);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      side: const BorderSide(
                                          color: MyColors.grey),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      child: Text(
                                        'Reject',
                                        style: TextStyle(
                                            color: MyColors.primaryCustom),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.postApproveBusinessRequest(
                                          requestId: controller
                                              .businessRequest[index].reuestId,
                                          businessId: controller
                                              .businessRequest[index]
                                              .businessId);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.primaryCustom,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      child: Text(
                                        'Accept',
                                        style: TextStyle(
                                            fontFamily: MyFont.myFont,
                                            color: MyColors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        DottedHorizontalLine(
                          color: MyColors.grey,
                          dotSpacing: 10,
                          dotWidth: 10,
                        )
                      ],
                    ),
                  );
                });
          })
        : const Center(
            child: Text("No Notification found"),
          );
  }
}
