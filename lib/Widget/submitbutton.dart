import 'package:flutter/material.dart';

import '../Const/font.dart';
import '../Const/size.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final Function onTap;
  const SubmitButton(
      {Key? key,
      required this.isLoading,
      required this.onTap,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () {
              onTap();
            },
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.transparent,
        minimumSize: Size(width(context), 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // <-- Radius
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              title,
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
    );
  }
}
