class SpecialistListModel {
  int? orgId;
  String? specialistId;
  String? specilistName;
  String? displayName;
  String? businessCategoryId;
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
  bool? allowOnlineApp;
  String? businessCategoryname;
  String? fileName;
  String? filePath;
  double? ratingValue;
  int? specialistcount;
  String? favSpecialistId;
  String? bioInfo;
  bool? isActive;
  bool? customerPlace;
  bool? businessPalce;
  List<SpecilaistServicesList>? servicesList;
  // List<BusinessServicesModel>? servicesList;

  bool isfavourite = false;

  SpecialistListModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    specialistId = json['SpecialistId'];
    specilistName = json['SpecilistName'];
    favSpecialistId = json['FavSpecialistId'];
    displayName = json['DisplayName'];
    dialCode = json['DialCode'];
    mobileNo = json['MobileNo'];
    emailId = json['EmailId'];
    appPIN = json['AppPIN'];
    businessCategoryId = json['BusinessCategoryId'];
    businessCategoryname = json['BusinessCategoryName'];
    tranPIN = json['TranPIN'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    city = json['City'];
    country = json['Country'];
    postalCode = json['PostalCode'];
    allowOnlineApp = json['AllowOnlineApp'];
    fileName = json['FileName'];
    filePath = json['FilePath'];
    ratingValue = json['RatingValue'];
    bioInfo = json['BioInfo'];
    isActive = json['IsActive'];
    customerPlace =  json['ServiceatCustomerPlace'];
    businessPalce =  json['ServiceatSpecialistPlace'];

    if (json['ServicesList'] != null) {
      servicesList = <SpecilaistServicesList>[];
      json['ServicesList'].forEach((v) {
        servicesList!.add(new SpecilaistServicesList.fromJson(v));
      });
    }
  }
}

class SpecilaistServicesList {
  int? orgId;
  String? specialistid;
  String? businessServiceId;
  String? businessServiceName;
  int? durationMinutes;
  int? tokens;
  String? fromtime;
  String? toTime;
  bool? isActive;
  String? createdBy;
  String? createdOn;

  SpecilaistServicesList(
      {this.orgId,
      this.specialistid,
      this.businessServiceId,
      this.businessServiceName,
      this.durationMinutes,
      this.tokens,
      this.fromtime,
      this.toTime,
      this.isActive,
      this.createdBy,
      this.createdOn});

  SpecilaistServicesList.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    specialistid = json['SpecialistId'];
    businessServiceId = json['ServiceId'];
    businessServiceName = json['ServiceName'];
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
    data['SpecialistId'] = this.specialistid;
    data['ServiceId'] = this.businessServiceId;
    data['ServiceName'] = this.businessServiceName;
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
