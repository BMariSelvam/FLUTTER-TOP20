import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_20/Model/specialistmodel.dart';
import 'package:top_20/Screens/spalsh/icon_splash_screen1.dart';
import 'package:top_20/Screens/spalsh/icon_splash_screen2.dart';
import 'package:top_20/Screens/spalsh/icon_splash_screen3.dart';
import 'package:top_20/Screens/spalsh/icon_splash_screen4.dart';
import 'package:top_20/Screens/spalsh/icon_splash_screen5.dart';
import 'package:top_20/Screens/welcome/welcome_screen.dart';
import '../Screens/BusinessFlow/Appointment/BusinessReschedule/businessreschedulescreen.dart';
import '../Screens/BusinessFlow/Appointment/appointmentconfirmdetailscreen.dart';
import '../Screens/BusinessFlow/Appointment/businessappointmentscreen.dart';
import '../Screens/BusinessFlow/BusinessBottomNavBar/businessbottomnavbar.dart';
import '../Screens/BusinessFlow/BusinessDashBoard/businessdashbordscreen.dart';
import '../Screens/BusinessFlow/Rating/ratingsscreen.dart';
import '../Screens/BusinessFlow/Receive/receivescreen.dart';
import '../Screens/BusinessFlow/Services/AddServices/allservicelist.dart';
import '../Screens/BusinessFlow/Services/AddServices/servicesscreen.dart';
import '../Screens/BusinessFlow/Services/RequestServices/requestservicescreen.dart';
import '../Screens/BusinessFlow/Settings/EditProfile/editprofilescreen.dart';
import '../Screens/BusinessFlow/Settings/settingsscreen.dart';
import '../Screens/BusinessFlow/Specialist/SpecialistDetail/specialistdetailscreen.dart';
import '../Screens/BusinessFlow/Specialist/SpecialistInvite/specialistinvitescreen.dart';
import '../Screens/BusinessFlow/Specialist/SpecialistListing/specialistlistscreen.dart';
import '../Screens/BusinessFlow/Specialist/SpecialistListing/specialistsearchbyname.dart';
import '../Screens/BusinessFlow/Transfer/transferscreen.dart';
import '../Screens/ForgetPassword/forgetpasswordscreen.dart';
import '../Screens/Login/loginscreen.dart';
import '../Screens/Registration/Business/businessregfirst/businessregfirstscreen.dart';
import '../Screens/Registration/Business/businesssecound/businesssecoundscreen.dart';
import '../Screens/Registration/Business/businessthrid/businessthridscreen.dart';
import '../Screens/Registration/ServiceRequestScreen.dart';
import '../Screens/Registration/Specialist/specialistregfirst/specialistregfirstscreen.dart';
import '../Screens/Registration/Specialist/specialistregsecond/specialistregsecondscreen.dart';
import '../Screens/Registration/Specialist/specialistregthird/specialistregthirdscreen.dart';
import '../Screens/Registration/User/userregfirstscreen.dart';
import '../Screens/Registration/contactdetailsscreen.dart';
import '../Screens/Registration/otpscreen.dart';
import '../Screens/SpecialistFlow/SpecialistBottomNavBar/specialistbottomnavbar.dart';
import '../Screens/SpecialistFlow/SpecialistBusinessInvitation/specialistbusinessinvitation.dart';
import '../Screens/SpecialistFlow/SpecialistDashboard/specialistdashboardscreen.dart';
import '../Screens/SpecialistFlow/specialistsettings/SpecialistEditProfile/specialisteditprofile.dart';
import '../Screens/SpecialistFlow/specialistsettings/specialistupdateprofilescreen.dart';
import '../Screens/SplashScreen/splashscreen.dart';
import '../Screens/Success/successscreen.dart';
import '../Screens/UesrFlow/AboutBusiness/BusinessRating/businessratingscreen.dart';
import '../Screens/UesrFlow/AboutBusiness/aboutbusinessscreen.dart';
import '../Screens/UesrFlow/AboutSpecialist/SpecialistRating/specialistratingscreen.dart';
import '../Screens/UesrFlow/AboutSpecialist/aboutspecialistscreen.dart';
import '../Screens/UesrFlow/Appointment/SpecialistAppointment/specialistappointmentscreen.dart';
import '../Screens/UesrFlow/Appointment/businessappointment/businessappointmentscreen.dart';
import '../Screens/UesrFlow/AppointmentDetail/userappointmentdetailscreen.dart';
import '../Screens/UesrFlow/FavoriteSpecialistAndBusiness/favbusiness.dart';
import '../Screens/UesrFlow/FavoriteSpecialistAndBusiness/favspecialist.dart';
import '../Screens/UesrFlow/FeaturedServices/FeaturedServicesBusinessSpecialist/feacturedservicesbusinessspecialistscreen.dart';
import '../Screens/UesrFlow/FeaturedServices/featuredservicescreen.dart';
import '../Screens/UesrFlow/NearBy/nearbyscreen.dart';
import '../Screens/UesrFlow/UserBottomNavBar/userbottomnavbar.dart';
import '../Screens/UesrFlow/UserBusinessSpecialist/UserBusinessList/userbusinesslistsscreen.dart';
import '../Screens/UesrFlow/UserBusinessSpecialist/UserSpecialistList/userspecialistscreen.dart';
import '../Screens/UesrFlow/UserDashBoard/userdashboardscreen.dart';
import '../Screens/UesrFlow/UserProfile/EditProfile/editprofilescreen.dart';
import '../Screens/UesrFlow/UserProfile/ResetPassword/resetpasswordscreen.dart';
import '../Screens/UesrFlow/UserProfile/userprofilescreen.dart';

