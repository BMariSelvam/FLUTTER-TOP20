import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_20/Const/font.dart';
import 'package:top_20/Helper/extension.dart';
import 'package:top_20/Widget/submitbutton.dart';
import 'package:top_20/Widget/textformfield.dart';
import 'package:top_20/Widget/togglebutton.dart';
import '../../../../Const/assets.dart';
import '../../../../Const/colors.dart';
import '../../Model/businessregmodel.dart';
import '../../Model/specialistregmodel.dart';
import 'BefroeServiceRegisterController.dart';

class BeforeServiceRequestList extends StatefulWidget {
  const BeforeServiceRequestList({Key? key}) : super(key: key);

  @override
  State<BeforeServiceRequestList> createState() =>
      _BeforeServiceRequestListListState();
}

class _BeforeServiceRequestListListState extends State<BeforeServiceRequestList> {
  late BeofreServiceController controller;
  late SpecialistRegModel specialistRegModel = SpecialistRegModel();
  late BusinessRegModel businessRegModel = BusinessRegModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(BeofreServiceController());
    firstfunc();
  }

  firstfunc() {
    if (specialistRegModel != null || specialistRegModel != []) {
      specialistRegModel = Get.arguments as SpecialistRegModel;
    } else {
      businessRegModel = Get.arguments as BusinessRegModel;
    }
  }

  XFile? pickedFile;
  String? logo64;
  String? imageName;

  @override
  Widget build(BuildContext context) {
    print("specialistRegModel.businessCategory");
    print(specialistRegModel.businessCategory);
    return Form(
      key: controller.serviceRequest,
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
                        ToggleButton(
                            onTap: (bool) {
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
                if (controller.serviceRequest.currentState!.validate()) {
                if (specialistRegModel != null) {
                  controller.callSplAddService(pickedFile?.name, pickedFile?.path,logo64,specialistRegModel);
                } else {
                  controller.callAddService(pickedFile?.name, pickedFile?.path,logo64,businessRegModel);
                }
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
