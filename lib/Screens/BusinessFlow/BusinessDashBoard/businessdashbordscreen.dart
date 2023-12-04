import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Const/size.dart';
import 'package:top_20/Screens/BusinessFlow/Rating/ratingsscreen.dart';
import 'package:top_20/Screens/BusinessFlow/Receive/receivescreen.dart';
import 'package:top_20/Screens/BusinessFlow/Settings/settingsscreen.dart';
import 'package:top_20/Screens/BusinessFlow/Transfer/transferscreen.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Helper/datautils.dart';
import '../../../Helper/extension.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../Model/userdetailmodel.dart';
import '../../../Widget/Constructors/constructors.dart';
import '../../UesrFlow/UserProfile/ResetPassword/resetpasswordscreen.dart';
import '../Appointment/businessappointmentscreen.dart';
import '../Services/AddServices/servicesscreen.dart';
import '../Specialist/SpecialistListing/specialistlistscreen.dart';
import 'bussinessdashboardcontroller.dart';

class BusinessDashboardScreen extends StatefulWidget {
  const BusinessDashboardScreen({Key? key}) : super(key: key);

  @override
  State<BusinessDashboardScreen> createState() =>
      _BusinessDashboardScreenState();
}

class _BusinessDashboardScreenState extends State<BusinessDashboardScreen> {
  var businessId;

  BusinessDetailsModel? businessDetailsModel;
  late BusinessDashboardController controller;

