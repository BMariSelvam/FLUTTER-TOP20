class BusinessAppointmentServicesModel {
  int? orgId;
  int? slNo;
  String? businessId;
  String? specialistId;
  String? businessServiceId;
  String? businessServiceName;
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

  BusinessAppointmentServicesModel(
      {this.orgId,
      this.slNo,
      this.businessId,
      this.specialistId,
      this.businessServiceId,
      this.businessServiceName,
      this.ratings,
      this.filename,
      this.filepath,
      this.businessCategoryId,
      this.isActive,
      this.createdBy,
      this.createdOn,
      this.durationMinutes,
      this.tokens});

  BusinessAppointmentServicesModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    slNo = json['SlNo'];
    specialistId = json['SpecialistId'];
    businessId = json['BusinessId'];
    businessServiceId = json['BusinessServiceId'];
    businessServiceName = json['BusinessServiceName'];
    filename = json['FileName'];
    filepath = json['FilePath'];
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
    data['SlNo'] = 1;
    data['ServiceId'] = this.businessServiceId;
    data['ServiceName'] = this.businessServiceName;
    data['BusinessId'] = this.businessId;
    data['SpecialistId'] = this.specialistId;
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
