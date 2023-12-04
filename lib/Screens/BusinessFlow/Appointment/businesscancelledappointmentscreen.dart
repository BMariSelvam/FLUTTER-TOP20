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

class BusinessCancelledListViewBuilder extends StatefulWidget {
  const BusinessCancelledListViewBuilder({Key? key}) : super(key: key);

  @override
  State<BusinessCancelledListViewBuilder> createState() =>
      _BusinessCancelledListViewBuilderState();
}

class _BusinessCancelledListViewBuilderState
    extends State<BusinessCancelledListViewBuilder> {
  List<Appointment> appointmentCancel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BusinessAppointmentDetailController controller =
        Get.find<BusinessAppointmentDetailController>();
    appointmentCancel = controller.appointmentList
        .where((element) => (element.status == 6))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return (appointmentCancel.isNotEmpty)
        ? ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: appointmentCancel.length,
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
                            'Booking Date : ',
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                            ),
                          ),
                          Text(
                            formatDate(
                                appointmentCancel[index].appoinmentDate ?? ""),
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
                              '${TimeUtils.toHHMM(dateString: appointmentCancel[index].appoinmentFromTime)} - ${TimeUtils.toHHMM(dateString: appointmentCancel[index].appoinmentToTime)}',
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
                                            appointmentCancel[index]
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
                                            appointmentCancel[index]
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '\$ ${appointmentCancel[index].totailCoinsPaid ?? ''}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
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
  }
}
