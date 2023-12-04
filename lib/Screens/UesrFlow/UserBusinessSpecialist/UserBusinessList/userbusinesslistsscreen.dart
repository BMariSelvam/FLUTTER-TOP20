import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Model/businesslistmodel.dart';
import '../../../../Const/approute.dart';
import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/extension.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/Member_details_model.dart';
import '../../../../Model/businesscstegorymodel.dart';
import '../../../../Model/businessservicemodel.dart';
import '../../../../Widget/searchdropdowntextfield.dart';
import '../UserSpecialistList/UserFavSpecialistAndBusinessController.dart';
import 'BusinessCategoryListAndServiceList.dart';

class UserBusinessListScreen extends StatefulWidget {
  const UserBusinessListScreen({Key? key}) : super(key: key);

  @override
  State<UserBusinessListScreen> createState() => _UserBusinessListScreenState();
}

class _UserBusinessListScreenState extends State<UserBusinessListScreen> {
  String? businessCategoryId = '';
  String? selectedServiceId = '';
  String? selectedBusinessCategoryId = '';

  late BusinessCategoryAndServiceController controller;

  BusinessListUserViewModel? businessListUserViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(BusinessCategoryAndServiceController());
    controller.getBusinessCategory();
    controller.getBusinessServices(businessCategoryId);
    controller.getbusinessList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessCategoryAndServiceController>(builder: (logic) {
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
                  title: const Text("TOP TWENTY BUSINESS"),
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
                                    items: controller
                                        .businessTrueCategoryList.value,
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
                                      controller.selectedBusinessCategory =
                                          value;
                                      businessCategoryId =
                                          value.businessCategoryId;
                                      setState(() {
                                        controller
                                            .businessTrueServicesList.value
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
                                    items: controller
                                        .businessTrueServicesList.value,
                                    color: Colors.black54,
                                    inputBorder: BorderSide.none,
                                    selectedItem:
                                        controller.selectedCategoryService,
                                    isValidator: false,
                                    // errorMessage: '*',
                                    onAddPressed: () {
                                      setState(() {
                                        selectedServiceId = "";
                                        controller.selectedCategoryService =
                                            null;
                                      });
                                    },
                                    onChanged: (value) {
                                      FocusScope.of(context).unfocus();
                                      controller.selectedCategoryService =
                                          value;
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
                          "Business",
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Top20BusinessListViewBuilder(
                            selectedServiceId: selectedServiceId,
                            selectedCategoryId: businessCategoryId,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}

class Top20BusinessListViewBuilder extends StatefulWidget {
  final selectedCategoryId;
  final String? selectedServiceId;

  const Top20BusinessListViewBuilder(
      {this.selectedCategoryId, this.selectedServiceId});

  @override
  State<Top20BusinessListViewBuilder> createState() =>
      _Top20BusinessListViewBuilderState();
}

class _Top20BusinessListViewBuilderState
    extends State<Top20BusinessListViewBuilder> {
  List<BusinessListUserViewModel> businessListUserViewModel = [];

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
    // TODO: implement initState
    super.initState();
    _initialiseData();
    BusinessCategoryAndServiceController controller =
        Get.find<BusinessCategoryAndServiceController>();
    businessListUserViewModel = controller.businessList
        .where((element) => (element.isActive == true))
        .toList();
    // controller.businessList.toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessCategoryAndServiceController>(
      builder: (controller) {
        // if (controller.status.isLoading) {
        //   return Center(
        //       child: LoadingAnimationWidget.threeRotatingDots(
        //           color: MyColors.primaryCustom, size: 20));
        // }
        return _listView(businessListUserViewModel);
      },
    );
  }

  _listView(List<BusinessListUserViewModel> businessList) {
    List<BusinessListUserViewModel> data = businessList;

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
        return BusinessItemList(businessListUserViewModel: data[index]);
      },
    );
  }
}

class BusinessItemList extends StatefulWidget {
  final BusinessListUserViewModel businessListUserViewModel;

  BusinessItemList({required this.businessListUserViewModel});

  @override
  State<BusinessItemList> createState() => _BusinessItemListState();
}

class _BusinessItemListState extends State<BusinessItemList> {
  late UserFavController _userFavController;
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
    _userFavController = Get.put(UserFavController());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.aboutBusiness,
            arguments: widget.businessListUserViewModel);
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
                          imageUrl:
                              widget.businessListUserViewModel.filePath ?? '',
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
                                widget.businessListUserViewModel.displayName ??
                                    ""),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        RatingBarIndicator(
                          rating:
                              widget.businessListUserViewModel.ratingValue ??
                                  3.0,
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
                            widget.businessListUserViewModel
                                    .businessCategoryName ??
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
                                    widget.businessListUserViewModel
                                            .isFavourite =
                                        !widget.businessListUserViewModel
                                            .isFavourite;
                                    _userFavController.changeBusinessFavourite(
                                      widget.businessListUserViewModel,
                                      memberId,
                                      widget.businessListUserViewModel
                                          .isFavourite,
                                    );
                                  });
                                },
                                icon: Icon(
                                  widget.businessListUserViewModel.isFavourite
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
