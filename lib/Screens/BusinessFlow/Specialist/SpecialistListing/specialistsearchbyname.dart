import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Const/colors.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Screens/BusinessFlow/Specialist/SpecialistListing/specialistlistcontroller.dart';

import '../../../../Const/approute.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/extension.dart';
import '../../../../Model/specialistmodel.dart';
import '../../../../Widget/textformfield.dart';
import 'GetOverAllSpecialist.dart';

class SpecialistSearchByNameScreen extends StatefulWidget {
  const SpecialistSearchByNameScreen({Key? key}) : super(key: key);

  @override
  State<SpecialistSearchByNameScreen> createState() =>
      _SpecialistSearchByNameScreenState();
}

class _SpecialistSearchByNameScreenState
    extends State<SpecialistSearchByNameScreen> {
  late GetAllSpecialistController controller;

  YourAncestorWidget? ancestor;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(GetAllSpecialistController());
    controller.getSearchSpecialistList();
  }

  String search ="";

  // void listingProfile(String value) {
  //   if (controller.searchByNameController.text.isEmpty) {
  //     controller.displayList.value = controller.specialistList.value;
  //   } else {
  //     controller.displayList.value = controller.specialistList.value
  //         .where((element) =>
  //         element.displayName!.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   }
  // }

  List<SpecialistListModel> filterList(String query) {
    return controller.specialistList.value.where((item) {
      return item.displayName.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
   }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetAllSpecialistController>(builder: (logic) {
      if (logic.isLoading == true) {
        return Scaffold(
          body: Center(
            child: LoadingAnimationWidget.threeRotatingDots(
                color: MyColors.primaryCustom, size: 20),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.scaffold,
          toolbarHeight: 100,
          elevation: 0,
          iconTheme: const IconThemeData(color: MyColors.black),
          leading: IconButton(
              onPressed: () {
                Get.back();
                controller.isAddClick.value = false;
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: CustomTextFormField(
              controller: controller.searchByNameController,
              onChanged: (String? value) {
                setState(() {
                  search = value.toString();
                });
                },
              textStyle: TextStyle(fontFamily: MyFont.myFont),
              inputFormatters: [],
              hintText: "Search",
              hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
              maxLength: 100,
            ),
          ),
        ),
        body: searchingSpecialistListView(),
      );
    });
  }

  searchingSpecialistListView() {
    print("=============================");
    print(controller.specialistList.value.length);
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),

        itemCount: search.isEmpty
            ? controller.specialistList.value.length
            : filterList(search).length,
        itemBuilder: (context, index) {
          final item = search.isEmpty
              ? controller.specialistList.value[index]
              : filterList(search)[index];
          return InkWell(
            onTap: () {
              Get.toNamed(Routes.specialistInviteScreen,
                  arguments: item);
            },
            child: Card(
              color: MyColors.scaffold,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Container(
                          decoration: BoxDecoration(
                            color: MyColors.regColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: webImage(
                                    imageUrl: item.filePath ??
                                        '',
                                  )),
                            ),
                          )),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  '${item.displayName}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              RatingBarIndicator(
                                rating: item.ratingValue ??
                                    2.75,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: MyColors.primaryCustom,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  '${item.specialistId}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
