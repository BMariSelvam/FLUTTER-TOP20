class MemberDetails {
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
  String? FilePath;
  String? userType;

  MemberDetails({
    this.orgId,
    this.memberId,
    this.displayName,
    this.memberName,
    this.emailId,
    this.mobileNo,
    this.dialCode,
    this.tranPin,
    this.appPin,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.country,
    this.city,
    this.postalCode,
    this.FilePath,
    this.FileName,
    this.logoImgBase64String,
  });

  MemberDetails.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    memberId = json['MemberId'];
    memberName = json['MemberName'];
    displayName = json['DisplayName'];
    emailId = json['EmailId'];
    mobileNo = json['MobileNo'];
    dialCode = json['DialCode'];
    tranPin = json['TranPin'];
    appPin = json['AppPin'];
    addressLine1 = json['AddressLine1'];
    addressLine2 = json['AddressLine2'];
    addressLine3 = json['AddressLine3'];
    city = json['City'];
    country = json['Country'];
    postalCode = json['PostalCode'];
    FileName = json['FileName'];
    FilePath = json['FilePath'];
    logoImgBase64String = json['Logo_Img_Base64String'];
  }

  Map<String, dynamic> toJson() {
    print(userType);
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['MemberId'] = this.memberId;
    data['MemberName'] = this.memberName;
    data['DisplayName'] = this.displayName;
    data['EmailId'] = this.emailId;
    data['MobileNo'] = this.mobileNo;
    data['City'] = this.city;
    data['DialCode'] = this.dialCode;
    data['TranPin'] = this.tranPin;
    data['AppPin'] = this.appPin;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['AddressLine3'] = this.addressLine3;
    data['Country'] = this.country;
    data['PostalCode'] = this.postalCode;
    data['FileName'] = this.FileName;
    data['FilePath'] = this.FilePath;
    data['Logo_Img_Base64String'] = this.logoImgBase64String;
    return data;
  }
}
