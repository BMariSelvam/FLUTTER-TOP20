import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_20/Screens/Success/successscreen.dart';
import '../../../../Const/approute.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/Member_details_model.dart';
import '../../../../Model/appointmentmodel.dart';
import '../../../../Model/businessappointmentmodel.dart';
import '../../../../Model/businesslistmodel.dart';
import '../../../../Model/userappointmentcreatemodel.dart';

class BusinessAppointmentController extends GetxController with StateMixin {
  //DatePicker
  DateTime selectedDate = DateTime.now();

  //TimePicker
  TimeOfDay time = TimeOfDay.now();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController fromTimeController = TextEditingController();
  final TextEditingController toTimeController = TextEditingController();
  int totalCoinsNeed = 0;
  int totalDurationTime = 0;
  String? date;
  late TimeOfDay addedServiceTime;
  TimeOfDay selectedTime = TimeOfDay.now();
  late TimeOfDay minimumTime;
  late TimeOfDay maximumTime;

  //ToggleButton
  RxBool isToggleOn = true.obs;
  RxBool isBusinessOn = true.obs;
  RxBool isCustomerOn = true.obs;
  int serviceLocation = 0;
  final businessAppointmentKey = GlobalKey<FormState>();
  late TimeOfDay fromTime;
  String openTime = "";
  String closeTime = "";
  Rx<List<BusinessListUserViewModel>?> businessList = (null as List<BusinessListUserViewModel>?).obs;
  Rx<List<BusinessAppointmentServicesModel>?> businessServiceList = (null as List<BusinessAppointmentServicesModel>?).obs;
  Rx<List<BusinessAppointmentServicesModel>?> businessTrueServiceList = (null as List<BusinessAppointmentServicesModel>?).obs;
  Rx<bool> isLoading = false.obs;
  late UserBusinessAppointmentCreateModel userBusinessAppointmentCreateModel;
  MemberDetails? memberDetails;
  List<Appointment> appointmentList = [];

  final DateTime currentDate = DateTime.now();
  final TimeOfDay currentTime = TimeOfDay.now();


 int openHrsTime = 0;
 int openMinTime = 0;

  int closeHrsTime = 0;
  int closeMinTime = 0;



  @override
  void onInit() {
    // TODO: implement initState
    super.onInit();
    _initialiseData();
  }


  _initialiseData() async {
    memberDetails = await PreferenceHelper.getMemberData();
  }

