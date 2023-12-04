import 'dart:convert';

/// OrgId : 1
/// BranchCode : "HO"
/// BannerId : "98C117167"
/// Title : "Banner2"
/// Description : "Banner2"
/// AdditionalDesc : "Banner2"
/// BannerImageFileName : "Logo_withouttext.png"
/// BannerImageFilePath : "http://154.26.130.251:478//CLIENTMEDIA//TOP10//BANNERIMAGES//44044934-4313-404d-82ab-d9e530d536cd_Logo_withouttext.png"
/// DisplayOrder : 0
/// IsActive : true
/// CreatedBy : "admin"
/// BannerImageBase64Str : null

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));
String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    num? orgId,
    String? branchCode,
    String? bannerId,
    String? title,
    String? description,
    String? additionalDesc,
    String? bannerImageFileName,
    String? bannerImageFilePath,
    num? displayOrder,
    bool? isActive,
    String? createdBy,
    dynamic bannerImageBase64Str,
  }) {
    _orgId = orgId;
    _branchCode = branchCode;
    _bannerId = bannerId;
    _title = title;
    _description = description;
    _additionalDesc = additionalDesc;
    _bannerImageFileName = bannerImageFileName;
    _bannerImageFilePath = bannerImageFilePath;
    _displayOrder = displayOrder;
    _isActive = isActive;
    _createdBy = createdBy;
    _bannerImageBase64Str = bannerImageBase64Str;
  }

  BannerModel.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _branchCode = json['BranchCode'];
    _bannerId = json['BannerId'];
    _title = json['Title'];
    _description = json['Description'];
    _additionalDesc = json['AdditionalDesc'];
    _bannerImageFileName = json['BannerImageFileName'];
    _bannerImageFilePath = json['BannerImageFilePath'];
    _displayOrder = json['DisplayOrder'];
    _isActive = json['IsActive'];
    _createdBy = json['CreatedBy'];
    _bannerImageBase64Str = json['BannerImageBase64Str'];
  }
  num? _orgId;
  String? _branchCode;
  String? _bannerId;
  String? _title;
  String? _description;
  String? _additionalDesc;
  String? _bannerImageFileName;
  String? _bannerImageFilePath;
  num? _displayOrder;
  bool? _isActive;
  String? _createdBy;
  dynamic _bannerImageBase64Str;
  BannerModel copyWith({
    num? orgId,
    String? branchCode,
    String? bannerId,
    String? title,
    String? description,
    String? additionalDesc,
    String? bannerImageFileName,
    String? bannerImageFilePath,
    num? displayOrder,
    bool? isActive,
    String? createdBy,
    dynamic bannerImageBase64Str,
  }) =>
      BannerModel(
        orgId: orgId ?? _orgId,
        branchCode: branchCode ?? _branchCode,
        bannerId: bannerId ?? _bannerId,
        title: title ?? _title,
        description: description ?? _description,
        additionalDesc: additionalDesc ?? _additionalDesc,
        bannerImageFileName: bannerImageFileName ?? _bannerImageFileName,
        bannerImageFilePath: bannerImageFilePath ?? _bannerImageFilePath,
        displayOrder: displayOrder ?? _displayOrder,
        isActive: isActive ?? _isActive,
        createdBy: createdBy ?? _createdBy,
        bannerImageBase64Str: bannerImageBase64Str ?? _bannerImageBase64Str,
      );
  num? get orgId => _orgId;
  String? get branchCode => _branchCode;
  String? get bannerId => _bannerId;
  String? get title => _title;
  String? get description => _description;
  String? get additionalDesc => _additionalDesc;
  String? get bannerImageFileName => _bannerImageFileName;
  String? get bannerImageFilePath => _bannerImageFilePath;
  num? get displayOrder => _displayOrder;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  dynamic get bannerImageBase64Str => _bannerImageBase64Str;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['BranchCode'] = _branchCode;
    map['BannerId'] = _bannerId;
    map['Title'] = _title;
    map['Description'] = _description;
    map['AdditionalDesc'] = _additionalDesc;
    map['BannerImageFileName'] = _bannerImageFileName;
    map['BannerImageFilePath'] = _bannerImageFilePath;
    map['DisplayOrder'] = _displayOrder;
    map['IsActive'] = _isActive;
    map['CreatedBy'] = _createdBy;
    map['BannerImageBase64Str'] = _bannerImageBase64Str;
    return map;
  }
}