class Routes {
  static const String splashScreen = "/SplashScreen";
  static const String loginScreen = "/LoginScreen";
  static const String contactDetailScreen = "/ContactDetailScreen";
  static const String businessRegFirstScreen = "/BusinessRegFirstScreen";
  static const String businessRegSecondScreen = "/BusinessRegSecondScreen";
  static const String businessRegThirdScreen = "/BusinessRegThirdScreen";
  static const String userRegFirstScreen = "/UserRegFirstScreen";
  static const String specialistRegFirstScreen = "/SpecialistRegFirstScreen";
  static const String specialistRegSecondScreen = "/SpecialistRegSecondScreen";
  static const String specialistRegThirdScreen = "/SpecialistRegThirdScreen";
  static const String successfulScreen = "/SuccessfulScreen";
  static const String oTPScreen = "/OTPScreen";
  static const String forgetPasswordScreen = "/ForgetPasswordScreen";
  static const String businessDashboardScreen = "/BusinessDashboardScreen";
  static const String specialistDashBoardScreen = "/SpecialistDashBoardScreen";
  static const String userBottomNavBar = "/UserBottomNavBar";
  static const String userDashBoardScreen = "/UserDashBoardScreen";
  static const String aboutSpecialistScreen = "/AboutSpecialistScreen";
  static const String appointmentScreen = "/AppointmentScreen";
  static const String userBusinessListScreen = "/UserBusinessListScreen";
  static const String aboutBusiness = "/AboutBusiness";
  static const String userAppointmentBusiness = "/UserAppointmentBusiness";
  static const String editProfileScreen = "/EditProfileScreen";
  static const String favoriteBusiness = "/FavoriteBusiness";
  static const String nearByScreen = "/NearByScreen";
  static const String userSpecialistScreen = "/UserSpecialistScreen";
  static const String resetPassword = "/ResetPassword";
  static const String businessBottomNavBar = "/BusinessBottomNavBar";
  static const String userBusinessSpecialistScreen =
      "/UserBusinessSpecialistScreen";
  static const String addSpecialistScreen = "/AddSpecialistScreen";
  static const String servicesScreen = "/ServicesScreen";
  static const String ratingScreen = "/RatingScreen";
  static const String receiveScreen = "/ReceiveScreen";
  static const String transferScreen = "/TransferScreen";
  static const String settingsScreen = "/SettingsScreen";
  static const String appointmentDetailScreen = "/AppointmentDetailScreen";
  static const String businessRescheduleScreen = "/BusinessRescheduleScreen";
  static const String specialistInviteScreen = "/SpecialistInviteScreen";

