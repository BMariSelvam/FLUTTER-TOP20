import 'businesscstegorymodel.dart';
import 'businessservicemodel.dart';

class SpecialistRegModel {
  int? orgId;
  String? specialistId;
  String? displayName;
  String? specilistName;
  String? dialCode;
  String? mobileNo;
  String? countryDialCode;
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
  String? logoImgBase64String;
  int? ratingValue;
  bool? haveFreelance;
  bool? serviceatCustomerPlace;
  bool? serviceatSpecialistPlace;
  double? latitude;
  String? bioInfo;
  double? longitude;
  String? businessCategory;
  BusinessCategoryModel? selectedCategory;
  List<BusinessServicesModel>? servicesList;

  SpecialistRegModel();

  Map<String, dynamic> toJson() {
    // print("map value");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['SpecialistId'] = this.specialistId;
    data['SpecilistName'] = this.specilistName;
    data['DisplayName'] = this.displayName;
    data['DialCode'] = this.dialCode;
    data['CountryDialCode'] = this.countryDialCode;
    data['MobileNo'] = this.mobileNo;
    data['EmailId'] = this.emailId;
    data['AppPIN'] = this.appPin;
    data['TranPin'] = this.tranPin;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['AddressLine3'] = this.addressLine3;
    data['City'] = this.city;
    data['Country'] = this.country;
    data['BusinessCategoryId'] = this.businessCategory;
    data['PostalCode'] = this.postalCode;
    data['AllowOnlineApp'] = this.allowOnlineApp;
    data['FileName'] = this.FileName;
    data['Logo_Img_Base64String'] = this.logoImgBase64String;
    data['RatingValue'] = this.ratingValue;
    data['HaveFreelance'] = this.haveFreelance;
    data['ServiceatCustomerPlace'] = this.serviceatCustomerPlace;
    data['ServiceatSpecialistPlace'] = this.serviceatSpecialistPlace;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['BioInfo'] = this.bioInfo;
    if (this.servicesList != null) {
      data['ServicesList'] = this.servicesList!.map((v) => v.toJson(true)).toList();
    }
    return data;
  }
}
