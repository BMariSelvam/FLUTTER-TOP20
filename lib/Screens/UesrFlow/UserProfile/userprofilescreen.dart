import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:top_20/Const/approute.dart';
import 'package:top_20/Helper/extension.dart';

import 'package:top_20/Screens/UesrFlow/UserBottomNavBar/userbottomnavbar.dart';

import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Const/font.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/Member_details_model.dart';
import '../../../Widget/dottedline.dart';
import 'ResetPassword/resetpasswordscreen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  var memberId;
  MemberDetails? memberDetails;

  _initialiseData() async {
    memberDetails = await PreferenceHelper.getMemberData();
    setState(() {
      memberId = memberDetails?.memberId;
    });
  }

  @override
  void initState() {
    print("===============1");
    // TODO: implement initState
    super.initState();
    _initialiseData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Get.back();
        return true; // Allow back navigation
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                "MY PROFILE",
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                ),
              ),
              centerTitle: true,
              expandedHeight: 300,
              pinned: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => UserBottomNavBar()));
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
              flexibleSpace: Padding(
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
                            imageUrl: memberDetails?.FilePath ?? '',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        child: Text(
                          capitalizeFirstLetter(
                              memberDetails?.displayName ?? ""),
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
                          memberDetails?.emailId ?? "",
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
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    ListTile(
                      tileColor: MyColors.regColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onTap: () {
                        Get.toNamed(Routes.editProfileScreen);
                      },
                      title: Text(
                        "Profile Update",
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      tileColor: MyColors.regColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const ResetPassword()));
                      },
                      title: Text(
                        "Change Password",
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
