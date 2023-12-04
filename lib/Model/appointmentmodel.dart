/// OrgId : 1
/// AppoinmentNo : "APP04AB8"
/// AppoinmentDate : "2023-04-07T00:00:00"
/// MemberId : "TPMEM13784"
/// BusinessId : "TOP06E7A"
/// SpecialistId : "0"
/// AppoinmentFromTime : "15:38:00"
/// AppoinmentToTime : "15:38:00"
/// TotailCoinsPaid : 100
/// PaymentStatus : 1
/// Status : 6
/// IsRescheduled : true
/// CategoryId : null
/// ServicePlace : 0
/// ReviewDescription : null
/// RatingValue : null
/// IsReviewReceived : false
/// CreatedBy : "Admin"
/// CreatedOn : "2023-04-07T18:09:10.85"
/// ChangedBy : "Admin"
/// ChangedOn : "2023-04-07T18:09:10.85"
/// AppoinmentDetail : null
/// BusinessData : [{"OrgId":1,"BusinessId":"TOP06E7A","BusinessName":"Business 1","DisplayName":"Business 1","EmailId":"mariganesh@mailinator.com","MobileNo":"9956874555","CountryDialCode":"+91","BusinessCategory":"6CBC41453","BusinessRegNo":"3698521","RatingValue":5.0,"TranPin":"123","AppPin":"123","AddressLine1":"string1231324","AddressLine2":"string22313","AddressLine3":"string32132","City":"string3","Country":"UAE","PostalCode":"900","AllowOnlineApp":true,"CustomerPlace":true,"BusinessPlace":true,"AllowIndividualTip":true,"OpenTime":"09:00:00.0000000","CloseTiime":"18:00:00.0000000","Latitude":1235.985,"Longitude":78965.63,"LogoFileName":"LOGO.jpg","Logo_Img_Base64String":"","LogoFilePath":"http://154.26.130.251:478//CLIENTMEDIA//TOP10//BUSINESS//96e520a3-7348-49ae-b61a-7bb6f83923bc_LOGO.jpg","ServicesList":null,"IsActive":true,"CreatedBy":"Admin","CreatedOn":"2023-03-30T01:21:53.417","IsApproved":false,"ApprovedBy":null,"ApprovedDate":null,"BusinessStatus":true}]
/// SpecialistData : [{"OrgId":1,"SpecialistId":"TPSPLF8A93","SpecilistName":"Ganesh Specialist 3","DisplayName":"ganesh","DialCode":"+91","MobileNo":"987456321","EmailId":"mariganesh3@mailinator.com","AppPIN":"321","TranPIN":"123","AddressLine1":"spa","AddressLine2":"new spa road","AddressLine3":"adyar","City":"chennai","Country":"India","PostalCode":"600100","AllowOnlineApp":true,"FileName":"LOGO.jpg","FilePath":"C://AppXperts//CLIENTMEDIA//TOP10//SPECIALIST//33a91b9d-66a8-418a-92ee-f583cedccbd0_LOGO.jpg","RatingValue":10.00,"HaveFreelance":true,"ServiceatCustomerPlace":true,"ServiceatSpecialistPlace":true,"Latitude":12.917141,"Longitude":12.917141,"BusinessCategoryId":"BCAT1001","IsActive":true,"CreatedBy":"Admin","CreatedOn":"2023-03-30T01:24:32.207"}]
/// MemberData : [{"OrgId":1,"MemberId":"TPMEM13784","MemberName":"Roshani Sitlani","DisplayName":"Roshani Sitlani","DialCode":"+1684","MobileNo":"09954411421","EmailId":"roshani@gmail.com","AppPIN":"654","TranPIN":"654","AddressLine1":"thambaram","AddressLine2":"medavakam","AddressLine3":"chennai","City":"Akola","Country":"123","PostalCode":"600100","FileName":"scaled_bfe2cf48-b169-4588-9200-15b7f6eb60ed2681621322037744024.jpg","FilePath":"C://AppXperts//CLIENTMEDIA//TOP10//INDIVITUAL//5e4b55c0-bc90-4110-9605-3471dbd3f028_scaled_bfe2cf48-b169-4588-9200-15b7f6eb60ed2681621322037744024.jpg","RatingValue":0.0,"IsActive":true,"CreatedBy":"Admin","CreatedOn":"2023-02-08T15:56:14.95","ChangedBy":"Admin","ChangedOn":"2023-04-10T05:28:55.1"}]

class Appointment {
  Appointment({
    num? orgId,
    String? appoinmentNo,
    String? appoinmentDate,
    String? memberId,
    String? businessId,
    String? specialistId,
    String? appoinmentFromTime,
    String? appoinmentToTime,
    num? totailCoinsPaid,
    num? paymentStatus,
    num? status,
    bool? isRescheduled,
    dynamic categoryId,
    num? servicePlace,
    dynamic reviewDescription,
    dynamic ratingValue,
    bool? isReviewReceived,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    List<AppointmentServiceListModel>? appoinmentDetail,
    List<BusinessData>? businessData,
    List<SpecialistData>? specialistData,
    List<MemberData>? memberData,
  }) {
    _orgId = orgId;
    _appoinmentNo = appoinmentNo;
    _appoinmentDate = appoinmentDate;
    _memberId = memberId;
    _businessId = businessId;
    _specialistId = specialistId;
    _appoinmentFromTime = appoinmentFromTime;
    _appoinmentToTime = appoinmentToTime;
    _totailCoinsPaid = totailCoinsPaid;
    _paymentStatus = paymentStatus;
    _status = status;
    _isRescheduled = isRescheduled;
    _categoryId = categoryId;
    _servicePlace = servicePlace;
    _reviewDescription = reviewDescription;
    ratingValue = ratingValue;
    _isReviewReceived = isReviewReceived;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _changedBy = changedBy;
    _changedOn = changedOn;
    _appoinmentDetail = appoinmentDetail;
    _businessData = businessData;
    _specialistData = specialistData;
    _memberData = memberData;
  }

