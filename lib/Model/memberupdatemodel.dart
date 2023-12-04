// Register Request Params

class LoginParams {
  final String emailId;
  final String password;

  LoginParams({required this.emailId, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrganizationId'] = 1;
    data['EmailId'] = emailId;
    data['Password'] = password;
    return data;
  }
}

class ContactDetailsSignupParams {
  final String emailId;
  final String phone;

  ContactDetailsSignupParams({required this.emailId, required this.phone});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrgId'] = 1;
    data['name'] = "test";
    data['Email'] = emailId;
    data['Phone'] = phone;
    data['viaOTP'] = "EMAIL";
    return data;
  }
}

class VerifyOTPParams {
  final String emailId;
  final String otp;

  VerifyOTPParams({required this.emailId, required this.otp});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrgId'] = 1;
    data['Email'] = emailId;
    data['OTP'] = otp;
    return data;
  }
}

class BusinessRegistrationParams {
  int? orgId;
  String? businessName;
  String? displayName;
  String? emailId;
  String? mobileNo;
  String? countryDialCode;
  String? businessCategory;
  String? businessRegNo;
  int? ratingValue;
  String? tranPin;
  String? appPin;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? country;
  String? postalCode;
  bool? allowOnlineApp;
  bool? allowIndividualTip;
  String? openTime;
  String? closeTiime;
  double? latitude;
  double? longitude;
  String? logoFileName;
  String? logoImgBase64String;
  List<ServicesListParams>? servicesList;

  BusinessRegistrationParams(
      {this.orgId,
      this.businessName,
      this.displayName,
      this.emailId,
      this.mobileNo,
      this.countryDialCode,
      this.businessCategory,
      this.businessRegNo,
      this.ratingValue,
      this.tranPin,
      this.appPin,
      this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.country,
      this.postalCode,
      this.allowOnlineApp,
      this.allowIndividualTip,
      this.openTime,
      this.closeTiime,
      this.latitude,
      this.longitude,
      this.logoFileName,
      this.logoImgBase64String,
      this.servicesList});

