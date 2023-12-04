import 'package:top_20/Model/specialistservicemodel.dart';

class UserSpecialistAppointmentCreateModel {
  int? orgId;
  String? appointmentDate;
  String? memberId;
  String? businessId;
  String? specialistId;
  String? appoinmentFromTime;
  String? appoinmentToTime;
  int? totailCoinsPaid;
  int? paymentStatus;
  int? status;
  bool? isRescheduled;
  int? serviceLocation;
  String? createdBy;
  String? createdOn;
  List<SpecialistServicesModel>? appoinmentDetail;

  UserSpecialistAppointmentCreateModel(
      {this.orgId,
      this.businessId,
      this.specialistId,
      this.memberId,
      this.appointmentDate,
      this.status,
      this.serviceLocation,
      this.appoinmentToTime,
      this.appoinmentFromTime,
      this.totailCoinsPaid,
      this.isRescheduled,
      this.paymentStatus,
      this.createdBy,
      this.createdOn,
      this.appoinmentDetail});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrgId'] = this.orgId;
    data['MemberId'] = this.memberId;
    data['SpecialistId'] = this.specialistId;
    data['BusinessId'] = this.businessId;
    data['AppoinmentDate'] = this.appointmentDate;
    data['AppoinmentFromTime'] = this.appoinmentFromTime;
    data['AppoinmentToTime'] = this.appoinmentToTime;
    data['TotailCoinsPaid'] = this.totailCoinsPaid;
    data['PaymentStatus'] = this.paymentStatus;
    data['Status'] = this.status;
    data['ServicePlace'] = this.serviceLocation;
    data['IsRescheduled'] = this.isRescheduled;
    data['CreatedBy'] = this.createdBy;
    data['PaymentStatus'] = this.paymentStatus;
    if (this.appoinmentDetail != null) {
      data['AppoinmentDetail'] =
          this.appoinmentDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
