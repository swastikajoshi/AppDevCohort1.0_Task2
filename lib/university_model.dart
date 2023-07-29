class UniversityModel {
  List<String>? domains;
  String? stateProvince;
  String? country;
  String? alphaTwoCode;
  List<String>? webPages;
  String? name;

  UniversityModel({
    this.domains,
    this.stateProvince,
    this.country,
    this.alphaTwoCode,
    this.webPages,
    this.name,
  });
  UniversityModel.fromJson(Map<String, dynamic> json) {
    if (json['domains'] != null) {
      final v = json['domains'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      domains = arr0;
    }
    stateProvince = json['state-province']?.toString();
    country = json['country']?.toString();
    alphaTwoCode = json['alpha_two_code']?.toString();
    if (json['web_pages'] != null) {
      final v = json['web_pages'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      webPages = arr0;
    }
    name = json['name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (domains != null) {
      final v = domains;
      final arr0 = [];
      v?.forEach((v) {
        arr0.add(v);
      });
      data['domains'] = arr0;
    }
    data['state-province'] = stateProvince;
    data['country'] = country;
    data['alpha_two_code'] = alphaTwoCode;
    if (webPages != null) {
      final v = webPages;
      final arr0 = [];
      v?.forEach((v) {
        arr0.add(v);
      });
      data['web_pages'] = arr0;
    }
    data['name'] = name;
    return data;
  }
}