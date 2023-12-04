import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Const/size.dart';

import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Widget/Constructors/constructors.dart';
import 'businessappointmentdetailcontroller.dart';
import 'businesscancelledappointmentscreen.dart';
import 'businesscompletedappointmentlistscreen.dart';
import 'businessconfirmedappointmentscreen.dart';
import 'businessopenappointmentlistview.dart';

class BusinessAppointmentDetails extends StatefulWidget {
  bool? isOpenClick;
  bool? isConfirmed;
  bool? isCompleted;
  bool? isCancelled;
  BusinessAppointmentDetails(
      {Key? key,
      this.isOpenClick,
      this.isCompleted,
      this.isCancelled,
      this.isConfirmed})
      : super(key: key);

  @override
  State<BusinessAppointmentDetails> createState() =>
      _BusinessAppointmentDetailsState();
}

class _BusinessAppointmentDetailsState
    extends State<BusinessAppointmentDetails> {
  late BusinessAppointmentDetailController controller;
  String? businessId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(BusinessAppointmentDetailController());
    controller.intialfunc();
  }

  List<AppointmentDetailsList> appointmentDetailsList = [
    AppointmentDetailsList(image: Assets.appointment3, text: 'Requested'),
    AppointmentDetailsList(image: Assets.appointment1, text: 'Confirmed'),
    AppointmentDetailsList(image: Assets.appointment2, text: 'Completed'),
    AppointmentDetailsList(image: Assets.appointment4, text: 'Cancelled'),
  ];

  List<Function> get onTapFunctions {
    return [
      () {
        setState(() {
          if (widget.isOpenClick = true) {
            widget.isCancelled = false;
            widget.isConfirmed = false;
            widget.isCompleted = false;
            print("Appointment 1 tapped!");
            // Your custom logic for Appointment 1 here
          }
        });
      },
      () {
        setState(() {
          if (widget.isConfirmed = true) {
            widget.isCancelled = false;
            widget.isOpenClick = false;
            widget.isCompleted = false;
            print("Appointment 2 tapped!");
            // Your custom logic for Appointment 1 here
          }
        });

        // Your custom logic for Appointment 2 here
      },
      () {
        setState(() {
          if (widget.isCompleted = true) {
            widget.isCancelled = false;
            widget.isOpenClick = false;
            widget.isConfirmed = false;
            print("Appointment 3 tapped!");
          }
        });
      },
      () {
        setState(() {
          if (widget.isCancelled = true) {
            widget.isOpenClick = false;
            widget.isConfirmed = false;
            widget.isCompleted = false;
            print("Appointment 4 tapped!");
          }
        });
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessAppointmentDetailController>(builder: (logic) {
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
              expandedHeight: 220,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
              title: Text(
                "APPOINTMENT",
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                ),
              ),
              centerTitle: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 80, 0, 10),
                    child: SizedBox(
                      height: height(context) / 10,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => onTapFunctions[index](),
                              child: SizedBox(
                                width: width(context) / 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: (appointmentDetailsList[index]
                                                    .text ==
                                                'Requested' &&
                                            widget.isOpenClick == true)
                                        ? MyColors.white
                                        : (appointmentDetailsList[index].text ==
                                                    'Cancelled' &&
                                                widget.isCancelled == true)
                                            ? MyColors.white
                                            : (appointmentDetailsList[index]
                                                            .text ==
                                                        'Confirmed' &&
                                                    widget.isConfirmed == true)
                                                ? MyColors.white
                                                : (appointmentDetailsList[index]
                                                                .text ==
                                                            'Completed' &&
                                                        widget.isCompleted ==
                                                            true)
                                                    ? MyColors.white
                                                    : MyColors.textFieldTheme,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: MyColors.white),
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Center(
                                      child: Text(
                                        appointmentDetailsList[index].text,
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          color: (appointmentDetailsList[index]
                                                          .text ==
                                                      'Requested' &&
                                                  widget.isOpenClick == true)
                                              ? MyColors.primaryCustom
                                              : (appointmentDetailsList[index]
                                                              .text ==
                                                          'Cancelled' &&
                                                      widget.isCancelled ==
                                                          true)
                                                  ? MyColors.primaryCustom
                                                  : (appointmentDetailsList[
                                                                      index]
                                                                  .text ==
                                                              'Confirmed' &&
                                                          widget.isConfirmed ==
                                                              true)
                                                      ? MyColors.primaryCustom
                                                      : (appointmentDetailsList[
                                                                          index]
                                                                      .text ==
                                                                  'Completed' &&
                                                              widget.isCompleted ==
                                                                  true)
                                                          ? MyColors
                                                              .primaryCustom
                                                          : MyColors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  child: buildAppointmentListView(),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  //ListViewCondition

  buildAppointmentListView() {
    if (widget.isOpenClick == true) {
      return const BusinessOpenListViewBuilder(); // Your Open appointment list view
    } else if (widget.isConfirmed == true) {
      return const BusinessConfirmListViewBuilder();
    } else if (widget.isCompleted == true) {
      return const BusinessCompleteListViewBuilder();
    } else if (widget.isCancelled == true) {
      return const BusinessCancelledListViewBuilder();
    } else {
      // Default case, return a placeholder or an empty widget
      return Container();
    }
  }
}