  Appointment.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _appoinmentNo = json['AppoinmentNo'];
    _appoinmentDate = json['AppoinmentDate'];
    _memberId = json['MemberId'];
    _businessId = json['BusinessId'];
    _specialistId = json['SpecialistId'];
    _appoinmentFromTime = json['AppoinmentFromTime'];
    _appoinmentToTime = json['AppoinmentToTime'];
    _totailCoinsPaid = json['TotailCoinsPaid'];
    _paymentStatus = json['PaymentStatus'];
    _status = json['Status'];
    _isRescheduled = json['IsRescheduled'];
    _categoryId = json['CategoryId'];
    _servicePlace = json['ServicePlace'];
    _reviewDescription = json['ReviewDescription'];
    ratingValue = json['RatingValue'];
    _isReviewReceived = json['IsReviewReceived'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
    // _appoinmentDetail = json['AppoinmentDetail'];
    if (json['AppoinmentDetail'] != null) {
      _appoinmentDetail = [];
      json['AppoinmentDetail'].forEach((v) {
        _appoinmentDetail?.add(AppointmentServiceListModel.fromJson(v));
      });
    }
    if (json['BusinessData'] != null) {
      _businessData = [];
      json['BusinessData'].forEach((v) {
        _businessData?.add(BusinessData.fromJson(v));
      });
    }
    if (json['SpecialistData'] != null) {
      _specialistData = [];
      json['SpecialistData'].forEach((v) {
        _specialistData?.add(SpecialistData.fromJson(v));
      });
    }
    if (json['MemberData'] != null) {
      _memberData = [];
      json['MemberData'].forEach((v) {
        _memberData?.add(MemberData.fromJson(v));
      });
    }
  }

  num? _orgId;
  String? _appoinmentNo;
  String? _appoinmentDate;
  String? _memberId;
  String? _businessId;
  String? _specialistId;
  String? _appoinmentFromTime;
  String? _appoinmentToTime;
  num? _totailCoinsPaid;
  num? _paymentStatus;
  num? _status;
  bool? _isRescheduled;
  dynamic _categoryId;
  num? _servicePlace;
  dynamic _reviewDescription;
  dynamic ratingValue;
  bool? _isReviewReceived;
  String? _createdBy;
  String? _createdOn;
  String? _changedBy;
  String? _changedOn;
  List<AppointmentServiceListModel>? _appoinmentDetail;
  List<BusinessData>? _businessData;
  List<SpecialistData>? _specialistData;
  List<MemberData>? _memberData;

  Appointment copyWith({
    num? orgId,
    String? appoinmentNo,
    String? appoinmentDate,
    String? memberId,
    String? businessId,
    String? specialistId,
    String? appoinmentFromTime,
    String? appoinmentToTime,
    num? totailCoinsPaid,
    num? paymentStatus,
    num? status,
    bool? isRescheduled,
    dynamic categoryId,
    num? servicePlace,
    dynamic reviewDescription,
    dynamic ratingValue,
    bool? isReviewReceived,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
    List<AppointmentServiceListModel>? appoinmentDetail,
    List<BusinessData>? businessData,
    List<SpecialistData>? specialistData,
    List<MemberData>? memberData,
  }) =>
      Appointment(
        orgId: orgId ?? _orgId,
        appoinmentNo: appoinmentNo ?? _appoinmentNo,
        appoinmentDate: appoinmentDate ?? _appoinmentDate,
        memberId: memberId ?? _memberId,
        businessId: businessId ?? _businessId,
        specialistId: specialistId ?? _specialistId,
        appoinmentFromTime: appoinmentFromTime ?? _appoinmentFromTime,
        appoinmentToTime: appoinmentToTime ?? _appoinmentToTime,
        totailCoinsPaid: totailCoinsPaid ?? _totailCoinsPaid,
        paymentStatus: paymentStatus ?? _paymentStatus,
        status: status ?? _status,
        isRescheduled: isRescheduled ?? _isRescheduled,
        categoryId: categoryId ?? _categoryId,
        servicePlace: servicePlace ?? _servicePlace,
        reviewDescription: reviewDescription ?? _reviewDescription,
        ratingValue: ratingValue ?? ratingValue,
        isReviewReceived: isReviewReceived ?? _isReviewReceived,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
        appoinmentDetail: appoinmentDetail ?? _appoinmentDetail,
        businessData: businessData ?? _businessData,
        specialistData: specialistData ?? _specialistData,
        memberData: memberData ?? _memberData,
      );

  num? get orgId => _orgId;

  String? get appoinmentNo => _appoinmentNo;

  String? get appoinmentDate => _appoinmentDate;

  String? get memberId => _memberId;

  String? get businessId => _businessId;

  String? get specialistId => _specialistId;

  String? get appoinmentFromTime => _appoinmentFromTime;

