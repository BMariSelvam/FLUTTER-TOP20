class HttpUrl {
  static const String base = "http://154.26.130.251:289/"; //---->LiveUrl
  // static const String base = "http://154.26.130.251:287/"; //--->TestingUrl

    static String get baseUrl => "${base}api/";

  static String get businessLogin => "${baseUrl}Top10Business/Login";

  static String get generalLogin => "${baseUrl}Password/Login";

  static String get generateToken => "${baseUrl}Token/GenerateToken";

  static String get sendOtp => "${baseUrl}OTPController/SendOTP";

  static String get verifyOTP => "${baseUrl}OTPController/VerifyOTP";

  static String get businessCategory =>
      "${baseUrl}BusinessCategory/GetAll?OrganizationId=1";

  static String get businessService =>
      "${baseUrl}BusinessService/GetAll?OrganizationId=1&";

  static String get createBusinessService => "${baseUrl}BusinessService/Create";

  static String get registerBusiness => "${baseUrl}Top10Business/Create";

  static String get businessSpecialistList =>
      "${baseUrl}BusinessSpecialist/GetAll";

  static String get specialistSearch => "${baseUrl}Specialist/GetAllSearch";

  static String get inviteSpecialist =>
      "${baseUrl}Top10Business/InviteSpecialist";

  static String get updateBusiness =>
      "${baseUrl}Top10Business/EditBusinessProfile";

  static String get updateSpecialist =>
      "${baseUrl}Specialist/EditBusinessProfile";

  static String get updateMember =>
      "${baseUrl}/MemberRegistration/EditMemberProfile";

  static String get registerSpecialist => "${baseUrl}/Specialist/Create";

  static String get registerMember => "${baseUrl}/MemberRegistration/Create";

  static String get memberLogin => "${baseUrl}/MemberRegistration/Login";

  static String get specialistLogin => "${baseUrl}Specialist/Login";

  //Google Api
  static const String googleGeocode =
      'https://maps.googleapis.com/maps/api/geocode/json';

  // Business Requst
  static String get getBusinessRequst =>
      "${baseUrl}Specialist/GetBusinessRequest?OrganizationId=1&";

  //SpecialistId=TPSPL073B3
  static String get approveRequest =>
      "${baseUrl}/Specialist/ApproveBusinessRequest";

  static String get getAllSpecialist => "${baseUrl}Specialist/GetAll?";

  static String get unInvitedSpecialist =>
      "${baseUrl}/Top10Business/GetUnInvitedSpecialist";

  static String get getBusinessByCategory => "${baseUrl}Top10Business/GetAll?";

  //BankDetails
  static String get addBankAccount => "${baseUrl}/BankAccount/Create";

  static String get specialistandbussinessGetServices =>
      "${baseUrl}/Specialist/GetAllService?OrganizationId=1&IsActive=true&";

  static String get businessServices =>
      "${baseUrl}/Top10Business/GetBusinessServices?OrganizationId=1&Isactive=true&";

  static String get allbusinessServices =>
      "${baseUrl}/BusinessService/GetAll?OrganizationId=1";

  // static String get businessServices => "${baseUrl}/Top10Business/GetBusinessServices?OrganizationId=1&";

  static String get businessGetSpecialist =>
      "${baseUrl}/BusinessSpecialist/GetAll?OrganizationId=1&";

  //AppointmentForSpecialist
  static String get userAppointmentSpecialist =>
      "${baseUrl}/MemberRegistration/BookAppoinment";

  //CreateFavorite Specialist
  static String get userFavSpecialist =>
      '${baseUrl}MemberRegistration/CreateFavoriteSpecialist';

  //remove Favorite Specialist
  static String get removeFavSpecialist =>
      '${baseUrl}MemberRegistration/RemoveFavoriteSpecialist';

  //CreateFavorite Business
  static String get userFavBusiness =>
      '${baseUrl}MemberRegistration/CreateFavoriteBusiness';

  //remove Favorite Business
  static String get removeFavBusiness =>
      '${baseUrl}MemberRegistration/RemoveFavoriteBusiness';

  //GetFavorite Business
  static String get userGetFavSpecialist =>
      '${baseUrl}/MemberRegistration/GetAllFavoriteSpecialist?OrganizationId=1&';

//GetFavorite Specialist
  static String get userGetFavBusiness =>
      '${baseUrl}/MemberRegistration/GetAllFavoriteBusiness?OrganizationId=1&';

  static String get specialistGetServices =>
      "${baseUrl}/Specialist/GetAllService?OrganizationId=1&";

  static String get getAppointmentList =>
      "${baseUrl}/MemberRegistration/GetAppoinment?OrganizationId=1&";

  static String updateAppointment(
          {required int orgId,
          required String appointmentId,
          required int status}) =>
      "${baseUrl}/MemberRegistration/AppoinmentStatusUpdate?OrganizationId=$orgId&AppoinmentNo=$appointmentId&Status=$status&User=admn";

  static String get resheduleAppointment =>
      "${baseUrl}/MemberRegistration/AppoinmentReSchedule";

  //AddNew Service
  static String get AddNewServices =>
      "${baseUrl}/BusinessService/AddNewServiceRequest";

  static String get postRating =>
      "${baseUrl}MemberRegistration/CreateReviewandRating";

  //AddNew Service
  static String get AddNewServicescreate =>
      "${baseUrl}/BusinessService/AddNewServiceRequest";

  static String get addbusinessServicelist =>
      "${baseUrl}/Top10Business/CreateService";

  static String get checkingEmailExsiting =>
      "${baseUrl}/OTPController/CheckMemberAlreadyExist?OrgId=1&DisplayName=&MobileNo=&CountryDialCode=";

  static String get getNewReqestserviceApi =>
      "${baseUrl}/BusinessService/GetNewServiceRequest?OrganizationId=1&Status=false&";

  static String get forgetPassword => "${baseUrl}/Password/ForgetPassword";

  static String get newCategoryAdded =>
      "${baseUrl}BusinessCategory/AddCategoryRequest";

  static String get businessGetBy =>
      "${baseUrl}/Top10Business/GetBusinessByCode?OrganizationId=1&";

  static String get specialistGetBy =>
      "${baseUrl}/Specialist/GetByCode?OrganizationId=1&";

  static String get bannerGetAll =>
      "${baseUrl}/BannerImage/GetAll?OrganizationId=1&BannerId=";

  static String get advertisementGetAll =>
      "${baseUrl}/Advertistment/GetAll?OrganizationId=1";

  static String get addExistingServiceSpecialist =>
      "${baseUrl}/Specialist/CreateService2";

  static String get addExistingServiceBusiness =>
      "${baseUrl}/Top10Business/CreateService2";

  static String get changepassword => "${baseUrl}/Password/ChangePassword";

  static String get inActiveServiceSpecialist =>
      "${baseUrl}Specialist/ActiveInActiveService";

  static String get inActiveServiceBusiness =>
      "${baseUrl}Top10Business/ActiveInActiveService";

  static String get beforeServiceRequest =>
      "${baseUrl}/BusinessService/AddNewServiceRequest";

  static String get getAllBusinessRequest =>
      "${baseUrl}/Specialist/GetBusinessRequest?";

  static String get createServiceBusiness =>
      "${baseUrl}/Top10Business/CreateService2";

  static String get createServiceSpecialist =>
      "${baseUrl}/Specialist/CreateService2";

  static String get getAllServiceSpecialist =>
      "${baseUrl}Specialist/GetAllService?";

  static String get getAllServiceBusiness =>
      "${baseUrl}Top10Business/GetBusinessServices?";

  ///User Rating API

  static String get postUserReview => "${baseUrl}MemberReviewInfo/Create";

  static String get getUserBusinessRate => "${baseUrl}MemberReviewInfo/GetAll";

  static String get getFeaturedServices => "${baseUrl}FeaturedService/GetAll";
}
