import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Screens/BusinessFlow/Specialist/SpecialistListing/specialistlistcontroller.dart';
import 'package:top_20/Widget/textformfield.dart';

import '../../../../Const/approute.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/extension.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/memberupdatemodel.dart';
import '../../../../Model/specialistmodel.dart';
import 'GetMyspcialistScreenController.dart';

final searchLoader = StateProvider.autoDispose<bool>((ref) => false);

class AddSpecialistScreen extends ConsumerStatefulWidget {
  const AddSpecialistScreen({Key? key}) : super(key: key);

  @override
  createState() => _BusinessSpecialistQRState();
}

class _BusinessSpecialistQRState extends ConsumerState<AddSpecialistScreen> {
  late AddSpecialistListController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(AddSpecialistListController());
  }

  void listingProfile(String value) {
    if (controller.searchByNameController.text.isEmpty) {
      controller.displayList.value = controller.specialistList.value;
    } else {
      controller.displayList.value = controller.specialistList
          .where((element) =>
              element.displayName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }

  @override
  void dispose() {
    controller.isAddClick.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddSpecialistListController>(builder: (logic) {
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
              pinned: true,
              expandedHeight: controller.isAddClick.value ? 200 : 80,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined)),
              title: Text(
                "SPECIALIST",
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                ),
              ),
              centerTitle: true,
              actions: [
                (controller.isAddClick.value)
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            controller.isAddClick.value =
                                !controller.isAddClick.value;
                          });
                        },
                        icon: const Icon(Icons.keyboard_arrow_up_sharp))
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            controller.isAddClick.value =
                                !controller.isAddClick.value;
                          });
                        },
                        icon: const Icon(Icons.add))
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: (controller.isAddClick.value)
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 80, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: width(context) / 2.3,
                                child: CustomTextFormField(
                                  controller: controller.scanByQrController,
                                  readOnly: true,
                                  onTap: () async {
                                    // scanQrcode();
                                  },
                                  textStyle: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontSize: 15,
                                      color: MyColors.white),
                                  hintText: "SCAN BY QR",
                                  hintTextStyle: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontSize: 15,
                                      color: MyColors.white),
                                  cursorColor: MyColors.white,
                                  filled: true,
                                  filledColor: MyColors.textFieldTheme,
                                  inputFormatters: [],
                                  maxLength: 100,
                                  inputBorder: BorderSide.none,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        // scanQrcode();
                                      },
                                      icon: const Icon(
                                        Icons.qr_code_2_sharp,
                                        color: MyColors.white,
                                      )),
                                )),
                            SizedBox(
                              width: width(context) / 2.3,
                              child: CustomTextFormField(
                                controller: controller.searchByNameController,
                                onTap: () {
                                  Get.toNamed(
                                      Routes.specialistSearchByNameScreen);
                                },
                                textStyle: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontSize: 15,
                                    color: MyColors.white),
                                hintText: "SEARCH BY NAME",
                                hintTextStyle: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontSize: 15,
                                    color: MyColors.white),
                                readOnly: true,
                                cursorColor: MyColors.white,
                                filled: true,
                                filledColor: MyColors.textFieldTheme,
                                inputFormatters: [],
                                maxLength: 100,
                                inputBorder: BorderSide.none,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      Get.toNamed(
                                          Routes.specialistSearchByNameScreen);
                                    },
                                    icon: const Icon(
                                      Icons.person,
                                      color: MyColors.white,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ))
                    : Container(),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 18, 10, 20),
                child: Column(
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
                    SizedBox(
                        height: height(context),
                        child: GetMySpecialistBusinessScreen())
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
  // businessSpecialistListView() {
  //     return  ListView.builder(
  //         shrinkWrap: true,
  //         padding: const EdgeInsets.all(0),
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemCount: controller.specialistOverAllList.length,
  //         itemBuilder: (context, index) {
  //           return GestureDetector(
  //             onTap: () {
  //               Get.toNamed(Routes.businessSpecialistDetailScreen,
  //                   arguments: controller.specialistOverAllList[index]);
  //             },
  //             child: Card(
  //               color: MyColors.scaffold,
  //               elevation: 0,
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(10.0)),
  //               child: Padding(
  //                 padding:
  //                 const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //                 child: Row(
  //                   children: [
  //                     SizedBox(
  //                       height: 80,
  //                       width: 80,
  //                       child: Container(
  //                           decoration: BoxDecoration(
  //                             color: MyColors.regColor,
  //                             borderRadius: BorderRadius.circular(10.0),
  //                           ),
  //                           child: Center(
  //                             child: ClipRRect(
  //                               borderRadius: BorderRadius.circular(10.0),
  //                               child: SizedBox(
  //                                   height: 60,
  //                                   width: 60,
  //                                   child: webImage(
  //                                     imageUrl: controller
  //                                         .specialistOverAllList[index]
  //                                         .filePath ??
  //                                         "",
  //                                     fit: BoxFit.fill,
  //                                   )),
  //                             ),
  //                           )),
  //                     ),
  //                     const SizedBox(width: 15),
  //                     Flexible(
  //                       child: Column(
  //                         children: [
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Flexible(
  //                                 child: Text(
  //                                   controller.specialistOverAllList[index]
  //                                       .specilistName ??
  //                                       "",
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: TextStyle(
  //                                     fontFamily: MyFont.myFont,
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 18,
  //                                   ),
  //                                 ),
  //                               ),
  //                               const SizedBox(width: 5),
  //                               RatingBarIndicator(
  //                                 rating: controller
  //                                     .specialistOverAllList[index]
  //                                     .ratingValue ??
  //                                     2.75,
  //                                 itemBuilder: (context, index) =>
  //                                     Icon(
  //                                       Icons.star,
  //                                       color: MyColors.primaryCustom,
  //                                     ),
  //                                 itemCount: 5,
  //                                 itemSize: 20.0,
  //                               ),
  //                             ],
  //                           ),
  //                           const SizedBox(height: 10),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Flexible(
  //                                 child: Text(
  //                                   controller.specialistOverAllList[index]
  //                                       .specialistId ??
  //                                       "",
  //                                   overflow: TextOverflow.ellipsis,
  //                                   maxLines: 2,
  //                                   style: TextStyle(
  //                                     fontFamily: MyFont.myFont,
  //                                     fontWeight: FontWeight.w500,
  //                                     fontSize: 18,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     const SizedBox(width: 10),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         });
  // }

  callSearchSpecialist({String? displayName, String? specialistId}) async {
    ref.read(searchLoader.notifier).update((state) => true);
    SpecialistSearchParams params = SpecialistSearchParams(
      emailId: '',
      displayName: displayName ?? '',
      specialistId: specialistId ?? '',
    );
    await ApiService.specialistSearch(params: params).then((apiResponse) async {
      ref.read(searchLoader.notifier).update((state) => false);
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status &&
            apiResponse.apiResponseModel!.result != null) {
          Map<String, dynamic>? json =
              (apiResponse.apiResponseModel!.result! as List).first;
          if (json != null) {
            SpecialistListModel specialistListModel =
                SpecialistListModel.fromJson(json);
            Get.toNamed(Routes.specialistInviteScreen,
                arguments: specialistListModel);
          } else {
            PreferenceHelper.showSnackBar(
                context: context, msg: "Invalid Data");
          }
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: context, msg: message);
        }
      } else {
        PreferenceHelper.showSnackBar(context: context, msg: apiResponse.error);
      }
    });
  }
}

