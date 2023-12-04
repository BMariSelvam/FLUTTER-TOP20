import 'dart:convert';

/// OrgId : 1
/// BranchCode : "HO"
/// AdvId : "5A5D20616"
/// Title : "Test Adv"
/// Description : "Test ADvertisement"
/// ImageFileName : "Banner.png"
/// ImageFilePath : "http://154.26.130.251:478//CLIENTMEDIA//TOP10//ADVERTISMENTIMAGES//978fab7e-b0e8-4229-9bca-783eab74d1a8_Banner.png"
/// AdvURLLink : null
/// DisplayOrder : 0
/// StartDate : "2023-05-24T00:00:00"
/// Enddate : "2023-05-27T00:00:00"
/// IsActive : true
/// CreatedBy : "admin"
/// CreatedOn : "2023-05-24T20:55:52.723"
/// ChangedBy : "admin"
/// ChangedOn : "2023-05-25T14:32:03.323"
/// ImageBase64Str : null

AdvertisementModel advertisementModelFromJson(String str) =>
    AdvertisementModel.fromJson(json.decode(str));
String advertisementModelToJson(AdvertisementModel data) =>
    json.encode(data.toJson());

class AdvertisementModel {
  AdvertisementModel({
    num? orgId,
    String? branchCode,
    String? advId,
    String? title,
    String? description,
    String? imageFileName,
    String? imageFilePath,
    dynamic advURLLink,
    num? displayOrder,
    String? startDate,
    String? enddate,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    dynamic imageBase64Str,
  }) {
    _orgId = orgId;
    _branchCode = branchCode;
    _advId = advId;
    _title = title;
    _description = description;
    _imageFileName = imageFileName;
    _imageFilePath = imageFilePath;
    _advURLLink = advURLLink;
    _displayOrder = displayOrder;
    _startDate = startDate;
    _enddate = enddate;
    _isActive = isActive;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _changedBy = changedBy;
    _changedOn = changedOn;
    _imageBase64Str = imageBase64Str;
  }

  AdvertisementModel.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _branchCode = json['BranchCode'];
    _advId = json['AdvId'];
    _title = json['Title'];
    _description = json['Description'];
    _imageFileName = json['ImageFileName'];
    _imageFilePath = json['ImageFilePath'];
    _advURLLink = json['AdvURLLink'];
    _displayOrder = json['DisplayOrder'];
    _startDate = json['StartDate'];
    _enddate = json['Enddate'];
    _isActive = json['IsActive'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
    _imageBase64Str = json['ImageBase64Str'];
  }
  num? _orgId;
  String? _branchCode;
  String? _advId;
  String? _title;
  String? _description;
  String? _imageFileName;
  String? _imageFilePath;
  dynamic _advURLLink;
  num? _displayOrder;
  String? _startDate;
  String? _enddate;
  bool? _isActive;
  String? _createdBy;
  String? _createdOn;
  String? _changedBy;
  String? _changedOn;
  dynamic _imageBase64Str;
  AdvertisementModel copyWith({
    num? orgId,
    String? branchCode,
    String? advId,
    String? title,
    String? description,
    String? imageFileName,
    String? imageFilePath,
    dynamic advURLLink,
    num? displayOrder,
    String? startDate,
    String? enddate,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    dynamic imageBase64Str,
  }) =>
      AdvertisementModel(
        orgId: orgId ?? _orgId,
        branchCode: branchCode ?? _branchCode,
        advId: advId ?? _advId,
        title: title ?? _title,
        description: description ?? _description,
        imageFileName: imageFileName ?? _imageFileName,
        imageFilePath: imageFilePath ?? _imageFilePath,
        advURLLink: advURLLink ?? _advURLLink,
        displayOrder: displayOrder ?? _displayOrder,
        startDate: startDate ?? _startDate,
        enddate: enddate ?? _enddate,
        isActive: isActive ?? _isActive,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
        imageBase64Str: imageBase64Str ?? _imageBase64Str,
      );
  num? get orgId => _orgId;
  String? get branchCode => _branchCode;
  String? get advId => _advId;
  String? get title => _title;
  String? get description => _description;
  String? get imageFileName => _imageFileName;
  String? get imageFilePath => _imageFilePath;
  dynamic get advURLLink => _advURLLink;
  num? get displayOrder => _displayOrder;
  String? get startDate => _startDate;
  String? get enddate => _enddate;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  String? get changedBy => _changedBy;
  String? get changedOn => _changedOn;
  dynamic get imageBase64Str => _imageBase64Str;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['BranchCode'] = _branchCode;
    map['AdvId'] = _advId;
    map['Title'] = _title;
    map['Description'] = _description;
    map['ImageFileName'] = _imageFileName;
    map['ImageFilePath'] = _imageFilePath;
    map['AdvURLLink'] = _advURLLink;
    map['DisplayOrder'] = _displayOrder;
    map['StartDate'] = _startDate;
    map['Enddate'] = _enddate;
    map['IsActive'] = _isActive;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    map['ImageBase64Str'] = _imageBase64Str;
    return map;
  }
}
