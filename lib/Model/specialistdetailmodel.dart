class SpecialistDetails {
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
  double? ratingValue;
  bool? haveFreelance;
  bool? serviceatCustomerPlace;
  bool? serviceatSpecialistPlace;
  double? latitude;
  double? longitude;
  String? businessCategory;
  int? SpecialistCount;
  String? bioInfo;
  String? businessCategoryName;
  bool? isActive;

  SpecialistDetails(
      {this.orgId,
      this.specialistId,
      this.displayName,
      this.specilistName,
      this.haveFreelance,
      this.businessCategoryName,
      this.serviceatCustomerPlace,
      this.serviceatSpecialistPlace,
      this.emailId,
      this.mobileNo,
      this.dialCode,
      this.businessCategory,
      this.ratingValue,
      this.tranPin,
      this.appPin,
      this.addressLine1,
      this.addressLine2,
      this.addressLine3,
      this.country,
      this.city,
      this.postalCode,
      this.allowOnlineApp,
      this.latitude,
      this.longitude,
      this.FileName,
      this.FilePath,
      this.logoImgBase64String,
      this.bioInfo,this.isActive});

  SpecialistDetails.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    specialistId = json['SpecialistId'];
    specilistName = json['SpecilistName'];
    displayName = json['DisplayName'];
    emailId = json['EmailId'];
    mobileNo = json['MobileNo'];
    dialCode = json['DialCode'];
    businessCategory = json['BusinessCategoryId'];
    businessCategoryName = json['BusinessCategoryName'];
    ratingValue = json['RatingValue'];
    tranPin = json['TranPin'];
    appPin = json['AppPin'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    city = json['City'];
    country = json['Country'];
    postalCode = json['PostalCode'];
    haveFreelance = json['HaveFreelance'];
    allowOnlineApp = json['AllowOnlineApp'];
    serviceatSpecialistPlace = json['ServiceatSpecialistPlace'];
    serviceatCustomerPlace = json['ServiceatCustomerPlace'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    FileName = json['LogoFileName'];
    bioInfo = json['BioInfo'];
    FilePath = json['FilePath'];
    logoImgBase64String = json['Logo_Img_Base64String'];
    isActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['SpecialistId'] = this.specialistId;
    data['SpecilistName'] = this.specilistName;
    data['DisplayName'] = this.displayName;
    data['EmailId'] = this.emailId;
    data['MobileNo'] = this.mobileNo;
    data['DialCode'] = this.dialCode;
    data['BusinessCategoryName'] = this.businessCategoryName;
    data['BusinessCategoryId'] = this.businessCategory;
    data['RatingValue'] = this.ratingValue;
    data['TranPin'] = this.tranPin;
    data['AppPin'] = this.appPin;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['AddressLine3'] = this.addressLine3;
    data['Country'] = this.country;
    data['PostalCode'] = this.postalCode;
    data['AllowOnlineApp'] = this.allowOnlineApp;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['FileName'] = this.FileName;
    data['FilePath'] = this.FilePath;
    data['BioInfo'] = this.bioInfo;
    data['Logo_Img_Base64String'] = this.logoImgBase64String;
    data['HaveFreelance'] = this.haveFreelance;
    data['AllowOnlineApp'] = this.allowOnlineApp;
    data['ServiceatSpecialistPlace'] = this.serviceatSpecialistPlace;
    data['ServiceatCustomerPlace'] = this.serviceatCustomerPlace;
    data['IsActive'] = this.isActive;
    return data;
  }
}
