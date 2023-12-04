import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:top_20/Screens/UesrFlow/UserDashBoard/userdashboardscreen.dart';
import 'package:top_20/Screens/UesrFlow/UserProfile/userprofilescreen.dart';

import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/Member_details_model.dart';
import '../UserRatingsandReview/userratingandreviewscreen.dart';

class UserBottomNavBar extends StatefulWidget {
  int currentIndex;
  int previousIndex;
  UserBottomNavBar({
    this.currentIndex = 0,
    this.previousIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<UserBottomNavBar> createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  var memberId;

  MemberDetails? memberDetails;

  _initialiseData() async {
    await PreferenceHelper.getMemberData().then((value) {
      setState(() {
        memberDetails = value;
        memberId = memberDetails?.memberId;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialiseData();
  }

  void _onItemTapped(int index) async {
    setState(() {
      widget.previousIndex = widget.currentIndex;
      widget.currentIndex = index;
    });
  }

  void _onBackPressed() {
    setState(() {
      widget.currentIndex = widget.previousIndex;
    });
  }

  final tab = const [
    UserDashBoardScreen(),
    UserRatingsAndReviewsScreen(),
    //(memberDetails != null) ? UserProfileScreen() : LoginScreen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.currentIndex != 0) {
          _onBackPressed();
        }
        return false;
      },
      child: Scaffold(
        body: tab.elementAt(widget.currentIndex),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    activeIcon:
                        Image.asset(Assets.home, color: MyColors.primaryCustom),
                    icon: Image.asset(Assets.home),
                    label: ""),
                BottomNavigationBarItem(
                    activeIcon: Image.asset(Assets.calender,scale: 2,
                        color: MyColors.primaryCustom),
                    icon: Image.asset(Assets.calender,scale: 2,),
                    label: ""),
                BottomNavigationBarItem(
                    activeIcon:
                        Image.asset(Assets.user, color: MyColors.primaryCustom),
                    icon: Image.asset(Assets.user),
                    label: ""),
              ],
              currentIndex: widget.currentIndex,
              selectedItemColor: MyColors.primaryCustom,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
