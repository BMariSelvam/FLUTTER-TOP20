import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:top_20/Const/font.dart';

import '../../../Const/approute.dart';
import '../../../Const/colors.dart';
import '../../../Helper/extension.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/userdetailmodel.dart';
import '../../UesrFlow/UserProfile/ResetPassword/resetpasswordscreen.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({Key? key}) : super(key: key);

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  var businessId;

  BusinessDetailsModel? businessDetailsModel;

  _initialiseData() async {
    businessDetailsModel = await PreferenceHelper.getBusinessData();
    setState(() {
      businessId = businessDetailsModel?.businessId;
    });
    print("Top20========Business");
    print("memberId===$businessId");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialiseData();
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
                Get.offAllNamed(Routes.businessBottomNavBar);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
            title: Text(
              "BUSINESS PROFILE",
              style: TextStyle(
                fontFamily: MyFont.myFont,
              ),
            ),
            centerTitle: true,
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
                          imageUrl: businessDetailsModel?.logoFilePath ?? '',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                      child: Text(
                        capitalizeFirstLetter(
                            businessDetailsModel?.displayName ?? ""),
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
                        businessDetailsModel?.emailId ?? "",
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
                      Get.toNamed(Routes.businessEditProfileScreen);
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
    );
  }
}
