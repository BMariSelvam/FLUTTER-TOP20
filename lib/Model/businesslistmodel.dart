import 'businessspecialistmodel.dart';

class BusinessListUserViewModel {
  int? orgId;
  String? businessId;
  String? FavBusinessId;
  String? reuestId;
  String? businessName;
  String? displayName;
  String? dialCode;
  String? mobileNo;
  String? emailId;
  String? appPIN;
  String? tranPIN;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? city;
  String? country;
  String? postalCode;
  String? fileName;
  String? filePath;
  double? ratingValue;
  String? businessCategoryId;
  String? businessCategoryName;
  int? bussinessListCount;
  bool? isActive;
  String? openTime;
  String? closeTiime;
  bool? customerPlace;
  bool? businessPalce;
  List<BussinesServicesList>? servicesList;

  bool isExpanded = false;
  bool isFavourite = false;

  List<BusinessMySpecialistModel> businessSpecialist = [];

  BusinessListUserViewModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    businessId = json['BusinessId'];
    reuestId = json['RequestId'];
    businessName = json['BusinessName'];
    displayName = json['DisplayName'];
    dialCode = json['DialCode'];
    mobileNo = json['MobileNo'];
    businessCategoryId = json['BusinessCategory'];
    FavBusinessId = json['FavBusinessId'];
    businessCategoryName = json['BusinessCategoryName'];
    emailId = json['EmailId'];
    appPIN = json['AppPIN'];
    tranPIN = json['TranPIN'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    city = json['City'];
    country = json['Country'];
    postalCode = json['PostalCode'];
    fileName = json['FileName'];
    filePath = json['LogoFilePath'];
    ratingValue = json['RatingValue'];
    isActive =  json['IsActive'];
    openTime =  json['OpenTime'];
    closeTiime =  json['CloseTiime'];
    customerPlace =  json['CustomerPlace'];
    businessPalce =  json['BusinessPlace'];


    if (json['ServicesList'] != null) {
      servicesList = <BussinesServicesList>[];
      json['ServicesList'].forEach((v) {
        servicesList!.add(new BussinesServicesList.fromJson(v));
      });
    }
  }
}

class BussinesServicesList {
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

  BussinesServicesList(
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

  BussinesServicesList.fromJson(Map<String, dynamic> json) {
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
