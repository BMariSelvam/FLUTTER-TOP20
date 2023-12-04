class BusinessListModel {
  int? orgId;
  String? businessId;
  String? reuestId;
  String? businessName;
  String? displayName;
  String? dialCode;
  String? mobileNo;
  String? emailId;
  String? appPIN;
  String? tranPIN;
  int? status;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? city;
  String? country;
  String? postalCode;
  String? fileName;
  String? filePath;
  double? ratingValue;
  int? bussinessListCount;

  BusinessListModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    businessId = json['BusinessId'];
    reuestId = json['RequestId'];
    businessName = json['BusinessName'];
    displayName = json['DisplayName'];
    dialCode = json['DialCode'];
    mobileNo = json['MobileNo'];
    status = json['Status'];
    emailId = json['EmailId'];
    appPIN = json['AppPIN'];
    tranPIN = json['TranPIN'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    city = json['City'];
    country = json['Country'];
    postalCode = json['PostalCode'];
    fileName = json['LogoFileName'];
    filePath = json['LogoFilePath'];
    ratingValue = json['RatingValue'];
  }
}
