class MySpecilaistModel {
  MySpecilaistModel({
      this.orgId, 
      this.businessId, 
      this.specialistId, 
      this.specilistName, 
      this.displayName, 
      this.fileName, 
      this.filePath, 
      this.ratingValue, 
      this.isActive, 
      this.createdBy, 
      this.createdOn,});

  MySpecilaistModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    businessId = json['BusinessId'];
    specialistId = json['SpecialistId'];
    specilistName = json['SpecilistName'];
    displayName = json['DisplayName'];
    fileName = json['FileName'];
    filePath = json['FilePath'];
    ratingValue = json['RatingValue'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
  }
  int? orgId;
  String? businessId;
  String? specialistId;
  String? specilistName;
  String? displayName;
  dynamic fileName;
  String? filePath;
  double? ratingValue;
  bool? isActive;
  String? createdBy;
  String? createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['BusinessId'] = businessId;
    map['SpecialistId'] = specialistId;
    map['SpecilistName'] = specilistName;
    map['DisplayName'] = displayName;
    map['FileName'] = fileName;
    map['FilePath'] = filePath;
    map['RatingValue'] = ratingValue;
    map['IsActive'] = isActive;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    return map;
  }

}