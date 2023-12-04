import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Model/Member_details_model.dart';

import '../Model/specialistdetailmodel.dart';

import '../Model/userdetailmodel.dart';
import 'constant.dart';

class PreferenceHelper {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static bool isUser = false;
  static bool isBusiness = false;
  static bool isSpecialist = false;

  static Future<bool> isUserLoggedIn() async {
    var userDetailsModel = await PreferenceHelper.getBusinessData();
    return userDetailsModel != null;
  }

  // static bool isSmartWatch(BuildContext context) {
  //   if (MediaQuery.of(context).size.width == 320 &&
  //       MediaQuery.of(context).size.height == 320) {
  //     return true;
  //   }
  //   return false;
  // }

  static void navigateMap(
      {required String orginLatLon, String? destinationLatLon}) async {
    String url =
        "https://www.google.com/maps/dir/?api=1&origin=$orginLatLon${destinationLatLon != null ? "&destination=$destinationLatLon" : ''}&travelmode=driving&dir_action=navigate";
    String appUrl =
        "comgooglemaps://?saddr=$orginLatLon&daddr=$destinationLatLon&directionsmode=driving";
    if (await canLaunchUrlString(appUrl)) {
      await launchUrlString(appUrl);
    } else if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void launchMap({required String latLng}) async {
    // String query = Uri.encodeComponent(latLng);
    // String googleUrl = "google.navigation:q=$latLng";
    // Uri googleUri = Uri.parse(googleUrl);
    String url = "https://www.google.com/maps/search/?api=1&query=$latLng";
    // String url = "https://www.google.com/maps/search/$latLng";
    // String encodedURl = Uri.encodeFull(url);
    try {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } catch (error) {
      PreferenceHelper.print('Could not launch');
    }
  }

  static Future<BusinessDetailsModel?> getBusinessData() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user_data';
    if (prefs.containsKey(key)) {
      final value = json.decode(prefs.getString(key)!);
      if (value != null) {
        PreferenceHelper.log('Get User Data: $value');
        return BusinessDetailsModel.fromJson(value);
      }
    }
    return null;
  }

