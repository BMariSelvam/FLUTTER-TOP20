class ApiResponseModel {
  int? code;
  bool status = false;
  String? message;
  dynamic result;

  ApiResponseModel(
      {required this.code,
        required this.status,
        required this.message,
        required this.result});

  ApiResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    status = json['Status'];
    message = json['Message'];
    // result = (json['Data'] != null && json['Data'] is Map<String, dynamic>) ? json['result'] : null;
    result = json['Data'];
  }
}
