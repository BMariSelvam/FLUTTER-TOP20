import '../Model/businessregmodel.dart';
import '../Model/businessservicemodel.dart';
import '../Model/memberregmodel.dart';
import '../Model/memberupdatemodel.dart';
import '../Model/specialistregmodel.dart';
import '../Model/userappointmentcreatemodel.dart';
import '../Model/userregmodel.dart';
import '../Model/userspecialistappointmentmodel.dart';
import 'api.dart';
import 'networkmanager.dart';

class ApiService {
  // login
  // static Future<ApiResponse> login({required LoginParams loginParams}) async {
  //   final apiResponse = await NetworkManager.post(
  //       url: HttpUrl.businessLogin, params: loginParams.toJson());
  //   return apiResponse;
  // }
  //
  // //Specialistlogin
  // static Future<ApiResponse> specialistlogin(
  //     {required LoginParams loginParams}) async {
  //   final apiResponse = await NetworkManager.post(
  //       url: HttpUrl.specialistLogin, params: loginParams.toJson());
  //   return apiResponse;
  // }
  //
  // // Memberlogin
  // static Future<ApiResponse> memberlogin(
  //     {required LoginParams loginParams}) async {
  //   final apiResponse = await NetworkManager.post(
  //       url: HttpUrl.memberLogin, params: loginParams.toJson());
  //   return apiResponse;
  // }
  //
  // static Future<ApiResponse> sendOtp(
  //     {required ContactDetailsSignupParams params}) async {
  //   final apiResponse = await NetworkManager.post(
  //       url: HttpUrl.sendOtp, params: params.toJson());
  //   return apiResponse;
  // }
  //
  // static Future<ApiResponse> verifyOtp(
  //     {required VerifyOTPParams params}) async {
  //   final apiResponse = await NetworkManager.post(
  //       url: HttpUrl.verifyOTP, params: params.toJson());
  //   return apiResponse;
  // }
  //
  // static Future<ApiResponse> businessCategory(
  //     {required ContactDetailsSignupParams params}) async {
  //   final apiResponse = await NetworkManager.post(
  //       url: HttpUrl.businessCategory, params: params.toJson());
  //   return apiResponse;
  // }

  static Future<ApiResponse> addBusinessServices(
      {required Map<String, dynamic> params}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.beforeServiceRequest, params: params);
    return apiResponse;
  }

  static Future<ApiResponse> registerBusiness(
      {required BusinessRegModel businessRegModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.registerBusiness, params: businessRegModel.toJson());
    return apiResponse;
  }

  static Future<ApiResponse> registerSpecialist(
      {required SpecialistRegModel specialistRegModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.registerSpecialist, params: specialistRegModel.toJson());
    return apiResponse;
  }

  static Future<ApiResponse> registerMember(
      {required MemberRegModel memberRegModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.registerMember, params: memberRegModel.toJson());
    return apiResponse;
  }

  static Future<ApiResponse> updateMember(
      {required MemberUpdateParams params}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.updateMember, params: params.toJson());
    return apiResponse;
  }

  static Future<ApiResponse> specialistSearch(
      {required SpecialistSearchParams params}) async {
    final apiResponse = await NetworkManager.get(
        url: HttpUrl.specialistSearch, params: params.toJson());
    return apiResponse;
  }

//
//   static Future<ApiResponse> inviteSpecialist(
//       {required InviteSpecialistParams params}) async {
//     final apiResponse = await NetworkManager.post(
//         url: HttpUrl.inviteSpecialist, params: params.toJson());
//     return apiResponse;
//   }
//
  static Future<ApiResponse> updateBusiness(
      {required BusinessUpdateParams params}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.updateBusiness, params: params.toJson());
    return apiResponse;
  }

  static Future<ApiResponse> updateSpecialist(
      {required SpecialistUpdateParams params}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.updateSpecialist, params: params.toJson());
    return apiResponse;
  }