  static const String businessSpecialistDetailScreen =
      "/BusinessSpecialistDetailScreen";
  static const String specialistSearchByNameScreen =
      "/SpecialistSearchByNameScreen";
  static const String businessAppointmentDetails =
      "/BusinessAppointmentDetails";

  static const String businessEditProfileScreen = "/BusinessEditProfileScreen";
  static const String serviceAllListScreen = "/ServiceAllListScreen";
  static const String businessServiceRequestList =
      "/BusinessServiceRequestList";
  static const String specialistAppointmentScreen =
      "/SpecialistAppointmentScreen";
  static const String specialistBottomNavBar = "/SpecialistBottomNavBar";
  static const String userProfileScreen = "/UserProfileScreen";
  static const String specialistBusinessInvitationScreen =
      "/SpecialistBusinessInvitationScreen";
  static const String specialistUpdateProfile = "/SpecialistUpdateProfile";
  static const String getUserFavSpecialList = "/GetUserFavSpecialList";
  static const String userAppointmentDetailScreen =
      "/UserAppointmentDetailScreen";

  static const String splash1Gif = "/splash1Gif";
  static const String splash5Gif = "/splash5Gif";
  static const String splash2Gif = "/splash2Gif";
  static const String splash3Gif = "/splash3Gif";
  static const String splash4Gif = "/splash4Gif";
  static const String welcomeScreen = "/WelcomeScreen";
  static const String specialistEditProfileScreen =
      "/SpecialistEditProfileScreen";
  static const String beforeregisterServiceAdd = "/BeforeregisterServiceAdd";
  static const String businessRatingScreen = "/BusinessRatingScreen";
  static const String specialistRatingScreen = "/SpecialistRatingScreen";
  static const String featuredServicesScreen = "/FeaturedServicesScreen";
  static const String feaBusSplScreen = "/FeaBusSplScreen";
}

