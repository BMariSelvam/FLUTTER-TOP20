class CountryModel {
  String? country;
  String? iso;

  CountryModel({this.country, this.iso});

  CountryModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    iso = json['iso'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$country";
  }
}
