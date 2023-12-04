import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Model/businesslistmodel.dart';
import 'package:top_20/Widget/togglebutton.dart';
import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/extension.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/Member_details_model.dart';
import '../../../../Model/businessappointmentmodel.dart';
import '../../../../Model/userappointmentcreatemodel.dart';
import '../../../../Widget/CustomToggleButton.dart';
import '../../../../Widget/ToggleButtonAppoitment.dart';
import '../../../../Widget/dottedline.dart';
import '../../../../Widget/submitbutton.dart';
import '../../../../Widget/textformfield.dart';
import 'businessappointmentcontroller.dart';

class UserAppointmentBusiness extends StatefulWidget {
  const UserAppointmentBusiness({Key? key}) : super(key: key);

  @override
  State<UserAppointmentBusiness> createState() =>
      _UserAppointmentBusinessState();
}

class _UserAppointmentBusinessState extends State<UserAppointmentBusiness> {
  BusinessListUserViewModel? businessListUserViewModel;
  var specialistId;

  var memberId;
  late TimeOfDay fromTime;
  String openTime = "";
  String closeTime = "";

  MemberDetails? memberDetails;

  _initialiseData() async {
    memberDetails = await PreferenceHelper.getMemberData();
    memberId = memberDetails?.memberId;
  }