  String? get appoinmentToTime => _appoinmentToTime;

  num? get totailCoinsPaid => _totailCoinsPaid;

  num? get paymentStatus => _paymentStatus;

  num? get status => _status;

  bool? get isRescheduled => _isRescheduled;

  dynamic get categoryId => _categoryId;

  num? get servicePlace => _servicePlace;

  dynamic get reviewDescription => _reviewDescription;

  // dynamic get ratingValue => ratingValue;
  bool? get isReviewReceived => _isReviewReceived;

  String? get createdBy => _createdBy;

  String? get createdOn => _createdOn;

  String? get changedBy => _changedBy;

  String? get changedOn => _changedOn;

  List<AppointmentServiceListModel>? get appoinmentDetail => _appoinmentDetail;

  List<BusinessData>? get businessData => _businessData;

  List<SpecialistData>? get specialistData => _specialistData;

  List<MemberData>? get memberData => _memberData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['AppoinmentNo'] = _appoinmentNo;
    map['AppoinmentDate'] = _appoinmentDate;
    map['MemberId'] = _memberId;
    map['BusinessId'] = _businessId;
    map['SpecialistId'] = _specialistId;
    map['AppoinmentFromTime'] = _appoinmentFromTime;
    map['AppoinmentToTime'] = _appoinmentToTime;
    map['TotailCoinsPaid'] = _totailCoinsPaid;
    map['PaymentStatus'] = _paymentStatus;
    map['Status'] = _status;
    map['IsRescheduled'] = _isRescheduled;
    map['CategoryId'] = _categoryId;
    map['ServicePlace'] = _servicePlace;
    map['ReviewDescription'] = _reviewDescription;
    map['RatingValue'] = ratingValue;
    map['IsReviewReceived'] = _isReviewReceived;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    map['AppoinmentDetail'] = _appoinmentDetail;
    if (_businessData != null) {
      map['BusinessData'] = _businessData?.map((v) => v.toJson()).toList();
    }
    if (_specialistData != null) {
      map['SpecialistData'] = _specialistData?.map((v) => v.toJson()).toList();
    }
    if (_memberData != null) {
      map['MemberData'] = _memberData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// OrgId : 1
/// MemberId : "TPMEM13784"
/// MemberName : "Roshani Sitlani"
/// DisplayName : "Roshani Sitlani"
/// DialCode : "+1684"
/// MobileNo : "09954411421"
/// EmailId : "roshani@gmail.com"
/// AppPIN : "654"
/// TranPIN : "654"
/// AddressLine1 : "thambaram"
/// AddressLine2 : "medavakam"
/// AddressLine3 : "chennai"
/// City : "Akola"
/// Country : "123"
/// PostalCode : "600100"
/// FileName : "scaled_bfe2cf48-b169-4588-9200-15b7f6eb60ed2681621322037744024.jpg"
/// FilePath : "C://AppXperts//CLIENTMEDIA//TOP10//INDIVITUAL//5e4b55c0-bc90-4110-9605-3471dbd3f028_scaled_bfe2cf48-b169-4588-9200-15b7f6eb60ed2681621322037744024.jpg"
/// RatingValue : 0.0
/// IsActive : true
/// CreatedBy : "Admin"
/// CreatedOn : "2023-02-08T15:56:14.95"
/// ChangedBy : "Admin"
/// ChangedOn : "2023-04-10T05:28:55.1"

class MemberData {
  MemberData({
    num? orgId,
    String? memberId,
    String? memberName,
    String? displayName,
    String? dialCode,
    String? mobileNo,
    String? emailId,
    String? appPIN,
    String? tranPIN,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? city,
    String? country,
    String? postalCode,
    String? fileName,
    String? filePath,
    double? ratingValue,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
  }) {
    _orgId = orgId;
    _memberId = memberId;
    _memberName = memberName;
    _displayName = displayName;
    _dialCode = dialCode;
    _mobileNo = mobileNo;
    _emailId = emailId;
    _appPIN = appPIN;
    _tranPIN = tranPIN;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _addressLine3 = addressLine3;
    _city = city;
    _country = country;
    _postalCode = postalCode;
    _fileName = fileName;
    _filePath = filePath;
    _ratingValue = ratingValue;
    _isActive = isActive;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _changedBy = changedBy;
    _changedOn = changedOn;
  }

  MemberData.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _memberId = json['MemberId'];
    _memberName = json['MemberName'];
    _displayName = json['DisplayName'];
    _dialCode = json['DialCode'];
    _mobileNo = json['MobileNo'];
    _emailId = json['EmailId'];
    _appPIN = json['AppPIN'];
    _tranPIN = json['TranPIN'];
    _addressLine1 = json['AddressLine1'];
    _addressLine2 = json['AddressLine2'];
    _addressLine3 = json['AddressLine3'];
    _city = json['City'];
    _country = json['Country'];
    _postalCode = json['PostalCode'];
    _fileName = json['FileName'];
    _filePath = json['FilePath'];
    _ratingValue = json['RatingValue'];
    _isActive = json['IsActive'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _changedBy = json['ChangedBy'];
    _changedOn = json['ChangedOn'];
  }

  num? _orgId;
  String? _memberId;
  String? _memberName;
  String? _displayName;
  String? _dialCode;
  String? _mobileNo;
  String? _emailId;
  String? _appPIN;
  String? _tranPIN;
  String? _addressLine1;
  String? _addressLine2;
  String? _addressLine3;
  String? _city;
  String? _country;
  String? _postalCode;
  String? _fileName;
  String? _filePath;
  double? _ratingValue;
  bool? _isActive;
  String? _createdBy;
  String? _createdOn;
  String? _changedBy;
  String? _changedOn;

  MemberData copyWith({
    num? orgId,
    String? memberId,
    String? memberName,
    String? displayName,
    String? dialCode,
    String? mobileNo,
    String? emailId,
    String? appPIN,
    String? tranPIN,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? city,
    String? country,
    String? postalCode,
    String? fileName,
    String? filePath,
    double? ratingValue,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    String? changedBy,
    String? changedOn,
  }) =>
      MemberData(
        orgId: orgId ?? _orgId,
        memberId: memberId ?? _memberId,
        memberName: memberName ?? _memberName,
        displayName: displayName ?? _displayName,
        dialCode: dialCode ?? _dialCode,
        mobileNo: mobileNo ?? _mobileNo,
        emailId: emailId ?? _emailId,
        appPIN: appPIN ?? _appPIN,
        tranPIN: tranPIN ?? _tranPIN,
        addressLine1: addressLine1 ?? _addressLine1,
        addressLine2: addressLine2 ?? _addressLine2,
        addressLine3: addressLine3 ?? _addressLine3,
        city: city ?? _city,
        country: country ?? _country,
        postalCode: postalCode ?? _postalCode,
        fileName: fileName ?? _fileName,
        filePath: filePath ?? _filePath,
        ratingValue: ratingValue ?? _ratingValue,
        isActive: isActive ?? _isActive,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        changedBy: changedBy ?? _changedBy,
        changedOn: changedOn ?? _changedOn,
      );

  num? get orgId => _orgId;

  String? get memberId => _memberId;

  String? get memberName => _memberName;

  String? get displayName => _displayName;

  String? get dialCode => _dialCode;

  String? get mobileNo => _mobileNo;

  String? get emailId => _emailId;

  String? get appPIN => _appPIN;

  String? get tranPIN => _tranPIN;

  String? get addressLine1 => _addressLine1;

  String? get addressLine2 => _addressLine2;

  String? get addressLine3 => _addressLine3;

  String? get city => _city;

  String? get country => _country;

  String? get postalCode => _postalCode;

  String? get fileName => _fileName;

  String? get filePath => _filePath;

  double? get ratingValue => _ratingValue;

  bool? get isActive => _isActive;

  String? get createdBy => _createdBy;

  String? get createdOn => _createdOn;

  String? get changedBy => _changedBy;

  String? get changedOn => _changedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['MemberId'] = _memberId;
    map['MemberName'] = _memberName;
    map['DisplayName'] = _displayName;
    map['DialCode'] = _dialCode;
    map['MobileNo'] = _mobileNo;
    map['EmailId'] = _emailId;
    map['AppPIN'] = _appPIN;
    map['TranPIN'] = _tranPIN;
    map['AddressLine1'] = _addressLine1;
    map['AddressLine2'] = _addressLine2;
    map['AddressLine3'] = _addressLine3;
    map['City'] = _city;
    map['Country'] = _country;
    map['PostalCode'] = _postalCode;
    map['FileName'] = _fileName;
    map['FilePath'] = _filePath;
    map['RatingValue'] = _ratingValue;
    map['IsActive'] = _isActive;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['ChangedBy'] = _changedBy;
    map['ChangedOn'] = _changedOn;
    return map;
  }
}

/// OrgId : 1
/// SpecialistId : "TPSPLF8A93"
/// SpecilistName : "Ganesh Specialist 3"
/// DisplayName : "ganesh"
/// DialCode : "+91"
/// MobileNo : "987456321"
/// EmailId : "mariganesh3@mailinator.com"
/// AppPIN : "321"
/// TranPIN : "123"
/// AddressLine1 : "spa"
/// AddressLine2 : "new spa road"
/// AddressLine3 : "adyar"
/// City : "chennai"
/// Country : "India"
/// PostalCode : "600100"
/// AllowOnlineApp : true
/// FileName : "LOGO.jpg"
/// FilePath : "C://AppXperts//CLIENTMEDIA//TOP10//SPECIALIST//33a91b9d-66a8-418a-92ee-f583cedccbd0_LOGO.jpg"
/// RatingValue : 10.00
/// HaveFreelance : true
/// ServiceatCustomerPlace : true
/// ServiceatSpecialistPlace : true
/// Latitude : 12.917141
/// Longitude : 12.917141
/// BusinessCategoryId : "BCAT1001"
/// IsActive : true
/// CreatedBy : "Admin"
/// CreatedOn : "2023-03-30T01:24:32.207"

class SpecialistData {
  SpecialistData({
    num? orgId,
    String? specialistId,
    String? specilistName,
    String? displayName,
    String? dialCode,
    String? mobileNo,
    String? emailId,
    String? appPIN,
    String? tranPIN,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? city,
    String? country,
    String? postalCode,
    bool? allowOnlineApp,
    String? fileName,
    String? filePath,
    num? ratingValue,
    bool? haveFreelance,
    bool? serviceatCustomerPlace,
    bool? serviceatSpecialistPlace,
    num? latitude,
    num? longitude,
    String? businessCategoryId,
    bool? isActive,
    String? createdBy,
    String? createdOn,
  }) {
    _orgId = orgId;
    _specialistId = specialistId;
    _specilistName = specilistName;
    _displayName = displayName;
    _dialCode = dialCode;
    _mobileNo = mobileNo;
    _emailId = emailId;
    _appPIN = appPIN;
    _tranPIN = tranPIN;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _addressLine3 = addressLine3;
    _city = city;
    _country = country;
    _postalCode = postalCode;
    _allowOnlineApp = allowOnlineApp;
    _fileName = fileName;
    _filePath = filePath;
    _ratingValue = ratingValue;
    _haveFreelance = haveFreelance;
    _serviceatCustomerPlace = serviceatCustomerPlace;
    _serviceatSpecialistPlace = serviceatSpecialistPlace;
    _latitude = latitude;
    _longitude = longitude;
    _businessCategoryId = businessCategoryId;
    _isActive = isActive;
    _createdBy = createdBy;
    _createdOn = createdOn;
  }