  Future<DateTime?> showTimePopup(
      BuildContext context,
      TimeOfDay selectedTime, // The initially selected time
      ) async {
    final DateTime currentTime = DateTime.now();
    final int minuteInterval = 15; // Your desired minute interval

    // Calculate the initial time, making sure it's divisible by minuteInterval
    int minuteAdjustment = (selectedTime.minute % minuteInterval).ceil();
    TimeOfDay initialTime;

    if (selectedTime.hour < minimumTime.hour ||
        (selectedTime.hour == minimumTime.hour && selectedTime.minute < minimumTime.minute)) {
      initialTime = minimumTime;
    } else {
      initialTime = TimeOfDay(
        hour: selectedTime.hour,
        minute: (selectedTime.minute - minuteAdjustment) % 60,
      );
    }

    final TimeOfDay? picked = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        TimeOfDay? selectedTime;
        return Container(
          height: 280,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    initialTime.hour, // Use the adjusted initialTime
                    initialTime.minute, // Use the adjusted initialTime
                  ),
                  minimumDate: DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    minimumTime.hour,
                    minimumTime.minute,
                  ),
                  maximumDate: DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    maximumTime.hour,
                    maximumTime.minute,
                  ),
                  onDateTimeChanged: (DateTime newDateTime) {
                    final selectedTime = TimeOfDay.fromDateTime(newDateTime);
                    final selectedDateTime = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );

                    if (newDateTime.isAfter(currentTime) &&
                        selectedTime.hour >= minimumTime.hour &&
                        selectedTime.hour <= maximumTime.hour) {
                      // Handle the selected time as needed
                    }
                  },
                  use24hFormat: true,
                  minuteInterval: minuteInterval,
                ),
              ),
              CupertinoButton(
                child: const Text('OK'),
                onPressed: () {
                  final selectedTime = this.selectedTime;
                  final selectedDateTime = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );

                  if (selectedDateTime.isAfter(currentTime) &&
                      selectedTime.hour >= minimumTime.hour &&
                      selectedTime.hour <= maximumTime.hour) {
                    Navigator.of(context).pop(selectedTime);
                  }
                },
              ),
            ],
          ),
        );
      },
    );

    if (picked != null) {
      // Handle the picked time as nee
    }

    List<String> timeParts = openTime.split(':');
    List<String> closeTimes = closeTime.split(':');

    if (timeParts.length >= 2 && timeParts.length >= 2) {
      int hours = int.tryParse(timeParts[0]) ?? 0;
      int minutes = int.tryParse(timeParts[1]) ?? 0;
      int roundedMinutes = ((minutes + 7) ~/ 15) * 15;
      DateTime initialDateTime = DateTime.now().add(Duration(hours: hours, minutes: roundedMinutes));

      int hourss = int.tryParse(closeTimes[0]) ?? 0;
      int minutess = int.tryParse(closeTimes[1]) ?? 0;
      int roundedMinutess = ((minutess + 7) ~/ 15) * 15;
      DateTime endTime = DateTime.now().add(Duration(hours: hourss, minutes: roundedMinutess));

      print("initialDateTimNNNNNe");
      print(initialDateTime);

      return await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (_) {
          DateTime? selectedDateTime;
          DateTime? MaxiumTime = DateTime.tryParse("2023-09-20 18:00");
          return Container(
            height: 280,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: true,
                    minuteInterval: 15, // Modify the minuteInterval as needed
                    initialDateTime: initialDateTime.add(Duration(minutes: 15 - initialDateTime!.minute % 15)),
                    minimumDate: initialDateTime?.add(Duration(minutes: 15 - initialDateTime!.minute % 15)),
                    // maximumDate: endTime,
                    onDateTimeChanged: (picked) {
                      selectedDateTime = picked;
                    },
                  ),
                ),
                CupertinoButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context)
                      .pop(selectedDateTime ?? DateTime.now()),
                )
              ],
            ),
          );
        },
      );
    } else {
      // Handle invalid input here
      return null;
    }
  }


  getBusinessServicesList(businessId) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse = await NetworkManager.get(
        url: HttpUrl.businessServices,
        // todo: This is hardcoded so far. Need to change in future
        params: {
          "BusinessId": businessId
          //   specialistListModel.specialistId
        },
      );
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<BusinessAppointmentServicesModel> list =
                resJson.map<BusinessAppointmentServicesModel>((value) {
              return BusinessAppointmentServicesModel.fromJson(value);
            }).toList();
            businessServiceList.value = list;
            businessTrueServiceList.value = businessServiceList.value?.where((element) => element.isActive == true).toList();
            return;
          }
        } else {
          businessServiceList.value = null;
          change(null, status: RxStatus.error());
          Get.showSnackbar(
            GetSnackBar(
              title: "Error",
              message: apiResponse.apiResponseModel!.message ?? '',
              icon: const Icon(Icons.error),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        businessServiceList.value = null;
        change(null, status: RxStatus.error());
        // Get.showSnackbar(
        //     GetSnackBar(
        //       title: "Error",
        //       // message: apiResponse.apiResponseModel!.message ?? '',
        //       message: 'bbbbbbbbbbbbbbbbbbbbbbbbbbb',
        //       icon: const Icon(Icons.error),
        //       duration: const Duration(seconds: 3),
        //      ),
        //     );
      }
    } catch (e) {
      businessServiceList.value = null;
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: e.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  getBusinessList(businessId) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    try {
      final apiResponse =
      await NetworkManager.get(url: HttpUrl.businessGetBy, params: {
        "BusinessId": businessId,
      });
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          List? resJson = apiResponse.apiResponseModel!.result!;
          if (resJson != null) {
            List<BusinessListUserViewModel> list =
            resJson.map<BusinessListUserViewModel>((value) {
              return BusinessListUserViewModel.fromJson(value);
            }).toList();
            businessList.value = list;
          }
        }
      }
    } catch (e) {
      change(null, status: RxStatus.error());
    }
    openTimeAndCloseTime();
  }

  callUserAppointmentBusiness() async {
    isLoading.value = true;
    int sNo = 1;
    for (var elemnet in userBusinessAppointmentCreateModel.appoinmentDetail!) {
      elemnet.slNo = sNo++;
    }
    ApiService.userAppointmentBusiness(
            userBusinessAppointmentCreateModel:
                userBusinessAppointmentCreateModel)
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          Get.offAll(() => SuccessfulScreen(
              text: "Booking Requested.\nPlease check under \nAppointments for confirmation",
              isLoading: false,
              title: "Go To DashBoard",
              onTap: () {
                Get.offAllNamed(Routes.userBottomNavBar);
              }));
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  getUserRatings(businessId) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getAppointmentList,
      params: {
        //todo hardcoded for business id
        "SpecialistId": "${businessId}" ?? "",
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.result != null) {
          //logic for api call success
          appointmentList = (apiResponse.apiResponseModel!.result as List)
              .map((e) => Appointment.fromJson(e))
              .toList();
        } else {
          // appointmentList = null;
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        }
      } else {
        // appointmentList = null;
        change(null, status: RxStatus.error());
        PreferenceHelper.showSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }


  openTimeAndCloseTime() {
    print("==========businessList.value");
    print(businessList.value?.first.openTime);
    print(businessList.value?.first.closeTiime);
    // String? oST = businessList.value?.first.openTime;


    String? time1 = businessList.value?.first.openTime;
    String? time2 = businessList.value?.first.closeTiime;

    List<String> time1Components = time1!.split(':');
    List<String> time2Components = time2!.split(':');

    String hours1 = time1Components[0];
    String minutes1 = time1Components[1];
    String seconds1 = time1Components[2];

    String hours2 = time2Components[0];
    String minutes2 = time2Components[1];
    String seconds2 = time2Components[2];

    print("Time 1: Hours: $hours1, Minutes: $minutes1, Seconds: $seconds1");
    print("Time 2: Hours: $hours2, Minutes: $minutes2, Seconds: $seconds2");

     openHrsTime = int.parse(hours1);
     openMinTime = int.parse(minutes1);

     closeHrsTime = int.parse(hours2);
     closeMinTime = int.parse(minutes2);
      minimumTime = TimeOfDay(hour: openHrsTime, minute: openMinTime);
      maximumTime = TimeOfDay(hour: closeHrsTime, minute: closeMinTime);

  }

}
