class CountryListModel {
  String? country;
  String? code;
  String? iso;

  CountryListModel({this.country, this.code, this.iso});

  CountryListModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    code = json['code'];
    iso = json['iso'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$code - $country";
  }
}
