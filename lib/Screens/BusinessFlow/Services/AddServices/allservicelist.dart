import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../Const/approute.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/extension.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/CreateServiceModel.dart';
import '../../../../Model/businessregmodel.dart';
import '../../../../Widget/submitbutton.dart';
import 'CreateServiceController.dart';

class ServiceAllListScreen extends StatefulWidget {
  const ServiceAllListScreen({Key? key}) : super(key: key);

  @override
  State<ServiceAllListScreen> createState() => _ServiceAllListScreenState();
}

class _ServiceAllListScreenState extends State<ServiceAllListScreen> {
  late BusinessServiceController controller;

  void initState() {
    controller = Get.put(BusinessServiceController());
    controller.intialfunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessServiceController>(builder: (logic) {
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
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "ADD SERVICES",
            style: TextStyle(
              fontFamily: MyFont.myFont,
            ),
          ),
          centerTitle: true,
          actions:  [
            // Container(
            //   height: 10,
            //   decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            //   child: const Text("Service\nRequest",
            //     style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 13,
            //   ),),
            // )

          ],
        ),
        body: SingleChildScrollView(
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
                return businessAllServiceList();
              }),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 200),
                child: Center(
                  child: SizedBox(
                    height: 50,
                    child: TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.businessServiceRequestList);
                        },
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: OverflowBox(
                                minWidth: 0.0,
                                maxWidth: double.infinity,
                                alignment: Alignment.centerRight,
                                child: Text("New Service Request->",
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.mainTheme,
                                  ),),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SubmitButton(
            isLoading: false,
            // onTap: () {
            //   setState(() {
            //     controller.isAddServiceButtonServiceClick.value =
            //         !controller.isAddServiceButtonServiceClick.value;
            //   });
            // },
            onTap: () async {
              //Add ServiceList
              (controller.specialistId != null)
                  ? controller.createNewServiceModel = CreateNewServiceModel(
                      orgId: 1,
                      specialistId: await PreferenceHelper.getSpecialistData()
                          .then((value) => value?.specialistId),
                      businessId: " ",
                      createdby: await PreferenceHelper.getSpecialistData()
                          .then((value) => value?.specilistName),
                      addservicesList: controller.businessServiceList.value
                          ?.where((element) => element.isSelected == true)
                          .toList())
                  : controller.createNewServiceModel = CreateNewServiceModel(
                      orgId: 1,
                      businessId: await PreferenceHelper.getBusinessData()
                          .then((value) => value?.businessId),
                      specialistId: " ",
                      createdby: await PreferenceHelper.getBusinessData()
                          .then((value) => value?.businessName),
                      addservicesList: controller.businessServiceList.value
                          !.where((element) => element.isSelected == true)
                          .toList());

              (controller.specialistId != null)
                  ? controller.createSpecilaistService()
                  : controller.AddExistingServiceBusiness();
            },
            title: "Add Services",
          ),
        ),
      );
    });
  }

  businessAllServiceList() {
    if (controller.businessServiceList.value?.length != null) {
      return Wrap(
          runSpacing: 30,
          spacing: 15,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: controller.businessServiceList.value!
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    if (controller.selectedServiceIds
                            .contains(e.businessServiceId) ||
                        controller.selectedServiceIds.contains(e.serviceId)) {
                      _selectService(e);
                      return;
                    } else {
                      _selectService(e);
                    }
                  },
                  child: Row(
                    children: [
                      AbsorbPointer(
                        absorbing: false,
                        child: Checkbox(
                            value: e.isSelected,
                            onChanged: (value) {
                              if (controller.selectedServiceIds
                                      .contains(e.businessServiceId) ||
                                  controller.selectedServiceIds
                                      .contains(e.serviceId)) {
                                _selectService(e);
                                return;
                              } else {
                                _selectService(e);
                              }
                            }),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: width(context) / 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              capitalizeFirstLetter(
                                  e.businessServiceName ?? ''),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: height(context) / 50),
                            Text(
                              e.businessServiceId ?? '',
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: MyColors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Charges : ${e.tokens ?? ' '}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                color: MyColors.darkGrey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Duration : ${e.durationMinutes ?? ' '} Mins',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList());
    }
    return Container();
  }

  void _selectService(CreateServiceModel e) {
    if (e.isSelected == true) {
      e.isSelected = true;
    } else {
      e.isSelected = true;
    }
    controller.update();
  }

}