  late BusinessAppointmentController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialiseData();
    controller = Get.put(BusinessAppointmentController());
    businessListUserViewModel = Get.arguments as BusinessListUserViewModel;
    controller.getBusinessServicesList(businessListUserViewModel?.businessId);
    controller.getBusinessList(businessListUserViewModel?.businessId);
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessAppointmentController>(builder: (logic) {
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
                "APPOINTMENT BOOKING",
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
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.asset(
                              Assets.profile,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  capitalizeFirstLetter(
                                    businessListUserViewModel?.displayName ??
                                        "",
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: MyColors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    // Text(
                                    //   "4.3 1.23k(reviews)",
                                    //   overflow: TextOverflow.ellipsis,
                                    //   style: TextStyle(
                                    //     fontFamily: MyFont.myFont,
                                    //     fontWeight: FontWeight.w500,
                                    //     fontSize: 20,
                                    //     color: MyColors.white,
                                    //   ),
                                    // ),
                                    RatingBarIndicator(
                                      rating: businessListUserViewModel
                                              ?.ratingValue ??
                                          3.75,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: MyColors.yellow,
                                      ),
                                      itemCount: 5,
                                      itemSize: 20.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      DottedHorizontalLine(
                        color: MyColors.white,
                        dotWidth: 15,
                        dotSpacing: 20,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        capitalizeFirstLetter(
                            businessListUserViewModel?.businessCategoryName ??
                                ""),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: MyColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Form(
                    key: controller.businessAppointmentKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomTextFormField(
                                  controller: controller.dateController,
                                  labelText: "",
                                  hintText: "Date",
                                  readOnly: true,
                                  labelTextStyle: TextStyle(),
                                  textStyle: TextStyle(),
                                  inputFormatters: [],
                                  maxLength: 100,
                                  suffixIcon: IconButton(
                                      onPressed: () async {
                                        _selectDate(context);
                                        controller.fromTimeController.clear();
                                        controller.toTimeController.clear();

                                        if (controller
                                            .toTimeController.text.isNotEmpty) {
                                          controller.toTimeController.clear();

                                          // Unselect items in businessServiceList
                                          setState(() {
                                            var selectedItems = controller
                                                .businessServiceList.value
                                                ?.where((element) =>
                                                    element.isSelected == true)
                                                .toList();

                                            for (var item in selectedItems!) {
                                              item.isSelected = false;
                                            }
                                          });
                                        }
                                      },
                                      icon: const Icon(
                                          Icons.calendar_month_outlined)),
                                  onTap: () async {
                                    _selectDate(context);
                                    controller.fromTimeController.clear();
                                    controller.toTimeController.clear();

                                    if (controller
                                        .toTimeController.text.isNotEmpty) {
                                      controller.toTimeController.clear();

                                      // Unselect items in businessServiceList
                                      setState(() {
                                        var selectedItems = controller
                                            .businessServiceList.value
                                            ?.where((element) =>
                                                element.isSelected == true)
                                            .toList();

                                        for (var item in selectedItems!) {
                                          item.isSelected = false;
                                        }
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "From Time",
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: width(context) / 2.3,
                                      child: CustomTextFormField(
                                          controller:
                                              controller.fromTimeController,
                                          labelText: "",
                                          hintText: "Time",
                                          readOnly: true,
                                          labelTextStyle: TextStyle(
                                              fontFamily: MyFont.myFont),
                                          textStyle: TextStyle(
                                              fontFamily: MyFont.myFont),
                                          inputFormatters: [],
                                          maxLength: 100,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              if (controller.dateController.text
                                                  .isNotEmpty) {
                                                _selectTime(context);
                                              } else {
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Please Choose the Appointment date First",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                );
                                              }

                                              if (controller.toTimeController
                                                  .text.isNotEmpty) {
                                                // Clear toTimeController
                                                controller.toTimeController
                                                    .clear();

                                                // Unselect items in businessServiceList
                                                setState(() {
                                                  var selectedItems = controller
                                                      .businessServiceList.value
                                                      ?.where((element) =>
                                                          element.isSelected ==
                                                          true)
                                                      .toList();
                                                  for (var item
                                                      in selectedItems!) {
                                                    item.isSelected = false;
                                                  }
                                                });
                                              }
                                            },
                                            icon: const Icon(
                                                Icons.access_time_outlined),
                                          ),
                                          onTap: () async {
                                            if (controller.dateController.text
                                                .isNotEmpty) {
                                              _selectTime(context);
                                            } else {
                                              Fluttertoast.showToast(
                                                msg:
                                                    "Please Choose the Appointment date First",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                              );
                                            }
                                            if (controller.toTimeController.text
                                                .isNotEmpty) {
                                              controller.toTimeController
                                                  .clear();
                                              setState(() {
                                                var selectedItems = controller
                                                    .businessServiceList.value
                                                    ?.where((element) =>
                                                        element.isSelected ==
                                                        true)
                                                    .toList();

                                                for (var item
                                                    in selectedItems!) {
                                                  item.isSelected = false;
                                                }
                                              });
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "To Time",
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: width(context) / 2.3,
                                      child: CustomTextFormField(
                                        controller: controller.toTimeController,
                                        labelText: "",
                                        hintText: "Time",
                                        readOnly: true,
                                        labelTextStyle: TextStyle(
                                            fontFamily: MyFont.myFont),
                                        textStyle: TextStyle(
                                            fontFamily: MyFont.myFont),
                                        inputFormatters: [],
                                        maxLength: 100,
                                        suffixIcon: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.access_time_outlined),
                                        ),
                                        // onTap: () async {
                                        //   FocusScope.of(context).unfocus();
                                        //   DateTime? selectedTime =
                                        //       await PreferenceHelper.showTimePopup(
                                        //           context, null);
                                        //   if (selectedTime != null) {
                                        //     controller.openTime = selectedTime;
                                        //     controller.fromTimeController.text =
                                        //         PreferenceHelper.dateToString(
                                        //             date: selectedTime,
                                        //             dateFormat: 'HH:mm');
                                        //   }
                                        // },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        SizedBox(height: height(context) / 50),
                        Text(
                          "Select Services",
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: height(context) / 50),
                        // UserAppointmentBusinessListView(
                        //     businessServices: widget.businessListUserViewModel),
                        _ListView(),
                        SizedBox(height: height(context) / 50),
                        Card(
                          color: MyColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children: [
                                Text(
                                  'Service location',
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: height(context) / 50),
                                (controller.businessList.value?.first
                                                .customerPlace ==
                                            true &&
                                        controller.businessList.value?.first
                                                .businessPalce ==
                                            true)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Customer Place',
                                            style: TextStyle(
                                                fontFamily: MyFont.myFont,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          AppoinmentToggle(
                                              value:
                                                  controller.isToggleOn.value,
                                              onTap: (bool) {
                                                setState(() {
                                                  controller.isToggleOn.value =
                                                      !controller
                                                          .isToggleOn.value;
                                                  print(controller.isToggleOn);
                                                  if (controller
                                                      .isToggleOn.value) {
                                                    controller.serviceLocation =
                                                        0;
                                                  } else {
                                                    controller.serviceLocation =
                                                        1;
                                                  }
                                                });
                                                print(
                                                    controller.serviceLocation);
                                              }),
                                          Text(
                                            'Business Place',
                                            style: TextStyle(
                                                fontFamily: MyFont.myFont,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                          )
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          (controller.businessList.value?.first
                                                      .customerPlace ==
                                                  true)
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Customer Place',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            MyFont.myFont,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    CustomToggleButton(
                                                      value: controller
                                                          .isCustomerOn.value,
                                                      onTap: (bool) {
                                                        setState(() {
                                                          controller
                                                              .isCustomerOn
                                                              .value = true;
                                                          if (controller
                                                              .isCustomerOn
                                                              .value) {
                                                            controller
                                                                .serviceLocation = 1;
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                )
                                              : const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 20, bottom: 5),
                                                  child: Text(
                                                      "This Business providing services at business place"),
                                                ),
                                          (controller.businessList.value?.first
                                                      .businessPalce ==
                                                  true)
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Business Place',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            MyFont.myFont,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    CustomToggleButton(
                                                      value: controller
                                                          .isBusinessOn.value,
                                                      onTap: (bool) {
                                                        setState(() {
                                                          controller
                                                              .isBusinessOn
                                                              .value = true;
                                                          print(controller
                                                              .isBusinessOn);
                                                          if (controller
                                                              .isBusinessOn
                                                              .value) {
                                                            controller
                                                                .serviceLocation = 1;
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                )
                                              : const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 5),
                                                  child: Text(
                                                      "This Business providing services at Customer place"),
                                                ),
                                        ],
                                      )
                                // ToggleButtons(
                                //   isSelected: isSelected,
                                //   onPressed: (int newIndex) {
                                //     setState(() {
                                //       for (int i = 0; i < isSelected.length; i++) {
                                //         isSelected[i] = i == newIndex;
                                //       }
                                //
                                //       if (newIndex == 0) {
                                //         controller.serviceLocation = 1; // Set your service location values accordingly
                                //       } else {
                                //         controller.serviceLocation = 0;
                                //       }
                                //     });
                                //   },
                                //   children: const [
                                //     Text('Customer Place'),
                                //     Text('Business Place'),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height(context) / 50),
                        Text(
                          'Checkout',
                          style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        SizedBox(height: height(context) / 50),
                        // UserBusinessAppointmentCheckout(),
                        Obx(() {
                          return _selectedData();
                        }),
                        (controller.totalCoinsNeed != 0)
                            ? Column(
                                children: [
                                  SizedBox(height: height(context) / 50),
                                  const Divider(
                                    indent: 20,
                                    endIndent: 20,
                                    thickness: 2,
                                  ),
                                  SizedBox(height: height(context) / 50),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Total Charges',
                                              style: TextStyle(
                                                  fontFamily: MyFont.myFont,
                                                  fontWeight: FontWeight.w600)),
                                          Row(
                                            children: [
                                              Text(
                                                "${controller.totalCoinsNeed}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily: MyFont.myFont,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(width: 15),
                                              Text(
                                                'AED',
                                                style: TextStyle(
                                                  fontFamily: MyFont.myFont,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Total Minutes',
                                              style: TextStyle(
                                                  fontFamily: MyFont.myFont,
                                                  fontWeight: FontWeight.w600)),
                                          const SizedBox(width: 15),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.timer_outlined,
                                                size: 15,
                                              ),
                                              const SizedBox(width: 15),
                                              Text(
                                                '${controller.totalDurationTime}  Min',
                                                style: TextStyle(
                                                    fontFamily: MyFont.myFont,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height(context) / 50),
                                  const Divider(
                                    indent: 20,
                                    endIndent: 20,
                                    thickness: 2,
                                  ),
                                  SizedBox(height: height(context) / 50),
                                ],
                              )
                            : Container(),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30.0, horizontal: 10),
                            child: Obx(() {
                              print(memberId);
                              return SubmitButton(
                                  isLoading: controller.isLoading.value,
                                  onTap: () {
                                    if (controller
                                        .businessAppointmentKey.currentState!
                                        .validate()) {
                                      controller
                                              .userBusinessAppointmentCreateModel =
                                          UserBusinessAppointmentCreateModel(
                                              orgId: 1,
                                              specialistId:
                                                  (specialistId != null)
                                                      ? specialistId
                                                      : "0",
                                              memberId: memberId,
                                              appointmentDate: controller.date,
                                              appoinmentFromTime: controller
                                                  .fromTimeController.text,
                                              appoinmentToTime: controller
                                                  .toTimeController.text,
                                              totailCoinsPaid:
                                                  controller.totalCoinsNeed,
                                              businessId:
                                                  businessListUserViewModel
                                                      ?.businessId,
                                              serviceLocation:
                                                  controller.serviceLocation,
                                              // (controller.isToggleOn)
                                              //     ? 0
                                              //     : 1,
                                              isRescheduled: true,
                                              status: 1,
                                              paymentStatus: 1,
                                              createdBy: controller
                                                  .memberDetails?.memberId,
                                              appoinmentDetail: controller
                                                  .businessServiceList.value
                                                  ?.where((element) =>
                                                      element.isSelected ==
                                                      true)
                                                  .toList());
                                      controller.callUserAppointmentBusiness();
                                    }
                                  },
                                  title: "Request Booking");
                            }))
                      ],
                    ),
                  )),
            )
          ],
        ),
      );
    });
  }

  Widget _ListView() {
    if (controller.businessTrueServiceList.value?.length != null) {
      return Wrap(
          runSpacing: 0,
          spacing: 0,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: controller.businessTrueServiceList.value!
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    if (controller.fromTimeController.text.isNotEmpty) {
                      _selectService(e);
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please Choose From Time",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                    }
                  },
                  child: Card(
                    color:
                        e.isSelected == true ? MyColors.tabBar : MyColors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                activeColor: MyColors.primaryCustom,
                                value: e.isSelected,
                                onChanged: (f) {
                                  if (controller
                                      .fromTimeController.text.isNotEmpty) {
                                    _selectService(e);
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Please Choose From Time",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: MyColors.regColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Center(
                                child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child:
                                        webImage(imageUrl: e.filepath ?? "")),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        e.businessServiceName ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star_rounded,
                                            color: Colors.amber,
                                          ),
                                          Text(
                                            '${e.ratings ?? '4.2'}',
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Text(
                                            '${e.tokens ?? ""}',
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            'AED',
                                            style: TextStyle(
                                              fontFamily: MyFont.myFont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: MyColors.darkGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Flexible(
                                      child: SizedBox(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.access_time_outlined,
                                              color: MyColors.primaryCustom,
                                            ),
                                            const SizedBox(width: 1),
                                            Text(
                                              "${e.durationMinutes ?? ""} Mins",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: MyFont.myFont,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: MyColors.darkGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                          // Column(
                          //   children: [
                          //     Row(
                          //       children: [
                          //         Text(
                          //           '${e.businessServiceName ?? ''}',
                          //           style: TextStyle(
                          //               fontFamily: MyFont.myFont,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //         // Text(
                          //         //   '-${_userSpecialistAppointment[index].appointmentServiceFor}',
                          //         //   style: TextStyle(
                          //         //       fontFamily: Constant.myFont,
                          //         //       fontWeight: FontWeight.bold),
                          //         // )
                          //       ],
                          //     ),
                          //     SizedBox(height: height(context) / 100),
                          //     Row(
                          //       children: [
                          //         Image.asset(Assets.coin, scale: 20),
                          //         SizedBox(width: 5),
                          //         Text(
                          //           '${e.tokens ?? ''}',
                          //           style: TextStyle(
                          //               fontFamily: MyFont.myFont,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //         SizedBox(width: width(context) / 20),
                          //         Text(
                          //           '${e.durationMinutes ?? ''}',
                          //           style: TextStyle(
                          //               fontFamily: MyFont.myFont,
                          //               fontWeight: FontWeight.w500,
                          //               fontSize: 12,
                          //               color: MyColors.grey),
                          //         ),
                          //         SizedBox(width: 5),
                          //         Icon(
                          //           Icons.access_time,
                          //           size: 15,
                          //           color: MyColors.grey,
                          //         )
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Icon(Icons.star,
                          //         size: 15, color: MyColors.primaryCustom),
                          //     Text(
                          //       '${e.ratings ?? '4.2'}',
                          //       style: TextStyle(
                          //           fontFamily: MyFont.myFont,
                          //           color: Colors.black,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList());
    }
    return const Text(
      "No Services Found",
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  Widget _selectedData() {
    if (controller.businessTrueServiceList.value?.length != null) {
      return Wrap(
          runSpacing: 15,
          spacing: 15,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: controller.businessTrueServiceList.value!
              .map((e) => (e.isSelected == true)
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.businessServiceName ?? '',
                                style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(width: 15),
                            Row(
                              children: [
                                Text(
                                  '${e.tokens ?? ''}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  'AED',
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container())
              .toList());
    }
    return Container();
  }

  void _selectService(BusinessAppointmentServicesModel e) {
    if (e.isSelected == true) {
      e.isSelected = false;
      controller.toTimeController.clear();
    } else {
      e.isSelected = true;
    }

    updateControllers();
    controller.update();
  }

  void updateControllers() {
    if (controller.fromTimeController.text.isNotEmpty) {
      List<String> timeParts = controller.fromTimeController.text.split(':');
      int hours = int.parse(timeParts[0]);
      int minutes = int.parse(timeParts[1]);
      controller.fromTime = TimeOfDay(hour: hours, minute: minutes);
    }

    controller.totalCoinsNeed = 0;
    controller.totalDurationTime = 0;

    for (var service in controller.businessTrueServiceList.value!) {
      if (service.isSelected == true) {
        controller.totalCoinsNeed += service.tokens ?? 0;
        controller.totalDurationTime += service.durationMinutes ?? 0;
      }
    }

    int addingServiceHours = controller.totalDurationTime ~/ 60;
    int addingServiceMinutes = controller.totalDurationTime % 60;
    controller.addedServiceTime =
        TimeOfDay(hour: addingServiceHours, minute: addingServiceMinutes);

    // Update toTimeController only if there are selected services
    if (controller.totalCoinsNeed > 0) {
      int totalMinutes =
          (controller.fromTime.hour * 60 + controller.fromTime.minute) +
              (controller.addedServiceTime.hour * 60 +
                  controller.addedServiceTime.minute);
      int hours1 = totalMinutes ~/ 60;
      int minutes2 = totalMinutes % 60;
      TimeOfDay addedServiceTimeOfDay =
          TimeOfDay(hour: hours1, minute: minutes2);
      String hourString = addedServiceTimeOfDay.hour.toString().padLeft(2, '0');
      String minuteString =
          addedServiceTimeOfDay.minute.toString().padLeft(2, '0');
      String timeString = '$hourString:$minuteString';
      controller.toTimeController.text = timeString;
    } else {
      // Clear toTimeController if no services are selected
      controller.toTimeController.clear();
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final DateTime currentTime = DateTime.now();

    final TimeOfDay? picked = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 280,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    (selectedTime.minute -
                        selectedTime.minute % 15), // Adjust initial minute
                  ),
                  minimumDate: DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    controller.minimumTime.hour,
                    controller.minimumTime.minute,
                  ),
                  maximumDate: DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    controller.maximumTime.hour,
                    controller.maximumTime.minute,
                  ),
                  onDateTimeChanged: (DateTime newDateTime) {
                    final selectedTime = TimeOfDay.fromDateTime(newDateTime);
                    final selectedDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );

                    if (newDateTime.isAfter(currentTime) &&
                        selectedTime.hour >= controller.minimumTime.hour &&
                        selectedTime.hour <= controller.maximumTime.hour) {
                      // Update the selectedTime in the controller
                      this.selectedTime = selectedTime;

                      // Update the fromTimeController text in the controller
                      controller.fromTimeController.text =
                          "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
                    }
                  },
                  use24hFormat: true,
                  minuteInterval: 15,
                ),
              ),
              CupertinoButton(
                child: const Text('OK'),
                onPressed: () {
                  final selectedTime = this.selectedTime;
                  final selectedDateTime = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );

                  if (selectedDateTime.isAfter(currentTime) &&
                      selectedTime.hour >= controller.minimumTime.hour &&
                      selectedTime.hour <= controller.maximumTime.hour) {
                    Navigator.of(context).pop(selectedTime);
                  }
                },
              ),
            ],
          ),
        );
      },
    );

    if (picked != null) {
      // No need to update the state here
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    String formattedDate =
        DateFormat("yyyy-MM-dd").format(DateTime.now().toLocal());

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(currentDate.year, currentDate.month, currentDate.day),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;

        if (formattedDate ==
            DateFormat("yyyy-MM-dd").format(picked.toLocal())) {
          // If selected date is the same as the current date
          int updatedCloseHrsTime = controller.closeHrsTime;
          int updatedCloseMinTime =
              controller.closeMinTime - 30; // Subtracting 30 minutes

          if (updatedCloseMinTime < 0) {
            updatedCloseHrsTime -= 1; // Subtract 1 hour
            updatedCloseMinTime +=
                60; // Add 60 minutes to adjust negative minutes
          }

          if (updatedCloseHrsTime < 0) {
            updatedCloseHrsTime =
                23; // If the result is negative, set it to 23 (assuming a 24-hour format)
          }

          controller.minimumTime = TimeOfDay.fromDateTime(DateTime.now());
          controller.maximumTime =
              TimeOfDay(hour: updatedCloseHrsTime, minute: updatedCloseMinTime);
        } else {
          int updatedCloseHrsTime = controller.closeHrsTime;
          int updatedCloseMinTime =
              controller.closeMinTime - 30; // Subtracting 30 minutes

          if (updatedCloseMinTime < 0) {
            updatedCloseHrsTime -= 1; // Subtract 1 hour
            updatedCloseMinTime +=
                60; // Add 60 minutes to adjust negative minutes
          }

          if (updatedCloseHrsTime < 0) {
            updatedCloseHrsTime =
                23; // If the result is negative, set it to 23 (assuming a 24-hour format)
          }
          // If selected date is not the current date
          controller.minimumTime = TimeOfDay(
              hour: controller.openHrsTime, minute: controller.openMinTime);
          controller.maximumTime =
              TimeOfDay(hour: updatedCloseHrsTime, minute: updatedCloseMinTime);
        }

        selectedTime = controller.minimumTime;

        controller.dateController.text =
            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";

        controller.date =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        controller.fromTimeController.clear();
      });
    }
  }
}