  _initialiseData() async {
    businessDetailsModel = await PreferenceHelper.getBusinessData();
    setState(() {
      businessId = businessDetailsModel?.businessId;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialiseData();
    controller = Get.put(BusinessDashboardController());
    controller.getAllAppointments();
  }

  //GridViewBuilder
  List<BusinessDashBordGrid> explore = [
    BusinessDashBordGrid(
      image: Assets.img1,
      name: 'SPECIALIST',
      color: MyColors.fav1,
    ),
    BusinessDashBordGrid(
      image: Assets.img2,
      name: 'SERVICES',
      color: MyColors.lightGreen,
    ),
    BusinessDashBordGrid(
      image: Assets.img3,
      name: 'RATING',
      color: MyColors.fav2,
    ),
    BusinessDashBordGrid(
      image: Assets.img4,
      name: 'RECEIVE',
      color: MyColors.lightGreen,
    ),
    BusinessDashBordGrid(
      image: Assets.img5,
      name: 'TRANSFER',
      color: MyColors.fav2,
    ),
    BusinessDashBordGrid(
      image: Assets.img6,
      name: 'SETTING',
      color: MyColors.fav1,
    ),
  ];

  List exploreScreens() => [
        const AddSpecialistScreen(),
        const ServicesScreen(),
        const RatingScreen(),
        const ReceiveScreen(),
        const TransferScreen(),
        const BusinessProfileScreen(),
      ];

  List appointmentNavigation = [
    BusinessAppointmentDetails(
        isOpenClick: true,
        isCancelled: false,
        isCompleted: false,
        isConfirmed: false),
    BusinessAppointmentDetails(
        isOpenClick: false,
        isCancelled: false,
        isCompleted: false,
        isConfirmed: true),
    BusinessAppointmentDetails(
        isOpenClick: false,
        isCancelled: false,
        isCompleted: true,
        isConfirmed: false),
    BusinessAppointmentDetails(
        isOpenClick: false,
        isCancelled: true,
        isCompleted: false,
        isConfirmed: false),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessDashboardController>(builder: (logic) {
      if (logic.isLoading == true) {
        return Scaffold(
          body: Center(
            child: LoadingAnimationWidget.threeRotatingDots(
                color: MyColors.primaryCustom, size: 20),
          ),
        );
      }
      return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: MyColors.fav1,
                  ),
                  child: Center(
                    child:
                        SizedBox(height: 100, child: Image.asset(Assets.logo)),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.businessEditProfileScreen);
                  },
                  leading: Icon(
                    Icons.person,
                    color: MyColors.primaryCustom,
                  ),
                  title: Text(
                    "Profile Update",
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const ResetPassword()));
                  },
                  leading: Icon(
                    Icons.lock,
                    color: MyColors.primaryCustom,
                  ),
                  title: Text(
                    "Change Password",
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    await PreferenceHelper.clearUserData();
                    Get.offAllNamed(Routes.loginScreen);
                  },
                  leading: Icon(
                    Icons.logout,
                    color: MyColors.primaryCustom,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 280,
                leading: IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState
                          ?.openDrawer(); // Open the drawer
                    },
                    icon: Image.asset(Assets.menu)),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none_outlined)),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Center(
                        child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.settingsScreen);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: webImage(
                              imageUrl:
                                  businessDetailsModel?.logoFilePath ?? '',
                            )),
                      ),
                    )),
                  ),
                ],
                flexibleSpace: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 30, 5, 10),
                  child: FlexibleSpaceBar(
                    background: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Appointment",
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, childAspectRatio: 0.7),
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            List<BusinessAppointmentGrid> appointment = [
                              BusinessAppointmentGrid(
                                  image: Assets.appointment3,
                                  count: controller.appointmentList
                                          .where(
                                              (element) => element.status == 1)
                                          .toList()
                                          .length
                                          .toString()
                                          .toString() ??
                                      "0",
                                  name: 'Requested'),
                              BusinessAppointmentGrid(
                                  image: Assets.appointment1,
                                  count: controller.appointmentList
                                          .where((element) =>
                                              element.status == 2 ||
                                              element.status == 3)
                                          .toList()
                                          .length
                                          .toString()
                                          .toString() ??
                                      "0",
                                  name: 'Confirmed'),
                              BusinessAppointmentGrid(
                                  image: Assets.appointment2,
                                  count: controller.appointmentList
                                          .where(
                                              (element) => element.status == 5)
                                          .toList()
                                          .length
                                          .toString()
                                          .toString() ??
                                      "0",
                                  name: 'Completed'),
                              BusinessAppointmentGrid(
                                  image: Assets.appointment4,
                                  count: controller.appointmentList
                                          .where(
                                              (element) => element.status == 6)
                                          .toList()
                                          .length
                                          .toString()
                                          .toString() ??
                                      "0",
                                  name: 'Cancelled'),
                            ];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            appointmentNavigation[index]));
                              },
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(appointment[index].image),
                                    const SizedBox(height: 20),
                                    Text(
                                      appointment[index].count,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      appointment[index].name,
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.white,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          exploreScreens()[index]));
                            },
                            child: Card(
                              color: explore[index].color,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 20, 20, 0),
                                        child: Image.asset(
                                          explore[index].image,
                                          fit: BoxFit.fill,
                                        ),
                                      )),
                                  const SizedBox(height: 20),
                                  Text(
                                    explore[index].name,
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: (controller.appointmentOpen.isNotEmpty)
                    ? Card(
                        color: MyColors.regColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Recent Booking",
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Get.toNamed(
                                      //     Routes.businessAppointmentDetails);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BusinessAppointmentDetails(
                                                      isOpenClick: true,
                                                      isCancelled: false,
                                                      isCompleted: false,
                                                      isConfirmed: false)));
                                    },
                                    child: Text(
                                      "View All",
                                      style: TextStyle(
                                        fontFamily: MyFont.myFont,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                child: recentAppointmentList(),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
              )
            ],
          ));
    });
  }

  recentAppointmentList() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: (controller.appointmentOpen.length > 5)
            ? 5
            : controller.appointmentOpen.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.appointmentDetailScreen,
                  arguments: controller.appointmentOpen[index]);
            },
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: MyColors.white,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Booking Date  :',
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          formatDate(controller
                                  .appointmentOpen[index].appoinmentDate ??
                              ""),
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time_outlined,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${TimeUtils.toHHMM(dateString: controller.appointmentOpen[index].appoinmentFromTime)} - ${TimeUtils.toHHMM(dateString: controller.appointmentOpen[index].appoinmentToTime)}',
                            style: TextStyle(
                              fontFamily: MyFont.myFont,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: MyColors.grey,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image.asset(
                              Assets.profile,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: SizedBox(
                                    width: width(context) / 1.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller
                                                  .appointmentOpen[index]
                                                  .memberData
                                                  ?.first
                                                  .displayName ??
                                              '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: MyFont.myFont,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          controller.appointmentOpen[index]
                                                  .appoinmentNo ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: MyFont.myFont,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        " ${controller.appointmentOpen[index].totailCoinsPaid} AED",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
