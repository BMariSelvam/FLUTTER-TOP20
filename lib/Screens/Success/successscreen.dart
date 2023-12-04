import 'package:flutter/material.dart';

import '../../Const/assets.dart';
import '../../Const/font.dart';
import '../../Widget/submitbutton.dart';

class SuccessfulScreen extends StatefulWidget {
  final String text;
  final bool isLoading;
  final String title;
  final Function onTap;

  const SuccessfulScreen({
    Key? key,
    required this.text,
    required this.isLoading,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SuccessfulScreen> createState() => _SuccessfulScreenState();
}

class _SuccessfulScreenState extends State<SuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.success),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: MyFont.myFont,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SubmitButton(
            isLoading: widget.isLoading,
            onTap: widget.onTap,
            title: widget.title),
      ),
    );
  }
}
