import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_20/Helper/preferencehelper.dart';
import 'package:top_20/Widget/submitbutton.dart';
import 'package:top_20/Widget/textformfield.dart';
import '../../../../Const/colors.dart';
import '../../../../Const/font.dart';
import '../../../../Const/size.dart';
import '../../../../Helper/apiservice.dart';
import '../../../../Helper/extension.dart';
import '../../../../Model/memberupdatemodel.dart';
import 'editprofilecontroller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  XFile? pickedFile;

  late EditProfileController controller;

  String displayName = "";
  String email = "";
  String filePath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(EditProfileController());
    IntialFunction();
  }

  IntialFunction() async {
    await PreferenceHelper.getMemberData().then((value) => setState(() {
          displayName = "${value?.displayName}";
          email = "${value?.emailId}";
          controller.userNameController.text = "${value?.memberName}";
          controller.addressLine1Controller.text = "${value?.addressLine1}";
          controller.addressLine2Controller.text = "${value?.addressLine2}";
          controller.addressLine3Controller.text = "${value?.addressLine3}";
          controller.mobileNumberController.text = "${value?.mobileNo}";
          controller.countryController.text = "${value?.country}";
          controller.cityController.text = "${value?.city}";
          controller.dialCodeController.text = "${value?.dialCode}";
          filePath = "${value?.FilePath}";
          controller.memberUpdateParams.memberId = "${value?.memberId}";
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                "EDIT PROFILE",
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                ),
              ),
              centerTitle: true,
              expandedHeight: 300,
              pinned: true,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
              flexibleSpace: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              height: 90,
                              width: 90,
                              clipBehavior: Clip.hardEdge,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: (pickedFile == null)
                                  ? webImage(
                                      imageUrl: filePath ?? '',
                                      height: 60,
                                      width: 60)
                                  : pickedFile != null
                                      ? Image.file(
                                          File(pickedFile!.path),
                                          fit: BoxFit.fill,
                                        )
                                      : Container(
                                          color: Colors.grey,
                                          child: const Icon(
                                            Icons.person,
                                            size: 70,
                                          )),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 15,
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
                      const SizedBox(height: 20),
                      Flexible(
                        child: Text(
                          capitalizeFirstLetter(displayName),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        child: Text(
                          email,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                    ],
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
                      controller: controller.userNameController,
                      hintText: "UserName",
                      hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                      textStyle: TextStyle(fontFamily: MyFont.myFont),
                      inputFormatters: [],
                      readOnly: true,
                      maxLength: 100,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Valid UserName";
                        } else if (value.length < 3) {
                          return "Enter Minimum 3 long";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.addressLine1Controller,
                      hintText: "AddressLine1",
                      hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                      textStyle: TextStyle(fontFamily: MyFont.myFont),
                      inputFormatters: [],
                      maxLength: 100,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Valid Address";
                        } else if (value.length < 3) {
                          return "Enter Minimum 3 long";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.addressLine2Controller,
                      hintText: "AddressLine2",
                      hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                      textStyle: TextStyle(fontFamily: MyFont.myFont),
                      inputFormatters: [],
                      maxLength: 100,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Valid Address";
                        } else if (value.length < 3) {
                          return "Enter Minimum 3 long";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.addressLine3Controller,
                      hintText: "AddressLine3",
                      hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                      textStyle: TextStyle(fontFamily: MyFont.myFont),
                      inputFormatters: [],
                      maxLength: 100,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Valid Address";
                        } else if (value.length < 3) {
                          return "Enter Minimum 3 long";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 60,
                          child: CustomTextFormField(
                            readOnly: true,
                            controller: controller.dialCodeController,
                            hintText: "DC",
                            hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                            textStyle: TextStyle(fontFamily: MyFont.myFont),
                            inputFormatters: [],
                            maxLength: 100,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Valid DialCode";
                              } else if (value.length < 3) {
                                return "Enter Minimum 3 long";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: width(context) / 1.4,
                          child: CustomTextFormField(
                            controller: controller.mobileNumberController,
                            hintText: "Mobile Number",
                            hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                            textStyle: TextStyle(fontFamily: MyFont.myFont),
                            inputFormatters: [],
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            maxLength: 100,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Valid Mobile Number";
                              } else if (value.length < 5) {
                                return "Enter Minimum 5 long";
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.cityController,
                      hintText: "City",
                      hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                      textStyle: TextStyle(fontFamily: MyFont.myFont),
                      inputFormatters: [],
                      maxLength: 100,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Valid City";
                        } else if (value.length < 3) {
                          return "Enter Minimum 3 long";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: controller.countryController,
                      hintText: "Country",
                      hintTextStyle: TextStyle(fontFamily: MyFont.myFont),
                      textStyle: TextStyle(fontFamily: MyFont.myFont),
                      inputFormatters: [],
                      maxLength: 100,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Valid Country";
                        } else if (value.length < 3) {
                          return "Enter Minimum 3 long";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SubmitButton(
              isLoading: false,
              onTap: () {
                print("object");
                controller.memberUpdateParams.memberName =
                    controller.userNameController.text;
                controller.memberUpdateParams.addressLine1 =
                    controller.addressLine1Controller.text;
                controller.memberUpdateParams.addressLine2 =
                    controller.addressLine2Controller.text;
                controller.memberUpdateParams.addressLine3 =
                    controller.addressLine3Controller.text;
                controller.memberUpdateParams.city =
                    controller.cityController.text;
                controller.memberUpdateParams.country =
                    controller.countryController.text;
                controller.UpdatedMember();
              },
              title: "Update Profile"),
        ));
  }

  //ImagePicker
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
        controller.memberUpdateParams.filePath = pickedFile!.path;
        controller.memberUpdateParams.FileName = pickedFile!.name;
      });
      controller.memberUpdateParams.logoImgBase64String =
          base64Encode(imageBytes);
    } else {
      debugPrint('No image selected.');
    }
  }
}
