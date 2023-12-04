import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Const/size.dart';
import 'package:top_20/Helper/extension.dart';

import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Helper/datautils.dart';
import '../../../Model/appointmentmodel.dart';
import 'businessappointmentdetailcontroller.dart';

class BusinessCompleteListViewBuilder extends StatefulWidget {
  const BusinessCompleteListViewBuilder({Key? key}) : super(key: key);

  @override
  State<BusinessCompleteListViewBuilder> createState() =>
      _BusinessCompleteListViewBuilderState();
}

class _BusinessCompleteListViewBuilderState
    extends State<BusinessCompleteListViewBuilder> {
  List<Appointment> appointmentCompleted = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BusinessAppointmentDetailController controller =
        Get.find<BusinessAppointmentDetailController>();
    appointmentCompleted = controller.appointmentList
        .where((element) => (element.status == 5))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessAppointmentDetailController>(builder: (logic) {
      return (appointmentCompleted.isNotEmpty)
          ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: appointmentCompleted.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: MyColors.regColor,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Booking Date  :  ',
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                              ),
                            ),
                            Text(
                              formatDate(
                                  appointmentCompleted[index].appoinmentDate ??
                                      ""),
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time_outlined,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${TimeUtils.toHHMM(dateString: appointmentCompleted[index].appoinmentFromTime)} - ${TimeUtils.toHHMM(dateString: appointmentCompleted[index].appoinmentToTime)}',
                                style: TextStyle(
                                  fontFamily: MyFont.myFont,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          color: MyColors.grey,
                          thickness: 1,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.asset(
                                  Assets.profile,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: SizedBox(
                                        width: width(context),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              appointmentCompleted[index]
                                                      .memberData
                                                      ?.first
                                                      .displayName ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontFamily: MyFont.myFont,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              appointmentCompleted[index]
                                                      .appoinmentNo ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: MyFont.myFont,
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "${appointmentCompleted[index].totailCoinsPaid} AED",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              })
          : Padding(
              padding: const EdgeInsets.only(bottom: 300),
              child: Image.asset(Assets.noData),
            );
    });
  }
}
