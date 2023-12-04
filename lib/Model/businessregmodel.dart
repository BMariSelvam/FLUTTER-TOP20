import 'CreateServiceModel.dart';
import 'businesscstegorymodel.dart';
import 'businessservicemodel.dart';

class BusinessRegModel {
  int? orgId;
  String? businessName;
  String? displayName;
  String? emailId;
  String? mobileNo;
  String? countryDialCode;
  String? businessCategory;
  String? businessRegNo;
  // int? ratingValue;
  String? tranPin;
  String? appPin;
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
  // String? location;
  double? latitude;
  double? longitude;
  String? logoFileName;
  String? logoImgBase64String;
  bool? businessStatus;
  bool? allowCustomerPlace;
  String? bioInfo;
  bool? allowBusinessPlace;
  List<BusinessServicesModel>? servicesList;
  BusinessCategoryModel? selectedCategory;

  BusinessRegModel();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['BusinessName'] = this.businessName;
    data['DisplayName'] = this.displayName;
    data['EmailId'] = this.emailId;
    data['MobileNo'] = this.mobileNo;
    data['CountryDialCode'] = this.countryDialCode;
    data['BusinessCategory'] = this.businessCategory;
    data['BusinessRegNo'] = this.businessRegNo;
    // data['RatingValue'] = this.ratingValue;
    data['TranPin'] = this.tranPin;
    data['AppPin'] = this.appPin;
    data['AddressLine1'] = this.addressLine1;
    data['AddressLine2'] = this.addressLine2;
    data['AddressLine3'] = this.addressLine3;
    data['City'] = this.city;
    data['Country'] = this.country;
    data['PostalCode'] = this.postalCode;
    data['AllowOnlineApp'] = this.allowOnlineApp;
    data['AllowIndividualTip'] = this.allowIndividualTip;
    data['BusinessPlace'] = this.allowBusinessPlace;
    data['CustomerPlace'] = this.allowCustomerPlace;
    data['OpenTime'] = this.openTime;
    data['CloseTiime'] = this.closeTiime;
    data['BioInfo'] = this.bioInfo;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['BusinessStatus'] = this.businessStatus;
    data['LogoFileName'] = this.logoFileName;
    data['Logo_Img_Base64String'] = this.logoImgBase64String;
    if (this.servicesList != null) {
      data['ServicesList'] = this.servicesList!.map((v) => v.toJson(true)).toList();
    }
    return data;
  }
}

class AddServicesListModel {
  int? orgId;
  String? specialistId;
  String? businessId;
  String? createdby;
  String? createdOn;
  List<BusinessServicesModel>? addservicesList;

  AddServicesListModel(
      {this.orgId,
      this.businessId,
      this.specialistId,
      this.createdby,
      this.createdOn,
      this.addservicesList});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['SpecialistId'] = this.specialistId;
    data['BusinessId'] = this.businessId;
    data['CreatedBy'] = this.createdby;
    data['createdOn'] = "2023-05-22T11:20:33.893Z";
    data['ServicesList'] =
        this.addservicesList!.map((v) => v.toJson(false)).toList();
    return data;
  }
}


class CreateNewServiceModel {
  int? orgId;
  String? specialistId;
  String? businessId;
  String? createdby;
  String? createdOn;
  List<CreateServiceModel>? addservicesList;

  CreateNewServiceModel(
      {this.orgId,
        this.businessId,
        this.specialistId,
        this.createdby,
        this.createdOn,
        this.addservicesList});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['SpecialistId'] = this.specialistId;
    data['BusinessId'] = this.businessId;
    data['CreatedBy'] = this.createdby;
    data['createdOn'] = "2023-05-22T11:20:33.893Z";
    data['ServicesList'] =
        this.addservicesList!.map((v) => v.toJson()).toList();
    return data;
  }
}
