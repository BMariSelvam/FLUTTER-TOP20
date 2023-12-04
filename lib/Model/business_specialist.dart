/// OrgId : 1
/// BusinessId : "TOPFCDC0"
/// SpecialistId : "TPSPL75D6E"
/// SpecilistName : "Ganesh Specialist 2"
/// DisplayName : "ganesh"
/// FileName : "LOGO.jpg"
/// FilePath : "C://AppXperts//CLIENTMEDIA//TOP10//SPECIALIST//80b89997-875c-4b22-94f9-15f6aaf5fddc_LOGO.jpg"
/// RatingValue : 10.00
/// IsActive : true
/// CreatedBy : "admin"
/// CreatedOn : "2023-04-01T02:53:22.137"

class BusinessSpecialist {
  BusinessSpecialist({
      num? orgId, 
      String? businessId, 
      String? specialistId, 
      String? specilistName, 
      String? displayName, 
      String? fileName, 
      String? filePath, 
      num? ratingValue, 
      bool? isActive, 
      String? createdBy, 
      String? createdOn,}){
    _orgId = orgId;
    _businessId = businessId;
    _specialistId = specialistId;
    _specilistName = specilistName;
    _displayName = displayName;
    _fileName = fileName;
    _filePath = filePath;
    _ratingValue = ratingValue;
    _isActive = isActive;
    _createdBy = createdBy;
    _createdOn = createdOn;
}

  BusinessSpecialist.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _businessId = json['BusinessId'];
    _specialistId = json['SpecialistId'];
    _specilistName = json['SpecilistName'];
    _displayName = json['DisplayName'];
    _fileName = json['FileName'];
    _filePath = json['FilePath'];
    _ratingValue = json['RatingValue'];
    _isActive = json['IsActive'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
  }
  num? _orgId;
  String? _businessId;
  String? _specialistId;
  String? _specilistName;
  String? _displayName;
  String? _fileName;
  String? _filePath;
  num? _ratingValue;
  bool? _isActive;
  String? _createdBy;
  String? _createdOn;
BusinessSpecialist copyWith({  num? orgId,
  String? businessId,
  String? specialistId,
  String? specilistName,
  String? displayName,
  String? fileName,
  String? filePath,
  num? ratingValue,
  bool? isActive,
  String? createdBy,
  String? createdOn,
}) => BusinessSpecialist(  orgId: orgId ?? _orgId,
  businessId: businessId ?? _businessId,
  specialistId: specialistId ?? _specialistId,
  specilistName: specilistName ?? _specilistName,
  displayName: displayName ?? _displayName,
  fileName: fileName ?? _fileName,
  filePath: filePath ?? _filePath,
  ratingValue: ratingValue ?? _ratingValue,
  isActive: isActive ?? _isActive,
  createdBy: createdBy ?? _createdBy,
  createdOn: createdOn ?? _createdOn,
);
  num? get orgId => _orgId;
  String? get businessId => _businessId;
  String? get specialistId => _specialistId;
  String? get specilistName => _specilistName;
  String? get displayName => _displayName;
  String? get fileName => _fileName;
  String? get filePath => _filePath;
  num? get ratingValue => _ratingValue;
  bool? get isActive => _isActive;
  String? get createdBy => _createdBy;
  String? get createdOn => _createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['BusinessId'] = _businessId;
    map['SpecialistId'] = _specialistId;
    map['SpecilistName'] = _specilistName;
    map['DisplayName'] = _displayName;
    map['FileName'] = _fileName;
    map['FilePath'] = _filePath;
    map['RatingValue'] = _ratingValue;
    map['IsActive'] = _isActive;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    return map;
  }

}