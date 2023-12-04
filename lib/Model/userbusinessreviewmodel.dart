class UserBusinessReviewModel {
  UserBusinessReviewModel({
    this.orgId,
    this.reviewId,
    this.reviewDate,
    this.memberId,
    this.memberName,
    this.displayName,
    this.businessId,
    this.specialistId,
    this.createdBy,
    this.createdOn,
    this.reviewDescription,
    this.ratingValue,
    this.isReviewValidated,
    this.fileName,
    this.filePath,
  });

  UserBusinessReviewModel.fromJson(dynamic json) {
    orgId = json['OrgId'];
    reviewId = json['ReviewId'];
    reviewDate = json['ReviewDate'];
    memberId = json['MemberId'];
    memberName = json['MemberName'];
    displayName = json['DisplayName'];
    businessId = json['BusinessId'];
    specialistId = json['SpecialistId'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    reviewDescription = json['ReviewDescription'];
    ratingValue = json['RatingValue'];
    isReviewValidated = json['IsReviewValidated'];
    fileName = json['FileName'];
    filePath = json['FilePath'];
  }
  int? orgId;
  String? reviewId;
  String? reviewDate;
  String? memberId;
  String? memberName;
  String? displayName;
  String? businessId;
  String? specialistId;
  String? createdBy;
  String? createdOn;
  String? reviewDescription;
  double? ratingValue;
  bool? isReviewValidated;
  String? fileName;
  String? filePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = orgId;
    map['ReviewId'] = reviewId;
    map['ReviewDate'] = reviewDate;
    map['MemberId'] = memberId;
    map['MemberName'] = memberName;
    map['DisplayName'] = displayName;
    map['BusinessId'] = businessId;
    map['SpecialistId'] = specialistId;
    map['CreatedBy'] = createdBy;
    map['CreatedOn'] = createdOn;
    map['ReviewDescription'] = reviewDescription;
    map['RatingValue'] = ratingValue;
    map['IsReviewValidated'] = isReviewValidated;
    map['FileName'] = fileName;
    map['FilePath'] = filePath;
    return map;
  }
}
