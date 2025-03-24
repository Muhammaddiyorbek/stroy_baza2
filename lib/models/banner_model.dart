// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

List<BannerModel> bannerModelFromJson(String str) => List<BannerModel>.from(json.decode(str).map((x) => BannerModel.fromJson(x)));

String bannerModelToJson(List<BannerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerModel {
  final int id;
  final int branch;
  final String? image;
  final bool isActive;

  BannerModel({
    this.id = -1,
    this.branch = -1,
    this.image = '',
    this.isActive = false,
  });

  BannerModel copyWith({
    int? id,
    int? branch,
    String? image,
    bool? isActive,
  }) =>
      BannerModel(
        id: id ?? this.id,
        branch: branch ?? this.branch,
        image: image ?? this.image,
        isActive: isActive ?? this.isActive,
      );

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        branch: json["branch"],
        image: json["image"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch": branch,
        "image": image,
        "is_active": isActive,
      };
}