final pages = [
  GetPage(name: Routes.splashScreen, page: () => const SplashScreen()),
  GetPage(
      name: Routes.userAppointmentBusiness,
      page: () => const UserAppointmentBusiness()),
  GetPage(name: Routes.loginScreen, page: () => const LoginScreen()),
  GetPage(
      name: Routes.userDashBoardScreen,
      page: () => const UserDashBoardScreen()),
  GetPage(name: Routes.oTPScreen, page: () => const OTPScreen()),
  GetPage(
      name: Routes.contactDetailScreen,
      page: () => const ContactDetailsScreen()),
  GetPage(
      name: Routes.businessRegFirstScreen,
      page: () => const BusinessRegFirstScreen()),
  GetPage(
      name: Routes.businessRegSecondScreen,
      page: () => const BusinessRegSecondScreen()),
  GetPage(
      name: Routes.businessRegThirdScreen,
      page: () => const BusinessRegThirdScreen()),
  GetPage(
      name: Routes.specialistRegFirstScreen,
      page: () => const SpecialistRegFirstScreen()),
  GetPage(
      name: Routes.specialistRegSecondScreen,
      page: () => const SpecialistRegSecondScreen()),
  GetPage(
      name: Routes.specialistRegThirdScreen,
      page: () => const SpecialistRegThirdScreen()),
  GetPage(
      name: Routes.userRegFirstScreen, page: () => const UserRegFirstScreen()),
  GetPage(
      name: Routes.forgetPasswordScreen,
      page: () => const ForgetPasswordScreen()),
  GetPage(
      name: Routes.businessDashboardScreen,
      page: () => const BusinessDashboardScreen()),
  GetPage(
      name: Routes.specialistDashBoardScreen,
      page: () => const SpecialistDashBoardScreen()),
  GetPage(name: Routes.userBottomNavBar, page: () => UserBottomNavBar()),
  GetPage(
      name: Routes.userBusinessSpecialistScreen,
      page: () => const UserSpecialistScreen()),
  GetPage(
      name: Routes.aboutSpecialistScreen,
      page: () => const AboutSpecialistScreen()),
  GetPage(
      name: Routes.appointmentScreen, page: () => const AppointmentScreen()),
  GetPage(
      name: Routes.userBusinessListScreen,
      page: () => const UserBusinessListScreen()),
  GetPage(name: Routes.aboutBusiness, page: () => const AboutBusiness()),
  GetPage(
      name: Routes.favoriteBusiness, page: () => const GetUserFavBusiness()),
  GetPage(
      name: Routes.editProfileScreen, page: () => const EditProfileScreen()),
  GetPage(name: Routes.nearByScreen, page: () => const NearByScreen()),
  GetPage(name: Routes.resetPassword, page: () => const ResetPassword()),
  GetPage(
      name: Routes.userSpecialistScreen,
      page: () => const UserSpecialistScreen()),
  GetPage(
      name: Routes.businessBottomNavBar, page: () => BusinessBottomNavBar()),
  GetPage(
      name: Routes.addSpecialistScreen,
      page: () => const AddSpecialistScreen()),
  GetPage(name: Routes.servicesScreen, page: () => const ServicesScreen()),
  GetPage(name: Routes.ratingScreen, page: () => const RatingScreen()),
  GetPage(name: Routes.receiveScreen, page: () => const ReceiveScreen()),
  GetPage(name: Routes.transferScreen, page: () => const TransferScreen()),
  GetPage(
      name: Routes.settingsScreen, page: () => const BusinessProfileScreen()),
  GetPage(
      name: Routes.specialistSearchByNameScreen,
      page: () => const SpecialistSearchByNameScreen()),
  GetPage(
      name: Routes.specialistInviteScreen,
      page: () => const SpecialistInviteScreen()),
  GetPage(
      name: Routes.appointmentDetailScreen,
      page: () => const AppointmentDetailScreen()),
  GetPage(
      name: Routes.businessAppointmentDetails,
      page: () => BusinessAppointmentDetails()),
  GetPage(
      name: Routes.businessRescheduleScreen,
      page: () => const BusinessRescheduleScreen()),
  GetPage(
      name: Routes.businessSpecialistDetailScreen,
      page: () => const BusinessSpecialistDetailScreen()),
  GetPage(
      name: Routes.businessEditProfileScreen,
      page: () => const BusinessEditProfileScreen()),
  GetPage(
      name: Routes.serviceAllListScreen,
      page: () => const ServiceAllListScreen()),
  GetPage(
      name: Routes.businessServiceRequestList,
      page: () => const BusinessServiceRequestList()),
  GetPage(
      name: Routes.specialistBottomNavBar,
      page: () => SpecialistBottomNavBar()),
  GetPage(
      name: Routes.specialistBusinessInvitationScreen,
      page: () => const SpecialistBusinessInvitationScreen()),
  GetPage(
      name: Routes.userProfileScreen, page: () => const UserProfileScreen()),
  GetPage(
      name: Routes.specialistUpdateProfile,
      page: () => const SpecialistUpdateProfile()),
  GetPage(
      name: Routes.getUserFavSpecialList,
      page: () => const GetUserFavSpecialList()),
  GetPage(
      name: Routes.userAppointmentDetailScreen,
      page: () => const UserAppointmentDetailScreen()),
  GetPage(name: Routes.splash1Gif, page: () => const IconSplashScreen1()),
  GetPage(name: Routes.splash5Gif, page: () => const IconSplashScreen5()),
  GetPage(name: Routes.splash2Gif, page: () => const IconSplashScreen2()),
  GetPage(name: Routes.splash3Gif, page: () => const IconSplashScreen3()),
  GetPage(name: Routes.splash4Gif, page: () => const IconSplashScreen4()),
  GetPage(name: Routes.welcomeScreen, page: () => const WelcomeScreen()),
  GetPage(
      name: Routes.specialistEditProfileScreen,
      page: () => const SpecialistEditProfileScreen()),
  GetPage(
      name: Routes.beforeregisterServiceAdd,
      page: () => const BeforeServiceRequestList()),
  GetPage(
      name: Routes.businessRatingScreen,
      page: () => const BusinessRatingScreen()),
  GetPage(
      name: Routes.specialistRatingScreen,
      page: () => const SpecialistRatingScreen()),
  GetPage(
      name: Routes.featuredServicesScreen,
      page: () => const FeaturedServicesScreen()),
  GetPage(name: Routes.feaBusSplScreen, page: () => const FeaBusSplScreen()),
];
