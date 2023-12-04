class BusinessMySpecialistModel {
  int? orgId;
  String? specialistId;
  String? businessId;
  String? displayName;
  String? specilistName;
  String? FileName;
  String? filepath;
  bool? isActive;
  String? createdBy;
  String? createdOn;
  double? ratingValue;
  int? durationMinutes;

  bool? isPressed;

  BusinessMySpecialistModel(
      {this.orgId,
      this.businessId,
      this.isActive,
      this.createdOn,
      this.createdBy,
      this.filepath,
      this.specialistId,
      this.displayName,
      this.specilistName,
      this.ratingValue,
      this.FileName,
      this.durationMinutes});

  BusinessMySpecialistModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    specialistId = json['SpecialistId'];
    specilistName = json['SpecilistName'];
    displayName = json['DisplayName'];
    ratingValue = json['RatingValue'];
    FileName = json['FileName'];
    filepath = json['FilePath'];
    createdOn = json['CreatedOn'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    businessId = json['BusinessId'];
    durationMinutes=json['Duration_Minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['SpecialistId'] = this.specialistId;
    data['SpecilistName'] = this.specilistName;
    data['DisplayName'] = this.displayName;
    data['RatingValue'] = this.ratingValue;
    data['BusinessId'] = this.businessId;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    data['IsActive'] = this.isActive;
    data['FilePath'] = this.filepath;
    data['FileName'] = this.FileName;
    data['durationMinutes']=this.durationMinutes;
    return data;
  }
}
