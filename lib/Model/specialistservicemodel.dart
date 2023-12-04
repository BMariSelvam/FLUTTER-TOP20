class SpecialistServicesModel {
  int? orgId;
  int? slNo;
  String? serviceId;
  String? specialistId;
  String? businessId;
  String? businessServiceId;
  String? businessServiceName;
  String? serviceName;
  String? businessCategoryId;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  int? durationMinutes;
  int? tokens;
  double? ratings;
  String? filename;
  String? filepath;

  bool? isSelected = false;

  SpecialistServicesModel(
      {this.orgId,
        this.slNo,
        this.serviceId,
        this.specialistId,
        this.businessId,
        this.businessServiceId,
        this.businessServiceName,
        this.serviceName,
        this.ratings,
        this.filename,
        this.filepath,
        this.businessCategoryId,
        this.isActive,
        this.createdBy,
        this.createdOn,
        this.durationMinutes,
        this.tokens});

  SpecialistServicesModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    slNo = json['SlNo'];
    serviceId = json['ServiceId'];
    specialistId = json['SpecialistId'];
    businessId = json['BusinessId'];
    businessServiceId = json['BusinessServiceId'];
    businessServiceName = json['BusinessServiceName'];
    filename = json['FileName'];
    filepath = json['FilePath'];
    serviceName = json['ServiceName'];
    businessCategoryId = json['BusinessCategoryId'];
    durationMinutes = json['Duration_Minutes'];
    ratings = json['RatingValue'];
    tokens = json['Tokens'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['SlNo'] = this.slNo;
    data['ServiceId'] = this.serviceId;
    data['ServiceName'] = this.serviceName;
    data['SpecialistId'] = this.specialistId;
    data['BusinessId'] = this.businessId;
    data['BusinessServiceId'] = this.businessServiceId;
    data['BusinessServiceName'] = this.businessServiceName;
    data['Duration_Minutes'] = this.durationMinutes;
    data['Coins'] = this.tokens;
    data['RatingValue'] = this.ratings;
    data['FilePath'] = this.filepath;
    data['FileName'] = this.filename;
    data['IsActive'] = this.isActive;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    return data;
  }
}
