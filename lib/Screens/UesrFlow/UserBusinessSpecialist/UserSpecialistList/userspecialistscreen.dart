import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Const/colors.dart';
import 'package:top_20/Const/size.dart';
import 'package:top_20/Model/businesscstegorymodel.dart';
import 'package:top_20/Screens/UesrFlow/UserBusinessSpecialist/UserSpecialistList/userspecialistlistcontroller.dart';
import 'package:top_20/Widget/searchdropdowntextfield.dart';

import '../../../../Const/approute.dart';
import '../../../../Const/assets.dart';
import '../../../../Const/font.dart';
import '../../../../Helper/extension.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/Member_details_model.dart';
import '../../../../Model/businessservicemodel.dart';
import '../../../../Model/specialistmodel.dart';
import 'UserFavSpecialistAndBusinessController.dart';

class UserSpecialistScreen extends StatefulWidget {
  const UserSpecialistScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserSpecialistScreen> createState() => _UserSpecialistScreenState();
}

class _UserSpecialistScreenState extends State<UserSpecialistScreen> {
  bool login = false;
  String? businessCategoryId = '';
  String? selectedServiceId = '';
  String? selectedBusinessCategoryId = '';

  var memberId;
  MemberDetails? memberDetails;

  SpecialistListModel? specialistListModel;