  SpecialistData.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _specialistId = json['SpecialistId'];
    _specilistName = json['SpecilistName'];
    _displayName = json['DisplayName'];
    _dialCode = json['DialCode'];
    _mobileNo = json['MobileNo'];
    _emailId = json['EmailId'];
    _appPIN = json['AppPIN'];
    _tranPIN = json['TranPIN'];
    _addressLine1 = json['AddressLine1'];
    _addressLine2 = json['AddressLine2'];
    _addressLine3 = json['AddressLine3'];
    _city = json['City'];
    _country = json['Country'];
    _postalCode = json['PostalCode'];
    _allowOnlineApp = json['AllowOnlineApp'];
    _fileName = json['FileName'];
    _filePath = json['FilePath'];
    _ratingValue = json['RatingValue'];
    _haveFreelance = json['HaveFreelance'];
    _serviceatCustomerPlace = json['ServiceatCustomerPlace'];
    _serviceatSpecialistPlace = json['ServiceatSpecialistPlace'];
    _latitude = json['Latitude'];
    _longitude = json['Longitude'];
    _businessCategoryId = json['BusinessCategoryId'];
    _isActive = json['IsActive'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
  }

  num? _orgId;
  String? _specialistId;
  String? _specilistName;
  String? _displayName;
  String? _dialCode;
  String? _mobileNo;
  String? _emailId;
  String? _appPIN;
  String? _tranPIN;
  String? _addressLine1;
  String? _addressLine2;
  String? _addressLine3;
  String? _city;
  String? _country;
  String? _postalCode;
  bool? _allowOnlineApp;
  String? _fileName;
  String? _filePath;
  num? _ratingValue;
  bool? _haveFreelance;
  bool? _serviceatCustomerPlace;
  bool? _serviceatSpecialistPlace;
  num? _latitude;
  num? _longitude;
  String? _businessCategoryId;
  bool? _isActive;
  String? _createdBy;
  String? _createdOn;

