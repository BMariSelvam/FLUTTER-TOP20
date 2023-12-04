class CreateServiceModel {
  int? orgId;
  String? servicename;
  String? serviceId;
  String? businessServiceId;
  String? businessServiceName;
  String? businessCategoryId;
  String? businessId;
  String? specialistId;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  int? durationMinutes;
  int? tokens;
  String? fromtime;
  String? toTime;
  String? fileName;
  String? filePath;
  String? service_Img_Base64String;
  String? emailId;
  String? userType;
  bool isSelected = true;

  CreateServiceModel(
      {this.orgId,
        this.businessServiceId,
        this.servicename,
        this.serviceId,
        this.businessServiceName,
        this.businessCategoryId,
        this.businessId,
        this.specialistId,
        this.isActive,
        this.createdBy,
        this.createdOn,
        this.durationMinutes,
        this.tokens,
        this.fromtime,
        required this.isSelected,
        this.toTime,
        this.emailId,
        this.userType,
        this.filePath,
        this.fileName,
        this.service_Img_Base64String});

  CreateServiceModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    businessServiceId = json['BusinessServiceId'];
    businessServiceName = json['BusinessServiceName'];
    serviceId = json['ServiceId'];
    servicename = json['ServiceName'];
    businessCategoryId = json['BusinessCategoryId'];
    businessId = json['BusinessId'];
    specialistId = json['SpecialistId'];
    durationMinutes = json['Duration_Minutes'];
    tokens = json['Tokens'];
    fromtime = json['Fromtime'];
    toTime = json['ToTime'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    fileName = json['FileName'];
    filePath = json['FilePath'];
    service_Img_Base64String = json['Service_Img_Base64String'];
    emailId = json['EmailId'];
    userType = json['UserType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
      data['ServiceId'] = this.businessServiceId;
      data['ServiceName'] = this.businessServiceName;
    data['BusinessServiceId'] = this.businessServiceId;
    data['SpecialistId'] = this.specialistId;
    data['BusinessId'] = this.businessId;
    data['BusinessCategoryId'] = this.businessCategoryId;
    data['BusinessServiceName'] = this.businessServiceName;
    data['Duration_Minutes'] = this.durationMinutes;
    data['IsActive'] = this.isActive;
    data['Tokens'] = this.tokens;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    data['FileName'] = this.fileName;
    data['FilePath'] = this.filePath;
    data['Service_Img_Base64String'] = this.service_Img_Base64String;
    data['EmailId'] = this.emailId;
    data['UserType'] = this.userType;
    return data;
  }

  @override
  String toString() {
    return "$businessServiceName";
  }
}
