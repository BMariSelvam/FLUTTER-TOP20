import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Helper/extension.dart';
import 'package:top_20/Screens/BusinessFlow/Services/RequestServices/requestservicecontroller.dart';
import 'package:top_20/Widget/submitbutton.dart';
import 'package:top_20/Widget/textformfield.dart';
import 'package:top_20/Widget/togglebutton.dart';
import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../../../Helper/preferenceHelper.dart';
import '../../../../Model/businessservicemodel.dart';

class BusinessServiceRequestList extends StatefulWidget {
  const BusinessServiceRequestList({Key? key}) : super(key: key);

  @override
  State<BusinessServiceRequestList> createState() =>
      _BusinessServiceRequestListState();
}

class _BusinessServiceRequestListState
    extends State<BusinessServiceRequestList> {
  late RequestServiceController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(RequestServiceController());
    controller.intialfunc();
    intialfuncs();
  }

  XFile? pickedFile;
  String? logo64;
  String? imageName;

  String? businessCateName;
  String? SpecialistCateName;

  intialfuncs() async {
    await PreferenceHelper.getSpecialistData().then((value) => setState(() {
          controller.categoryNameController.text =
              value?.businessCategoryName ?? "";
        }));
    await PreferenceHelper.getBusinessData().then((value) => setState(() {
          controller.categoryNameController.text =
              value?.businessCategoryName ?? "";
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.businessRequestServicesKey,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 280,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined)),
              title: Text(
                "REQUEST SERVICES",
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                ),
              ),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
                  child: Align(
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
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: controller.categoryNameController,
                      textStyle: TextStyle(fontFamily: MyFont.myFont),
                      hintText: "Category Name",
                      hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                      inputFormatters: [],
                      maxLength: 200,
                      readOnly: true,
                      maxLine: 1,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.serviceNameController,
                      textStyle: TextStyle(fontFamily: MyFont.myFont),
                      hintText: "Service Name",
                      hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                      inputFormatters: [],
                      maxLength: 100,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Valid Name";
                        } else if (value.length <= 3) {
                          return "Your Service name must have a 3 character";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.serviceChargeController,
                      textStyle: TextStyle(fontFamily: MyFont.myFont),
                      hintText: "Service Charges",
                      hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                      inputFormatters: [NumericInputFormatter()],
                      keyboardType: TextInputType.number,
                      maxLength: 100,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Valid Charges";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.serviceDurationController,
                      textStyle: TextStyle(fontFamily: MyFont.myFont),
                      hintText: "Service Time",
                      hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Text(
                            "Mins",
                            style: TextStyle(fontFamily: MyFont.myFont),
                          )),
                      inputFormatters: [NumericInputFormatter()],
                      keyboardType: TextInputType.number,
                      maxLength: 100,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Your Duration of Service";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Business Status',
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        ToggleButton(onTap: (bool) {
                          setState(() {
                            controller.isServiceStatus.value =
                                !controller.isServiceStatus.value;
                          });
                        })
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SubmitButton(
              isLoading: false,
              onTap: () async {
                if (controller.businessRequestServicesKey.currentState!
                    .validate()) {
                  (controller.businessId != null)
                      ? controller.businessServicesModel =
                          BusinessServicesModel(
                          orgId: 1,
                          businessId: await PreferenceHelper.getBusinessData()
                              .then((value) => value?.businessId),
                          businessServiceId: "",
                          specialistId: "0",
                          businessServiceName:
                              controller.serviceNameController.text,
                          businessCategoryId:
                              await PreferenceHelper.getBusinessData().then(
                            (value) => value?.businessCategory,
                          ),
                          tokens: int.parse(
                              controller.serviceChargeController.text),
                          durationMinutes: int.parse(
                              controller.serviceDurationController.text),
                          isActive: controller.isServiceStatus.value,
                          createdBy: await PreferenceHelper.getBusinessData()
                              .then((value) => value?.businessId),
                          createdOn: "2023-03-29T12:14:17.243",
                          fileName: pickedFile?.name,
                          service_Img_Base64String: logo64,
                          filePath: pickedFile?.path,
                        )
                      : controller.businessServicesModel =
                          BusinessServicesModel(
                          orgId: 1,
                          businessId: "0",
                          businessServiceId: "",
                          specialistId:
                              await PreferenceHelper.getSpecialistData()
                                  .then((value) => value?.specialistId),
                          businessServiceName:
                              controller.serviceNameController.text,
                          businessCategoryId:
                              await PreferenceHelper.getSpecialistData()
                                  .then((value) => value?.businessCategory),
                          tokens: int.parse(
                              controller.serviceChargeController.text),
                          durationMinutes: int.parse(
                              controller.serviceDurationController.text),
                          isActive: controller.isServiceStatus.value,
                          createdBy: await PreferenceHelper.getSpecialistData()
                              .then((value) => value?.specialistId),
                            createdOn: "2023-03-29T12:14:17.243",
                            fileName: pickedFile?.name,
                          service_Img_Base64String: logo64,
                          filePath: pickedFile?.path,
                        );
                  controller.businessRequestServices();
                }
              },
              title: 'Request Service'),
        ),
      ),
    );
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
  }
}
