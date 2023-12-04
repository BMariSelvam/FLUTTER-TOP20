import 'package:get/get.dart';

import '../../../Helper/networkmanager.dart';
import '../../../Model/appointmentmodel.dart';
import '../../../helper/api.dart';
import '../../../helper/preferenceHelper.dart';

class BusinessDashboardController extends GetxController with StateMixin {
  List<Appointment> appointmentList = <Appointment>[];
  Rx<bool> isLoading = false.obs;
  List<Appointment> appointmentOpen = [];


  getAllAppointments() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.getAppointmentList,
      //todo: following lines are hardcoded
      params: {
        "BusinessId": await PreferenceHelper.getBusinessData()
            .then((value) => value?.businessId)
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
          appointmentOpen = appointmentList
              .where((element) => (element.status == 1))
              .toList();
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          // PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
          Get.snackbar("No Data Found", message!,
              duration: 3.seconds, snackPosition: SnackPosition.TOP);
        }
      }
    });
  }

}

