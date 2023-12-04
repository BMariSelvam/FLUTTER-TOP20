import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Const/approute.dart';
import '../../../Const/colors.dart';
import '../../../Const/font.dart';
import '../../../Helper/extension.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/specialistdetailmodel.dart';
import '../../UesrFlow/UserProfile/ResetPassword/resetpasswordscreen.dart';

class SpecialistUpdateProfile extends StatefulWidget {
  const SpecialistUpdateProfile({Key? key}) : super(key: key);

  @override
  State<SpecialistUpdateProfile> createState() =>
      _SpecialistUpdateProfileState();
}

class _SpecialistUpdateProfileState extends State<SpecialistUpdateProfile> {
  var specialistId;

  SpecialistDetails? specialistDetails;

  initialiseData() async {
    specialistDetails = await PreferenceHelper.getSpecialistData();
    setState(() {
      specialistId = specialistDetails?.specialistId;
    });
    print("Top20========Specialist");
    print("specialist===$specialistId");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiseData();
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
                Get.offAllNamed(Routes.specialistBottomNavBar);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
            title: Text(
              "SPECIALIST PROFILE",
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
                          imageUrl: specialistDetails?.FilePath ?? '',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Flexible(
                      child: Text(
                        capitalizeFirstLetter(
                            specialistDetails?.displayName ?? ""),
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
                        specialistDetails?.emailId ?? "",
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
                      Get.toNamed(Routes.specialistEditProfileScreen);
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