  SpecialistData copyWith({
    num? orgId,
    String? specialistId,
    String? specilistName,
    String? displayName,
    String? dialCode,
    String? mobileNo,
    String? emailId,
    String? appPIN,
    String? tranPIN,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? city,
    String? country,
    String? postalCode,
    bool? allowOnlineApp,
    String? fileName,
    String? filePath,
    num? ratingValue,
    bool? haveFreelance,
    bool? serviceatCustomerPlace,
    bool? serviceatSpecialistPlace,
    num? latitude,
    num? longitude,
    String? businessCategoryId,
    bool? isActive,
    String? createdBy,
    String? createdOn,
  }) =>
      SpecialistData(
        orgId: orgId ?? _orgId,
        specialistId: specialistId ?? _specialistId,
        specilistName: specilistName ?? _specilistName,
        displayName: displayName ?? _displayName,
        dialCode: dialCode ?? _dialCode,
        mobileNo: mobileNo ?? _mobileNo,
        emailId: emailId ?? _emailId,
        appPIN: appPIN ?? _appPIN,
        tranPIN: tranPIN ?? _tranPIN,
        addressLine1: addressLine1 ?? _addressLine1,
        addressLine2: addressLine2 ?? _addressLine2,
        addressLine3: addressLine3 ?? _addressLine3,
        city: city ?? _city,
        country: country ?? _country,
        postalCode: postalCode ?? _postalCode,
        allowOnlineApp: allowOnlineApp ?? _allowOnlineApp,
        fileName: fileName ?? _fileName,
        filePath: filePath ?? _filePath,
        ratingValue: ratingValue ?? _ratingValue,
        haveFreelance: haveFreelance ?? _haveFreelance,
        serviceatCustomerPlace:
            serviceatCustomerPlace ?? _serviceatCustomerPlace,
        serviceatSpecialistPlace:
            serviceatSpecialistPlace ?? _serviceatSpecialistPlace,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        businessCategoryId: businessCategoryId ?? _businessCategoryId,
        isActive: isActive ?? _isActive,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
      );

  num? get orgId => _orgId;

  String? get specialistId => _specialistId;

  String? get specilistName => _specilistName;

  String? get displayName => _displayName;

  String? get dialCode => _dialCode;

  String? get mobileNo => _mobileNo;

  String? get emailId => _emailId;

  String? get appPIN => _appPIN;

  String? get tranPIN => _tranPIN;

  String? get addressLine1 => _addressLine1;

  String? get addressLine2 => _addressLine2;

  String? get addressLine3 => _addressLine3;