class GetMySpecialistBusinessScreen extends StatefulWidget {
  const GetMySpecialistBusinessScreen({Key? key}) : super(key: key);

  @override
  State<GetMySpecialistBusinessScreen> createState() =>
      _GetMySpecialistBusinessScreenState();
}

class _GetMySpecialistBusinessScreenState
    extends State<GetMySpecialistBusinessScreen> {
  late GetMyspecilaistController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(GetMyspecilaistController());
    controller.getBusinessMyspecialist();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetMyspecilaistController>(builder: (logic) {
      if (logic.isLoading == true) {
        return Scaffold(
          body: Center(
            child: LoadingAnimationWidget.threeRotatingDots(
                color: MyColors.primaryCustom, size: 20),
          ),
        );
      }
      return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.specialistOverAllList?.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.businessSpecialistDetailScreen,
                    arguments: controller.specialistOverAllList?[index]);
              },
              child: Card(
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
                                      imageUrl: controller
                                              .specialistOverAllList?[index]
                                              .filePath ??
                                          "",
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            )),
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
                                    controller.specialistOverAllList?[index]
                                            .specilistName ??
                                        "",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                RatingBarIndicator(
                                  rating: controller
                                          .specialistOverAllList?[index]
                                          .ratingValue ??
                                      2.75,
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
                                    controller.specialistOverAllList?[index]
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
          });
    });
  }
}
