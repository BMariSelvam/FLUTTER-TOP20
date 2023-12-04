import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Const/size.dart';
import 'package:top_20/Helper/extension.dart';
import 'package:top_20/Screens/Success/successscreen.dart';
import 'package:top_20/Widget/submitbutton.dart';
import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Helper/datautils.dart';
import '../../../Model/appointmentmodel.dart';
import '../../../Widget/appointmentdetailrow.dart';
import 'businessconfirmappiointmentdetailsController.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  late BusinessConfirmAppointmentController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = Get.put(BusinessConfirmAppointmentController());
    _controller.appointment = Get.arguments as Appointment;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessConfirmAppointmentController>(builder: (logic) {
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
                              child: webImage(
                                imageUrl: _controller.appointment.memberData
                                        ?.first.filePath ??
                                    "",
                                fit: BoxFit.fill,
                              )),
                        ),
                        const SizedBox(height: 20),
                        Flexible(
                          child: Text(
                            capitalizeFirstLetter(_controller.appointment
                                    .memberData?.first.displayName ??
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
                        Flexible(
                          child: Text(
                            _controller.appointment.memberData?.first.emailId ??
                                "",
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
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppointmentDetailRow(
                      appointmentItem: 'User ID',
                      appointmentName:
                          "${_controller.appointment.memberData?.first.memberId}",
                    ),
                    const SizedBox(height: 20),
                    AppointmentDetailRow(
                      appointmentItem: 'Contact Number',
                      appointmentName:
                          "${_controller.appointment.memberData?.first.mobileNo}",
                    ),
                    const SizedBox(height: 20),
                    AppointmentDetailRow(
                      appointmentItem: 'Appointment Date',
                      appointmentName: formatDate(
                          _controller.appointment.appoinmentDate ?? ""),
                    ),
                    const SizedBox(height: 20),
                    AppointmentDetailRow(
                      appointmentItem: 'Appointment No',
                      appointmentName:
                          "${_controller.appointment.appoinmentNo}",
                    ),
                    const SizedBox(height: 20),
                    AppointmentDetailRow(
                      appointmentItem: 'Appointment Timing',
                      appointmentName:
                          '${TimeUtils.toHHMM(dateString: _controller.appointment?.appoinmentFromTime ?? "")} - ${TimeUtils.toHHMM(dateString: _controller.appointment?.appoinmentToTime ?? "")}',
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
                        Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Text(
                              [
                                _controller.appointment.memberData?.first
                                    .addressLine1!,
                                if (_controller.appointment.memberData?.first
                                        .addressLine2?.isNotEmpty ==
                                    true)
                                  _controller.appointment.memberData?.first
                                      .addressLine2!,
                                if (_controller.appointment.memberData?.first
                                        .addressLine3?.isNotEmpty ==
                                    true)
                                  _controller.appointment.memberData?.first
                                      .addressLine3!,
                                if (_controller.appointment.memberData?.first
                                        .city?.isNotEmpty ==
                                    true)
                                  _controller
                                      .appointment.memberData?.first.city!,
                                if (_controller.appointment.memberData?.first
                                        .country?.isNotEmpty ==
                                    true)
                                  _controller
                                      .appointment.memberData?.first.country!,
                                if (_controller.appointment.memberData?.first
                                        .postalCode?.isNotEmpty ==
                                    true)
                                  _controller.appointment.memberData?.first
                                      .postalCode!,
                              ].join(", "),
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ))
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
                    (_controller.appointment.appoinmentDetail != null)
                        ? Container(
                            child: appointmentServiceList(),
                          )
                        : Container(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              (_controller.appointment.status == 2 ||
                      _controller.appointment.status == 3)
                  ? Obx(() {
                      return Expanded(
                          child: SubmitButton(
                        isLoading: _controller.rescheduleIsLoading.value,
                        title: 'Re-Schedule',
                        onTap: () {
                          _showPopUp(context);
                        },
                      ));
                    })
                  : Obx(() {
                      return Expanded(
                          child: SubmitButton(
                        isLoading: _controller.cancelIsLoading.value,
                        title: 'Cancel',
                        onTap: () {
                          _showPopUp(context);
                        },
                      ));
                    }),
              const SizedBox(
                width: 20,
              ),
              (_controller.appointment.status == 2 ||
                      _controller.appointment.status == 3)
                  ? Obx(() {
                      return Expanded(
                        child: SubmitButton(
                          onTap: () {
                            _controller.confirmAppointment(
                                isComplete: true,
                                isCancel: false,
                                isConfirm: false);
                          },
                          title: 'Completed',
                          isLoading: _controller.bookingIsLoading.value,
                        ),
                      );
                    })
                  : Obx(() {
                      return Expanded(
                        child: SubmitButton(
                          onTap: () {
                            _controller.confirmAppointment(
                                isCancel: false,
                                isComplete: false,
                                isConfirm: true);
                          },
                          title: 'Confirm',
                          isLoading: _controller.bookingIsLoading.value,
                        ),
                      );
                    })
            ],
          ),
        ),
      );
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
              'Reschedule',
              style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Text(
            'Do you want to Reschedule this \n Appointment',
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
                    Get.toNamed(Routes.businessRescheduleScreen,
                        arguments: _controller.appointment);
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
                    _controller.confirmAppointment(
                        isCancel: true, isComplete: false, isConfirm: false);
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

  appointmentServiceList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: _controller.appointment.appoinmentDetail?.length,
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
                Expanded(
                  flex: 3,
                  child: Text(
                    _controller
                            .appointment.appoinmentDetail?[index].serviceName ??
                        '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  flex: 2,
                  child: Text(
                    "${_controller.appointment.appoinmentDetail?[index].coins}" ??
                        '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
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