  String? get city => _city;

  String? get country => _country;

  String? get postalCode => _postalCode;

  bool? get allowOnlineApp => _allowOnlineApp;

  String? get fileName => _fileName;

  String? get filePath => _filePath;

  num? get ratingValue => _ratingValue;

  bool? get haveFreelance => _haveFreelance;

  bool? get serviceatCustomerPlace => _serviceatCustomerPlace;

  bool? get serviceatSpecialistPlace => _serviceatSpecialistPlace;

  num? get latitude => _latitude;

  num? get longitude => _longitude;

  String? get businessCategoryId => _businessCategoryId;

  bool? get isActive => _isActive;

  String? get createdBy => _createdBy;

  String? get createdOn => _createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['SpecialistId'] = _specialistId;
    map['SpecilistName'] = _specilistName;
    map['DisplayName'] = _displayName;
    map['DialCode'] = _dialCode;
    map['MobileNo'] = _mobileNo;
    map['EmailId'] = _emailId;
    map['AppPIN'] = _appPIN;
    map['TranPIN'] = _tranPIN;
    map['AddressLine1'] = _addressLine1;
    map['AddressLine2'] = _addressLine2;
    map['AddressLine3'] = _addressLine3;
    map['City'] = _city;
    map['Country'] = _country;
    map['PostalCode'] = _postalCode;
    map['AllowOnlineApp'] = _allowOnlineApp;
    map['FileName'] = _fileName;
    map['FilePath'] = _filePath;
    map['RatingValue'] = _ratingValue;
    map['HaveFreelance'] = _haveFreelance;
    map['ServiceatCustomerPlace'] = _serviceatCustomerPlace;
    map['ServiceatSpecialistPlace'] = _serviceatSpecialistPlace;
    map['Latitude'] = _latitude;
    map['Longitude'] = _longitude;
    map['BusinessCategoryId'] = _businessCategoryId;
    map['IsActive'] = _isActive;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    return map;
  }
}

/// OrgId : 1
/// BusinessId : "TOP06E7A"
/// BusinessName : "Business 1"
/// DisplayName : "Business 1"
/// EmailId : "mariganesh@mailinator.com"
/// MobileNo : "9956874555"
/// CountryDialCode : "+91"
/// BusinessCategory : "6CBC41453"
/// BusinessRegNo : "3698521"
/// RatingValue : 5.0
/// TranPin : "123"
/// AppPin : "123"
/// AddressLine1 : "string1231324"
/// AddressLine2 : "string22313"
/// AddressLine3 : "string32132"
/// City : "string3"
/// Country : "UAE"
/// PostalCode : "900"
/// AllowOnlineApp : true
/// CustomerPlace : true
/// BusinessPlace : true
/// AllowIndividualTip : true
/// OpenTime : "09:00:00.0000000"
/// CloseTiime : "18:00:00.0000000"
/// Latitude : 1235.985
/// Longitude : 78965.63
/// LogoFileName : "LOGO.jpg"
/// Logo_Img_Base64String : ""
/// LogoFilePath : "http://154.26.130.251:478//CLIENTMEDIA//TOP10//BUSINESS//96e520a3-7348-49ae-b61a-7bb6f83923bc_LOGO.jpg"
/// ServicesList : null
/// IsActive : true
/// CreatedBy : "Admin"
/// CreatedOn : "2023-03-30T01:21:53.417"
/// IsApproved : false
/// ApprovedBy : null
/// ApprovedDate : null
/// BusinessStatus : true

class BusinessData {
  BusinessData({
    num? orgId,
    String? businessId,
    String? businessName,
    String? displayName,
    String? emailId,
    String? mobileNo,
    String? countryDialCode,
    String? businessCategory,
    String? businessRegNo,
    num? ratingValue,
    String? tranPin,
    String? appPin,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? city,
    String? country,
    String? postalCode,
    bool? allowOnlineApp,
    bool? customerPlace,
    bool? businessPlace,
    bool? allowIndividualTip,
    String? openTime,
    String? closeTiime,
    num? latitude,
    num? longitude,
    String? logoFileName,
    String? logoImgBase64String,
    String? logoFilePath,
    dynamic servicesList,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    bool? isApproved,
    dynamic approvedBy,
    dynamic approvedDate,
    bool? businessStatus,
  }) {
    _orgId = orgId;
    _businessId = businessId;
    _businessName = businessName;
    _displayName = displayName;
    _emailId = emailId;
    _mobileNo = mobileNo;
    _countryDialCode = countryDialCode;
    _businessCategory = businessCategory;
    _businessRegNo = businessRegNo;
    _ratingValue = ratingValue;
    _tranPin = tranPin;
    _appPin = appPin;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _addressLine3 = addressLine3;
    _city = city;
    _country = country;
    _postalCode = postalCode;
    _allowOnlineApp = allowOnlineApp;
    _customerPlace = customerPlace;
    _businessPlace = businessPlace;
    _allowIndividualTip = allowIndividualTip;
    _openTime = openTime;
    _closeTiime = closeTiime;
    _latitude = latitude;
    _longitude = longitude;
    _logoFileName = logoFileName;
    _logoImgBase64String = logoImgBase64String;
    _logoFilePath = logoFilePath;
    _servicesList = servicesList;
    _isActive = isActive;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _isApproved = isApproved;
    _approvedBy = approvedBy;
    _approvedDate = approvedDate;
    _businessStatus = businessStatus;
  }

