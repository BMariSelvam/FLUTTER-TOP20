class FeaturedServicesModel {
  FeaturedServicesModel({
    this.orgId,
    this.tranNo,
    this.tranDate,
    this.serviceId,
    this.serviceName,
    this.isActive,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.fileName,
    this.filePath,
    this.businessDetail,
    this.specialistDetail,
  });

  FeaturedServicesModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    tranNo = json['TranNo'];
    tranDate = json['TranDate'];
    serviceId = json['ServiceId'];
    serviceName = json['ServiceName'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    fileName = json['FileName'];
    filePath = json['FilePath'];
    if (json['BusinessDetail'] != null) {
      businessDetail = [];
      json['BusinessDetail'].forEach((v) {
        businessDetail?.add(BusinessDetail.fromJson(v));
      });
    }
    if (json['SpecialistDetail'] != null) {
      specialistDetail = [];
      json['SpecialistDetail'].forEach((v) {
        specialistDetail?.add(SpecialistDetail.fromJson(v));
      });
    }
  }
  int? orgId;
  String? tranNo;
  String? tranDate;
  String? serviceId;
  String? serviceName;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  String? fileName;
  String? filePath;
  List<BusinessDetail>? businessDetail;
  List<SpecialistDetail>? specialistDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TranNo'] = tranNo;
    map['TranDate'] = tranDate;
    map['ServiceId'] = serviceId;
    map['ServiceName'] = serviceName;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['FileName'] = fileName;
    map['FilePath'] = filePath;
    if (businessDetail != null) {
      map['BusinessDetail'] = businessDetail?.map((v) => v.toJson()).toList();
    }
    if (specialistDetail != null) {
      map['SpecialistDetail'] =
          specialistDetail?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SpecialistDetail {
  SpecialistDetail({
    this.orgId,
    this.tranNo,
    this.slNo,
    this.specialistId,
    this.specialistName,
    this.isSelected,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.ratingValue,
    this.fileName,
    this.filePath,
  });

  SpecialistDetail.fromJson(dynamic json) {
    orgId = json['OrgId'];
    tranNo = json['TranNo'];
    slNo = json['SlNo'];
    specialistId = json['SpecialistId'];
    specialistName = json['SpecialistName'];
    isSelected = json['IsSelected'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    ratingValue = json['RatingValue'];
    fileName = json['FileName'];
    filePath = json['FilePath'];
  }
  int? orgId;
  String? tranNo;
  int? slNo;
  String? specialistId;
  String? specialistName;
  bool? isSelected;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  double? ratingValue;
  dynamic fileName;
  String? filePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TranNo'] = tranNo;
    map['SlNo'] = slNo;
    map['SpecialistId'] = specialistId;
    map['SpecialistName'] = specialistName;
    map['IsSelected'] = isSelected;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['RatingValue'] = ratingValue;
    map['FileName'] = fileName;
    map['FilePath'] = filePath;
    return map;
  }
}

class BusinessDetail {
  BusinessDetail({
    this.orgId,
    this.tranNo,
    this.slNo,
    this.businessId,
    this.businessName,
    this.isSelected,
    this.createdBy,
    this.createdOn,
    this.changedBy,
    this.changedOn,
    this.ratingValue,
    this.fileName,
    this.filePath,
  });

  BusinessDetail.fromJson(dynamic json) {
    orgId = json['OrgId'];
    tranNo = json['TranNo'];
    slNo = json['SlNo'];
    businessId = json['BusinessId'];
    businessName = json['BusinessName'];
    isSelected = json['IsSelected'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    changedBy = json['ChangedBy'];
    changedOn = json['ChangedOn'];
    ratingValue = json['RatingValue'];
    fileName = json['FileName'];
    filePath = json['FilePath'];
  }
  int? orgId;
  String? tranNo;
  int? slNo;
  String? businessId;
  String? businessName;
  bool? isSelected;
  String? createdBy;
  String? createdOn;
  String? changedBy;
  String? changedOn;
  double? ratingValue;
  dynamic fileName;
  String? filePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['TranNo'] = tranNo;
    map['SlNo'] = slNo;
    map['BusinessId'] = businessId;
    map['BusinessName'] = businessName;
    map['IsSelected'] = isSelected;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ChangedBy'] = changedBy;
    map['ChangedOn'] = changedOn;
    map['RatingValue'] = ratingValue;
    map['FileName'] = fileName;
    map['FilePath'] = filePath;
    return map;
  }
}
