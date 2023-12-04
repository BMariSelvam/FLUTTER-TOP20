class MemberRegModel {
  int? orgId;
  int? memberId;
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
  bool? latitude;
  bool? longitude;
  int? ratingValue;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
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
    data['Logo_Img_Base64String'] = this.logoImgBase64String;
    data['FilePath'] = this.filePath;
    data['RatingValue'] = this.ratingValue;
    return data;
  }
}