  BusinessData.fromJson(dynamic json) {
    _orgId = json['OrgId'];
    _businessId = json['BusinessId'];
    _businessName = json['BusinessName'];
    _displayName = json['DisplayName'];
    _emailId = json['EmailId'];
    _mobileNo = json['MobileNo'];
    _countryDialCode = json['CountryDialCode'];
    _businessCategory = json['BusinessCategory'];
    _businessRegNo = json['BusinessRegNo'];
    _ratingValue = json['RatingValue'];
    _tranPin = json['TranPin'];
    _appPin = json['AppPin'];
    _addressLine1 = json['AddressLine1'];
    _addressLine2 = json['AddressLine2'];
    _addressLine3 = json['AddressLine3'];
    _city = json['City'];
    _country = json['Country'];
    _postalCode = json['PostalCode'];
    _allowOnlineApp = json['AllowOnlineApp'];
    _customerPlace = json['CustomerPlace'];
    _businessPlace = json['BusinessPlace'];
    _allowIndividualTip = json['AllowIndividualTip'];
    _openTime = json['OpenTime'];
    _closeTiime = json['CloseTiime'];
    _latitude = json['Latitude'];
    _longitude = json['Longitude'];
    _logoFileName = json['LogoFileName'];
    _logoImgBase64String = json['Logo_Img_Base64String'];
    _logoFilePath = json['LogoFilePath'];
    _servicesList = json['ServicesList'];
    _isActive = json['IsActive'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _isApproved = json['IsApproved'];
    _approvedBy = json['ApprovedBy'];
    _approvedDate = json['ApprovedDate'];
    _businessStatus = json['BusinessStatus'];
  }

  num? _orgId;
  String? _businessId;
  String? _businessName;
  String? _displayName;
  String? _emailId;
  String? _mobileNo;
  String? _countryDialCode;
  String? _businessCategory;
  String? _businessRegNo;
  num? _ratingValue;
  String? _tranPin;
  String? _appPin;
  String? _addressLine1;
  String? _addressLine2;
  String? _addressLine3;
  String? _city;
  String? _country;
  String? _postalCode;
  bool? _allowOnlineApp;
  bool? _customerPlace;
  bool? _businessPlace;
  bool? _allowIndividualTip;
  String? _openTime;
  String? _closeTiime;
  num? _latitude;
  num? _longitude;
  String? _logoFileName;
  String? _logoImgBase64String;
  String? _logoFilePath;
  dynamic _servicesList;
  bool? _isActive;
  String? _createdBy;
  String? _createdOn;
  bool? _isApproved;
  dynamic _approvedBy;
  dynamic _approvedDate;
  bool? _businessStatus;

  BusinessData copyWith({
    num? orgId,
    String? businessId,
    String? businessName,
    String? displayName,
    String? emailId,
    String? mobileNo,
    String? countryDialCode,
    String? businessCategory,
    String? businessRegNo,
    num? ratingValue,
    String? tranPin,
    String? appPin,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? city,
    String? country,
    String? postalCode,
    bool? allowOnlineApp,
    bool? customerPlace,
    bool? businessPlace,
    bool? allowIndividualTip,
    String? openTime,
    String? closeTiime,
    num? latitude,
    num? longitude,
    String? logoFileName,
    String? logoImgBase64String,
    String? logoFilePath,
    dynamic servicesList,
    bool? isActive,
    String? createdBy,
    String? createdOn,
    bool? isApproved,
    dynamic approvedBy,
    dynamic approvedDate,
    bool? businessStatus,
  }) =>
      BusinessData(
        orgId: orgId ?? _orgId,
        businessId: businessId ?? _businessId,
        businessName: businessName ?? _businessName,
        displayName: displayName ?? _displayName,
        emailId: emailId ?? _emailId,
        mobileNo: mobileNo ?? _mobileNo,
        countryDialCode: countryDialCode ?? _countryDialCode,
        businessCategory: businessCategory ?? _businessCategory,
        businessRegNo: businessRegNo ?? _businessRegNo,
        ratingValue: ratingValue ?? _ratingValue,
        tranPin: tranPin ?? _tranPin,
        appPin: appPin ?? _appPin,
        addressLine1: addressLine1 ?? _addressLine1,
        addressLine2: addressLine2 ?? _addressLine2,
        addressLine3: addressLine3 ?? _addressLine3,
        city: city ?? _city,
        country: country ?? _country,
        postalCode: postalCode ?? _postalCode,
        allowOnlineApp: allowOnlineApp ?? _allowOnlineApp,
        customerPlace: customerPlace ?? _customerPlace,
        businessPlace: businessPlace ?? _businessPlace,
        allowIndividualTip: allowIndividualTip ?? _allowIndividualTip,
        openTime: openTime ?? _openTime,
        closeTiime: closeTiime ?? _closeTiime,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        logoFileName: logoFileName ?? _logoFileName,
        logoImgBase64String: logoImgBase64String ?? _logoImgBase64String,
        logoFilePath: logoFilePath ?? _logoFilePath,
        servicesList: servicesList ?? _servicesList,
        isActive: isActive ?? _isActive,
        createdBy: createdBy ?? _createdBy,
        createdOn: createdOn ?? _createdOn,
        isApproved: isApproved ?? _isApproved,
        approvedBy: approvedBy ?? _approvedBy,
        approvedDate: approvedDate ?? _approvedDate,
        businessStatus: businessStatus ?? _businessStatus,
      );

  num? get orgId => _orgId;

  String? get businessId => _businessId;

  String? get businessName => _businessName;

  String? get displayName => _displayName;

  String? get emailId => _emailId;

  String? get mobileNo => _mobileNo;

  String? get countryDialCode => _countryDialCode;

  String? get businessCategory => _businessCategory;

  String? get businessRegNo => _businessRegNo;

  num? get ratingValue => _ratingValue;

  String? get tranPin => _tranPin;

  String? get appPin => _appPin;

  String? get addressLine1 => _addressLine1;

  String? get addressLine2 => _addressLine2;

  String? get addressLine3 => _addressLine3;

  String? get city => _city;

  String? get country => _country;

  String? get postalCode => _postalCode;

  bool? get allowOnlineApp => _allowOnlineApp;

  bool? get customerPlace => _customerPlace;

  bool? get businessPlace => _businessPlace;

  bool? get allowIndividualTip => _allowIndividualTip;

  String? get openTime => _openTime;

  String? get closeTiime => _closeTiime;

  num? get latitude => _latitude;

  num? get longitude => _longitude;

  String? get logoFileName => _logoFileName;

  String? get logoImgBase64String => _logoImgBase64String;

  String? get logoFilePath => _logoFilePath;

  dynamic get servicesList => _servicesList;

  bool? get isActive => _isActive;

  String? get createdBy => _createdBy;

  String? get createdOn => _createdOn;

  bool? get isApproved => _isApproved;

  dynamic get approvedBy => _approvedBy;

  dynamic get approvedDate => _approvedDate;

  bool? get businessStatus => _businessStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['BusinessId'] = _businessId;
    map['BusinessName'] = _businessName;
    map['DisplayName'] = _displayName;
    map['EmailId'] = _emailId;
    map['MobileNo'] = _mobileNo;
    map['CountryDialCode'] = _countryDialCode;
    map['BusinessCategory'] = _businessCategory;
    map['BusinessRegNo'] = _businessRegNo;
    map['RatingValue'] = _ratingValue;
    map['TranPin'] = _tranPin;
    map['AppPin'] = _appPin;
    map['AddressLine1'] = _addressLine1;
    map['AddressLine2'] = _addressLine2;
    map['AddressLine3'] = _addressLine3;
    map['City'] = _city;
    map['Country'] = _country;
    map['PostalCode'] = _postalCode;
    map['AllowOnlineApp'] = _allowOnlineApp;
    map['CustomerPlace'] = _customerPlace;
    map['BusinessPlace'] = _businessPlace;
    map['AllowIndividualTip'] = _allowIndividualTip;
    map['OpenTime'] = _openTime;
    map['CloseTiime'] = _closeTiime;
    map['Latitude'] = _latitude;
    map['Longitude'] = _longitude;
    map['LogoFileName'] = _logoFileName;
    map['Logo_Img_Base64String'] = _logoImgBase64String;
    map['LogoFilePath'] = _logoFilePath;
    map['ServicesList'] = _servicesList;
    map['IsActive'] = _isActive;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['IsApproved'] = _isApproved;
    map['ApprovedBy'] = _approvedBy;
    map['ApprovedDate'] = _approvedDate;
    map['BusinessStatus'] = _businessStatus;
    return map;
  }
}