  late UserBusinessSpecialistListController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(UserBusinessSpecialistListController());
    controller.getBusinessCategory();
    controller.getBusinessServices(businessCategoryId);
    controller.getSpecialistList();
  }

  initializeData() async {
    memberDetails = await PreferenceHelper.getMemberData();
    setState(() {
      memberId = memberDetails?.memberId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserBusinessSpecialistListController>(builder: (logic) {
      if (logic.isLoading == true) {
        return Scaffold(
          body: Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                  color: MyColors.primaryCustom, size: 20)),
        );
      }
      return WillPopScope(
        onWillPop: () async {
          Get.back();
          return true;
        },
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 200,
                pinned: true,
                title: const Text("TOP TWENTY SPECIALIST"),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 80, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width(context) / 2.3,
                            child: Obx(() {
                              return SearchDropdownTextField<
                                      BusinessCategoryModel>(
                                  hintText: 'Category',
                                  hintTextStyle: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    color: MyColors.white,
                                  ),
                                  textStyle: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    color: MyColors.white,
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.search,
                                    color: MyColors.white,
                                  ),
                                  inputBorder: BorderSide.none,
                                  filled: true,
                                  filledColor: MyColors.textFieldTheme,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  items:
                                      controller.businessTrueCategoryList.value,
                                  color: Colors.black54,
                                  selectedItem:
                                      controller.selectedBusinessCategory,
                                  isValidator: false,
                                  // errorMessage: '*',
                                  onAddPressed: () {
                                    setState(() {
                                      businessCategoryId = "";
                                      controller.selectedBusinessCategory =
                                          null;
                                    });
                                  },
                                  onChanged: (value) {
                                    FocusScope.of(context).unfocus();
                                    controller.selectedBusinessCategory = value;
                                    businessCategoryId =
                                        value.businessCategoryId;
                                    setState(() {
                                      controller.businessTrueServicesList.value
                                          .clear();
                                      controller.getBusinessServices(
                                          businessCategoryId);
                                      selectedServiceId = "";
                                    });
                                  });
                            }),
                          ),
                          SizedBox(
                            width: width(context) / 2.3,
                            child: Obx(() {
                              return SearchDropdownTextField<
                                      BusinessServicesModel>(
                                  hintText: 'Service',
                                  hintTextStyle: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      color: MyColors.white),
                                  textStyle: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      color: MyColors.white),
                                  filled: true,
                                  filledColor: MyColors.textFieldTheme,
                                  suffixIcon: const Icon(Icons.search,
                                      color: MyColors.white),
                                  items:
                                      controller.businessTrueServicesList.value,
                                  color: Colors.black54,
                                  inputBorder: BorderSide.none,
                                  selectedItem:
                                      controller.selectedCategoryService,
                                  isValidator: false,
                                  // errorMessage: '*',
                                  onAddPressed: () {
                                    setState(() {
                                      selectedServiceId = "";
                                      controller.selectedCategoryService = null;
                                    });
                                  },
                                  onChanged: (value) {
                                    FocusScope.of(context).unfocus();
                                    controller.selectedCategoryService = value;
                                    setState(() {
                                      selectedServiceId =
                                          value.businessServiceId;
                                    });
                                  });
                              // : PreferenceHelper.showSnackBar(
                              //     context: Get.context!,
                              //     msg: "No Service Found");
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Specialist",
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Center(
                        child: Top20SpecialistListViewBuilder(
                            selectedCategoryId: businessCategoryId,
                            selectedServiceId: selectedServiceId),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class Top20SpecialistListViewBuilder extends StatefulWidget {
  final selectedCategoryId;
  final String? selectedServiceId;

  const Top20SpecialistListViewBuilder(
      {this.selectedCategoryId, this.selectedServiceId});

  @override
  State<Top20SpecialistListViewBuilder> createState() =>
      _Top20SpecialistListViewBuilderState();
}

class _Top20SpecialistListViewBuilderState
    extends State<Top20SpecialistListViewBuilder> {
  var memberId;
  MemberDetails? memberDetails;

  // SpecialistListModel? specialistListModel;

  List<SpecialistListModel> specialistListModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller = Get.put(SpecialistListController())..getSpecialistList();
    UserBusinessSpecialistListController controller =
        Get.find<UserBusinessSpecialistListController>();
    specialistListModel = controller.specialistList
        .where((element) => (element.isActive == true))
        .toList();
    // controller.specialistList.toList();
  }

  initializeData() async {
    memberDetails = await PreferenceHelper.getMemberData();
    setState(() {
      memberId = memberDetails?.memberId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserBusinessSpecialistListController>(
      builder: (logic) {
        return _listView(specialistListModel);
      },
    );
  }

  _listView(List<SpecialistListModel> specialistList) {
    List<SpecialistListModel> data = specialistList;

    if (widget.selectedCategoryId != "") {
      data = data
          .where((e) => e.businessCategoryId == widget.selectedCategoryId)
          .toList();
    }

    if (widget.selectedServiceId != "") {
      data = data
          .where((element) =>
              (element.servicesList?.any((service) =>
                  service.businessServiceId == widget.selectedServiceId)) ??
              false)
          .toList();
    }

    if (data.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Image.asset(
          Assets.noData,
          scale: 5,
        ),
      );
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return SpecialistListView(specialistListModel: data[index]);
        });
  }
}

class SpecialistListView extends StatefulWidget {
  final SpecialistListModel specialistListModel;

  const SpecialistListView({super.key, required this.specialistListModel});

  @override
  State<SpecialistListView> createState() => _SpecialistListViewState();
}

class _SpecialistListViewState extends State<SpecialistListView> {
  var memberId;
  MemberDetails? memberDetails;
  late UserFavController _userFavController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialiseData();
    _userFavController = Get.put(UserFavController());
  }

  _initialiseData() async {
    memberDetails = await PreferenceHelper.getMemberData();
    setState(() {
      memberId = memberDetails?.memberId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.aboutSpecialistScreen,
            arguments: widget.specialistListModel);
      },
      child: Card(
        color: MyColors.scaffold,
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          imageUrl: widget.specialistListModel.filePath ?? '',
                        )),
                  )),
                ),
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
                            capitalizeFirstLetter(
                              widget.specialistListModel.displayName ?? "",
                            ),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        RatingBarIndicator(
                          rating: widget.specialistListModel.ratingValue ?? 4,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: MyColors.primaryCustom,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                        ),
                      ],
                    ),
                    // const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.specialistListModel.businessCategoryname ??
                                "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        (memberDetails != null)
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.specialistListModel.isfavourite =
                                        !widget.specialistListModel.isfavourite;
                                    _userFavController
                                        .changeSpecialistFavourite(
                                      specialistListModel:
                                          widget.specialistListModel,
                                      memberId: memberId,
                                      isFav: widget
                                          .specialistListModel.isfavourite,
                                    );
                                  });
                                },
                                icon: Icon(
                                  (widget.specialistListModel.isfavourite)
                                      ? Icons.favorite_outlined
                                      : Icons.favorite_outline_rounded,
                                  color: MyColors.primaryCustom,
                                ))
                            : Container(),
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
  }
}