//   static Future<ApiResponse> updateMember(
//       {required MemberUpdateParams params}) async {
//     final apiResponse = await NetworkManager.post(
//         url: HttpUrl.updateMember, params: params.toJson());
//     return apiResponse;
//   }
//
//   // get Business Requst
//   static Future<ApiResponse> getBusinessRequst(
//       {required GetBusinessRequstListParams params}) async {
//     final apiResponse = await NetworkManager.get(
//         url: HttpUrl.getBusinessRequst, params: params.toJson());
//     return apiResponse;
//   }
//
//   //List Specialist in before usingDashboard
//   static Future<ApiResponse> getSpecialistByCategory(
//       {required GetAllSpecialistCategory params}) async {
//     final apiResponse = await NetworkManager.get(
//         url: HttpUrl.getAllSpecialist, params: params.toJson());
//     return apiResponse;
//   }
//
//   //List Business in before usingDashboard
//   static Future<ApiResponse> getBusinessByCategory(
//       {required GetAllBusinessCategory params}) async {
//     final apiResponse = await NetworkManager.get(
//         url: HttpUrl.getBusinessByCategory, params: params.toJson());
//     return apiResponse;
//   }
//
//   //Add Bank Account
//   static Future<ApiResponse> addUserBankAccount(
//       {required BankAccouctModel bankAccouctModel}) async {
//     final apiResponse = await NetworkManager.post(
//         url: HttpUrl.addBankAccount, params: bankAccouctModel.toJson());
//     return apiResponse;
//   }
//
//   //GetAllSpecialistCategory
//   // static Future<ApiResponse> getSpecialistCategory(
//   //     {required GetAllSpecialistCategory params}) async {
//   //   final apiResponse = await NetworkManager.get(
//   //       url: Api.getSpecialistCategory, params: params.toJson());
//   //   return apiResponse;
//   // }
// // GetAllBusinessCategory
// //   static Future<ApiResponse> getBusinessCategory(
// //       {required GetAllBusinessCategory params}) async {
// //     final apiResponse = await NetworkManager.get(
// //         url: Api.getBusinessCategory, params: params.toJson());
// //     return apiResponse;
// //   }
//
  // AppointmentForSpecialist
  static Future<ApiResponse> userAppointmentSpecialist(
      {required UserSpecialistAppointmentCreateModel
          userAppointmentCreateModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.userAppointmentSpecialist,
        params: userAppointmentCreateModel.toJson());
    return apiResponse;
  }

//
  //AppointmentBusiness
  static Future<ApiResponse> userAppointmentBusiness(
      {required UserBusinessAppointmentCreateModel
          userBusinessAppointmentCreateModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.userAppointmentSpecialist,
        params: userBusinessAppointmentCreateModel.toJson());
    return apiResponse;
  }

//
//   //Add NewService
//
  static Future<ApiResponse> addNewServices(
      {required BusinessServicesModel businessServicesModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.AddNewServicescreate,
        params: businessServicesModel.toJson(false));
    return apiResponse;
  }

  //AppointmentBusiness
  static Future<ApiResponse> postRating(
      {required Map<String, dynamic> data}) async {
    final apiResponse =
        await NetworkManager.post(url: HttpUrl.postRating, params: data);
    return apiResponse;
  }

//User - Specialist Post Rating
  static Future<ApiResponse> userSplPostRating(
      {required Map<String, dynamic> data}) async {
    final apiResponse =
        await NetworkManager.post(url: HttpUrl.postUserReview, params: data);
    return apiResponse;
  }

//
//   static Future<ApiResponse> addservicebusiness(
//       {required AddServicesListModel addServicesListModel}) async {
//     final apiResponse = await NetworkManager.post(
//         url: HttpUrl.addbusinessServicelist,
//         params: addServicesListModel.toJson());
//     return apiResponse;
//   }
//
//   // Approve Requst
//   static Future<ApiResponse> approveRequest(
//       {required Map<String, dynamic> data}) async {
//     final apiResponse =
//     await NetworkManager.post(url: HttpUrl.approveRequest, params: data);
//     return apiResponse;
//   }
//
  static Future<ApiResponse> inActiveServiceSpecialist(
      {required AddServicesListModel addServicesListModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.inActiveServiceSpecialist,
        params: addServicesListModel.toJson());
    return apiResponse;
  }

  static Future<ApiResponse> inActiveServiceBusiness(
      {required AddServicesListModel addServicesListModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.inActiveServiceBusiness,
        params: addServicesListModel.toJson());
    return apiResponse;
  }
//

  static Future<ApiResponse> addExistingServicesBusiness(
      {required AddServicesListModel addServicesListModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.createServiceBusiness,
        // inActiveServiceBusiness,
        params: addServicesListModel.toJson());
    return apiResponse;
  }

//
  static Future<ApiResponse> createServiceSpecialist(
      {required AddServicesListModel addServicesListModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.createServiceSpecialist,
        // inActiveServiceBusiness,
        params: addServicesListModel.toJson());
    return apiResponse;
  }

//

  static Future<ApiResponse> CreateSerivceSpecialist(
      {required CreateNewServiceModel createNewServiceModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.createServiceSpecialist,
        // inActiveServiceBusiness,
        params: createNewServiceModel.toJson());
    return apiResponse;
  }

  static Future<ApiResponse> AddExistingServicesbusiness(
      {required CreateNewServiceModel createNewServiceModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.createServiceBusiness,
        // inActiveServiceBusiness,
        params: createNewServiceModel.toJson());
    return apiResponse;
  }

//
  static Future<ApiResponse> inActiveRemoveServiceSpecialist(
      {required AddServicesListModel removeServicesListModel}) async {
    final apiResponse = await NetworkManager.post(
        url: HttpUrl.inActiveServiceSpecialist,
        params: removeServicesListModel.toJson());
    return apiResponse;
  }
//
//   static Future<ApiResponse> InActiveServicebusiness(
//       {required AddServicesListModel removeServicesListModel}) async {
//     final apiResponse = await NetworkManager.post(
//         url: HttpUrl.inActiveServiceBusiness,
//         params: removeServicesListModel.toJson());
//     return apiResponse;
//   }
}
