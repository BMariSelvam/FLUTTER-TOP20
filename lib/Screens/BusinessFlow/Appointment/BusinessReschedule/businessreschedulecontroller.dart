import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:top_20/Helper/datautils.dart';

import '../../../../Const/approute.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/appointmentmodel.dart';
import '../../../../Model/business_specialist.dart';
import '../../../Success/appoinmentsuceessscreen.dart';
import '../../../Success/successscreen.dart';
import '../appointmentconfirmdetailscreen.dart';
import '../appointmentconfirmdetailscreen.dart';

class BusinessRescheduleController extends GetxController with StateMixin {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController assignSpecialistController = TextEditingController();


  DateTime? time;
  DateTime selectDate = DateTime.now();
  String? date;

  late Appointment appointment;
  Rx<String?> selectedDate = "".obs;
  Rx<String?> selectedStartTime = "".obs;
  Rx<String?> selectedEndTime = "".obs;
  Rx<BusinessSpecialist?> selectedSpecialist =
      (null as BusinessSpecialist?).obs;
  var appointmentDate = DateTime.now().obs;
  var appointmentStartTime = TimeOfDay.now().obs;
  var appointmentEndTime = TimeOfDay.now().obs;

  RxList<BusinessSpecialist> specialistList = <BusinessSpecialist>[].obs;
  RxBool isLoading = false.obs;

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: appointmentDate.value.isBefore(DateTime.now())
            ? DateTime.now()
            : appointmentDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2024),
        //initialEntryMode: DatePickerEntryMode.input,
        // initialDatePickerMode: DatePickerMode.year,
        helpText: 'Select Date',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
        fieldLabelText: 'Apoointment Date',
        fieldHintText: 'Month/Date/Year',
        selectableDayPredicate: disableDate);
    if (pickedDate != null && pickedDate != appointmentDate.value) {
      appointmentDate.value = pickedDate;
      selectedDate.value =
          TimeUtils.toDDMMYYYY(dateString: pickedDate.toString());
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))))) {
      return true;
    }
    return false;
  }

  // getBusinessSpecialists() async {
  //   change(null, status: RxStatus.loading());
  //
  //   await NetworkManager.get(
  //     url: HttpUrl.businessSpecialistList,
  //     params: {
  //       "OrganizationId": 1,
  //       "BusinessId": appointment.businessId,
  //     },
  //   ).then((apiResponse) async {
  //     if (apiResponse.apiResponseModel != null &&
  //         apiResponse.apiResponseModel!.status) {
  //       if (apiResponse.apiResponseModel!.result != null) {
  //         List<dynamic> dataJson =
  //             (apiResponse.apiResponseModel!.result! as List);
  //         if (dataJson != null) {
  //           specialistList.value =
  //               dataJson.map((e) => BusinessSpecialist.fromJson(e)).toList();
  //           selectedSpecialist.value = specialistList.firstWhere((element) =>
  //               element.specialistId ==
  //               appointment.specialistData?.first.specialistId);
  //         } else {
  //           // PreferenceHelper.showSnackBar(
  //           //     context: Get.context!, msg: "Invalid Data");
  //           Get.snackbar("Invalid Data", "Invalid Data",
  //               duration: 10.seconds, snackPosition: SnackPosition.TOP);
  //         }
  //       } else {
  //         String? message = apiResponse.apiResponseModel?.message;
  //         Get.snackbar("Invalid Data", message!,
  //             duration: 10.seconds, snackPosition: SnackPosition.TOP);
  //       }
  //     } else {
  //       String? message = apiResponse.error;
  //       Get.snackbar("Invalid Data", message!,
  //           duration: 10.seconds, snackPosition: SnackPosition.TOP);
  //     }
  //     change(null, status: RxStatus.success());
  //   });
  // }

  chooseStartTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: appointmentStartTime.value,
      builder: (context, child) {
        return Theme(data: ThemeData.light(), child: child!);
      },
      initialEntryMode: TimePickerEntryMode.input,
      helpText: 'Select Appointment Time',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorInvalidText: 'Provide valid time',
      hourLabelText: 'Select Hour',
      minuteLabelText: 'Select Minute',
    );

    if (pickedTime != null && pickedTime != selectedStartTime.value) {
      if (appointmentDate.value.applied(pickedTime).isBefore(DateTime.now())) {
        Get.snackbar("Error", "You can't select the past time");
      } else {
        appointmentStartTime.value = pickedTime;

        // Format the selected time to 24-hour format
        final formattedTime = DateFormat.Hm().format(DateTime(2023, 1, 1, pickedTime.hour, pickedTime.minute));
        selectedStartTime.value = formattedTime;

        // Calculate end time based on service duration
        calculateEndTime();
      }
    }
  }

  void calculateEndTime() {
    // Get the time difference
    Duration timeDifference = calculateTimeDifference();

    // Convert appointmentStartTime to DateTime
    DateTime startTime = DateTime(
      appointmentDate.value.year,
      appointmentDate.value.month,
      appointmentDate.value.day,
      appointmentStartTime.value.hour,
      appointmentStartTime.value.minute,
    );

    // Calculate end time based on the time difference
    DateTime endTime = startTime.add(timeDifference);

    // Update the values
    appointmentEndTime.value = TimeOfDay.fromDateTime(endTime);

    // Format the end time to 24-hour format
    final formattedEndTime = "${endTime.hour}:${endTime.minute}";
    selectedEndTime.value = formattedEndTime;
  }



  Duration calculateTimeDifference() {

    DateTime fromTime = DateTime.parse(appointment.appoinmentDate ?? '')
        .add(Duration(
      hours: int.parse(appointment.appoinmentFromTime!.split(':')[0]),
      minutes: int.parse(appointment.appoinmentFromTime!.split(':')[1]),
    ));


    DateTime toTime = DateTime.parse(appointment.appoinmentDate ?? '')
        .add(Duration(
      hours: int.parse(appointment.appoinmentToTime!.split(':')[0]),
      minutes: int.parse(appointment.appoinmentToTime!.split(':')[1]),
    ));

    Duration difference = toTime.difference(fromTime);

    return difference;
  }





  chooseEndTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: appointmentEndTime.value,
        builder: (context, child) {
          return Theme(data: ThemeData.light(), child: child!);
        },
        initialEntryMode: TimePickerEntryMode.input,
        helpText: 'Select Appointment Time',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorInvalidText: 'Provide valid time',
        hourLabelText: 'Select Hour',
        minuteLabelText: 'Select Minute');
    if (pickedTime != null && pickedTime != selectedStartTime.value) {
      if (appointmentDate.value.applied(pickedTime).isBefore(DateTime.now())) {
        Get.snackbar("Error", "You can't select the past time");
      } else {
        appointmentEndTime.value = pickedTime;
        selectedEndTime.value = TimeUtils.toHHMM(
            dateString: "${pickedTime.hour}:${pickedTime.minute}:00");
      }
    }
  }

  rescheduleAppointment() async {
    isLoading.value = true;
    update();
    await NetworkManager.post(
      url: HttpUrl.resheduleAppointment,
      params: {
        "OrgId": 1,
        "AppoinmentNo": appointment.appoinmentNo,
        "AppoinmentDate": TimeUtils.toServerDateFormat(
            dateString: appointmentDate.toString()),
        "AppoinmentFromTime":
            TimeUtils.toHHMMSS(dateString: selectedStartTime.value),
        "AppoinmentToTime":
            TimeUtils.toHHMMSS(dateString: selectedEndTime.value),
        "Status": 3,
        "IsRescheduled": true,
        "CreatedBy": "admin"
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        //logic for api call success
        if (apiResponse.apiResponseModel!.status) {
          Get.offAll(const AppointmentSuccessfullyScreen(
              text: "Your Appointment Reschedule \n Successfully",
              isLoading: false,
              title: "Go To DashBoard"));
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          // PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
          Get.snackbar("No Data Found", message!,
              duration: 3.seconds, snackPosition: SnackPosition.TOP);
        }
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.apiResponseModel?.message;
        // PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
        Get.snackbar("No Data Found", message!,
            duration: 3.seconds, snackPosition: SnackPosition.TOP);
      }
    });
  }


}
