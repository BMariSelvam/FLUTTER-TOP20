import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_20/Helper/extension.dart';

import '../Const/colors.dart';
import '../Const/font.dart';

class AppointmentDetailRow extends StatefulWidget {
  final String appointmentItem;
  final String appointmentName;
  const AppointmentDetailRow({
    Key? key,
    required this.appointmentItem,
    required this.appointmentName,
  }) : super(key: key);

  @override
  State<AppointmentDetailRow> createState() => _AppointmentDetailRowState();
}

class _AppointmentDetailRowState extends State<AppointmentDetailRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            widget.appointmentItem,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: MyColors.darkGrey,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            capitalizeFirstLetter(widget.appointmentName),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        )
      ],
    );
  }

}
