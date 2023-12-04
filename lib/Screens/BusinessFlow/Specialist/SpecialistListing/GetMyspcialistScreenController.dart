import 'package:get/get.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/MySpecilaistModel.dart';
import '../../../../Model/specialistmodel.dart';

class GetMyspecilaistController extends GetxController with StateMixin {
  List<MySpecilaistModel>? specialistOverAllList = [];

  Rx<bool> isLoading = false.obs;


  getBusinessMyspecialist() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
     NetworkManager.get(
      url: HttpUrl.businessGetSpecialist,
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
          specialistOverAllList = (apiResponse.apiResponseModel!.result as List)
              .map((e) => MySpecilaistModel.fromJson(e))
              .toList();

        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          // PreferenceHelper.showSnackBar(context: Get.context!, msg: message);
          Get.snackbar("No Data Found", message!,
              duration: 3.seconds, snackPosition: SnackPosition.TOP);
        }
      } else {
       specialistOverAllList?.length = 0;
        change(null, status: RxStatus.error());
        String? message = apiResponse.error;
        Get.snackbar("Response Error", message!,
            duration: 3.seconds, snackPosition: SnackPosition.TOP);
      }
    });
  }

}