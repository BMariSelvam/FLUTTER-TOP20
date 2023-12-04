import 'package:get/get.dart';
import 'package:top_20/Screens/Success/appoinmentsuceessscreen.dart';

import '../../../Const/approute.dart';
import '../../../Helper/networkmanager.dart';
import '../../../Model/appointmentmodel.dart';
import '../../../helper/api.dart';
import '../../../helper/preferenceHelper.dart';

class BusinessConfirmAppointmentController extends GetxController
    with StateMixin {
  late Appointment appointment;

  RxBool bookingIsLoading = false.obs;
  RxBool rescheduleIsLoading = false.obs;
  RxBool cancelIsLoading = false.obs;

  confirmAppointment(
      {bool isCancel = false,
      bool isComplete = false,
      bool isConfirm = false}) async {
    print(">>>>>>>>>>>1111111111111>>>>>>>>>>>>");
    bookingIsLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.post(
      url: HttpUrl.updateAppointment(
        orgId: 1,
        appointmentId: appointment.appoinmentNo.toString(),
        status: isComplete
            ? 5
            : isCancel
                ? 6
                : 2,
      ),
      params: {},
    ).then((apiResponse) async {
      bookingIsLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.status) {
          if (isComplete) {
            print("======complete=====");
            Get.offAll(const AppointmentSuccessfullyScreen(
                text: "Your Appointment Completed \n Successfully",
                isLoading: false,
                title: "Go To DashBoard"));
          }
          if (isCancel) {
            print("======isCancel=====");
            Get.offAll(const AppointmentSuccessfullyScreen(
                text: "Your Appointment Canceled",
                isLoading: false,
                title: "Go To DashBoard"));
          }
          if (isConfirm) {
            print("======Confirm=====");
            Get.offAll(const AppointmentSuccessfullyScreen(
                text: "Your Appointment Confirmed \n Successfully",
                isLoading: false,
                title: "Go To DashBoard"));
          }
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          // PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
          Get.snackbar("Appointment", message!,
              duration: 3.seconds, snackPosition: SnackPosition.TOP);
        }
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.error;
        Get.snackbar("Response Error", message!,
            duration: 3.seconds, snackPosition: SnackPosition.TOP);
      }
    });
  }
}
