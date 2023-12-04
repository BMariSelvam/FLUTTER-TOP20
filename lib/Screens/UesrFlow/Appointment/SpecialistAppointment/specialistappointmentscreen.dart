import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:top_20/Const/size.dart';
import 'package:top_20/Screens/UesrFlow/Appointment/SpecialistAppointment/specialistappointmentcontroller.dart';
import 'package:top_20/Widget/textformfield.dart';
import 'package:top_20/Widget/togglebutton.dart';

import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Helper/extension.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/specialistmodel.dart';
import '../../../../Model/specialistservicemodel.dart';
import '../../../../Model/userspecialistappointmentmodel.dart';
import '../../../../Widget/CustomToggleButton.dart';
import '../../../../Widget/ToggleButtonAppoitment.dart';
import '../../../../Widget/dottedline.dart';
import '../../../../Widget/submitbutton.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late AppointmentController controller;

  SpecialistListModel? specialistListModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(AppointmentController());
    specialistListModel = Get.arguments as SpecialistListModel;
    controller.getBusinessServicesList(specialistListModel?.specialistId);
    controller.getSpeciliast(specialistListModel?.specialistId);
    print(controller.specilaist.value?.first.customerPlace);
    print(controller.specilaist.value?.first.businessPalce);
    print("==========");
    print(specialistListModel?.ratingValue);
  }

  DateTime selectedDate = DateTime.now();
  String formattedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now().toLocal());
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay minimumTime = TimeOfDay(hour: 10, minute: 0);
  TimeOfDay maximumTime = TimeOfDay(hour: 16, minute: 0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(builder: (logic) {
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: SizedBox(
                                height: 80,
                                width: 80,
                                child: webImage(
                                  imageUrl: specialistListModel?.filePath ?? '',
                                )),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  capitalizeFirstLetter(
                                    specialistListModel?.displayName ?? "",
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
                                      rating:
                                          specialistListModel?.ratingValue ?? 0,
                                      itemBuilder: (context, index) =>
                                          const Icon(
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
                            specialistListModel?.businessCategoryname ?? ""),
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
                  padding: const EdgeInsets.all(18.0),
                  physics: const ScrollPhysics(),
                  child: Form(
                    key: controller.appointmentKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
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
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                  icon: const Icon(
                                      Icons.calendar_month_outlined)),
                              onTap: () async {
                                _selectDate(context);
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
                                    controller: controller.fromTimeController,
                                    labelText: "",
                                    hintText: "Time",
                                    readOnly: true,
                                    labelTextStyle:
                                        TextStyle(fontFamily: MyFont.myFont),
                                    textStyle:
                                        TextStyle(fontFamily: MyFont.myFont),
                                    inputFormatters: [],
                                    maxLength: 100,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        if (controller
                                            .dateController.text.isNotEmpty) {
                                          _selectTime(context);
                                        } else {
                                          Fluttertoast.showToast(
                                            msg:
                                                "Please Choose the Appointment date First",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                          );
                                        }
                                        if (controller
                                            .toTimeController.text.isNotEmpty) {
                                          controller.toTimeController.clear();
                                          setState(() {
                                            var selectedItems = controller
                                                .specialistServiceList.value
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
                                          Icons.access_time_outlined),
                                    ),
                                    onTap: () async {
                                      if (controller
                                          .dateController.text.isNotEmpty) {
                                        _selectTime(context);
                                      } else {
                                        // Display an error message when the date is not selected
                                        Fluttertoast.showToast(
                                          msg:
                                              "Please Choose Appointment Date First",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      }
                                      if (controller
                                          .toTimeController.text.isNotEmpty) {
                                        controller.toTimeController.clear();
                                        setState(() {
                                          var selectedItems = controller
                                              .specialistServiceList.value
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
                                    labelTextStyle:
                                        TextStyle(fontFamily: MyFont.myFont),
                                    textStyle:
                                        TextStyle(fontFamily: MyFont.myFont),
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
                        Text(
                          "Select Services",
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: height(context) / 50),
                        _Listview(),
                        SizedBox(height: height(context) / 50),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    controller.isViewPressed.value =
                                        !controller.isViewPressed.value;
                                  });
                                },
                                child: Text(controller.isViewPressed.value
                                    ? "View All"
                                    : "View less"))),
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
                                (controller.specilaist.value?.first
                                                .customerPlace ==
                                            true &&
                                        controller.specilaist.value?.first
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
                                          (controller.specilaist.value?.first
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
                                                                .isBusinessOn
                                                                .value = false;
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
                                          (controller.specilaist.value?.first
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
                                                                  .value =
                                                              !controller
                                                                  .isBusinessOn
                                                                  .value;
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
                        SizedBox(height: height(context) / 40),
                        Obx(() {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Checkout',
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              _selectedData(),
                            ],
                          );
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
                                          const SizedBox(width: 15),
                                          Row(
                                            children: [
                                              Text(
                                                "${controller.totalCoinsNeed}",
                                                style: TextStyle(
                                                    fontFamily: MyFont.myFont,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(width: 15),
                                              Text('AED',
                                                  style: TextStyle(
                                                    fontFamily: MyFont.myFont,
                                                    fontWeight: FontWeight.w600,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
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
                      ],
                    ),
                  )),
            )
          ],
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Obx(() {
              return SubmitButton(
                  isLoading: controller.isLoading.value,
                  onTap: () {
                    if (controller.appointmentKey.currentState!.validate()) {
                      controller.userAppointmentCreateModel =
                          UserSpecialistAppointmentCreateModel(
                              orgId: 1,
                              specialistId:
                                  (specialistListModel?.specialistId != null)
                                      ? specialistListModel?.specialistId
                                      : specialistListModel?.favSpecialistId,
                              memberId: controller.memberDetails?.memberId,
                              appointmentDate: controller.date,
                              appoinmentFromTime:
                                  controller.fromTimeController.text,
                              appoinmentToTime:
                                  controller.toTimeController.text,
                              totailCoinsPaid: controller.totalCoinsNeed,
                              businessId: "0",
                              serviceLocation:
                                  (controller.isBusinessPlace) ? 0 : 1,
                              isRescheduled: false,
                              status: 1,
                              paymentStatus: 1,
                              createdBy: controller.memberDetails?.memberId,
                              appoinmentDetail: controller
                                  .specialistTrueServiceList.value
                                  ?.where(
                                      (element) => element.isSelected == true)
                                  .toList());
                      controller.userAppointmentSpecialist();
                    }
                  },
                  title: "Request Booking");
            })),
      );
    });
  }

  Widget _Listview() {
    if (controller.specialistTrueServiceList.value?.length != null) {
      return Wrap(
          runSpacing: 0,
          spacing: 0,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: controller.specialistTrueServiceList.value!
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
                        e.isSelected == true ? MyColors.tabBar : Colors.white,
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
                                  }),
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
                                    SizedBox(
                                      width: width(context) / 3,
                                      child: Text(
                                        e.serviceName ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          '${e.ratings ?? '4.2'}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: MyFont.myFont,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
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
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_outlined,
                                            color: MyColors.primaryCustom,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${e.durationMinutes ?? ""} Mins",
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
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList());
    }
    return const Center(
      child: Text(
        "No Services Found",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _selectedData() {
    if (controller.specialistTrueServiceList.value?.isNotEmpty == true) {
      return Wrap(
          runSpacing: 0,
          spacing: 0,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: controller.specialistTrueServiceList.value!
              .map((e) => (e.isSelected == true)
                  ? Column(
                      children: [
                        SizedBox(height: height(context) / 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(e.serviceName ?? '',
                                    style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.w600)),

                                // Text(
                                //     '-${_appointmentController.specialistServiceList.value?.first.tokens}',
                                //     style: TextStyle(
                                //         fontFamily: Constant.myFont,
                                //         fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(width: 15),
                            Row(
                              children: [
                                Text(
                                  '${e.tokens ?? ''}',
                                  style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  'AED',
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.w600,
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

  void _selectService(SpecialistServicesModel e) {
    if (e.isSelected == true) {
      e.isSelected = false;
    } else {
      e.isSelected = true;
    }

    if (controller.fromTimeController.text.isNotEmpty) {
      List<String> timeParts = controller.fromTimeController.text.split(':');
      int hours = int.parse(timeParts[0]);
      int minutes = int.parse(timeParts[1]);

      controller.fromTime = TimeOfDay(hour: hours, minute: minutes);
    }

    controller.totalCoinsNeed = 0;
    controller.totalDurationTime = 0;

    for (var service in controller.specialistTrueServiceList.value!) {
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

    controller.update();
  }

  // appointmentBookingList() {
  //   return ListView.builder(
  //       padding: const EdgeInsets.all(0),
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemCount: controller.isViewPressed.value ? 3 : 10,
  //       shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         return Card(
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //             child: Row(
  //               children: [
  //                 SizedBox(
  //                   height: 80,
  //                   width: 80,
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                         color: MyColors.regColor,
  //                         borderRadius: BorderRadius.circular(10.0)),
  //                     child: Center(
  //                       child: SizedBox(
  //                         height: 60,
  //                         width: 60,
  //                         child: Image.asset(
  //                           Assets.profile,
  //                           fit: BoxFit.fill,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 20),
  //                 Flexible(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             "Select Services",
  //                             maxLines: 2,
  //                             overflow: TextOverflow.ellipsis,
  //                             style: TextStyle(
  //                               fontFamily: MyFont.myFont,
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 18,
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             child: Row(
  //                               children: [
  //                                 const Icon(
  //                                   Icons.star_rounded,
  //                                   color: Colors.amber,
  //                                 ),
  //                                 Text(
  //                                   "3.9",
  //                                   style: TextStyle(
  //                                     fontFamily: MyFont.myFont,
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                       const SizedBox(height: 20),
  //                       Row(
  //                         children: [
  //                           SizedBox(
  //                             child: Row(
  //                               children: [
  //                                 Image.asset(Assets.coin),
  //                                 const SizedBox(width: 5),
  //                                 Text(
  //                                   "120",
  //                                   style: TextStyle(
  //                                     fontFamily: MyFont.myFont,
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 18,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           const SizedBox(width: 20),
  //                           SizedBox(
  //                             child: Row(
  //                               children: [
  //                                 Icon(
  //                                   Icons.access_time_outlined,
  //                                   color: MyColors.primaryCustom,
  //                                 ),
  //                                 const SizedBox(width: 5),
  //                                 Text(
  //                                   "45 Mins",
  //                                   style: TextStyle(
  //                                     fontFamily: MyFont.myFont,
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 18,
  //                                     color: MyColors.grey,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
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
                    minimumTime.hour,
                    minimumTime.minute,
                  ),
                  maximumDate: DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    maximumTime.hour,
                    maximumTime.minute,
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
                        selectedTime.hour >= minimumTime.hour &&
                        selectedTime.hour <= maximumTime.hour) {
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
                      selectedTime.hour >= minimumTime.hour &&
                      selectedTime.hour <= maximumTime.hour) {
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
          minimumTime = TimeOfDay.fromDateTime(DateTime.now());
          maximumTime = TimeOfDay(hour: 23, minute: 45);
        } else {
          // If selected date is not the current date
          minimumTime = TimeOfDay(hour: 00, minute: 0);
          maximumTime = TimeOfDay(hour: 23, minute: 45);
        }

        selectedTime = minimumTime;
        controller.dateController.text =
            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
        controller.date =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        controller.fromTimeController.clear();
      });
    }
  }
}
