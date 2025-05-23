class UserAgreementModel {
  final int id;
  final String title;
  final String content;

  UserAgreementModel({
    required this.id,
    required this.title,
    required this.content,
  });

  factory UserAgreementModel.fromJson(Map<String, dynamic> json, String locale) {
    return UserAgreementModel(
      id: json['id'],
      title: json['title_$locale'] ?? '',
      content: json['content_$locale'] ?? '',
    );
  }
}
