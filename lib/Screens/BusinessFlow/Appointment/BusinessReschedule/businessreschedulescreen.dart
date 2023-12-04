import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/datautils.dart';
import '../../../../Model/appointmentmodel.dart';
import 'businessreschedulecontroller.dart';

class BusinessRescheduleScreen extends StatefulWidget {
  const BusinessRescheduleScreen({Key? key}) : super(key: key);

  @override
  State<BusinessRescheduleScreen> createState() =>
      _BusinessRescheduleScreenState();
}

class _BusinessRescheduleScreenState extends State<BusinessRescheduleScreen> {
  late BusinessRescheduleController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(BusinessRescheduleController());
    controller.appointment = Get.arguments as Appointment;

    // controller.getBusinessSpecialists();
    controller.selectedDate.value =
        TimeUtils.toDDMMYYYY(dateString: controller.appointment.appoinmentDate);
    controller.selectedStartTime.value =
        TimeUtils.toHHMM(dateString: controller.appointment.appoinmentFromTime);
    controller.selectedEndTime.value =
        TimeUtils.toHHMM(dateString: controller.appointment.appoinmentToTime);
    controller.appointmentDate.value =
        DateTime.parse(controller.appointment.appoinmentDate ?? '');
    Duration timeDifference = calculateTimeDifference();
    print("=====================================================");
    print('Time Difference: ${timeDifference.inHours} hours ${timeDifference.inMinutes % 60} minutes');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessRescheduleController>(builder: (logic) {
      if (logic.status == RxStatus.loading()) {
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
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
              title: Text(
                "APPOINTMENT RESCHEDULE",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date",
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(() {
                          return Container(
                            width: width(context),
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Card(
                              color: MyColors.white,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 1),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(controller.selectedDate.value ?? ''),
                                    IconButton(
                                        onPressed: () {
                                          controller.chooseDate();
                                        },
                                        icon: const Icon(
                                          Icons.calendar_month_outlined,
                                          size: 20,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
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
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Obx(() {
                              return Container(
                                width: width(context) / 2.5,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Card(
                                  color: MyColors.white,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 1),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(controller
                                                .selectedStartTime.value ??
                                            ''),
                                        IconButton(
                                            onPressed: () {
                                              controller.chooseStartTime();
                                            },
                                            icon: const Icon(
                                              Icons.schedule,
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
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
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Obx(() {
                              return Container(
                                width: width(context) / 2.5,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Card(
                                  color: MyColors.white,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 1),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(controller.selectedEndTime.value ??
                                            ''),
                                        IconButton(
                                            onPressed: () {

                                            },
                                            icon: const Icon(
                                              Icons.schedule,
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Text(
                    //   "Assign Specialist",
                    //   style: TextStyle(
                    //     fontFamily: MyFont.myFont,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 18,
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    // InkWell(
                    //   onTap: () {
                    //     if (!PreferenceHelper.isSpecialist) {
                    //       showDialog(
                    //           context: context,
                    //           builder: (BuildContext context) {
                    //             return AlertDialog(
                    //               scrollable: true,
                    //               content: setupAlertDialoadContainer(),
                    //             );
                    //           });
                    //     }
                    //   },
                    //   child: Container(
                    //     width: width(context),
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.grey),
                    //       borderRadius: BorderRadius.circular(20.0),
                    //     ),
                    //     child: Card(
                    //       color: MyColors.white,
                    //       elevation: 0,
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(left: 10, right: 10),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Obx(() {
                    //               return Text(controller.selectedSpecialist
                    //                       ?.value?.displayName ??
                    //                   '');
                    //             }),
                    //             IconButton(
                    //               onPressed: () {
                    //                 if (!PreferenceHelper.isSpecialist) {
                    //                   showDialog(
                    //                       context: context,
                    //                       builder: (BuildContext context) {
                    //                         return AlertDialog(
                    //                           scrollable: true,
                    //                           content:
                    //                               setupAlertDialoadContainer(),
                    //                         );
                    //                       });
                    //                 }
                    //               },
                    //               icon: const Icon(
                    //                   Icons.arrow_drop_down_outlined),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    side: const BorderSide(color: MyColors.mainTheme)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                  child: Text(
                    'Cancel',
                    style:
                        TextStyle(fontSize: 18, color: MyColors.primaryCustom),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.rescheduleAppointment();
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                  child: Text(
                    'Request',
                    style: TextStyle(fontSize: 18, color: MyColors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget setupAlertDialogueContainer() {
    return SizedBox(
      height: 300.0, // Change as per your requirement
      width: 300.0,
      child: Obx(() {
        return Scrollbar(
          thickness: 10,
          trackVisibility: true,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.specialistList.length,
            itemBuilder: (BuildContext context, int index) {
              bool isSelected =
                  controller.specialistList.value[index].specialistId ==
                      controller.selectedSpecialist?.value?.specialistId;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: () {
                    controller.selectedSpecialist.value =
                        controller.specialistList.value[index];
                    Get.back();
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xffF58021)
                            : Color(0xffF2F2F2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        controller.specialistList.value[index].displayName ??
                            '',
                        style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontSize: 14,
                            color: isSelected ? Colors.white : Colors.black),
                      )),
                ),
              );
            },
          ),
        );
      }),
    );
  }
  Duration calculateTimeDifference() {
    DateTime fromTime = DateTime.parse(controller.appointment.appoinmentDate ?? '')
        .add(Duration(
      hours: int.parse(controller.appointment.appoinmentFromTime!.split(':')[0]),
      minutes: int.parse(controller.appointment.appoinmentFromTime!.split(':')[1]),
    ));

    DateTime toTime = DateTime.parse(controller.appointment.appoinmentDate ?? '')
        .add(Duration(
      hours: int.parse(controller.appointment.appoinmentToTime!.split(':')[0]),
      minutes: int.parse(controller.appointment.appoinmentToTime!.split(':')[1]),
    ));

    Duration difference = toTime.difference(fromTime);

    return difference;
  }

}
