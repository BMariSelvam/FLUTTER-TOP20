import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_20/Const/size.dart';
import 'package:top_20/Screens/UesrFlow/AppointmentDetail/userappointmentdetailcontroller.dart';

import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Const/font.dart';
import '../../../Helper/datautils.dart';
import '../../../Helper/extension.dart';
import '../../../Model/appointmentmodel.dart';
import '../../../Widget/appointmentdetailrow.dart';

class UserAppointmentDetailScreen extends StatefulWidget {
  const UserAppointmentDetailScreen({super.key});

  @override
  State<UserAppointmentDetailScreen> createState() =>
      _UserAppointmentDetailScreenState();
}

class _UserAppointmentDetailScreenState
    extends State<UserAppointmentDetailScreen> {
  late UserAppointmentController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(UserAppointmentController());
    controller.appointment = Get.arguments as Appointment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 300,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
            title: Text(
              "APPOINTMENT DETAILS",
              style: TextStyle(
                fontFamily: MyFont.myFont,
              ),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: (controller.appointment.businessData != null)
                                ? webImage(
                              imageUrl: controller.appointment
                                  .businessData?.first.logoFilePath ??
                                  Assets.placeHolder,
                              fit: BoxFit.fill,
                            )
                                : webImage(
                              imageUrl: controller.appointment
                                  .specialistData?.first.filePath ??
                                  Assets.placeHolder,
                              fit: BoxFit.fill,
                            )),
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        child: Text(
                          capitalizeFirstLetter(controller.appointment
                              .businessData?.first.displayName ??
                              controller.appointment.specialistData?.first
                                  .displayName ??
                              ''),
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
                      Flexible(
                        child: Text(
                          controller.appointment.businessData?.first.emailId ??
                              controller
                                  .appointment.specialistData?.first.emailId ??
                              '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appointment Status',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: MyColors.darkGrey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Card(
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              controller.appointment.status == 2
                                  ? controller.appointment.status == 3
                                  ? "Reschedule"
                                  : "Confirmed"
                                  : controller.appointment.status == 3
                                  ? "Reschedule"
                                  : "Open",
                              style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: MyColors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  AppointmentDetailRow(
                    appointmentItem:
                    (controller.appointment.businessData != null)
                        ? 'Business ID'
                        : 'Specialist ID',
                    appointmentName:
                    controller.appointment.businessData?.first.businessId ??
                        controller.appointment.specialistData?.first
                            .specialistId ??
                        '',
                  ),
                  const SizedBox(height: 20),
                  AppointmentDetailRow(
                    appointmentItem: 'Contact Number',
                    appointmentName: controller
                        .appointment.businessData?.first.mobileNo ??
                        controller.appointment.specialistData?.first.mobileNo ??
                        '',
                  ),
                  const SizedBox(height: 20),
                  AppointmentDetailRow(
                    appointmentItem: 'Appointment Date',
                    appointmentName: TimeUtils.toDDMMYYYY(
                        dateString:
                        controller.appointment.appoinmentDate ?? ''),
                  ),
                  const SizedBox(height: 20),
                  AppointmentDetailRow(
                    appointmentItem: 'Appointment No',
                    appointmentName: controller.appointment.appoinmentNo ?? '',
                  ),
                  const SizedBox(height: 20),
                  AppointmentDetailRow(
                    appointmentItem: 'Appointment Timing',
                    appointmentName:
                    '${TimeUtils.toHHMM(dateString: controller.appointment.appoinmentFromTime)} - ${TimeUtils.toHHMM(dateString: controller.appointment?.appoinmentToTime)}',
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address",
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: MyColors.darkGrey,
                          )),
                      const SizedBox(height: 10),
                      (controller.appointment.businessData != null)
                          ? Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          [
                            controller.appointment.businessData?.first.addressLine1 ?? "",
                            if (controller.appointment.businessData?.first.addressLine2?.isNotEmpty == true)
                              controller.appointment.businessData?.first.addressLine2!,
                            if (controller.appointment.businessData?.first.addressLine3?.isNotEmpty == true)
                              controller.appointment.businessData?.first.addressLine3!,
                            if (controller.appointment.businessData?.first.city?.isNotEmpty == true)
                              controller.appointment.businessData?.first.city!,
                            if (controller.appointment.businessData?.first.country?.isNotEmpty == true)
                              controller.appointment.businessData?.first.country!,
                            if (controller.appointment.businessData?.first.postalCode?.isNotEmpty == true)
                              controller.appointment.businessData?.first.postalCode!,
                          ].join(", "),
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )

                      )
                          : Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          [
                            controller.appointment.specialistData?.first.addressLine1 ??"",
                            if (controller.appointment.specialistData?.first.addressLine2?.isNotEmpty == true)
                              controller.appointment.specialistData?.first.addressLine2!,
                            if (controller.appointment.specialistData?.first.addressLine3?.isNotEmpty == true)
                              controller.appointment.specialistData?.first.addressLine3!,
                            if (controller.appointment.specialistData?.first.city?.isNotEmpty == true)
                              controller.appointment.specialistData?.first.city!,
                            if (controller.appointment.specialistData?.first.country?.isNotEmpty == true)
                              controller.appointment.specialistData?.first.country!,
                            if (controller.appointment.specialistData?.first.postalCode?.isNotEmpty == true)
                              controller.appointment.specialistData?.first.postalCode!,
                          ].join(", "),
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Booked Services',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColors.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: userAppointmentServiceList(),
                  ),
                  // const AppointmentDetailRow(
                  //   appointmentItem: 'Total Timing',
                  //   appointmentName: '1234567890',
                  // ),
                  // const SizedBox(height: 20),
                  // const AppointmentDetailRow(
                  //   appointmentItem: 'Service Booked',
                  //   appointmentName: '1234567890',
                  // ),
                  // const SizedBox(height: 20),
                  // const SizedBox(height: 20),
                  // (_controller.appointment.status == 2 ||
                  //         _controller.appointment.status == 3)
                  //     ? SubmitButton(
                  //         isLoading: _controller.rescheduleIsLoading.value,
                  //         title: 'Completed',
                  //         onTap: () {
                  //           _controller.confirmAppointment(
                  //               isCancel: false, isComplete: true);
                  //         },
                  //       )
                  //     : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  userAppointmentServiceList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: controller.appointment.appoinmentDetail?.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          color: MyColors.scaffold,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 15,
                  color: MyColors.primaryCustom,
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: width(context) / 2.1,
                  child: Text(
                    controller
                        .appointment.appoinmentDetail?[index].serviceName ??
                        '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColors.black,
                    ),
                  ),
                ),

                const SizedBox(width: 20),
                Flexible(
                  child: Text(
                    "${controller.appointment.appoinmentDetail?[index].coins}" ??
                        '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    "AED",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColors.darkGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}