  BusinessRegistrationParams.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    businessName = json['BusinessName'];
    displayName = json['DisplayName'];
    emailId = json['EmailId'];
    mobileNo = json['MobileNo'];
    countryDialCode = json['CountryDialCode'];
    businessCategory = json['BusinessCategory'];
    businessRegNo = json['BusinessRegNo'];
    ratingValue = json['RatingValue'];
    tranPin = json['TranPin'];
    appPin = json['AppPin'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    country = json['Country'];
    postalCode = json['PostalCode'];
    allowOnlineApp = json['AllowOnlineApp'];
    allowIndividualTip = json['AllowIndividualTip'];
    openTime = json['OpenTime'];
    closeTiime = json['CloseTiime'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    logoFileName = json['LogoFileName'];
    logoImgBase64String = json['Logo_Img_Base64String'];
    if (json['ServicesList'] != null) {
      servicesList = <ServicesListParams>[];
      json['ServicesList'].forEach((v) {
        servicesList!.add(ServicesListParams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrgId'] = orgId;
    data['BusinessName'] = businessName;
    data['DisplayName'] = displayName;
    data['EmailId'] = emailId;
    data['MobileNo'] = mobileNo;
    data['CountryDialCode'] = countryDialCode;
    data['BusinessCategory'] = businessCategory;
    data['BusinessRegNo'] = businessRegNo;
    data['RatingValue'] = ratingValue;
    data['TranPin'] = tranPin;
    data['AppPin'] = appPin;
    data['AddressLine1'] = addressLine1;
    data['AddressLine2'] = addressLine2;
    data['AddressLine3'] = addressLine3;
    data['Country'] = country;
    data['PostalCode'] = postalCode;
    data['AllowOnlineApp'] = allowOnlineApp;
    data['AllowIndividualTip'] = allowIndividualTip;
    data['OpenTime'] = openTime;
    data['CloseTiime'] = closeTiime;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['LogoFileName'] = logoFileName;
    data['Logo_Img_Base64String'] = logoImgBase64String;
    if (servicesList != null) {
      data['ServicesList'] = servicesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesListParams {
  int? orgId;
  String? businessServiceId;
  String? businessServiceName;
  int? durationMinutes;
  int? tokens;
  String? fromtime;
  String? toTime;

  ServicesListParams(
      {this.orgId,
      this.businessServiceId,
      this.businessServiceName,
      this.durationMinutes,
      this.tokens,
      this.fromtime,
      this.toTime});

  ServicesListParams.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    businessServiceId = json['BusinessServiceId'];
    businessServiceName = json['BusinessServiceName'];
    durationMinutes = json['Duration_Minutes'];
    tokens = json['Tokens'];
    fromtime = json['Fromtime'];
    toTime = json['ToTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrgId'] = orgId;
    data['BusinessServiceId'] = businessServiceId;
    data['BusinessServiceName'] = businessServiceName;
    data['Duration_Minutes'] = durationMinutes;
    data['Tokens'] = tokens;
    data['Fromtime'] = fromtime;
    data['ToTime'] = toTime;
    return data;
  }
}

class SpecialistSearchParams {
  final String displayName;
  final String emailId;
  final String specialistId;

  SpecialistSearchParams({
    required this.emailId,
    required this.displayName,
    required this.specialistId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrganizationId'] = 1;
    data['DisplayName'] = displayName;
    data['Emailid'] = emailId;
    data['SpecialistId'] = specialistId;
    return data;
  }
}

class InviteSpecialistParams {
  final String businessId;
  final String specialistId;

  InviteSpecialistParams({
    required this.businessId,
    required this.specialistId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrgId'] = 1;
    data['RequestId'] = businessId;
    data['BusinessId'] = businessId;
    data['SpecialistId'] = specialistId;
    data['Status'] = 0;
    data['CreatedBy'] = 'admin';
    return data;
  }
}

class GetAllBusinessCategory {
  final String businessName;
  final String displayName;
  final String businessId;
  final String address1;
  final String address2;
  final String address3;
  final double ratingValue;

  GetAllBusinessCategory(
      {required this.businessName,
      required this.businessId,
      required this.displayName,
      required this.address1,
      required this.address2,
      required this.address3,
      required this.ratingValue});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrganizationId'] = 1;
    data['BusinessName'] = businessName;
    data['DisplayName'] = displayName;
    data['BusinessId'] = businessId;
    data['AddressLine1'] = address1;
    data['AddressLine2'] = address2;
    data['AddressLine3'] = address3;
    data['RatingValue'] = ratingValue;
    return data;
  }
}

class GetAllSpecialistCategory {
  final String specialistName;
  final String specialistId;
  final String displayName;
  final String address1;
  final String address2;
  final String address3;
  final String filePath;
  final double ratingValue;

  // final String businessCategoryId;

  GetAllSpecialistCategory({
    // required this.businessCategoryId
    required this.specialistName,
    required this.displayName,
    required this.filePath,
    required this.specialistId,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.ratingValue,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrganizationId'] = 1;
    // data['BusinessCategory'] = businessCategoryId;
    data['SpecilistName'] = specialistName;
    data['AddressLine1'] = address1;
    data['AddressLine2'] = address2;
    data['AddressLine3'] = address3;
    data['RatingValue'] = ratingValue;
    data['SpecialistId'] = specialistId;
    data['DisplayName'] = displayName;
    data['FilePath'] = filePath;

    return data;
  }
}

class GetBusinessRequstListParams {
  final String businessId;
  final String businessName;
  final String requestId;

  GetBusinessRequstListParams({
    required this.businessId,
    required this.businessName,
    required this.requestId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrganizationId'] = 1;
    data['BusinessId'] = businessId;
    data['RequestId'] = requestId;
    data['BusinessName'] = businessName;
    return data;
  }
}

class ApproveBusinessRequst {
  final String businessId;
  final String specialistId;
  final String requestId;

  ApproveBusinessRequst({
    required this.requestId,
    required this.businessId,
    required this.specialistId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrgId'] = 1;
    data['RequestId'] = requestId;
    data['BusinessId'] = businessId;
    data['SpecialistId'] = specialistId;
    data['Status'] = 0;
    data['CreatedBy'] = 'admin';
    return data;
  }
}

class BusinessUpdateParams {
  int? orgId;
  String? businessId;
  String? businessName;
  String? displayName;
  String? mobileNo;
  String? countryDialCode;
  String? businessCategory;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? country;
  String? city;
  String? postalCode;
  bool? allowOnlineApp;
  bool? allowIndividualTip;
  String? openTime;
  String? closeTiime;
  double? latitude;
  double? longitude;
  String? logoFileName;
  String? logoFilePath;
  String? logoImgBase64String;
  String? location;
  bool? allowCustomerPlace;
  bool? allowBusinessPlace;
  bool? businessStatus;
  String? businessCategoryName;
  String? bioInfo;
bool? isActive;
  BusinessUpdateParams();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = 1;
    data['BusinessId'] = this.businessId;
    if (businessCategory != null) {
      data['BusinessCategory'] = this.businessCategory;
    }
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['AddressLine3'] = this.addressLine3;
    data['City'] = this.city;
    data['Country'] = this.country;
    data['PostalCode'] = this.postalCode;
    data['AllowOnlineApp'] = this.allowOnlineApp;
    data['AllowIndividualTip'] = this.allowIndividualTip;
    data['IsActive'] = this.isActive;
    data['CustomerPlace'] = this.allowCustomerPlace;
    data['BusinessPlace'] = this.allowBusinessPlace;
    data['OpenTime'] = this.openTime;
    data['CloseTiime'] = this.closeTiime;
    data['BusinessCategoryName'] = this.businessCategoryName;
    if (latitude != null) {
      data['Location'] = this.location;
      data['Latitude'] = this.latitude;
      data['Longitude'] = this.longitude;
    }
    data['BioInfo'] = this.bioInfo;
    data['LogoFilePath'] = this.logoFilePath;
    data['LogoFileName'] = this.logoFileName;
    data['Logo_Img_Base64String'] = this.logoImgBase64String;

    data['BusinessStatus'] = this.businessStatus;
    return data;
  }
}

class SpecialistUpdateParams {
  int? orgId;
  String? specialistId;
  String? displayName;
  String? specilistName;
  String? dialCode;
  String? mobileNo;
  String? emailId;
  String? appPin;
  String? tranPin;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? city;
  String? country;
  String? postalCode;
  bool? allowOnlineApp;
  String? FileName;
  String? FilePath;
  String? logoImgBase64String;
  int? ratingValue;
  bool? haveFreelance;
  bool? serviceatCustomerPlace;
  bool? serviceatSpecialistPlace;
  double? latitude;
  double? longitude;
  String? businessCategory;
  String? businessCategoryName;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = 1;
    data['SpecialistId'] = this.specialistId;
    data['SpecilistName'] = this.specilistName;
    data['DisplayName'] = this.displayName;
    data['DialCode'] = this.dialCode;
    data['MobileNo'] = this.mobileNo;
    data['EmailId'] = this.emailId;
    data['AppPIN'] = this.appPin;
    data['TranPin'] = this.tranPin;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['AddressLine3'] = this.addressLine3;
    data['City'] = this.city;
    data['Country'] = this.country;
    if (businessCategory != null) {
      data['BusinessCategory'] = this.businessCategory;
      data['BusinessCategoryName'] = this.businessCategoryName;
    }
    data['PostalCode'] = this.postalCode;
    data['AllowOnlineApp'] = this.allowOnlineApp;

    data['FilePath'] = this.FilePath;
    data['LogoFileName'] = this.FileName;
    data['Logo_Img_Base64String'] = this.logoImgBase64String;

    data['RatingValue'] = this.ratingValue;
    data['HaveFreelance'] = this.haveFreelance;
    data['ServiceatCustomerPlace'] = this.serviceatCustomerPlace;
    data['ServiceatSpecialistPlace'] = this.serviceatSpecialistPlace;
    data['IsActive'] = this.isActive;
    if (latitude != null) {
      data['Latitude'] = this.latitude;
      data['Longitude'] = this.longitude;
    }

    return data;
  }
}

//GetAllSpecialistCategory

// class GetAllSpecialistCategory {
//   final String specialistName;
//   final String address1;
//   final String address2;
//   final String address3;
//   final double ratingValue;
//
//   GetAllSpecialistCategory(
//       {required this.specialistName,
//       required this.address1,
//       required this.address2,
//       required this.address3,
//       required this.ratingValue});
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['OrganizationId'] = 1;
//     data['SpecilistName'] = specialistName;
//     data['AddressLine1'] = address1;
//     data['AddressLine2'] = address2;
//     data['AddressLine3'] = address3;
//     data['RatingValue'] = ratingValue;
//     return data;
//   }
// }

//GetAllBusinessCategory

// class GetAllBusinessCategory {
//   final String businessName;
//   final String address1;
//   final String address2;
//   final String address3;
//   final double ratingValue;
//
//   GetAllBusinessCategory(
//       {required this.businessName,
//       required this.address1,
//       required this.address2,
//       required this.address3,
//       required this.ratingValue});
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['OrganizationId'] = 1;
//     data['BusinessName'] = businessName;
//     data['AddressLine1'] = address1;
//     data['AddressLine2'] = address2;
//     data['AddressLine3'] = address3;
//     data['RatingValue'] = ratingValue;
//     return data;
//   }
// }

class MemberUpdateParams {
  int? orgId;
  String? memberId;
  String? displayName;
  String? memberName;
  String? dialCode;
  String? mobileNo;
  String? emailId;
  String? appPin;
  String? tranPin;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? city;
  String? country;
  String? postalCode;
  String? FileName;
  String? logoImgBase64String;
  String? filePath;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = 1;
    data['MemberId'] = this.memberId;
    data['MemberName'] = this.memberName;
    data['DisplayName'] = this.displayName;
    data['DialCode'] = this.dialCode;
    data['MobileNo'] = this.mobileNo;
    data['EmailId'] = this.emailId;
    data['AppPIN'] = this.appPin;
    data['TranPin'] = this.tranPin;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['AddressLine3'] = this.addressLine3;
    data['City'] = this.city;
    data['Country'] = this.country;
    data['PostalCode'] = this.postalCode;
    data['FileName'] = this.FileName;
    data['FilePath'] = this.filePath;
    data['Logo_Img_Base64String'] = this.logoImgBase64String;
    return data;
  }
}
