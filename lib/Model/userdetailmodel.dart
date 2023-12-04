class BusinessDetailsModel {
  int? orgId;
  String? businessId;
  String? businessName;
  String? displayName;
  String? emailId;
  String? mobileNo;
  String? countryDialCode;
  String? businessCategory;
  String? businessRegNo;
  double? ratingValue;
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
  String? location;
  double? latitude;
  double? longitude;
  String? logoFileName;
  String? logoImgBase64String;
  String? logoFilePath;
  List<ServicesList>? servicesList;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  bool? isApproved;
  String? approvedBy;
  String? approvedDate;
  String? city;
  String? passwoard;
  bool? businessStatus;
  bool? customerPlace;
  bool? businessPlace;
  String? bioInfo;
  String? userType;
  String? businessCategoryName;

  BusinessDetailsModel(
      {this.orgId,
      this.businessId,
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
      this.passwoard,
      this.longitude,
      this.logoFileName,
      this.logoImgBase64String,
      this.logoFilePath,
      this.servicesList,
      this.isActive,
      this.createdBy,
      this.createdOn,
      this.isApproved,
      this.approvedBy,
      this.approvedDate,
      this.bioInfo,
      this.businessCategoryName});

  BusinessDetailsModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    businessId = json['BusinessId'];
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
    passwoard = json['AppPIN'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    city = json['City'];
    country = json['Country'];
    postalCode = json['PostalCode'];
    allowOnlineApp = json['AllowOnlineApp'];
    allowIndividualTip = json['AllowIndividualTip'];
    openTime = json['OpenTime'];
    closeTiime = json['CloseTiime'];
    location = json['Location'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    businessCategoryName = json['BusinessCategoryName'];
    logoFileName = json['LogoFileName'];
    logoImgBase64String = json['Logo_Img_Base64String'];
    bioInfo = json['BioInfo'];
    logoFilePath = json['LogoFilePath'];
    if (json['ServicesList'] != null) {
      servicesList = <ServicesList>[];
      json['ServicesList'].forEach((v) {
        servicesList!.add(new ServicesList.fromJson(v));
      });
    }
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    isApproved = json['IsApproved'];
    approvedBy = json['ApprovedBy'];
    approvedDate = json['ApprovedDate'];
    businessStatus = json['BusinessStatus'];
    customerPlace = json['CustomerPlace'];
    businessPlace = json['BusinessPlace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['BusinessId'] = this.businessId;
    data['BusinessName'] = this.businessName;
    data['DisplayName'] = this.displayName;
    data['EmailId'] = this.emailId;
    data['MobileNo'] = this.mobileNo;
    data['CountryDialCode'] = this.countryDialCode;
    data['BusinessCategory'] = this.businessCategory;
    data['BusinessRegNo'] = this.businessRegNo;
    data['RatingValue'] = this.ratingValue;
    data['TranPin'] = this.tranPin;
    data['AppPin'] = this.appPin;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['AddressLine3'] = this.addressLine3;
    data['Country'] = this.country;
    data['PostalCode'] = this.postalCode;
    data['AllowOnlineApp'] = this.allowOnlineApp;
    data['AllowIndividualTip'] = this.allowIndividualTip;
    data['OpenTime'] = this.openTime;
    data['CloseTiime'] = this.closeTiime;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['LogoFileName'] = this.logoFileName;
    data['BusinessCategoryName'] = this.businessCategoryName;
    data['Logo_Img_Base64String'] = this.logoImgBase64String;
    data['LogoFilePath'] = this.logoFilePath;
    data['BioInfo'] = this.bioInfo;
    if (this.servicesList != null) {
      data['ServicesList'] = this.servicesList!.map((v) => v.toJson()).toList();
    }
    data['IsActive'] = this.isActive;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    data['IsApproved'] = this.isApproved;
    data['ApprovedBy'] = this.approvedBy;
    data['ApprovedDate'] = this.approvedDate;
    // userType = "B";
    return data;
  }
}

class ServicesList {
  int? orgId;
  String? businessId;
  String? businessServiceId;
  String? businessServiceName;
  int? durationMinutes;
  int? tokens;
  String? fromtime;
  String? toTime;
  bool? isActive;
  String? createdBy;
  String? createdOn;

  ServicesList(
      {this.orgId,
      this.businessId,
      this.businessServiceId,
      this.businessServiceName,
      this.durationMinutes,
      this.tokens,
      this.fromtime,
      this.toTime,
      this.isActive,
      this.createdBy,
      this.createdOn});

  ServicesList.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    businessId = json['BusinessId'];
    businessServiceId = json['BusinessServiceId'];
    businessServiceName = json['BusinessServiceName'];
    durationMinutes = json['Duration_Minutes'];
    tokens = json['Tokens'];
    fromtime = json['Fromtime'];
    toTime = json['ToTime'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['BusinessId'] = this.businessId;
    data['BusinessServiceId'] = this.businessServiceId;
    data['BusinessServiceName'] = this.businessServiceName;
    data['Duration_Minutes'] = this.durationMinutes;
    data['Tokens'] = this.tokens;
    data['Fromtime'] = this.fromtime;
    data['ToTime'] = this.toTime;
    data['IsActive'] = this.isActive;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    return data;
  }
}
