import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Helper/api.dart';
import '../../../../Helper/networkmanager.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/specialistmodel.dart';

class AddSpecialistListController extends GetxController with StateMixin {
  RxBool isAddClick = false.obs;

  final searchKey = GlobalKey<FormState>();

  TextEditingController scanByQrController = TextEditingController();
  TextEditingController searchByNameController = TextEditingController();
  RxList<SpecialistListModel> specialistList = <SpecialistListModel>[].obs;
  RxList<SpecialistListModel> displayList = <SpecialistListModel>[].obs;
  List<SpecialistListModel> specialistOverAllList = [];
  Rx<bool> isLoading = false.obs;
  @override
  onInit() {
    super.onInit();
  }

}
