class City {
  final int id;
  final String nameUz;
  final String nameRu;
  final String nameEn;
  final int region;

  City({
    required this.id,
    required this.nameUz,
    required this.nameRu,
    required this.nameEn,
    required this.region,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json["id"],
      nameUz: json["name_uz"],
      nameRu: json["name_ru"],
      nameEn: json["name_en"],
      region: json["region"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name_uz": nameUz,
      "name_ru": nameRu,
      "name_en": nameEn,
      "region": region,
    };
  }
}
