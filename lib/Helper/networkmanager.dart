import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

import '../Const/enum.dart';
import '../Model/apiresponsemodel.dart';
import '../Model/fileuploadmodel.dart';

import '../main.dart';
import 'api.dart';
import 'constant.dart';
import 'extension.dart';
import 'preferenceHelper.dart';

class NetworkManager {
  static Dio _dio() {
    var headers = {
      if (bearerToken.isNotEmpty) "Authorization": "Bearer $bearerToken",
      "Content-Type": "application/json"
      // "Accept": "*/*",
      // "language-code": Themes.locale.languageCode,
      // "country-code": Themes.locale.countryCode
    };
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 50000),
      sendTimeout: const Duration(milliseconds: 300000),
      headers: headers,
    );
    PreferenceHelper.log("******Dio Header*****");
    prettyPrintJson(headers);
    Dio dio = Dio(options);
    return dio;
  }

  static Future<ApiResponse> get(
      {required String url, required Map<String, dynamic>? params}) async {
    PreferenceHelper.log("url----->$url");
    // var userDetailsModel = await Themes.getUserData();
    // if (userDetailsModel != null) {
    //   params ??= {
    //     "email_id": userDetailsModel.emailId,
    //     "type": userDetailsModel.orgId
    //   };
    // }
    if (params != null) {
      params["OrganizationId"] = 1;
      PreferenceHelper.log("******GET Params*****");
      prettyPrintJson(params);
    }
    return _mainCall(httpMethods: HttpMethods.get, url: url, params: params);
  }

  static Future<ApiResponse> post(
      {required String url, required Map<String, dynamic>? params}) async {
    // var userDetailsModel = await Themes.getUserData();
    // if (userDetailsModel != null) {
    //   if (params == null) {
    //     params = {
    //       "login_id": userDetailsModel.loginId,
    //       "type": userDetailsModel.loginType
    //     };
    //   } else {
    //     if (!params.containsKey("login_id")) {
    //       params["login_id"] = userDetailsModel.loginId;
    //     }
    //     if (!params.containsKey("type")) {
    //       params["type"] = userDetailsModel.loginType;
    //     }
    //   }
    // }
    PreferenceHelper.log("url----->$url");
    if (params != null) {
      params["OrganizationId"] = 1;
      PreferenceHelper.log("******POST Params*****");
      prettyPrintJson(params);
    }
    return _mainCall(httpMethods: HttpMethods.post, url: url, params: params);
  }

  static Future<ApiResponse> uploadFile(
      {required String url,
      required Map<String, dynamic>? params,
      required List<FileUploadModel>? fileUploadList}) async {
    // var userDetailsModel = await Themes.getUserData();
    // if (userDetailsModel != null) {
    //   if (params == null) {
    //     params = {"login_id": userDetailsModel.loginId};
    //   } else {
    //     if (!params.containsKey("login_id")) {
    //       params["login_id"] = userDetailsModel.loginId;
    //     }
    //     if (!params.containsKey("type")) {
    //       params["type"] = userDetailsModel.loginType;
    //     }
    //   }
    // }
    PreferenceHelper.log("url----->$url");
    FormData formData = FormData();
    if (params != null) {
      PreferenceHelper.log("******Params*****");
      prettyPrintJson(params);
      params.forEach((k, v) {
        formData.fields.add(MapEntry(k, v));
      });
    }
    if (fileUploadList != null && fileUploadList.isNotEmpty) {
      for (var fileUploadModel in fileUploadList) {
        if (fileUploadModel.file.path.isNotEmpty) {
          String fileName = basename(fileUploadModel.file.path);
          var multipartFile = MultipartFile.fromFileSync(
              fileUploadModel.file.path,
              filename: fileName);
          formData.files.add(MapEntry(fileUploadModel.keyName, multipartFile));
          log("Key Name : ${fileUploadModel.keyName}");
          log("File Name : $fileName");
          log("File Size : ${fileUploadModel.file.lengthSync()}");
        }
      }
    }
    return _mainCall(httpMethods: HttpMethods.post, url: url, params: formData);
  }

  static Future<ApiResponse> _mainCall(
      {required HttpMethods httpMethods,
      required String url,
      required var params}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return ApiResponse(
          apiResponseModel: null, error: "No Internet Connection");
    }
    try {
      late Response response;
      if (bearerToken.isEmpty) {
        await _generateToken();
      }
      if (httpMethods == HttpMethods.get) {
        response = await _dio().get(url, queryParameters: params);
      } else if (httpMethods == HttpMethods.post) {
        response = await _dio().post(url, data: params);
      } else if (httpMethods == HttpMethods.put) {
        response = await _dio().put(url, data: params);
      } else if (httpMethods == HttpMethods.delete) {
        response = await _dio().delete(url, data: params);
      }
      if (response.statusCode == 200) {
        if (response.data is String) {
          PreferenceHelper.log("######Response######");
          // if (Themes.navigatorKey.currentContext != null) {
          // Themes.navigatorKey.currentContext!
          //     .read<UserProvider>()
          //     .callCheckMultiUserLogin();
          // }
          var data = json.decode(response.data);
          if (data != null && data is Map<String, dynamic>) {
            prettyPrintJson(data);
            return ApiResponse(
                apiResponseModel: ApiResponseModel.fromJson(data), error: null);
          } else {
            PreferenceHelper.log("******Response Error*****");
            PreferenceHelper.log(response.data);
            return ApiResponse(apiResponseModel: null, error: "Response Error");
          }
        } else if (response.data is Map<String, dynamic>) {
          PreferenceHelper.log("******Response*****");
          prettyPrintJson(response.data);
          return ApiResponse(
              apiResponseModel: ApiResponseModel.fromJson(response.data),
              error: null);
        } else {
          PreferenceHelper.log("******Response*****");
          PreferenceHelper.log(response.data);
        }
      } else if (response.statusCode == 401) {
        await _generateToken();
      }
      return ApiResponse(apiResponseModel: null, error: "Response Error");
    } on DioError catch (error) {
      PreferenceHelper.log("DioError Exception occurred: $error");
      return ApiResponse(apiResponseModel: null, error: "Response error");
    } on FormatException catch (e) {
      PreferenceHelper.log("FormatException occurred: ${e.source}");
      return ApiResponse(apiResponseModel: null, error: "Response error");
    } catch (e) {
      PreferenceHelper.log("Exception occurred: $e");
      return ApiResponse(apiResponseModel: null, error: "Response error");
    }
  }

  static Future _generateToken() async {
    Map<String, dynamic> adminParams = {
      "Username": Constant.adminUserName,
      "Password": Constant.adminPassword,
    };
    PreferenceHelper.log("url----->${HttpUrl.generateToken}");
    PreferenceHelper.log("******Params*****");
    prettyPrintJson(adminParams);
    Response response =
        await _dio().post(HttpUrl.generateToken, data: adminParams);
    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic>) {
        bearerToken = response.data['Jwt_Token'];
      }
    }
  }
}

class ApiResponse {
  ApiResponseModel? apiResponseModel;
  String? error;

  ApiResponse({required this.apiResponseModel, required this.error});
}
