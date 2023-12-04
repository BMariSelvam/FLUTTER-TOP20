import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Const/approute.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Screens/BusinessFlow/Services/AddServices/servicecontroller.dart';
import 'package:top_20/Widget/submitbutton.dart';
import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/extension.dart';
import '../../../../Helper/preferenceHelper.dart';


class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late ServiceController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ServiceController());
    controller.intialfunc();
  }
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      super.initState();
      controller = Get.put(ServiceController());
      controller.intialfunc();
    });
    }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(builder: (logic) {
      var args = Get.arguments;
       int initialIndex=0;
      if (args == "Requested") {
        logic.isAddServiceClick.value = false;
        logic.isRequestedServiceClick.value = true;
      }
      if (logic.status == RxStatus.loading()) {
        return Center(
            child: LoadingAnimationWidget.threeRotatingDots(
                color: MyColors.primaryCustom, size: 20));
      }
      return Scaffold(
          body: DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    expandedHeight: 200,
                    leading: IconButton(
                      onPressed: () {
                        if (PreferenceHelper.isSpecialist) {
                          Get.offAllNamed(Routes.specialistBottomNavBar);
                        } else {
                          Get.offAllNamed(Routes.businessBottomNavBar);
                        }
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined),
                    ),
                    title: Text(
                      "SERVICES",
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                      ),
                    ),
                    centerTitle: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 80, 0, 10),
                          child: SizedBox(
                            height: height(context) / 10,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (controller.isAddServiceClick.value =
                                          true) {
                                        controller.isRequestedServiceClick.value =
                                            false;
                                      }
                                    });
                                  },
                                  child: SizedBox(
                                    width: width(context) / 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        color: (controller.isAddServiceClick.value)
                                            ? MyColors.white
                                            : MyColors.textFieldTheme,
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: MyColors.white),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: Center(
                                          child: Text(
                                            "Service",
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              color: (controller
                                                      .isAddServiceClick.value)
                                                  ? MyColors.primaryCustom
                                                  : MyColors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (controller.isRequestedServiceClick.value =
                                          true) {
                                        controller.isAddServiceClick.value = false;
                                      }
                                    });
                                  },
                                  child: SizedBox(
                                    width: width(context) / 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        color: (controller
                                                .isRequestedServiceClick.value)
                                            ? MyColors.white
                                            : MyColors.textFieldTheme,
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: MyColors.white),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: Center(
                                          child: Text(
                                            "Requested",
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              color: (controller
                                                      .isRequestedServiceClick
                                                      .value)
                                                  ? MyColors.primaryCustom
                                                  : MyColors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  (controller.isAddServiceClick.value)
                      ? SliverToBoxAdapter(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Services",
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Obx(() {
                                  return businessExistingServiceList();
                                })
                              ],
                            ),
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(18.0),
                            child: (controller.getBusinessRequestList.isNotEmpty)
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Requested Services",
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      SizedBox(
                                        child: requestedServiceList(),
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 100),
                                    child: Image.asset(Assets.noData),
                                  ),
                          ),
                        )
                ],
              ),
            ),
          ),
          bottomNavigationBar: (controller.isAddServiceClick.value)
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: SubmitButton(
                    isLoading: false,
                    onTap: () {
                      Get.toNamed(Routes.serviceAllListScreen);
                    },
                    title: "Add More Service",
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: SubmitButton(
                    isLoading: false,
                    onTap: () {
                      Get.toNamed(Routes.businessServiceRequestList);
                    },
                    title: "Request Services",
                  ),
                ));
    });
  }

  businessExistingServiceList() {
    if (controller.businessServiceList.value?.length != null) {
      return Wrap(
          runSpacing: 20,
          spacing: 15,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: controller.businessServiceList.value!
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    // if (serviceActiveInactiveController.selectedServiceIds
                    //         .contains(e.businessServiceId) &&
                    //     serviceActiveInactiveController.selectedServiceIds
                    //         .contains(e.serviceId)) {
                    //   return;
                    // } else {
                    //   _selectService(e);
                    // }
                  },
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
                                      imageUrl: e.filePath ?? "",
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            )),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: SizedBox(
                          width: width(context) / 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (controller.businessId != null)
                                Text(
                                  capitalizeFirstLetter(
                                      e.businessServiceName ?? ''),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: MyColors.black,
                                  ),
                                ),
                              if (controller.specialistId != null)
                                Text(
                                  e.servicename ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: MyColors.black,
                                  ),
                                ),
                              const SizedBox(height: 10),
                              if (controller.businessId != null)
                                Text(
                                  e.businessServiceId ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: MyColors.grey,
                                  ),
                                ),
                              if (controller.specialistId != null)
                                SizedBox(
                                  width: width(context) / 2,
                                  child: Text(
                                    e.serviceId ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: MyColors.grey,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Switch(
                        activeColor: Colors.green,
                        inactiveTrackColor: Colors.red,
                        value: e.isSelected!,
                        onChanged: (bool value) async {
                          setState(() {
                            e.isSelected = value;
                            print(e.isSelected);
                            print(value);
                            e.isActive = value;
                          });
                          // (PreferenceHelper.isSpecialist)
                          //     ? controller.addServicesListModel = AddServicesListModel(
                          //         orgId: 1,
                          //         specialistId:
                          //             await PreferenceHelper.getSpecialistData()
                          //                 .then((value) => value?.specialistId),
                          //         businessId: "",
                          //         createdby: await PreferenceHelper.getSpecialistData()
                          //             .then((value) => value?.specilistName),
                          //         addservicesList: controller
                          //             .businessServiceList.value
                          //             ?.where((element) =>
                          //                 element.isSelected == true)
                          //             .toList())
                          //     : controller.addServicesListModel =
                          //         AddServicesListModel(
                          //             orgId: 1,
                          //             businessId: await PreferenceHelper.getBusinessData()
                          //                 .then((value) => value?.businessId),
                          //             specialistId: "",
                          //             createdby: await PreferenceHelper.getBusinessData()
                          //                 .then((value) => value?.businessName),
                          //             addservicesList: controller.businessServiceList.value?.where((element)
                          //             => element.isSelected == true).toList());
                          // controller.businessServiceList.value?.forEach((element) async {
                          //   element.isActive = value;
                          // })
                           (controller.specialistId != null)
                              ? controller.activeInActiveSpcialist(e)
                              : controller.activeInActiveBusiness(e);
                        },
                      )
                    ],
                  ),
                ),
              )
              .toList());
    }
    return Container();
  }

  requestedServiceList() {
    if (controller.getBusinessRequestList.length != null) {
      return Wrap(
          runSpacing: 20,
          spacing: 15,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: controller.getBusinessRequestList
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    // if (serviceActiveInactiveController.selectedServiceIds
                    //         .contains(e.businessServiceId) &&
                    //     serviceActiveInactiveController.selectedServiceIds
                    //         .contains(e.serviceId)) {
                    //   return;
                    // } else {
                    //   _selectService(e);
                    // }
                  },
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
                                      imageUrl: e.filePath ?? "",
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            )),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                  Flexible(
                                    child: Text(
                                      capitalizeFirstLetter(
                                          e.businessServiceName ?? ''),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: MyColors.black,
                                      ),
                                    ),
                                  ),
                                const SizedBox(width: 10),
                                // if (PreferenceHelper.isBusiness)
                                //   Flexible(
                                //     child: Text(
                                //       '${e.tokens}',
                                //       overflow: TextOverflow.ellipsis,
                                //       style: TextStyle(
                                //         fontFamily: MyFont.myFont,
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 18,
                                //         color: MyColors.darkGrey,
                                //       ),
                                //     ),
                                //   ),
                                // if (PreferenceHelper.isSpecialist)
                                //   Flexible(
                                //     child: Text(
                                //       '${e.tokens}',
                                //       overflow: TextOverflow.ellipsis,
                                //       style: TextStyle(
                                //         fontFamily: MyFont.myFont,
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 18,
                                //         color: MyColors.darkGrey,
                                //       ),
                                //     ),
                                //   )
                              ],
                            ),
                            const SizedBox(height: 10),
                              Text(
                                e.businessServiceId ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: MyColors.grey,
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(width: width(context) / 20),
                    ],
                  ),
                ),
              )
              .toList());
    } else {
      return Text(
        "No Request Services here",
        style: TextStyle(
          fontFamily: MyFont.myFont,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: MyColors.darkGrey,
        ),
      );
    }
    return Container();
  }
}
