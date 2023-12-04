import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:top_20/Screens/BusinessFlow/Specialist/SpecialistInvite/specialistinvitecontroller.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/extension.dart';
import '../../../../Widget/submitbutton.dart';

class SpecialistInviteScreen extends StatefulWidget {
  const SpecialistInviteScreen({Key? key}) : super(key: key);

  @override
  State<SpecialistInviteScreen> createState() => _SpecialistInviteScreenState();
}

class _SpecialistInviteScreenState extends State<SpecialistInviteScreen> {
  late SpecialistInviteController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(SpecialistInviteController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            title: Text(
              capitalizeFirstLetter(
                  controller.specialistListModel.specilistName ?? ""),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: MyFont.myFont,
              ),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
                background: Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: webImage(
                          imageUrl:
                              controller.specialistListModel.filePath ?? "",
                          fit: BoxFit.fill,
                        )),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: Text(
                      capitalizeFirstLetter(
                          controller.specialistListModel.businessCategoryname ??
                              ""),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: MyColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RatingBarIndicator(
                    rating: controller.specialistListModel.ratingValue ?? 2,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                  ),
                ],
              ),
            )),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Services",
                  //   overflow: TextOverflow.ellipsis,
                  //   style: TextStyle(
                  //     fontFamily: MyFont.myFont,
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // InviteSpecialistDetailServiceList(
                  //     specialistServiceModel: controller.specialistListModel),
                  // const SizedBox(height: 20),
                  Text(
                    "About",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    capitalizeFirstLetter(
                        controller.specialistListModel.bioInfo ?? ""),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Contact Details",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "  Mobile Number : ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          controller.specialistListModel.mobileNo ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "  Email Id : ",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          controller.specialistListModel.emailId ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: width(context) / 3,
                child: SubmitButton(
                    isLoading: false,
                    onTap: () {
                      Get.back();
                    },
                    title: "Back")),
            SizedBox(
                width: width(context) / 3,
                child: SubmitButton(
                    isLoading: false,
                    onTap: () {
                      controller.callInviteSpecialist();
                    },
                    title: "Invite")),
          ],
        ),
      ),
    );
  }
}

class InviteSpecialistDetailServiceList extends StatefulWidget {
  final specialistServiceModel;
  const InviteSpecialistDetailServiceList(
      {super.key, this.specialistServiceModel});

  // const SpecialistDetailServiceList({Key? key}) : super(key: key);

  @override
  State<InviteSpecialistDetailServiceList> createState() =>
      _InviteSpecialistDetailServiceListState();
}

class _InviteSpecialistDetailServiceListState
    extends State<InviteSpecialistDetailServiceList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: widget.specialistServiceModel.servicesList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 8),
                const SizedBox(width: 20),
                Text(
                  capitalizeFirstLetter(
                    '${widget.specialistServiceModel.servicesList[index].businessServiceName ?? ""}',
                  ),
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