class AppointmentServiceListModel {
  AppointmentServiceListModel({
    int? orgId,
    String? appoinmentNo,
    int? slNo,
    String? serviceId,
    String? serviceName,
    int? coins,
    String? createdBy,
    String? createdOn,
    int? durationMinutes,
  }) {
    _orgId = orgId;
    _appoinmentNo = appoinmentNo;
    _slNo = slNo;
    _serviceId = serviceId;
    _serviceName = serviceName;
    _coins = coins;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _durationMinutes = durationMinutes;
  }

  AppointmentServiceListModel.fromJson(Map<String, dynamic> json) {
    _orgId = json['OrgId'];
    _appoinmentNo = json['AppoinmentNo'];
    _slNo = json['SlNo'];
    _serviceId = json['ServiceId'];
    _serviceName = json['ServiceName'];
    _coins = json['Coins'];
    _createdBy = json['CreatedBy'];
    _createdOn = json['CreatedOn'];
    _durationMinutes = json['Duration_Minutes'];
  }

  int? _orgId;
  String? _appoinmentNo;
  int? _slNo;
  String? _serviceId;
  String? _serviceName;
  int? _coins;
  String? _createdBy;
  String? _createdOn;
  int? _durationMinutes;

  int? get orgId => _orgId;

  String? get appoinmentNo => _appoinmentNo;

  int? get slNo => _slNo;

  String? get serviceId => _serviceId;

  String? get serviceName => _serviceName;

  int? get coins => _coins;

  String? get createdBy => _createdBy;

  String? get createdOn => _createdOn;

  int? get durationMinutes => _durationMinutes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrgId'] = _orgId;
    map['AppoinmentNo'] = _appoinmentNo;
    map['SlNo'] = _slNo;
    map['ServiceId'] = _serviceId;
    map['ServiceName'] = _serviceName;
    map['Coins'] = _coins;
    map['CreatedBy'] = _createdBy;
    map['CreatedOn'] = _createdOn;
    map['Duration_Minutes'] = _durationMinutes;
    return map;
  }
}

