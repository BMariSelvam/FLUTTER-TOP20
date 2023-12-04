import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_20/Screens/Registration/Specialist/specialistregthird/specialistregthirdcontroller.dart';
import 'package:top_20/Widget/textformfield.dart';

import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/businesscstegorymodel.dart';
import '../../../../Model/specialistregmodel.dart';
import '../../../../Widget/searchdropdowntextfield.dart';
import '../../../../Widget/submitbutton.dart';

class SpecialistRegThirdScreen extends StatefulWidget {
  const SpecialistRegThirdScreen({Key? key}) : super(key: key);

  @override
  State<SpecialistRegThirdScreen> createState() =>
      _SpecialistRegThirdScreenState();
}

class _SpecialistRegThirdScreenState extends State<SpecialistRegThirdScreen> {
  late SpecialistRegModel _specialistRegModel = SpecialistRegModel();

  late SpecialistRegThirdController controller;

  String selectedBusinessCategoryId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(SpecialistRegThirdController());
    _specialistRegModel = Get.arguments as SpecialistRegModel;
    controller.specialistRegModel.emailId = _specialistRegModel.emailId;
    controller.buildBusinessCategoryList();
  }

  XFile? pickedFile;
  String? logo64;
  String? imageName;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialistRegThirdController>(builder: (logic) {
      return Form(
        key: controller.specialistRegThirdKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.scaffold,
            elevation: 0,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: MyColors.black),
            title: Text(
              "Register as a Specialist",
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.black),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Signup to continue',
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.bioController,
                  hintText: "About",
                  hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  labelText: "*",
                  labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                  readOnly: false,
                  textStyle: TextStyle(fontFamily: MyFont.myFont),
                  inputFormatters: [],
                  obscureText: false,
                  maxLine: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "About Specialist";
                    }
                    if (value.length < 500) {
                      return "Enter Minimum 500 Character";
                    }
                    return null;
                  },
                  maxLength: 500,
                ),
                const SizedBox(height: 20),
                SearchDropdownTextField<BusinessCategoryModel>(
                    labelText: 'Specialist Category',
                    items: controller.businessTrueCategoryList.value,
                    color: Colors.black54,
                    selectedItem: controller.selectedBusinessCategory.value,
                    isValidator: false,
                    errorMessage: 'Enter Your Business Category',
                    onChanged: (value) {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        controller.selectedBusinessCategory.value = value;
                        controller.businessTrueServiceList.value?.clear();
                        controller.getBusinessServicesList(value.businessCategoryId);
                        controller.specialistRegModel.businessCategory = value.businessCategoryId;
                      });
                      controller.specialistRegModel.businessCategory = value.businessCategoryId;
                    }),
                const SizedBox(height: 20),
                Text(
                  "Services",
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                (controller.businessTrueServiceList.value != null)
                    ? Obx(() {
                        return _gridView();
                      })
                    : Container(),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  onPressed: () {
                    addSplServicePop();
                  },
                  child: Text(
                    "Add Services",
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: SubmitButton(
                isLoading: false,
                onTap: () {
                  print("object");
                  FocusScope.of(context).unfocus();
                  if (controller.businessTrueServiceList.value!
                      .where((element) => element.isSelected == true)
                      .toList()
                      .isEmpty) {
                    PreferenceHelper.showSnackBar(
                        context: context, msg: 'Please select your services');
                    return;
                  }

      if (controller.bioController.value.text.isEmpty) {
      PreferenceHelper.showSnackBar(
      context: context,
      msg: 'Please enter your bio information',
      );
      return;
      }
                  if (controller.specialistRegThirdKey.currentState!.validate()) {
                    controller.specialistRegModel.orgId = 1;
                    controller.specialistRegModel.emailId =
                        _specialistRegModel.emailId;
                    controller.specialistRegModel.dialCode =
                        _specialistRegModel.dialCode;
                    controller.specialistRegModel.mobileNo =
                        _specialistRegModel.mobileNo;
                    controller.specialistRegModel.FileName =
                        _specialistRegModel.FileName;
                    controller.specialistRegModel.logoImgBase64String =
                        _specialistRegModel.logoImgBase64String;
                    controller.specialistRegModel.specilistName =
                        _specialistRegModel.specilistName;
                    controller.specialistRegModel.displayName =
                        _specialistRegModel.displayName;
                    controller.specialistRegModel.tranPin =
                        _specialistRegModel.tranPin;
                    controller.specialistRegModel.appPin =
                        _specialistRegModel.appPin;
                    controller.specialistRegModel.haveFreelance =
                        _specialistRegModel.haveFreelance;
                    controller.specialistRegModel.allowOnlineApp =
                        _specialistRegModel.allowOnlineApp;
                    controller.specialistRegModel.serviceatSpecialistPlace =
                        _specialistRegModel.serviceatSpecialistPlace;
                    controller.specialistRegModel.serviceatCustomerPlace =
                        _specialistRegModel.serviceatCustomerPlace;
                    controller.specialistRegModel.addressLine1 =
                        _specialistRegModel.addressLine1;
                    controller.specialistRegModel.addressLine2 =
                        _specialistRegModel.addressLine2;
                    controller.specialistRegModel.addressLine3 =
                        _specialistRegModel.addressLine3;
                    controller.specialistRegModel.city =
                        _specialistRegModel.city;
                    controller.specialistRegModel.country =
                        _specialistRegModel.country;
                    controller.specialistRegModel.postalCode =
                        _specialistRegModel.postalCode;
                    controller.specialistRegModel.bioInfo =
                        controller.bioController.text;

                    controller.specialistRegModel.servicesList = controller
                        .businessTrueServiceList.value
                        ?.where((element) => element.isSelected == true)
                        .toList();
                    controller.specialistRegApi();
                  }
                },
                title: "Register"),
          ),
        ),
      );
    });
  }

  Widget _gridView() {
    if (controller.businessTrueServiceList.value?.length != null) {
      List<Widget> children = [];

      children = controller.businessTrueServiceList.value!
          .map((e) => InkWell(
                onTap: () {
                  if (e.isSelected == true) {
                    e.isSelected = false;
                  } else {
                    e.isSelected = true;
                  }
                  controller.update();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: e.isSelected == true
                          ? MyColors.tabBar
                          : Colors.grey.shade200,
                      border: Border.all(
                        color: e.isSelected == true
                            ? MyColors.mainTheme
                            : Colors.grey.shade200,
                      )),
                  child: Text(
                    e.businessServiceName ?? '',
                    style: TextStyle(
                        fontFamily: MyFont.myFont,
                        color:
                            e.isSelected == true ? Colors.black : Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ))
          .toList();
      // children.add(InkWell(
      //   onTap: () {
      //     // _showAddMore();
      //   },
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(8),
      //       color: MyColors.mainTheme,
      //       //border: Border.all()
      //     ),
      //     child: Text(
      //       '+ Add More',
      //       style: TextStyle(
      //           fontFamily: MyFont.myFont,
      //           color: Colors.white,
      //           fontSize: 12,
      //           fontWeight: FontWeight.w400),
      //     ),
      //   ),
      // ));
      return Wrap(
          runSpacing: 15,
          spacing: 15,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: children);
    }
    return Container();
  }

// _showAddMore() {
//   showDialog(
//       context: context,
//       builder: (context) {
//         TextEditingController serviceTEC = TextEditingController();
//         return AlertDialog(
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           title: Column(
//             children: [
//               const Text('Add Services'),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: serviceTEC,
//                 decoration: const InputDecoration(
//                     labelText: 'Specialization Name',
//                     suffixIcon: Icon(Icons.business_center),
//                     contentPadding: EdgeInsets.only(top: 1)),
//               ),
//               SizedBox(height: 30),
//               Obx(() {
//                 return SubmitButton(
//                     isLoading: controller.isLoading.value,
//                     onTap: () {
//                       if (serviceTEC.text.isNotEmpty) {
//                         FocusScope.of(context).unfocus();
//                         controller
//                             .callAddService(serviceTEC.text);
//                       }
//                     },
//                     title: 'Send Request');
//               })
//             ],
//           ),
//         );
//       });
// }
  addSplServicePop() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          TextEditingController serviceSplTEC = TextEditingController();
          TextEditingController servicetoken = TextEditingController();
          TextEditingController serviceTime = TextEditingController();
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Services',
                  textAlign: TextAlign.center,
                ),
                IconButton(
                    onPressed: () {
                      // setState(() {
                        serviceTime.clear();
                        servicetoken.clear();
                        serviceTime.clear();
                        pickedFile = null;
                      // });
                      Get.back();
                      //Get.back();
                    },
                    icon: Image.asset(Assets.clear))
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          height: 120,
                          width: 120,
                          clipBehavior: Clip.hardEdge,
                          decoration:
                          const BoxDecoration(shape: BoxShape.circle),
                          child: (pickedFile != null)
                              ? Image.file(
                            File(pickedFile!.path),
                            fit: BoxFit.fill,
                          )
                              : Container(
                              color: MyColors.scaffold,
                              child: Image.asset(
                                Assets.placeHolder,
                                fit: BoxFit.fill,
                              )),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 20,
                          child: GestureDetector(
                            onTap: () {
                              _showDialogToGetImage(context);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.photo_camera,
                                  size: 20,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: serviceSplTEC,
                    labelText: 'Services',
                    readOnly: false,
                    textStyle: TextStyle(
                      fontFamily: MyFont.myFont,
                    ),
                    inputFormatters: [],
                    obscureText: false,
                    labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    maxLength: 50,
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: servicetoken,
                    labelText: 'Token',
                    readOnly: false,
                    keyboardType: TextInputType.number,
                    textStyle: TextStyle(
                      fontFamily: MyFont.myFont,
                    ),
                    inputFormatters: [],
                    obscureText: false,
                    labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    maxLength: 50,
                  ),
                  SizedBox(height: 20),
                  CustomTextFormField(
                    controller: serviceTime,
                    labelText: 'Duration',
                    keyboardType: TextInputType.number,
                    hintText: "Min",
                    readOnly: false,
                    textStyle: TextStyle(
                      fontFamily: MyFont.myFont,
                    ),
                    inputFormatters: [],
                    obscureText: false,
                    labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                    maxLength: 50,
                  ),
                  SizedBox(height: 10),
                  Obx(() {
                    return SubmitButton(
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          if (serviceSplTEC.text.isNotEmpty) {
                            FocusScope.of(context).unfocus();
                            controller.callSplAddService(
                                serviceSplTEC.text,
                                servicetoken.text,
                                serviceTime.text,
                                pickedFile?.name,
                                pickedFile?.path,
                                logo64);

                          }
                        },
                        title: 'Send Request');
                  })
                ],
              ),
            ),
          );
        });
  }

  _showDialogToGetImage(BuildContext context) {
    // set up the buttons
    Widget cameraButton = ElevatedButton(
      child: Text("Camera",
          style: TextStyle(fontFamily: MyFont.myFont, color: Colors.white)),
      onPressed: () {
        _getImage(true);
        Navigator.of(context).pop();
      },
    );
    Widget galleryButton = ElevatedButton(
      child: Text(
        "Gallery",
        style: TextStyle(fontFamily: MyFont.myFont, color: Colors.white),
      ),
      onPressed: () {
        _getImage(false);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Choose Image"),
      content: const Text("Select Image from Camera or Gallery?"),
      actions: [cameraButton, galleryButton],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future _getImage(bool isCamera) async {
    final picker = ImagePicker();
    pickedFile = await picker.pickImage(
        imageQuality: Platform.isAndroid ? 40 : 30,
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      List<int> imageBytes = await pickedFile!.readAsBytes();
      setState(() {
        imageName = pickedFile!.name;
      });
      logo64 = base64Encode(imageBytes);
    } else {
      debugPrint('No image selected.');
    }
    Get.back();
    addSplServicePop();
  }
}
