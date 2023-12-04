class BusinessCategoryModel {
  int? orgId;
  String? businessCategoryId;
  String? businessCategoryName;
  bool? isActive;
  String? createdBy;
  String? createdOn;

  BusinessCategoryModel.fromJson(Map<String, dynamic> json) {
    orgId = json['OrgId'];
    businessCategoryId = json['BusinessCategoryId'];
    businessCategoryName = json['BusinessCategoryName'];
    isActive = json['IsActive'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$businessCategoryName";
  }
}