  static Future<SpecialistDetails?> getSpecialistData() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user_data';
    if (prefs.containsKey(key)) {
      final value = json.decode(prefs.getString(key)!);
      if (value != null) {
        PreferenceHelper.log('Get User Data: $value');
        return SpecialistDetails.fromJson(value);
      }
    }
    return null;
  }

  static Future<MemberDetails?> getMemberData() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user_data';
    if (prefs.containsKey(key)) {
      final value = json.decode(prefs.getString(key)!);
      if (value != null) {
        PreferenceHelper.log('Get User Data: $value');
        return MemberDetails.fromJson(value);
      }
    }
    return null;
  }

  static Future<bool> saveUserData(Map userData) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user_data';
    final value = json.encode(userData);
    isUser = false;
    isSpecialist = false;
    isBusiness = false;
    if (userData["MemberId"] != null) {
      isUser = true;
    } else if (userData["SpecialistId"] != null) {
      isSpecialist = true;
    } else if (userData["BusinessId"] != null) {
      isBusiness = true;
    }
    PreferenceHelper.log('Save User Data $value');
    return prefs.setString(key, value);
  }

  static Future<bool> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'user_data';
    await prefs.clear();
    return true;
  }

  static Future<bool> saveFirebaseToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'firebase_token';
    PreferenceHelper.log('firebase_token $token');
    return prefs.setString(key, token);
  }

  static Future<String> getFirebaseToken() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'firebase_token';
    if (prefs.containsKey(key)) {
      final value = prefs.getString(key);
      if (value != null) {
        PreferenceHelper.log('firebase_token: $value');
        return value;
      }
    }
    return 'fLQ1hGr6TVKYzWTUIQmAyP:APA91bFf5jUiAolaX4Wf8tqcoVVsIq_67lJwd5FKhRvUD0L58E6EYlZK1UBvvUsDWUCH9ododXfuzQi768eAvEqRMAc3obUcZMMjpHUcXYmGdTapIx8ba59HPZn81Mbs-uPmSVyvEsMl';
  }

  static showSnackBar(
      {required BuildContext context, String? msg, Duration? duration}) {
    if (msg != null && msg.isNotEmpty) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(SnackBar(
        content: Text(
          msg,
        ),
        duration: duration ?? const Duration(seconds: 2),
      ));
    }
  }

  // static showPopup(
  //     {required BuildContext context, String? msg, Duration? duration}) {
  //   if (msg != null && msg.isNotEmpty) {
  //     return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           content: Text(
  //             msg,
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }

  static String dateToString(
      {required DateTime date, String dateFormat = 'dd-MM-yyyy'}) {
    var formatter = DateFormat(dateFormat);
    String formatted = formatter.format(date);
    return formatted;
  }

  static String timeToString(
      {required TimeOfDay tod, String dateFormat = 'hh:mm a'}) {
    final now = DateTime.now();
    final dt =
        DateTime(now.year, now.month, now.day, tod.hour, tod.periodOffset);
    final format = DateFormat(dateFormat);
    return format.format(dt);
  }

  static String getDateTime(
      {required DateTime date,
      required TimeOfDay tod,
      dateFormat = 'yyyy-MM-dd HH:mm:ss'}) {
    final dt = DateTime(date.year, date.month, date.day, tod.hour,
        (tod.minute % 5 * 5).toInt());
    final format = DateFormat(dateFormat);
    return format.format(dt);
  }

  static String stringDateFormat(
      {required String date, dateFormat = 'dd-MM-yyyy hh:mm a'}) {
    var parsedDate = DateTime.parse(date);
    return PreferenceHelper.dateToString(
        date: parsedDate, dateFormat: dateFormat);
  }

  static Widget showLoader({Color? color}) {
    if (color == null) {
      return const CircularProgressIndicator();
    } else {
      return CircularProgressIndicator(backgroundColor: color);
    }
  }

  static showDialogLoader(BuildContext context) {
    EasyLoading.show(status: 'loading...');
  }

  static hideDialogLoader() {
    EasyLoading.dismiss();
  }

  static void call(String number) => launchUrlString("tel:$number");

  static void sendSms(String number) => launchUrlString("sms:$number");

  static void sendEmail(String email) => launchUrlString("mailto:$email");

  static void log(dynamic value) {
    if (value != null && Constant.showLog) {
      final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      pattern.allMatches(value).forEach((match) => debugPrint(match.group(0)));
    }
  }

  static void print(dynamic value) {
    if (value != null && Constant.showLog) {
      debugPrint(value);
    }
  }

  static void launchURL(String url, LaunchMode launchMode) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: launchMode);
    } else {}
  }

  // static Future<LocationModel?> getCurrentLocation() async {
  //   // const platform = MethodChannel('com.farnek.smartfm.smart_fm/location');
  //   // String currentLocation;
  //   // String? result;
  //   // try {
  //   //   result = await platform.invokeMethod('getCurrentLocation');
  //   //   currentLocation = 'Current location is $result';
  //   // } on PlatformException catch (e) {
  //   //   currentLocation = "Failed to get current location: '${e.message}'.";
  //   // }
  //   // Themes.print(currentLocation);
  //   // if (result != null) {
  //   //   var arr = result.split(',');
  //   //   if (arr.length >= 2) {
  //   //     return LocationModel(arr[0], arr[1]);
  //   //   }
  //   // }
  //   return null;
  // }

  static Future<DateTime?> showTimePopup(
      BuildContext context,
      DateTime? dateTime,
      ) async {
    return await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (_) {
        DateTime? selectedDateTime = dateTime ?? DateTime.tryParse("2023-01-01 00:00");

        // Ensure that the selected time is a multiple of 15 minutes
        int minuteOffset = selectedDateTime!.minute % 15;
        if (minuteOffset > 0) {
          selectedDateTime = selectedDateTime.add(Duration(minutes: 15 - minuteOffset));
        }

        return Container(
          height: 280,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  minuteInterval: 15,
                  initialDateTime: selectedDateTime,
                  minimumDate: selectedDateTime,
                  onDateTimeChanged: (picked) {
                    selectedDateTime = picked;
                  },
                ),
              ),
              CupertinoButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(selectedDateTime),
              ),
            ],
          ),
        );
      },
    );
  }


}
