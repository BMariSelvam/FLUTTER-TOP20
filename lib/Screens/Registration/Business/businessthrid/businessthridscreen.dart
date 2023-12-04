import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Const/approute.dart';
import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/businesscstegorymodel.dart';
import '../../../../Model/businessregmodel.dart';
import '../../../../Widget/searchdropdowntextfield.dart';
import '../../../../Widget/submitbutton.dart';
import '../../../../Widget/textformfield.dart';
import 'businessthirdcontroller.dart';

class BusinessRegThirdScreen extends StatefulWidget {
  const BusinessRegThirdScreen({Key? key}) : super(key: key);

  @override
  State<BusinessRegThirdScreen> createState() => _BusinessRegThirdScreenState();
}

class _BusinessRegThirdScreenState extends State<BusinessRegThirdScreen> {
  late BusinessThirdController controller;
  late TextEditingController bioController;

  String selectedBusinessCategoryId = "";

  @override
  void initState() {
    // TODO: implement initState
    controller = Get.put(BusinessThirdController());
    // _controller = Get.put(BusinessRegFirstController());
    controller.businessRegModel = Get.arguments as BusinessRegModel;
    controller.buildBusinessCategoryList();
  }


  XFile? pickedFile;
  String? logo64;
  String? imageName;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessThirdController>(builder: (logic) {
      return Form(
        key: controller.businessRegThirdKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.scaffold,
            elevation: 0,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: MyColors.black),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              "Register as a Business",
              style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  color: MyColors.black),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
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
                  hintText: "About our company",
                  hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                  readOnly: false,
                  labelText: "*",
                  labelTextStyle: TextStyle(color: MyColors.mainTheme,fontSize: 20),
                  textStyle: TextStyle(fontFamily: MyFont.myFont),
                  inputFormatters: [],
                  obscureText: false,
                  maxLine: 3,
                  maxLength: 500,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "About Business";
                    } else if (value.length < 500) {
                      return "Enter Minimum 500 Character";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SearchDropdownTextField<BusinessCategoryModel>(
                    labelText: 'Business Category',
                    items: controller.businessTrueCategoryList.value,
                    color: Colors.black54,
                    selectedItem: controller.selectedBusinessCategory.value,
                    isValidator: false,
                    errorMessage: 'Enter Your Business Category',
                    onChanged: (value) {
                      FocusScope.of(context).unfocus();
                      controller.selectedBusinessCategory.value = value;
                      controller
                          .getBusinessServicesList(value.businessCategoryId);
                      print(value.businessCategoryId);
                      controller.businessRegModel.businessCategory =
                          value.businessCategoryId;
                    }),
                const SizedBox(height: 20),
                // Container(
                //   decoration: BoxDecoration(border: Border.all()),
                //   child: GridView.builder(
                //     itemCount: 6,
                //     shrinkWrap: true,
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 3,
                //       childAspectRatio: 2.5,
                //     ),
                //     itemBuilder: (BuildContext context, int index) {
                //       return Card(
                //         elevation: 4,
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(20.0)),
                //         child: Center(
                //           child: Text(
                //             '${controller.businessCategoryList.value}',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               fontFamily: MyFont.myFont,
                //               fontSize: 16,
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                // const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  onPressed: () {
                    addCategoryPop();
                  },
                  child: Text(
                    "Add Category",
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // CustomTextFormField(
                //   controller: controller.serviceController,
                //   labelText: "Services",
                //   labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
                //   readOnly: false,
                //   textStyle: TextStyle(fontFamily: MyFont.myFont),
                //   inputFormatters: [],
                //   obscureText: false,
                //   maxLength: 20,
                // ),
                Text(
                  "Services",
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                (controller.businessTrueServiceList.value != null)
                    ? Obx(() {
                  return _gridView();
                })
                // Container(
                //         child: GridView.builder(
                //           itemCount:
                //               controller.businessServiceList.value?.length,
                //           shrinkWrap: true,
                //           gridDelegate:
                //               const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 3,
                //             childAspectRatio: 2.5,
                //           ),
                //           itemBuilder: (BuildContext context, int index) {
                //             return Card(
                //               elevation: 4,
                //               shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(20.0)),
                //               child: Center(
                //                 child: Text(
                //                   '${controller.businessServiceList.value?[index].businessServiceName}',
                //                   textAlign: TextAlign.center,
                //                   style: TextStyle(
                //                     fontFamily: MyFont.myFont,
                //                     fontSize: 16,
                //                   ),
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //       )
                    : Container(),

                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                  onPressed: () {
                    _showAddMore();
                  },
                  child: Text(
                    "Add Services",
                    style: TextStyle(
                      fontFamily: MyFont.myFont,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: SubmitButton(
              isLoading: false,
              onTap: () {
                print("object");

                if (controller.businessTrueServiceList != null &&
                    controller.businessTrueServiceList.value != null &&
                    controller.businessTrueServiceList.value!
                    .where((element) => element.isSelected == true)
                    .toList()
                    .isEmpty) {
                  PreferenceHelper.showSnackBar(
                    context: context,
                    msg: 'Please select your services',
                  );
                  return;
                }

                if (controller.bioController.value.text.isEmpty) {
                  PreferenceHelper.showSnackBar(
                    context: context,
                    msg: 'Please enter your bio information',
                  );
                  return;
                }

                // if (controller.businessRegThirdKey.currentState!.validate()) {
                print("object");
                controller.businessRegModel.orgId = 1;
                controller.businessRegModel.bioInfo =
                    controller.bioController.value.text;
                controller.businessRegModel.servicesList = controller
                    .businessTrueServiceList.value
                    ?.where((element) => element.isSelected == true)
                    .toList();
                controller.callBusinessRegistration();
              },
              title: 'Register',
            ),
          ),


        ),
      );
    });
  }

  Widget _gridView() {
    if (controller.businessTrueServiceList.value?.length != null) {
      List<Widget> children = [];

      children = controller.businessTrueServiceList.value!
          .map((e) =>
          InkWell(
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
                    color: e.isSelected == true
                        ? MyColors.black
                        : Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ))
          .toList();
      // children.add(InkWell(
      //   onTap: () {
      //     _showAddMore();
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
      // )
      //);
      return Wrap(
          runSpacing: 15,
          spacing: 15,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: children);
    }
    return Container();
  }

  _showAddMore() {
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController serviceTEC = TextEditingController();
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
                    controller: serviceTEC,
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
                    keyboardType: TextInputType.number,
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
                    controller: serviceTime,
                    labelText: 'Duration',
                    hintText: "Min",
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
                  SizedBox(height: 10),
                  Obx(() {
                    return SubmitButton(
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          if (serviceTEC.text.isNotEmpty) {
                            FocusScope.of(context).unfocus();
                            controller.callAddService(
                                serviceTEC.text, servicetoken.text,
                                serviceTime.text, pickedFile?.name,
                                pickedFile?.path, logo64);
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

  addCategoryPop() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          TextEditingController categoryTEC = TextEditingController();
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Category',
                  textAlign: TextAlign.center,
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Image.asset(Assets.clear))
              ],
            ),
            content: CustomTextFormField(
              controller: categoryTEC,
              labelText: 'Category',
              readOnly: false,
              textStyle: TextStyle(
                fontFamily: MyFont.myFont,
              ),
              inputFormatters: [],
              obscureText: false,
              labelTextStyle: TextStyle(
                fontFamily: MyFont.myFont,
              ),
              maxLength: 100,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SubmitButton(
                    isLoading: false,
                    onTap: () {
                      if (categoryTEC.text.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        controller.addNewCategoryRequest(categoryTEC.text,
                            controller.businessRegModel.emailId);
                      }
                    },
                    title: "Request Category"),
              ),
            ],
          );
        });
  }

  // addServicePop() {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         TextEditingController serviceTEC = TextEditingController();
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20.0)),
  //           title: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               const Text(
  //                 'Add Services',
  //                 textAlign: TextAlign.center,
  //               ),
  //               IconButton(
  //                   onPressed: () {
  //                     Get.back();
  //                   },
  //                   icon: Image.asset(Assets.clear))
  //             ],
  //           ),
  //           content: CustomTextFormField(
  //             controller: serviceTEC,
  //             labelText: 'Services',
  //             readOnly: false,
  //             textStyle: TextStyle(
  //               fontFamily: MyFont.myFont,
  //             ),
  //             inputFormatters: [],
  //             obscureText: false,
  //             labelTextStyle: TextStyle(fontFamily: MyFont.myFont),
  //             maxLength: 50,
  //           ),
  //           actions: [
  //             Padding(
  //               padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
  //               child: SubmitButton(
  //                   isLoading: false,
  //                   onTap: () {
  //                     if (serviceTEC.text.isNotEmpty) {
  //                       FocusScope.of(context).unfocus();
  //                       controller.callAddService(serviceTEC.text);
  //                     }
  //                     Navigator.pop(context);
  //                   },
  //                   title: "Request Services"),
  //             ),
  //           ],
  //         );
  //       });
  // }

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
    _showAddMore();
  }
}
